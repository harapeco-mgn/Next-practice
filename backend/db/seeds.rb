# Seed data - idempotent (find_or_create_by!)
puts "Seeding courses, lessons, and quizzes..."

# ============================================================
# Course 1: TypeScript 基礎 (TS-01)
# ============================================================
ts01 = Course.find_or_create_by!(title: "TypeScript 基礎 — 型システム入門") do |c|
  c.description = "JavaScriptとの違いから始め、基本の型・型推論・関数型・オブジェクト型をマスターする。"
  c.category    = "typescript"
  c.difficulty  = "beginner"
  c.position    = 1
end

l = Lesson.find_or_create_by!(course: ts01, position: 1) do |r|
  r.title   = "TypeScriptとは何か"
  r.content = <<~MD
    ## TypeScript とは？

    TypeScript は Microsoft が開発した **JavaScript のスーパーセット**です。
    静的型付けによってバグを早期発見できます。

    ```typescript
    // JavaScript
    function add(a, b) { return a + b; }

    // TypeScript
    function add(a: number, b: number): number {
      return a + b;
    }
    ```

    ### メリット
    - コンパイル時にエラーを検出
    - エディタの補完・リファクタリングが強力
    - チーム開発でのコードの可読性が向上
  MD
end

Quiz.find_or_create_by!(lesson: l, position: 1) do |q|
  q.question    = "TypeScript は何のスーパーセットですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "TypeScript は JavaScript のスーパーセットです。すべての JavaScript コードは有効な TypeScript コードです。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "JavaScript", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Python",     position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Ruby",       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Java",       position: 3) { |o| o.correct = false }
end

l2 = Lesson.find_or_create_by!(course: ts01, position: 2) do |r|
  r.title   = "基本の型"
  r.content = <<~MD
    ## 基本の型

    TypeScript の基本型を覚えましょう。

    ```typescript
    let isDone: boolean = false;
    let age: number = 25;
    let name: string = "Alice";
    let nothing: null = null;
    let undef: undefined = undefined;

    // 配列
    let numbers: number[] = [1, 2, 3];
    let names: Array<string> = ["Alice", "Bob"];

    // タプル
    let pair: [string, number] = ["hello", 42];
    ```

    ### any と unknown
    - `any`: 型チェックを無効化（なるべく使わない）
    - `unknown`: 型が不明だが安全に扱える
  MD
end

Quiz.find_or_create_by!(lesson: l2, position: 1) do |q|
  q.question    = "次のうち TypeScript の基本型でないものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`integer` は TypeScript には存在しません。整数も含む数値は `number` で表します。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "boolean", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "integer", position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "string",  position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "null",    position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: l2, position: 2) do |q|
  q.question      = "変数 `count` に型注釈を付けて `0` で初期化するコードを書いてください。"
  q.quiz_type     = "fill_in_blank"
  q.correct_answer = "let count: number = 0;"
  q.explanation   = "`number` 型の変数を宣言するには `let count: number = 0;` と書きます。"
  q.position      = 2
end

l3 = Lesson.find_or_create_by!(course: ts01, position: 3) do |r|
  r.title   = "関数の型"
  r.content = <<~MD
    ## 関数の型

    TypeScript では引数と戻り値に型を付けます。

    ```typescript
    // 基本的な関数型注釈
    function greet(name: string): string {
      return `Hello, ${name}!`;
    }

    // アロー関数
    const double = (n: number): number => n * 2;

    // オプション引数
    function createUser(name: string, age?: number): object {
      return { name, age };
    }

    // デフォルト引数
    function power(base: number, exp: number = 2): number {
      return base ** exp;
    }
    ```

    ### void と never
    - `void`: 戻り値なし
    - `never`: 決して返らない（例外を投げる関数）
  MD
end

Quiz.find_or_create_by!(lesson: l3, position: 1) do |q|
  q.question    = "戻り値がない関数の戻り値型に使うべきキーワードはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`void` は戻り値を返さない関数に使います。`undefined` と似ていますが、関数の戻り値型としては `void` を使うのが慣例です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "void",      position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "null",      position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "undefined", position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "never",     position: 3) { |o| o.correct = false }
end

# ============================================================
# Course 2: React 基礎 (RC-01)
# ============================================================
rc01 = Course.find_or_create_by!(title: "React 基礎 — コンポーネントと JSX") do |c|
  c.description = "JSX・コンポーネント・props・イベント処理の基礎をハンズオンで学ぶ。"
  c.category    = "react"
  c.difficulty  = "beginner"
  c.position    = 5
