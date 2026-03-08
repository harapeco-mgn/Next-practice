"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useAuth } from "@/contexts/AuthContext";
import type { ApiError } from "@/lib/types";
import axios from "axios";

export default function RegisterPage() {
  const { register } = useAuth();
  const router = useRouter();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [passwordConfirmation, setPasswordConfirmation] = useState("");
  const [errors, setErrors] = useState<string[]>([]);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrors([]);
    setLoading(true);
    try {
      await register(name, email, password, passwordConfirmation);
      router.push("/courses");
    } catch (err) {
      if (axios.isAxiosError(err)) {
        const data = err.response?.data as ApiError;
        setErrors(data?.errors ?? [data?.error ?? "登録に失敗しました"]);
      } else {
        setErrors(["登録に失敗しました"]);
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="w-full max-w-md rounded-xl bg-white p-8 shadow-sm">
      <h1 className="mb-6 text-2xl font-bold text-gray-900">無料登録</h1>
      <form onSubmit={handleSubmit} className="space-y-4">
        {errors.length > 0 && (
          <ul className="rounded-md bg-red-50 px-4 py-2 text-sm text-red-600">
            {errors.map((e) => (
              <li key={e}>{e}</li>
            ))}
          </ul>
        )}
        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700">
            名前
          </label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:border-indigo-500 focus:outline-none focus:ring-1 focus:ring-indigo-500"
            placeholder="山田 太郎"
          />
        </div>
        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700">
            メールアドレス
          </label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:border-indigo-500 focus:outline-none focus:ring-1 focus:ring-indigo-500"
            placeholder="you@example.com"
          />
        </div>
        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700">
            パスワード
          </label>
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            minLength={6}
            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:border-indigo-500 focus:outline-none focus:ring-1 focus:ring-indigo-500"
            placeholder="••••••••"
          />
        </div>
        <div>
          <label className="mb-1 block text-sm font-medium text-gray-700">
            パスワード（確認）
          </label>
          <input
            type="password"
            value={passwordConfirmation}
            onChange={(e) => setPasswordConfirmation(e.target.value)}
            required
            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:border-indigo-500 focus:outline-none focus:ring-1 focus:ring-indigo-500"
            placeholder="••••••••"
          />
        </div>
        <button
          type="submit"
          disabled={loading}
          className="w-full rounded-md bg-indigo-600 py-2.5 text-sm font-medium text-white hover:bg-indigo-700 disabled:opacity-60"
        >
          {loading ? "登録中..." : "登録する"}
        </button>
      </form>
      <p className="mt-4 text-center text-sm text-gray-600">
        すでにアカウントをお持ちの方は{" "}
        <Link href="/login" className="text-indigo-600 hover:underline">
          ログイン
        </Link>
      </p>
    </div>
  );
}
