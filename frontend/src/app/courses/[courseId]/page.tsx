import Link from "next/link";
import { notFound } from "next/navigation";
import type { Course, Lesson } from "@/lib/types";
import LessonList from "./LessonList";

type LessonSummary = Pick<Lesson, "id" | "title" | "position"> & {
  locked: boolean;
};
type CourseDetail = Course & { lessons: LessonSummary[] };

async function getCourse(id: string): Promise<CourseDetail> {
  const baseURL =
    process.env.INTERNAL_API_URL ?? "http://backend:3001/api/v1";
  const res = await fetch(`${baseURL}/courses/${id}`, { cache: "no-store" });
  if (res.status === 404) notFound();
  if (!res.ok) throw new Error("コース詳細の取得に失敗しました");
  const data = await res.json();
  return data.course;
}

export default async function CourseDetailPage({
  params,
}: {
  params: Promise<{ courseId: string }>;
}) {
  const { courseId } = await params;
  const course = await getCourse(courseId);

  return (
    <div className="mx-auto max-w-3xl px-6 py-12">
      <div className="mb-4 text-sm text-gray-500">
        <Link href="/courses" className="hover:underline">
          コース一覧
        </Link>
        {" › "}
        <span>{course.title}</span>
      </div>

      <h1 className="mb-3 text-3xl font-bold text-gray-900">{course.title}</h1>
      <p className="mb-8 text-gray-600">{course.description}</p>

      <h2 className="mb-4 text-xl font-semibold text-gray-800">レッスン一覧</h2>
      {/* initialLessons: SSR 時は未認証なので 1 つ目以外はロック済み */}
      {/* クライアントで再フェッチしてログイン済みユーザーのロック状態を反映 */}
      <LessonList courseId={courseId} initialLessons={course.lessons} />
    </div>
  );
}
