import Link from "next/link";
import { notFound } from "next/navigation";
import ReactMarkdown from "react-markdown";
import { Prism as SyntaxHighlighter } from "react-syntax-highlighter";
import { vscDarkPlus } from "react-syntax-highlighter/dist/esm/styles/prism";
import type { Components } from "react-markdown";
import type { Lesson, Quiz } from "@/lib/types";
import QuizCard from "@/components/quiz/QuizCard";
import LessonCompleteButton from "./LessonCompleteButton";

type LessonDetail = Lesson & {
  prev_lesson_id: number | null;
  next_lesson_id: number | null;
  quizzes: Quiz[];
};

async function getLesson(id: string): Promise<LessonDetail> {
  const baseURL =
    process.env.INTERNAL_API_URL ?? "http://backend:3001/api/v1";
  const res = await fetch(`${baseURL}/lessons/${id}`, { cache: "no-store" });
  if (res.status === 404) notFound();
  if (!res.ok) throw new Error("レッスンの取得に失敗しました");
  const data = await res.json();
  return data.lesson;
}

const markdownComponents: Components = {
  code({ className, children }) {
    const match = /language-(\w+)/.exec(className ?? "");
    const codeString = String(children).replace(/\n$/, "");
    if (match) {
      return (
        <SyntaxHighlighter
          style={vscDarkPlus}
          language={match[1]}
          PreTag="div"
        >
          {codeString}
        </SyntaxHighlighter>
      );
    }
    return (
      <code className="rounded bg-gray-100 px-1.5 py-0.5 font-mono text-sm text-pink-600">
        {children}
      </code>
    );
  },
};

export default async function LessonPage({
  params,
}: {
  params: Promise<{ courseId: string; lessonId: string }>;
}) {
  const { courseId, lessonId } = await params;
  const lesson = await getLesson(lessonId);

  return (
    <div className="mx-auto max-w-3xl px-6 py-12">
      <div className="mb-4 text-sm text-gray-500">
        <Link href="/courses" className="hover:underline">
          コース一覧
        </Link>
        {" › "}
        <Link href={`/courses/${courseId}`} className="hover:underline">
          コース
        </Link>
        {" › "}
        <span>{lesson.title}</span>
      </div>

      <h1 className="mb-8 text-3xl font-bold text-gray-900">{lesson.title}</h1>

      <article className="prose prose-indigo max-w-none">
        <ReactMarkdown components={markdownComponents}>
          {lesson.content}
        </ReactMarkdown>
      </article>

      {lesson.quizzes.length > 0 && (
        <section className="mt-12">
          <h2 className="mb-4 text-xl font-semibold text-gray-800">
            確認クイズ
          </h2>
          <div className="space-y-6">
            {lesson.quizzes.map((quiz) => (
              <QuizCard key={quiz.id} quiz={quiz} />
            ))}
          </div>
        </section>
      )}

      <div className="mt-12 flex items-center justify-between border-t pt-6">
        {lesson.prev_lesson_id ? (
          <Link
            href={`/courses/${courseId}/lessons/${lesson.prev_lesson_id}`}
            className="rounded-lg border px-4 py-2 text-sm text-gray-700 hover:bg-gray-50"
          >
            ← 前のレッスン
          </Link>
        ) : (
          <div />
        )}

        <LessonCompleteButton lessonId={lesson.id} courseId={courseId} />

        {lesson.next_lesson_id ? (
          <Link
            href={`/courses/${courseId}/lessons/${lesson.next_lesson_id}`}
            className="rounded-lg bg-indigo-600 px-4 py-2 text-sm text-white hover:bg-indigo-700"
          >
            次のレッスン →
          </Link>
        ) : (
          <Link
            href={`/courses/${courseId}`}
            className="rounded-lg border border-indigo-600 px-4 py-2 text-sm text-indigo-600 hover:bg-indigo-50"
          >
            コースへ戻る
          </Link>
        )}
      </div>
    </div>
  );
}