end

rl1 = Lesson.find_or_create_by!(course: rc01, position: 1) do |r|
  r.title   = "JSX とは何か"
  r.content = <<~MD
    ## JSX とは？

    JSX は JavaScript の拡張構文で、HTML に似た見た目のコードを JS の中に書けます。

    ```tsx
    // JSX
    const element = <h1>Hello, World!</h1>;

    // コンパイル後（React.createElement）
    const element = React.createElement('h1', null, 'Hello, World!');
    ```

    ### JSX のルール
    1. 必ず単一のルート要素を返す（または `<>...</>` フラグメント）
    2. `class` → `className`
    3. 属性名はキャメルケース（`onClick`, `onChange`）
    4. 式は `{}` で囲む

    ```tsx
    function Greeting({ name }: { name: string }) {
      return (
        <div className="greeting">
          <h1>Hello, {name}!</h1>
          <p>Today is {new Date().toLocaleDateString('ja-JP')}</p>
        </div>
      );
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rl1, position: 1) do |q|
  q.question    = "JSX で HTML の `class` 属性に相当する属性名はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "JSX では `class` は予約語のため、`className` を使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "class",     position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "className", position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "htmlClass", position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "cssClass",  position: 3) { |o| o.correct = false }
end

rl2 = Lesson.find_or_create_by!(course: rc01, position: 2) do |r|
  r.title   = "コンポーネントと props"
  r.content = <<~MD
    ## コンポーネントと props

    React コンポーネントは **UI の部品**です。props で外からデータを渡します。

    ```tsx
    // 関数コンポーネント
    type CardProps = {
      title: string;
      description: string;
      imageUrl?: string;
    };

    function Card({ title, description, imageUrl }: CardProps) {
      return (
        <div className="card">
          {imageUrl && <img src={imageUrl} alt={title} />}
          <h2>{title}</h2>
          <p>{description}</p>
        </div>
      );
    }

    // 使用例
    <Card title="TypeScript 基礎" description="型システムを学ぶ" />
    ```

    ### children props
    ```tsx
    function Section({ children }: { children: React.ReactNode }) {
      return <section className="section">{children}</section>;
    }

    <Section>
      <p>ここに内容が入ります</p>
    </Section>
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rl2, position: 1) do |q|
  q.question    = "props はコンポーネントに対して何の方向でデータを渡しますか？"
  q.quiz_type   = "single_choice"
  q.explanation = "React の props は親から子への一方向（単方向）のデータフローです。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "親から子（一方向）",   position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "子から親（一方向）",   position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "双方向",               position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "兄弟コンポーネント間", position: 3) { |o| o.correct = false }
end

rl3 = Lesson.find_or_create_by!(course: rc01, position: 3) do |r|
  r.title   = "イベント処理と条件レンダリング"
  r.content = <<~MD
    ## イベント処理

    ```tsx
    function Counter() {
      const [count, setCount] = React.useState(0);

      const handleClick = () => setCount(prev => prev + 1);

      return (
        <div>
          <p>カウント: {count}</p>
          <button onClick={handleClick}>+1</button>
        </div>
      );
    }
    ```

    ## 条件レンダリング

    ```tsx
    function Status({ isLoading, data }: { isLoading: boolean; data: string | null }) {
      if (isLoading) return <p>読み込み中...</p>;

      return (
        <div>
          {data ? (
            <p>データ: {data}</p>
          ) : (
            <p>データがありません</p>
          )}
        </div>
      );
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rl3, position: 1) do |q|
  q.question    = "React でボタンのクリックイベントを扱う props 名はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "React のイベント名はキャメルケースで、`onClick` がクリックイベントです。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "onclick",      position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "onClick",      position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "handleClick",  position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "click",        position: 3) { |o| o.correct = false }
end

# ============================================================
# Course 3: Next.js 基礎 (NX-01)
# ============================================================
nx01 = Course.find_or_create_by!(title: "Next.js 基礎 — App Router 入門") do |c|
  c.description = "App Router のファイル規約・レイアウト・ナビゲーションを学ぶ。"
  c.category    = "nextjs"
  c.difficulty  = "beginner"
  c.position    = 9
end

nl1 = Lesson.find_or_create_by!(course: nx01, position: 1) do |r|
  r.title   = "App Router とは"
  r.content = <<~MD
    ## App Router とは？

    Next.js 13+ で導入された**新しいルーティングシステム**です。`app/` ディレクトリを使います。

    ### ファイル規約

    | ファイル | 用途 |
    |---------|------|
    | `page.tsx` | ページコンポーネント（URL に対応） |
    | `layout.tsx` | 共通レイアウト（ネスト可能） |
    | `loading.tsx` | Suspense によるローディング UI |
    | `error.tsx` | エラーバウンダリ |
    | `not-found.tsx` | 404 ページ |

    ### ルーティング例

    ```
    app/
    ├── layout.tsx          # ルートレイアウト
    ├── page.tsx            # /
    ├── about/
    │   └── page.tsx        # /about
    └── blog/
        ├── page.tsx        # /blog
        └── [slug]/
            └── page.tsx    # /blog/any-slug
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nl1, position: 1) do |q|
  q.question    = "App Router でページを定義するファイル名は何ですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`page.tsx`（または `.js`）がそのディレクトリの URL に対応するページコンポーネントです。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "index.tsx",  position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "page.tsx",   position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "route.tsx",  position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "view.tsx",   position: 3) { |o| o.correct = false }
