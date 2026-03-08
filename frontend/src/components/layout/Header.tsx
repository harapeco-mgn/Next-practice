"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useAuth } from "@/contexts/AuthContext";

export default function Header() {
  const { user, logout } = useAuth();
  const router = useRouter();

  const handleLogout = () => {
    logout();
    router.push("/login");
  };

  return (
    <header className="border-b bg-white px-6 py-3">
      <div className="mx-auto flex max-w-5xl items-center justify-between">
        <Link href="/" className="text-xl font-bold text-indigo-600">
          Next Practice
        </Link>
        <nav className="flex items-center gap-4 text-sm">
          {user ? (
            <>
              <Link href="/courses" className="text-gray-700 hover:text-indigo-600">
                コース一覧
              </Link>
              <Link href="/dashboard" className="text-gray-700 hover:text-indigo-600">
                ダッシュボード
              </Link>
              <span className="text-gray-500">{user.name}</span>
              <button
                onClick={handleLogout}
                className="rounded-md bg-indigo-600 px-4 py-1.5 text-white hover:bg-indigo-700"
              >
                ログアウト
              </button>
            </>
          ) : (
            <>
              <Link href="/login" className="text-gray-700 hover:text-indigo-600">
                ログイン
              </Link>
              <Link
                href="/register"
                className="rounded-md bg-indigo-600 px-4 py-1.5 text-white hover:bg-indigo-700"
              >
                無料登録
              </Link>
            </>
          )}
        </nav>
      </div>
    </header>
  );
}
