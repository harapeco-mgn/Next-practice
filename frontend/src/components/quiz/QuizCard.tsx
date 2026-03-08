"use client";

import { useState } from "react";
import type { Quiz } from "@/lib/types";
import { apiClient } from "@/lib/api";

type Props = {
  quiz: Quiz;
};

export default function QuizCard({ quiz }: Props) {
  const [selected, setSelected] = useState<number[]>([]);
  const [fillAnswer, setFillAnswer] = useState("");
  const [result, setResult] = useState<{
    correct: boolean;
    explanation: string | null;
  } | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const isMultiple = quiz.quiz_type === "multiple_choice";
  const isFill =
    quiz.quiz_type === "fill_in_blank" || quiz.quiz_type === "code_challenge";

  const toggleOption = (id: number) => {
    if (result) return;
    if (isMultiple) {
      setSelected((prev) =>
        prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]
      );
    } else {
      setSelected([id]);
    }
  };

  const handleSubmit = async () => {
    setSubmitting(true);
    try {
      const payload = isFill
        ? { answer: fillAnswer }
        : { selected_option_ids: selected };

      const res = await apiClient.post<{
        correct: boolean;
        explanation: string | null;
      }>(`/quizzes/${quiz.id}/answer`, payload);
      setResult(res.data);
    } catch {
      setResult({ correct: false, explanation: "回答の送信に失敗しました" });
    } finally {
      setSubmitting(false);
    }
  };

  const canSubmit = isFill ? fillAnswer.trim().length > 0 : selected.length > 0;

  return (
    <div className="rounded-xl border bg-white p-6 shadow-sm">
      <p className="mb-4 font-semibold text-gray-900">{quiz.question}</p>

      {isFill ? (
        <input
          type="text"
          value={fillAnswer}
          onChange={(e) => setFillAnswer(e.target.value)}
          disabled={!!result}
          placeholder="回答を入力"
          className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:border-indigo-500 focus:outline-none focus:ring-1 focus:ring-indigo-500 disabled:bg-gray-50"
        />
      ) : (
        <div className="space-y-2">
          {quiz.quiz_options.map((opt) => {
            const isSelected = selected.includes(opt.id);
            return (
              <button
                key={opt.id}
                onClick={() => toggleOption(opt.id)}
                disabled={!!result}
                className={`w-full rounded-lg border px-4 py-2.5 text-left text-sm transition ${
                  isSelected
                    ? "border-indigo-500 bg-indigo-50 text-indigo-700"
                    : "border-gray-300 bg-white text-gray-800 hover:border-indigo-400 hover:bg-indigo-50"
                } disabled:cursor-default`}
              >
                {opt.body}
              </button>
            );
          })}
        </div>
      )}

      {!result && (
        <button
          onClick={handleSubmit}
          disabled={!canSubmit || submitting}
          className="mt-4 rounded-md bg-indigo-600 px-5 py-2 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-50"
        >
          {submitting ? "送信中..." : "回答する"}
        </button>
      )}

      {result && (
        <div
          className={`mt-4 rounded-lg p-4 ${result.correct ? "bg-green-50 text-green-800" : "bg-red-50 text-red-800"}`}
        >
          <p className="font-semibold">{result.correct ? "正解！" : "不正解"}</p>
          {result.explanation && (
            <p className="mt-1 text-sm">{result.explanation}</p>
          )}
        </div>
      )}
    </div>
  );
}
