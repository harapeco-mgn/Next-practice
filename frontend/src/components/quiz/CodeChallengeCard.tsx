"use client";

import { useState } from "react";
import dynamic from "next/dynamic";
import type { Quiz } from "@/lib/types";
import { apiClient } from "@/lib/api";

// Monaco Editor は SSR 非対応のため dynamic import
const MonacoEditor = dynamic(() => import("@monaco-editor/react"), {
  ssr: false,
  loading: () => (
    <div className="flex h-48 items-center justify-center rounded-md bg-gray-900 text-sm text-gray-400">
      エディタを読み込み中...
    </div>
  ),
});

type Props = {
  quiz: Quiz;
};

export default function CodeChallengeCard({ quiz }: Props) {
  const [code, setCode] = useState(quiz.starter_code ?? "");
  const [result, setResult] = useState<{
    correct: boolean;
    explanation: string | null;
  } | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [showHints, setShowHints] = useState(false);

  const handleSubmit = async () => {
    setSubmitting(true);
    try {
      const res = await apiClient.post<{
        correct: boolean;
        explanation: string | null;
      }>(`/quizzes/${quiz.id}/answer`, { answer: code });
      setResult(res.data);
    } catch {
      setResult({ correct: false, explanation: "送信に失敗しました" });
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="rounded-xl border bg-white shadow-sm">
      {/* ヘッダー */}
      <div className="border-b bg-gray-50 px-5 py-3 text-xs font-semibold uppercase tracking-wider text-gray-500">
        Code Challenge
      </div>

      <div className="p-5">
        {/* 問題文 */}
        <p className="mb-4 font-semibold text-gray-900">{quiz.question}</p>

        {/* ヒント */}
        {quiz.hints && quiz.hints.length > 0 && (
          <div className="mb-4">
            <button
              onClick={() => setShowHints(!showHints)}
              className="text-sm text-indigo-600 hover:underline"
            >
              {showHints ? "ヒントを隠す" : `ヒントを見る (${quiz.hints.length}件)`}
            </button>
            {showHints && (
              <ul className="mt-2 space-y-1">
                {quiz.hints.map((hint, i) => (
                  <li
                    key={i}
                    className="rounded-md bg-yellow-50 px-3 py-2 text-sm text-yellow-800"
                  >
                    💡 {hint}
                  </li>
                ))}
              </ul>
            )}
          </div>
        )}

        {/* Monaco Editor */}
        <div className="mb-4 overflow-hidden rounded-lg border">
          <MonacoEditor
            height="200px"
            language="typescript"
            theme="vs-dark"
            value={code}
            onChange={(val) => setCode(val ?? "")}
            options={{
              minimap: { enabled: false },
              fontSize: 14,
              lineNumbers: "on",
              scrollBeyondLastLine: false,
              readOnly: !!result,
              tabSize: 2,
            }}
          />
        </div>

        {!result && (
          <button
            onClick={handleSubmit}
            disabled={submitting || !code.trim()}
            className="rounded-md bg-indigo-600 px-5 py-2 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-50"
          >
            {submitting ? "送信中..." : "コードを送信"}
          </button>
        )}

        {result && (
          <div
            className={`rounded-lg p-4 ${
              result.correct ? "bg-green-50 text-green-800" : "bg-red-50 text-red-800"
            }`}
          >
            <p className="font-semibold">{result.correct ? "正解！" : "不正解"}</p>
            {result.explanation && (
              <p className="mt-1 text-sm">{result.explanation}</p>
            )}
            {!result.correct && (
              <button
                onClick={() => setResult(null)}
                className="mt-2 text-sm underline"
              >
                もう一度試す
              </button>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