end

nl2 = Lesson.find_or_create_by!(course: nx01, position: 2) do |r|
  r.title   = "Server Components と Client Components"
  r.content = <<~MD
    ## Server Components と Client Components

    App Router では**デフォルトで Server Component**です。

    ### Server Component（デフォルト）
    - サーバーで実行、HTML を返す
    - `async/await` で直接データフェッチ可能
    - `useState`, `useEffect` は使えない

    ```tsx
    // app/courses/page.tsx - Server Component
    async function CoursesPage() {
      const courses = await fetchCourses(); // サーバーサイドで実行

      return (
        <ul>
          {courses.map(c => <li key={c.id}>{c.title}</li>)}
        </ul>
      );
    }
    ```

    ### Client Component
    - `"use client"` ディレクティブが必要
    - ブラウザで実行、インタラクティブ
    - Hooks が使える

    ```tsx
    "use client";
    import { useState } from "react";

    export function LikeButton() {
      const [liked, setLiked] = useState(false);
      return <button onClick={() => setLiked(!liked)}>{liked ? "♥" : "♡"}</button>;
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nl2, position: 1) do |q|
  q.question    = "App Router でコンポーネントをクライアントサイドで実行するために必要なディレクティブはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = '`"use client"` を ファイルの先頭に書くことで Client Component になります。'
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: '"use client"',      position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: '"use server"',      position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: '"client-side"',     position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: 'import "client"',   position: 3) { |o| o.correct = false }
end

nl3 = Lesson.find_or_create_by!(course: nx01, position: 3) do |r|
  r.title   = "Link と useRouter によるナビゲーション"
  r.content = <<~MD
    ## ナビゲーション

    ### Link コンポーネント
    クライアントサイドナビゲーション（ページ全体のリロードなし）。

    ```tsx
    import Link from "next/link";

    <Link href="/courses">コース一覧</Link>
    <Link href={`/courses/${id}`}>詳細</Link>
    ```

    ### useRouter
    プログラム的なナビゲーション（フォーム送信後のリダイレクトなど）。

    ```tsx
    "use client";
    import { useRouter } from "next/navigation";

    function LoginForm() {
      const router = useRouter();

      const handleSubmit = async () => {
        await login();
        router.push("/dashboard"); // リダイレクト
      };
    }
    ```

    ### usePathname / useSearchParams
    ```tsx
    "use client";
    import { usePathname, useSearchParams } from "next/navigation";

    function NavLink() {
      const pathname = usePathname(); // 現在のパス
      const searchParams = useSearchParams();
      const category = searchParams.get("category"); // クエリパラメータ
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nl3, position: 1) do |q|
  q.question    = "`useRouter` はどのパッケージからインポートしますか？（App Router の場合）"
  q.quiz_type   = "single_choice"
  q.explanation = "App Router では `next/navigation` からインポートします。Pages Router の `next/router` と混同しないよう注意。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "next/router",      position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "next/navigation",  position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "react-router-dom", position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "next/link",        position: 3) { |o| o.correct = false }
end

puts "Done! Courses: #{Course.count}, Lessons: #{Lesson.count}, Quizzes: #{Quiz.count}, Options: #{QuizOption.count}"
