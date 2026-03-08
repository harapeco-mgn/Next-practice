"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useAuth } from "@/contexts/AuthContext";
import { apiClient } from "@/lib/api";

type CourseProgress = {
  course_id: number;
  title: string;
  category: string;
  difficulty: string;
  total_lessons: number;
  total_quizzes: number;
  completed_lessons: number;
  completed_quizzes: number;
  progress_pct: number;
  next_lesson: { id: number; title: string } | null;
};

const categoryLabel: Record<string, string> = {
  typescript: "TypeScript",
  react: "React",
  nextjs: "Next.js",
  rails: "Rails",
};

const difficultyColor: Record<string, string> = {
  beginner: "bg-green-100 text-green-700",
  intermediate: "bg-yellow-100 text-yellow-700",
  advanced: "bg-red-100 text-red-700",
};

export default function DashboardPage() {
  const { user, loading } = useAuth();
  const router = useRouter();
  const [progress, setProgress] = useState<CourseProgress[]>([]);
  const [fetching, setFetching] = useState(true);

  useEffect(() => {
    if (!loading && !user) {
      router.push("/login");
    }
  }, [loading, user, router]);

  useEffect(() => {
    if (!user) return;
    apiClient
      .get<{ progress: CourseProgress[] }>("/user/progress")
      .then((res) => setProgress(res.data.progress))
      .finally(() => setFetching(false));
  }, [user]);

  if (loading || fetching) {
    return (
      <div className="flex min-h-[60vh] items-center justify-center text-gray-500">
        読み込み中...
      </div>
    );
  }

  const totalPct =
    progress.length > 0
      ? Math.round(
          progress.reduce((sum, p) => sum + p.progress_pct, 0) / progress.length
        )
      : 0;

  // 進捗が途中のコースで次のレッスンがあるものを「続きから学習」候補にする
  const resumeTarget = progress.find(
    (p) => p.progress_pct > 0 && p.progress_pct < 100 && p.next_lesson
  ) ?? progress.find((p) => p.next_lesson);

  return (
    <div className="mx-auto max-w-4xl px-6 py-12">
      <h1 className="mb-2 text-3xl font-bold text-gray-900">ダッシュボード</h1>
      <p className="mb-8 text-gray-600">こんにちは、{user?.name} さん</p>

      {/* 続きから学習 */}
      {resumeTarget?.next_lesson && (
        <div className="mb-8 rounded-xl border border-indigo-200 bg-indigo-50 p-5">
          <p className="mb-1 text-sm font-medium text-indigo-600">
            続きから学習
          </p>
          <p className="mb-3 text-lg font-semibold text-gray-900">
            {resumeTarget.title} — {resumeTarget.next_lesson.title}
          </p>
          <Link
            href={`/courses/${resumeTarget.course_id}/lessons/${resumeTarget.next_lesson.id}`}
            className="inline-block rounded-lg bg-indigo-600 px-5 py-2 text-sm font-medium text-white hover:bg-indigo-700"
          >
            学習を再開する →
          </Link>
        </div>
      )}

      {/* 全体進捗 */}
      <div className="mb-8 rounded-xl border bg-white p-6 shadow-sm">
        <div className="mb-2 flex items-center justify-between">
          <span className="font-semibold text-gray-800">全体の進捗</span>
          <span className="text-2xl font-bold text-indigo-600">{totalPct}%</span>
        </div>
        <div className="h-3 w-full overflow-hidden rounded-full bg-gray-200">
          <div
            className="h-full rounded-full bg-indigo-500 transition-all duration-500"
            style={{ width: `${totalPct}%` }}
          />
        </div>
        <p className="mt-2 text-sm text-gray-500">
          {progress.filter((p) => p.progress_pct === 100).length} / {progress.length} コース完了
        </p>
      </div>

      {/* コース別進捗 */}
      <h2 className="mb-4 text-xl font-semibold text-gray-800">コース別進捗</h2>
      <div className="space-y-4">
        {progress.map((p) => (
          <div key={p.course_id} className="rounded-xl border bg-white p-5 shadow-sm">
            <div className="mb-3 flex items-start justify-between gap-4">
              <div>
                <div className="mb-1 flex items-center gap-2">
                  <span className="rounded-full bg-indigo-100 px-2.5 py-0.5 text-xs font-medium text-indigo-700">
                    {categoryLabel[p.category] ?? p.category}
                  </span>
                  <span
                    className={`rounded-full px-2.5 py-0.5 text-xs font-medium ${difficultyColor[p.difficulty] ?? ""}`}
                  >
                    {p.difficulty}
                  </span>
                  {p.progress_pct === 100 && (
                    <span className="rounded-full bg-green-100 px-2.5 py-0.5 text-xs font-medium text-green-700">
                      ✓ 完了
                    </span>
                  )}
                </div>
                <Link
                  href={`/courses/${p.course_id}`}
                  className="font-semibold text-gray-900 hover:text-indigo-600"
                >
                  {p.title}
                </Link>
              </div>
              <span className="shrink-0 text-xl font-bold text-indigo-600">
                {p.progress_pct}%
              </span>
            </div>

            <div className="mb-3 h-2 w-full overflow-hidden rounded-full bg-gray-200">
              <div
                className="h-full rounded-full bg-indigo-400 transition-all duration-500"
                style={{ width: `${p.progress_pct}%` }}
              />
            </div>

            <div className="flex items-center justify-between">
              <div className="flex gap-6 text-sm text-gray-600">
                <span>
                  レッスン:{" "}
                  <span className="font-medium text-gray-900">
                    {p.completed_lessons}/{p.total_lessons}
                  </span>
                </span>
                <span>
                  クイズ:{" "}
                  <span className="font-medium text-gray-900">
                    {p.completed_quizzes}/{p.total_quizzes}
                  </span>
                </span>
              </div>
              {p.next_lesson && p.progress_pct < 100 && (
                <Link
                  href={`/courses/${p.course_id}/lessons/${p.next_lesson.id}`}
                  className="rounded-md bg-indigo-50 px-3 py-1.5 text-xs font-medium text-indigo-600 hover:bg-indigo-100"
                >
                  続きへ →
                </Link>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
