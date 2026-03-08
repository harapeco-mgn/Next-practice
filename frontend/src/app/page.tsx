import Link from "next/link";

export default function Home() {
  return (
    <div className="mx-auto max-w-4xl px-6 py-24 text-center">
      <h1 className="mb-4 text-4xl font-bold tracking-tight text-gray-900">
        Rails × Next.js × TypeScript
        <br />
        <span className="text-indigo-600">実践学習プラットフォーム</span>
      </h1>
      <p className="mb-10 text-lg text-gray-700">
        クイズ・チュートリアル・コード練習で、
        <br />
        モダン Web 開発スタックを体系的に習得しよう。
      </p>
      <div className="flex justify-center gap-4">
        <Link
          href="/register"
          className="rounded-lg bg-indigo-600 px-6 py-3 text-base font-medium text-white hover:bg-indigo-700"
        >
          無料で始める
        </Link>
        <Link
          href="/courses"
          className="rounded-lg border border-gray-300 px-6 py-3 text-base font-medium text-gray-700 hover:bg-gray-50"
        >
          コースを見る
        </Link>
      </div>
    </div>
  );
}
