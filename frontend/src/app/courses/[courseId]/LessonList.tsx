"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { apiClient } from "@/lib/api";
import type { Lesson } from "@/lib/types";

type LessonSummary = Pick<Lesson, "id" | "title" | "position"> & {
  locked: boolean;
};

type Props = {
  courseId: string;
  initialLessons: LessonSummary[];
};

export default function LessonList({ courseId, initialLessons }: Props) {
  const [lessons, setLessons] = useState<LessonSummary[]>(initialLessons);

  useEffect(() => {
    // ログイン済みなら再フェッチしてロック状態を更新
    const token = localStorage.getItem("token");
    if (!token) return;

    apiClient
      .get<{ course: { lessons: LessonSummary[] } }>(`/courses/${courseId}`)
      .then((res) => setLessons(res.data.course.lessons))
      .catch(() => {});
  }, [courseId]);

  return (
    <ol className="space-y-3">
      {lessons.map((lesson, index) => (
        <li key={lesson.id}>
          {lesson.locked ? (
            <div className="flex cursor-not-allowed items-center gap-4 rounded-lg border bg-gray-50 px-5 py-4 text-gray-400">
              <span className="flex h-8 w-8 items-center justify-center rounded-full bg-gray-200 text-sm font-bold">
                {index + 1}
              </span>
              <span className="font-medium">{lesson.title}</span>
              <span className="ml-auto text-xs">🔒 前のレッスンを完了してください</span>
            </div>
          ) : (
            <Link
              href={`/courses/${courseId}/lessons/${lesson.id}`}
              className="flex items-center gap-4 rounded-lg border bg-white px-5 py-4 shadow-sm transition hover:border-indigo-400 hover:shadow-md"
            >
              <span className="flex h-8 w-8 items-center justify-center rounded-full bg-indigo-100 text-sm font-bold text-indigo-700">
                {index + 1}
              </span>
              <span className="font-medium text-gray-800">{lesson.title}</span>
            </Link>
          )}
        </li>
      ))}
    </ol>
  );
}
