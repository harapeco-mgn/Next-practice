"use client";

import { useState } from "react";
import { apiClient } from "@/lib/api";

type Props = {
  lessonId: number;
  courseId: string;
};

export default function LessonCompleteButton({ lessonId, courseId }: Props) {
  const [completed, setCompleted] = useState(false);
  const [loading, setLoading] = useState(false);

  const handleComplete = async () => {
    setLoading(true);
    try {
      await apiClient.post(`/lessons/${lessonId}/complete`);
      setCompleted(true);
    } catch {
      // 未ログインの場合はスキップ
    } finally {
      setLoading(false);
    }
  };

  if (completed) {
    return (
      <span className="rounded-lg bg-green-100 px-4 py-2 text-sm font-medium text-green-700">
        完了済み ✓
      </span>
    );
  }

  return (
    <button
      onClick={handleComplete}
      disabled={loading}
      className="rounded-lg bg-green-600 px-4 py-2 text-sm font-medium text-white hover:bg-green-700 disabled:opacity-50"
    >
      {loading ? "保存中..." : "レッスン完了"}
    </button>
  );
}
