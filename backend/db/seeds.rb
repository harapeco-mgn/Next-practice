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

# ============================================================
# Course TS-02: Utility Types実践
# ============================================================
ts02 = Course.find_or_create_by!(title: "Utility Types 実践") do |c|
  c.description = "Partial・Pick・Omit・ReturnType など実務で毎日使う Utility Types をマスターする。"
  c.category    = "typescript"
  c.difficulty  = "intermediate"
  c.position    = 4
end

ts02_l1 = Lesson.find_or_create_by!(course: ts02, position: 1) do |r|
  r.title   = "Partial・Required・Readonly"
  r.content = <<~MD
    ## Partial・Required・Readonly

    TypeScript には既存の型を変換する **Utility Types** が組み込まれています。

    ### Partial&lt;T&gt;
    全プロパティをオプショナルにします。フォームの更新処理でよく使います。

    ```typescript
    interface User {
      id: number;
      name: string;
      email: string;
    }

    // 更新時は一部のフィールドだけ送ることが多い
    function updateUser(id: number, data: Partial<User>) {
      // data.name は string | undefined
    }
    ```

    ### Required&lt;T&gt;
    全プロパティを必須にします。`Partial` の逆です。

    ### Readonly&lt;T&gt;
    全プロパティを読み取り専用にします。Redux の state や設定オブジェクトに使います。

    ```typescript
    const config: Readonly<{ apiUrl: string; timeout: number }> = {
      apiUrl: "https://api.example.com",
      timeout: 5000,
    };
    // config.apiUrl = "..."; // コンパイルエラー
    ```

    ### 落とし穴: Partial はシャロー
    `Partial` はネストしたオブジェクトには効きません。

    ```typescript
    interface Profile {
      user: { name: string; age: number };
    }
    type P = Partial<Profile>;
    // P.user は省略できるが、P.user.name は必須のまま
    ```
  MD
end

Quiz.find_or_create_by!(lesson: ts02_l1, position: 1) do |q|
  q.question    = "`Partial<User>` を使う最も適切なシーンはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`Partial` は更新処理など一部フィールドだけ送る場合に使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "ユーザー情報の更新（PATCHリクエスト）",   position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "新規ユーザーの作成（全フィールド必須）", position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "ユーザーIDの型定義",                    position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "読み取り専用の設定オブジェクト",         position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts02_l1, position: 2) do |q|
  q.question       = "`function updateUser(id: number, data: ___<User>) {}` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "Partial"
  q.explanation    = "更新処理では一部フィールドのみ受け取るため `Partial<User>` を使います。"
  q.position       = 2
end

ts02_l2 = Lesson.find_or_create_by!(course: ts02, position: 2) do |r|
  r.title   = "Pick・Omit・Record"
  r.content = <<~MD
    ## Pick・Omit・Record

    ### Pick&lt;T, K&gt;
    型から必要なプロパティだけ取り出します。

    ```typescript
    interface User {
      id: number;
      name: string;
      email: string;
      password: string;
    }

    // APIレスポンスではidとnameだけ必要
    type UserSummary = Pick<User, "id" | "name">;
    ```

    ### Omit&lt;T, K&gt;
    型から特定のプロパティを除外します。

    ```typescript
    // パスワードを含まない安全なUser型
    type SafeUser = Omit<User, "password">;
    ```

    ### Record&lt;K, V&gt;
    キーと値の型を指定したオブジェクト型を作ります。

    ```typescript
    // カテゴリラベルのマップ
    const categoryLabels: Record<string, string> = {
      typescript: "TypeScript",
      react: "React",
      nextjs: "Next.js",
    };

    // ユーザーIDをキーにしたマップ
    type UserMap = Record<number, User>;
    ```

    ### Pick vs Omit の使い分け
    - 必要なプロパティが少ない → `Pick`
    - 除外したいプロパティが少ない → `Omit`
  MD
end

Quiz.find_or_create_by!(lesson: ts02_l2, position: 1) do |q|
  q.question       = "`type SafeUser = ___(User, \"password\")` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "Omit"
  q.explanation    = "`Omit<T, K>` は指定したプロパティを除いた型を作ります。"
  q.position       = 1
end

Quiz.find_or_create_by!(lesson: ts02_l2, position: 2) do |q|
  q.question    = "`Pick` と `Omit` の使い分けとして正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "残したいプロパティが少ない場合は Pick、除外したいプロパティが少ない場合は Omit が適切です。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "残すプロパティが少ない → Pick、除外するプロパティが少ない → Omit", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Pick は必ず Omit より高速",                                        position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Omit は Pick の完全な上位互換",                                    position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "両者は異なる型を生成するため互換性がない",                         position: 3) { |o| o.correct = false }
end

ts02_l3 = Lesson.find_or_create_by!(course: ts02, position: 3) do |r|
  r.title   = "ReturnType・Parameters・Awaited"
  r.content = <<~MD
    ## ReturnType・Parameters・Awaited

    ### ReturnType&lt;typeof fn&gt;
    関数の戻り値型を取得します。既存の関数から型を逆引きできます。

    ```typescript
    async function fetchUser(id: number) {
      const res = await fetch(`/api/users/${id}`);
      return res.json() as Promise<{ id: number; name: string }>;
    }

    // 戻り値型を手動で書かなくてよい
    type FetchUserResult = ReturnType<typeof fetchUser>;
    // → Promise<{ id: number; name: string }>
    ```

    ### Parameters&lt;typeof fn&gt;
    関数の引数型をタプルで取得します。

    ```typescript
    type FetchUserParams = Parameters<typeof fetchUser>;
    // → [id: number]
    ```

    ### Awaited&lt;T&gt;
    Promise を解決した後の型を取得します。

    ```typescript
    type UserData = Awaited<ReturnType<typeof fetchUser>>;
    // → { id: number; name: string }
    ```

    ### 現場パターン
    APIクライアント関数の戻り値型を `ReturnType` で使い回すと、
    関数の実装を変更したときに型も自動で追従します。
  MD
end

Quiz.find_or_create_by!(lesson: ts02_l3, position: 1) do |q|
  q.question    = "`Awaited<Promise<string>>` の型は何ですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`Awaited<T>` は Promise を解決した後の型を返します。`Promise<string>` を解決すると `string` になります。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "string",           position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Promise<string>",  position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "string | Promise", position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "unknown",          position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts02_l3, position: 2) do |q|
  q.question       = "`type UserData = ___<typeof fetchUser>` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "ReturnType"
  q.explanation    = "`ReturnType<typeof fn>` で関数の戻り値型を取得できます。"
  q.position       = 2
end

# ============================================================
# Course TS-03: 型ガードとType Narrowing
# ============================================================
ts03 = Course.find_or_create_by!(title: "型ガードと Type Narrowing") do |c|
  c.description = "typeof・instanceof・ユーザー定義型ガード・Discriminated Union で型を安全に絞り込む。"
  c.category    = "typescript"
  c.difficulty  = "intermediate"
  c.position    = 5
end

ts03_l1 = Lesson.find_or_create_by!(course: ts03, position: 1) do |r|
  r.title   = "typeof・instanceof による型ガード"
  r.content = <<~MD
    ## typeof・instanceof による型ガード

    TypeScript では条件分岐の中で型が自動的に絞り込まれます（Narrowing）。

    ### typeof による絞り込み

    ```typescript
    function printValue(value: string | number) {
      if (typeof value === "string") {
        // ここでは value は string 型
        console.log(value.toUpperCase());
      } else {
        // ここでは value は number 型
        console.log(value.toFixed(2));
      }
    }
    ```

    ### 落とし穴: typeof null === "object"

    ```typescript
    typeof null === "object" // true！（JavaScriptの仕様）
    ```

    null チェックは必ず先に行いましょう。

    ### instanceof による絞り込み

    クラスのインスタンスを判定するときに使います。

    ```typescript
    class ApiError extends Error {
      constructor(public statusCode: number, message: string) {
        super(message);
      }
    }

    function handleError(error: unknown) {
      if (error instanceof ApiError) {
        console.log(`APIエラー: ${error.statusCode}`);
      } else if (error instanceof Error) {
        console.log(`エラー: ${error.message}`);
      }
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: ts03_l1, position: 1) do |q|
  q.question    = "`typeof null` の評価結果はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`typeof null` は JavaScript の仕様により `\"object\"` を返します。null チェックには `=== null` を使いましょう。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: '"object"',    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: '"null"',      position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: '"undefined"', position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: '"boolean"',   position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts03_l1, position: 2) do |q|
  q.question       = "`if (typeof value === \"___\") { return value.toUpperCase() }` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "string"
  q.explanation    = "`typeof value === \"string\"` で string 型に絞り込んでから `.toUpperCase()` を呼べます。"
  q.position       = 2
end

ts03_l2 = Lesson.find_or_create_by!(course: ts03, position: 2) do |r|
  r.title   = "ユーザー定義型ガード（is 演算子）"
  r.content = <<~MD
    ## ユーザー定義型ガード

    `typeof` や `instanceof` で判定できない場合は、自分で型ガード関数を書きます。

    ### type predicate の書き方

    ```typescript
    function isString(value: unknown): value is string {
      return typeof value === "string";
    }
    ```

    戻り値の型を `value is Type` と書くことで、TypeScript に型の絞り込みを伝えます。

    ### 現場パターン: APIエラーの判定

    ```typescript
    interface ApiError {
      code: string;
      message: string;
    }

    function isApiError(error: unknown): error is ApiError {
      return (
        typeof error === "object" &&
        error !== null &&
        "code" in error &&
        "message" in error
      );
    }

    // 使用例
    try {
      await fetchData();
    } catch (error) {
      if (isApiError(error)) {
        // error.code, error.message が使える
        showErrorMessage(error.message);
      }
    }
    ```

    ### axiosのエラー判定

    ```typescript
    import axios from "axios";

    function isAxiosError(error: unknown): error is axios.AxiosError {
      return axios.isAxiosError(error);
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: ts03_l2, position: 1) do |q|
  q.question    = "type predicate（型述語）の書き方として正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`value is Type` の形式で戻り値型を書くことで、TypeScript に型の絞り込みを伝えます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "value is Type",     position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "value as Type",     position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "value extends Type", position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "value instanceof Type", position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts03_l2, position: 2) do |q|
  q.question       = "`function isUser(value: unknown): value ___ User {` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "is"
  q.explanation    = "type predicate は `value is Type` の形式で書きます。"
  q.position       = 2
end

ts03_l3 = Lesson.find_or_create_by!(course: ts03, position: 3) do |r|
  r.title   = "Discriminated Union パターン"
  r.content = <<~MD
    ## Discriminated Union パターン

    共通の `type` フィールドで型を判別するパターンです。

    ### 基本パターン

    ```typescript
    type ApiResult =
      | { status: "success"; data: User }
      | { status: "error"; message: string }
      | { status: "loading" };

    function handleResult(result: ApiResult) {
      switch (result.status) {
        case "success":
          return <UserCard user={result.data} />;
        case "error":
          return <ErrorMessage message={result.message} />;
        case "loading":
          return <Spinner />;
      }
    }
    ```

    ### 現場での活用

    - **APIレスポンス**: 成功・失敗・ローディングの状態管理
    - **カスタムエラー型**: エラーの種類によって処理を分ける
    - **Reduxアクション型**: `action.type` で処理を振り分ける

    ### 落とし穴: 判別フィールドの不一致

    ```typescript
    // NG: 判別フィールドが異なる
    type Bad =
      | { kind: "success"; data: string }
      | { type: "error"; message: string }; // フィールド名が違う！
    ```

    判別フィールドは全ての型で**同じ名前**にしましょう。
  MD
end

Quiz.find_or_create_by!(lesson: ts03_l3, position: 1) do |q|
  q.question    = "Discriminated Union が最も有効なシーンはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Discriminated Union は共通のフィールドで複数の型を判別するパターンで、APIレスポンスの状態管理に最適です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "成功・エラー・ローディングのAPIレスポンス型", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "単純な文字列の型定義",                       position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "数値の範囲チェック",                         position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "配列の要素型定義",                           position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts03_l3, position: 2) do |q|
  q.question    = "Discriminated Union の判別フィールドについて正しい説明はどれですか？"
  q.quiz_type   = "true_false"
  q.explanation = "Discriminated Union の判別フィールドは全ての型で同じ名前を使う必要があります。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

ts03_l4 = Lesson.find_or_create_by!(course: ts03, position: 4) do |r|
  r.title   = "Exhaustive Check（網羅性チェック）"
  r.content = <<~MD
    ## Exhaustive Check（網羅性チェック）

    `never` 型を使って、switch 文などですべてのケースを処理したことをコンパイル時に保証します。

    ### assertNever パターン

    ```typescript
    function assertNever(x: never): never {
      throw new Error("Unhandled case: " + JSON.stringify(x));
    }

    type Shape =
      | { kind: "circle"; radius: number }
      | { kind: "square"; side: number }
      | { kind: "triangle"; base: number; height: number };

    function getArea(shape: Shape): number {
      switch (shape.kind) {
        case "circle":
          return Math.PI * shape.radius ** 2;
        case "square":
          return shape.side ** 2;
        case "triangle":
          return (shape.base * shape.height) / 2;
        default:
          return assertNever(shape); // 全ケースを網羅していないとコンパイルエラー
      }
    }
    ```

    ### 現場価値

    新しい `kind` を `Shape` 型に追加したとき、`getArea` の `switch` を更新し忘れると
    **コンパイルエラー**で気づけます。テストなしでも網羅性を保証できます。

    ### never 型とは

    `never` は「到達不能なコード」を表す型です。
    - 常に例外を投げる関数の戻り値型
    - `switch` の `default` で全ケースを処理済みの場合
  MD
end

Quiz.find_or_create_by!(lesson: ts03_l4, position: 1) do |q|
  q.question    = "`never` 型の説明として正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`never` は到達不能なコードを表す型です。全てのケースを処理した後の `default` や、常に例外を投げる関数の戻り値型として使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "到達不能なコードを表す型",                   position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "null と undefined の両方を表す型",           position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "void と同じ意味の型",                       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "任意の型に代入できる型",                     position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts03_l4, position: 2) do |q|
  q.question    = "Exhaustive Check は switch 文の `default` ブランチに `assertNever` を置くことで実現できる。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。`assertNever(x: never)` を `default` に置くことで、全ケースを処理していないとコンパイルエラーになります。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

# ============================================================
# Course TS-04: Generics実践
# ============================================================
ts04 = Course.find_or_create_by!(title: "Generics 実践") do |c|
  c.description = "Generic 関数・制約・Generic インターフェース・条件型を使って再利用性の高い型を書く。"
  c.category    = "typescript"
  c.difficulty  = "advanced"
  c.position    = 6
end

ts04_l1 = Lesson.find_or_create_by!(course: ts04, position: 1) do |r|
  r.title   = "Generic 関数の基礎"
  r.content = <<~MD
    ## Generic 関数の基礎

    Generics を使うと、型を引数として受け取る汎用的な関数を書けます。

    ### 基本構文

    ```typescript
    // T は型引数（任意の名前）
    function identity<T>(value: T): T {
      return value;
    }

    identity<string>("hello"); // string 型
    identity<number>(42);      // number 型
    identity("hello");         // 型推論で string と判定
    ```

    ### 実用的な例

    ```typescript
    function first<T>(arr: T[]): T | undefined {
      return arr[0];
    }

    const names = ["Alice", "Bob", "Carol"];
    const first_name = first(names); // string | undefined
    ```

    ### useState の型引数

    実は `useState` も Generics の使用例です。

    ```typescript
    const [user, setUser] = useState<User | null>(null);
    const [count, setCount] = useState<number>(0);
    ```

    ### Generic の恩恵
    - 同じロジックを異なる型で再利用できる
    - `any` を使わずに型安全を保てる
    - 型推論が働くため型引数を省略できることが多い
  MD
end

Quiz.find_or_create_by!(lesson: ts04_l1, position: 1) do |q|
  q.question    = "`useState<User | null>(null)` の `<User | null>` の役割はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "型引数として `User | null` を渡すことで、state の型を明示できます。これが Generics の典型的な使用例です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "useState に渡す型引数（state の型を明示）",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "useState のデフォルト値の型キャスト",          position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Optional Chaining の省略構文",                position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "TypeScript の比較演算子",                     position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts04_l1, position: 2) do |q|
  q.question       = "`function first<T>(arr: T[]): T | ___` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "undefined"
  q.explanation    = "配列が空の場合 `undefined` を返すため、戻り値型は `T | undefined` になります。"
  q.position       = 2
end

ts04_l2 = Lesson.find_or_create_by!(course: ts04, position: 2) do |r|
  r.title   = "Generic 制約（extends）"
  r.content = <<~MD
    ## Generic 制約（extends）

    型引数に制約をつけることで、特定のプロパティやメソッドの使用を保証できます。

    ### 基本的な制約

    ```typescript
    // T は必ず object 型
    function keys<T extends object>(obj: T): Array<keyof T> {
      return Object.keys(obj) as Array<keyof T>;
    }
    ```

    ### keyof を使った型安全なプロパティアクセス

    ```typescript
    function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
      return obj[key];
    }

    const user = { id: 1, name: "Alice", email: "alice@example.com" };
    getProperty(user, "name");  // OK: string
    getProperty(user, "age");   // コンパイルエラー: "age" は keyof User にない
    ```

    ### 落とし穴: 制約なしだとプロパティアクセスでエラー

    ```typescript
    // NG: T に制約がないと .length にアクセスできない
    function getLength<T>(value: T): number {
      return value.length; // エラー: T に length がない可能性
    }

    // OK: length プロパティを持つ型に制約
    function getLength<T extends { length: number }>(value: T): number {
      return value.length;
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: ts04_l2, position: 1) do |q|
  q.question    = "`<K extends keyof T>` の制約が意味することはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`K extends keyof T` は「K は T のプロパティ名のいずれか」という制約です。型安全なプロパティアクセスを実現します。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "K は T のプロパティ名のいずれか",            position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "K は T を継承したクラス",                   position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "K は T より小さい型",                       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "K と T は同じ型",                           position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts04_l2, position: 2) do |q|
  q.question       = "`function getProperty<T, K ___ keyof T>(obj: T, key: K): T[K]` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "extends"
  q.explanation    = "`K extends keyof T` で K を T のプロパティ名に制約します。"
  q.position       = 2
end

ts04_l3 = Lesson.find_or_create_by!(course: ts04, position: 3) do |r|
  r.title   = "Generic 型（インターフェース・型エイリアス）"
  r.content = <<~MD
    ## Generic 型

    インターフェースや型エイリアスにも型引数を使えます。

    ### ApiResponse パターン

    ```typescript
    interface ApiResponse<T> {
      data: T;
      status: number;
      message: string;
    }

    // 使用例
    type UserResponse = ApiResponse<User>;
    type CoursesResponse = ApiResponse<Course[]>;
    ```

    ### Maybe 型

    ```typescript
    type Maybe<T> = T | null | undefined;

    function findUser(id: number): Maybe<User> {
      return users.find(u => u.id === id);
    }
    ```

    ### カスタムフックの型設計

    ```typescript
    interface UseApiResult<T> {
      data: T | null;
      isLoading: boolean;
      error: string | null;
    }

    function useApi<T>(url: string): UseApiResult<T> {
      const [data, setData] = useState<T | null>(null);
      const [isLoading, setIsLoading] = useState(true);
      const [error, setError] = useState<string | null>(null);
      // ...fetch処理
      return { data, isLoading, error };
    }

    // 使用例
    const { data: user } = useApi<User>("/api/users/1");
    ```
  MD
end

Quiz.find_or_create_by!(lesson: ts04_l3, position: 1) do |q|
  q.question    = "`ApiResponse<User[]>` の `data` プロパティの型はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`ApiResponse<T>` の `data` は `T` 型です。`T` に `User[]` を渡すと `data: User[]` になります。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "User[]",         position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "User",           position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Array<unknown>", position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "T[]",            position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: ts04_l3, position: 2) do |q|
  q.question       = "`interface Paginated<___> { data: T[]; total: number }` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "T"
  q.explanation    = "型引数の名前は慣例的に `T` を使います。`interface Paginated<T>` が正しい書き方です。"
  q.position       = 2
end

# ============================================================
# Course RC-02: 基本Hooks
# ============================================================
rc02 = Course.find_or_create_by!(title: "基本 Hooks — useState・useEffect・useReducer") do |c|
  c.description = "useState の内部動作・useEffect の依存配列・useReducer と useContext を実践的に学ぶ。"
  c.category    = "react"
  c.difficulty  = "intermediate"
  c.position    = 7
end

rc02_l1 = Lesson.find_or_create_by!(course: rc02, position: 1) do |r|
  r.title   = "useState の内部動作と正しい使い方"
  r.content = <<~MD
    ## useState の内部動作と正しい使い方

    ### state 更新は非同期

    `setState` を呼んでも、直後に state の値を読んでも**まだ更新されていません**。

    ```tsx
    const [count, setCount] = useState(0);

    function handleClick() {
      setCount(count + 1);
      console.log(count); // まだ 0（更新は次のレンダリング後）
    }
    ```

    ### 関数型更新

    前の値を使って更新する場合は関数型更新を使います。

    ```tsx
    // NG: 連続して呼ぶとまとめられてしまう
    setCount(count + 1);
    setCount(count + 1); // 結果: 1（期待値: 2）

    // OK: 関数型更新
    setCount(prev => prev + 1);
    setCount(prev => prev + 1); // 結果: 2
    ```

    ### オブジェクト state はイミュータブルに更新

    ```tsx
    // NG: 直接変更しても再レンダリングされない
    user.name = "Bob";
    setUser(user);

    // OK: 新しいオブジェクトを作る
    setUser(prev => ({ ...prev, name: "Bob" }));
    ```

    ### Batching（バッチ処理）

    React 18 以降、イベントハンドラ内の複数の `setState` は1回のレンダリングにまとめられます。
  MD
end

Quiz.find_or_create_by!(lesson: rc02_l1, position: 1) do |q|
  q.question       = "`setCount(___ => ___ + 1)` の `___` を埋めてください（前の値を使った更新）。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "prev"
  q.explanation    = "関数型更新では `prev`（前の state 値）を引数として受け取ります。"
  q.position       = 1
end

Quiz.find_or_create_by!(lesson: rc02_l1, position: 2) do |q|
  q.question    = "`setState` 直後に `state` の値を読むと新しい値が得られる。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。`setState` は非同期で、state の更新は次のレンダリングで反映されます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

rc02_l2 = Lesson.find_or_create_by!(course: rc02, position: 2) do |r|
  r.title   = "useEffect の正しい使い方と依存配列"
  r.content = <<~MD
    ## useEffect の正しい使い方と依存配列

    ### 依存配列の3パターン

    ```tsx
    // 1. 依存配列なし: 毎レンダリング後に実行
    useEffect(() => { console.log("毎回"); });

    // 2. 空配列: マウント時のみ実行
    useEffect(() => { console.log("マウント時のみ"); }, []);

    // 3. 値あり: 値が変わったときに実行
    useEffect(() => { console.log("count が変わった"); }, [count]);
    ```

    ### クリーンアップ関数

    タイマー・イベントリスナー・WebSocket はクリーンアップが必要です。

    ```tsx
    useEffect(() => {
      const timer = setInterval(() => setCount(c => c + 1), 1000);
      return () => clearInterval(timer); // アンマウント時に実行
    }, []);
    ```

    ### 落とし穴: 依存配列にオブジェクト・関数を入れると毎回実行される

    ```tsx
    // NG: options は毎レンダリングで新しいオブジェクトが作られる
    useEffect(() => { fetchData(options); }, [options]);

    // OK: useMemo / useCallback でメモ化するか、必要な値のみ依存配列に入れる
    ```

    ### Strict Mode での2回実行

    開発環境では意図的に2回実行されます。クリーンアップが正しく実装されているか確認するためです。
  MD
end

Quiz.find_or_create_by!(lesson: rc02_l2, position: 1) do |q|
  q.question    = "クリーンアップ関数が必要なケースはどれですか？（複数選択）"
  q.quiz_type   = "multiple_choice"
  q.explanation = "タイマー・イベントリスナー・WebSocket サブスクリプションは、コンポーネントのアンマウント時に解除しないとメモリリークの原因になります。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "setInterval でタイマーを設定したとき", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "window.addEventListener で登録したとき", position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "WebSocket を接続したとき",              position: 2) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "単純なコンソールログを出力するとき",   position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc02_l2, position: 2) do |q|
  q.question    = "開発環境で `useEffect` が2回実行されるのはバグである。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。React 18 の Strict Mode では開発時に意図的に2回実行されます。クリーンアップが正しく実装されているか確認するためです。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

rc02_l3 = Lesson.find_or_create_by!(course: rc02, position: 3) do |r|
  r.title   = "useReducer・useContext"
  r.content = <<~MD
    ## useReducer・useContext

    ### useState vs useReducer

    ```
    useState  向き: 独立した単純な値
    useReducer向き: 複数の値が連動して変わる
                    次の状態が現在の状態に依存する
    ```

    ### useReducer の基本形

    ```tsx
    type Action =
      | { type: "increment" }
      | { type: "decrement" }
      | { type: "reset"; payload: number };

    function reducer(state: number, action: Action): number {
      switch (action.type) {
        case "increment": return state + 1;
        case "decrement": return state - 1;
        case "reset":     return action.payload;
        default:          return state;
      }
    }

    const [count, dispatch] = useReducer(reducer, 0);
    dispatch({ type: "increment" });
    ```

    ### useContext でグローバルに値を配布

    ```tsx
    const ThemeContext = createContext<"light" | "dark">("light");

    // Provider で囲む
    <ThemeContext.Provider value="dark">
      <App />
    </ThemeContext.Provider>

    // 任意の子コンポーネントで使う
    const theme = useContext(ThemeContext);
    ```

    ### 落とし穴: Context の値が変わると全 consumers が再レンダリング

    Context の値が変わると、その Context を `useContext` で使っている全コンポーネントが再レンダリングされます。
    関心ごとに Context を分割して影響範囲を最小化しましょう。
  MD
end

Quiz.find_or_create_by!(lesson: rc02_l3, position: 1) do |q|
  q.question    = "`useReducer` が適している状況はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`useReducer` は複数の state が連動して変化する複雑な状態管理に適しています。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "複数の値が連動して変わる複雑な状態管理", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "単純なボタンのon/off状態",              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "フォームの1つの入力値",                 position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "モーダルの開閉状態のみ",               position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc02_l3, position: 2) do |q|
  q.question       = "`const [state, ___] = useReducer(reducer, initialState)` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "dispatch"
  q.explanation    = "`useReducer` の第2戻り値は `dispatch` 関数で、action を発行するために使います。"
  q.position       = 2
end

# ============================================================
# Course RC-03: 応用Hooks
# ============================================================
rc03 = Course.find_or_create_by!(title: "応用 Hooks — useMemo・useCallback・useRef・並行処理") do |c|
  c.description = "パフォーマンス最適化のための Hooks と React 18 の並行処理機能を学ぶ。"
  c.category    = "react"
  c.difficulty  = "intermediate"
  c.position    = 8
end

rc03_l1 = Lesson.find_or_create_by!(course: rc03, position: 1) do |r|
  r.title   = "useMemo・useCallback の正しい使い方"
  r.content = <<~MD
    ## useMemo・useCallback の正しい使い方

    ### useMemo: 計算結果をメモ化

    ```tsx
    const sortedItems = useMemo(
      () => [...items].sort((a, b) => a.price - b.price),
      [items]
    );
    // items が変わらない限り sortedItems は同じ参照
    ```

    ### useCallback: 関数をメモ化

    ```tsx
    const handleSubmit = useCallback(
      async (data: FormData) => {
        await submitForm(data);
      },
      [] // 依存なし
    );
    ```

    ### いつ使うか

    ```
    useMemo:
      計算コストが高い処理（ソート・フィルタ・重い計算）
      参照同一性が必要（依存配列に入れる値）

    useCallback:
      memo() した子コンポーネントへ渡す関数
      useEffect の依存配列に入れる関数
    ```

    ### 重要: むやみに使うと逆効果

    メモ化自体にも計算コストがあります。
    **計測してから最適化する**のが原則です。
    プリミティブ値のメモ化は不要です。
  MD
end

Quiz.find_or_create_by!(lesson: rc03_l1, position: 1) do |q|
  q.question    = "`useCallback` を使うべき状況はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`useCallback` は `memo()` した子コンポーネントへ関数を渡す場合や、`useEffect` の依存配列に関数を入れる場合に有効です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "memo() した子コンポーネントへ渡す関数",        position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "全てのイベントハンドラ",                       position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "文字列を返す単純な関数",                       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "1回しか呼ばれない初期化関数",                  position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc03_l1, position: 2) do |q|
  q.question    = "全てのコンポーネントを `memo()` で囲むとパフォーマンスが向上する。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。`memo()` 自体にもコストがあり、むやみに使うと逆効果になります。計測してから最適化しましょう。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

rc03_l2 = Lesson.find_or_create_by!(course: rc03, position: 2) do |r|
  r.title   = "useRef の活用パターン"
  r.content = <<~MD
    ## useRef の活用パターン

    ### DOM 参照

    ```tsx
    function TextInput() {
      const inputRef = useRef<HTMLInputElement>(null);

      const focus = () => {
        inputRef.current?.focus();
      };

      return (
        <>
          <input ref={inputRef} type="text" />
          <button onClick={focus}>フォーカス</button>
        </>
      );
    }
    ```

    ### 再レンダリングをまたいで値を保持

    `useRef` に値を入れても再レンダリングが起きません。

    ```tsx
    const prevValue = useRef<string>("");

    useEffect(() => {
      console.log(`前の値: ${prevValue.current}, 現在の値: ${currentValue}`);
      prevValue.current = currentValue; // 前回の値を保持
    });
    ```

    ### useRef vs useState の使い分け

    ```
    表示に使う値 → useState（変更で再レンダリングが必要）
    内部処理のみ → useRef（変更で再レンダリング不要）
    ```

    ### タイマー ID の保持

    ```tsx
    const timerRef = useRef<ReturnType<typeof setInterval>>();

    useEffect(() => {
      timerRef.current = setInterval(() => { /* ... */ }, 1000);
      return () => clearInterval(timerRef.current);
    }, []);
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc03_l2, position: 1) do |q|
  q.question    = "`useRef` と `useState` の最大の違いはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`useRef` の値を変更しても再レンダリングは起きません。表示に関係ない内部処理の値保持に使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "useRef は値の変更で再レンダリングが起きない",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "useRef は初期値を設定できない",                 position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "useRef は DOM 参照にしか使えない",               position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "useRef は Server Component で使える",           position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc03_l2, position: 2) do |q|
  q.question       = "`const inputRef = useRef<___>(null)` で input 要素への参照を作るとき `___` に入る型は？"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "HTMLInputElement"
  q.explanation    = "`useRef<HTMLInputElement>(null)` で input 要素への型安全な参照を作れます。"
  q.position       = 2
end

rc03_l3 = Lesson.find_or_create_by!(course: rc03, position: 3) do |r|
  r.title   = "useTransition・useDeferredValue（並行処理）"
  r.content = <<~MD
    ## useTransition・useDeferredValue

    React 18 の並行機能を使うと、重い処理でも UI の応答性を保てます。

    ### useTransition

    低優先度の状態更新をマークします。

    ```tsx
    const [isPending, startTransition] = useTransition();

    function handleSearch(value: string) {
      setInput(value);                         // 高優先度: 即座に反映
      startTransition(() => setQuery(value));  // 低優先度: 余裕ができたら実行
    }

    return (
      <>
        <input value={input} onChange={e => handleSearch(e.target.value)} />
        {isPending && <Spinner />}
        <SearchResults query={query} />
      </>
    );
    ```

    ### useDeferredValue

    受け取った値を遅延させます（Props 経由の場合に使う）。

    ```tsx
    const deferredQuery = useDeferredValue(query);
    // deferredQuery が古い間は isPending 的に扱える
    ```

    ### 使い分け

    ```
    useTransition:    自分で setState を呼ぶとき
    useDeferredValue: Props や外から来た値を遅延させるとき
    ```

    ### 現場での使いどころ

    - 大量データのフィルタリング
    - 検索ボックスのリアルタイム絞り込み
    - タブ切り替えで重いコンポーネントを遅延レンダリング
  MD
end

Quiz.find_or_create_by!(lesson: rc03_l3, position: 1) do |q|
  q.question    = "`startTransition` 内に入れるべき処理はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`startTransition` は低優先度の state 更新（重い描画を伴うもの）をマークするために使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "大量データのフィルタリング結果を表示する state 更新", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "入力フィールドのテキスト更新",                      position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "fetch によるデータ取得",                           position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "エラー状態の更新",                                 position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc03_l3, position: 2) do |q|
  q.question       = "`const [___, startTransition] = useTransition()` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "isPending"
  q.explanation    = "`useTransition` は `[isPending, startTransition]` を返します。`isPending` は遷移中かどうかを示します。"
  q.position       = 2
end

# ============================================================
# Course RC-04: コンポーネント設計パターン
# ============================================================
rc04 = Course.find_or_create_by!(title: "コンポーネント設計パターン") do |c|
  c.description = "ディレクトリ構造・TypeScript × React の型パターン・カスタムフック・フォーム設計を学ぶ。"
  c.category    = "react"
  c.difficulty  = "intermediate"
  c.position    = 9
end

rc04_l1 = Lesson.find_or_create_by!(course: rc04, position: 1) do |r|
  r.title   = "ディレクトリ構造パターンと選び方"
  r.content = <<~MD
    ## ディレクトリ構造パターン

    プロジェクトの規模やチームに合わせてディレクトリ構造を選びましょう。

    ### ① タイプ別（小規模向け）

    ```
    components/
      auth/       # LoginForm, RegisterForm
      layout/     # Header, Footer
      ui/         # Button, Badge, Input
    hooks/
    lib/
    ```

    ### ② フィーチャー別（中〜大規模・現場で最も多い）

    ```
    features/
      auth/
        components/   # LoginForm, RegisterForm
        hooks/        # useAuth
        api/          # authApi
        types.ts
      courses/
        components/   # CourseCard, CourseList
        hooks/        # useCourses
    components/       # アプリ全体で共通のUIのみ
    ```

    機能単位でまとまるので**削除・移植が容易**です。

    ### ③ Atomic Design（デザインシステムあり）

    atoms → molecules → organisms → templates の階層で管理。
    小規模では過剰になりやすいです。

    ### ④ コロケーション（Next.js App Router 推奨）

    ```
    app/
      courses/
        _components/  # courses 専用（外から使わない）
        [courseId]/
          _components/
          page.tsx
    components/       # 本当に全体で共通のものだけ
    ```

    `_` プレフィックスでルーティングから除外されます。
  MD
end

Quiz.find_or_create_by!(lesson: rc04_l1, position: 1) do |q|
  q.question    = "Atomic Design の説明として正しいものはどれですか？"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。Atomic Design はデザインシステムを持つ大規模チーム向けです。小規模では過剰になりやすく、粒度の判断も難しいです。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

Quiz.find_or_create_by!(lesson: rc04_l1, position: 2) do |q|
  q.question    = "現場で最も多く採用されているディレクトリ構造はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "フィーチャー別構成は機能単位でまとまるため削除・移植が容易で、中〜大規模の現場で最も多く使われます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "フィーチャー別（feature-based）", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "タイプ別（type-based）",         position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Atomic Design",                 position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "コロケーション",                 position: 3) { |o| o.correct = false }
end

rc04_l2 = Lesson.find_or_create_by!(course: rc04, position: 2) do |r|
  r.title   = "TypeScript × React の型パターン"
  r.content = <<~MD
    ## TypeScript × React の型パターン

    ### イベントハンドラの正しい型

    ```tsx
    // NG: any になってしまう
    const handleClick = (e) => { ... }

    // OK: 明示的に型を指定
    const handleClick  = (e: React.MouseEvent<HTMLButtonElement>) => { ... }
    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => { ... }
    const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => { ... }
    ```

    ### ReactNode vs ReactElement の違い

    ```typescript
    React.ReactNode     // 最も広い（string・number・null も含む）← children の型はこれ
    React.ReactElement  // JSX が返すオブジェクト（null は含まない）
    JSX.Element         // React.ReactElement と同じ（古い書き方）
    ```

    ### React.ComponentProps で HTML 要素の型を再利用

    ```tsx
    interface ButtonProps extends React.ComponentProps<'button'> {
      variant?: 'primary' | 'secondary'
    }

    function Button({ variant = 'primary', ...props }: ButtonProps) {
      return <button {...props} className={`btn-${variant}`} />
    }
    ```

    ### React.FC を使わない理由

    `React.FC` は TypeScript の型推論を妨げる場合があるため、
    現在は**関数の戻り値型を明示しない**書き方が主流です。
  MD
end

Quiz.find_or_create_by!(lesson: rc04_l2, position: 1) do |q|
  q.question    = "`children` の型として最も適切なものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`React.ReactNode` は最も広い型で、string・number・null・JSX 要素など全てを含みます。`children` の型には `React.ReactNode` を使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "React.ReactNode",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "React.ReactElement", position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "JSX.Element",        position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "React.FC",           position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc04_l2, position: 2) do |q|
  q.question       = "`const handleChange = (e: React.___Event<HTMLInputElement>) => {}` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "Change"
  q.explanation    = "input の onChange イベントには `React.ChangeEvent<HTMLInputElement>` を使います。"
  q.position       = 2
end

rc04_l3 = Lesson.find_or_create_by!(course: rc04, position: 3) do |r|
  r.title   = "カスタムフックによるロジックの分離"
  r.content = <<~MD
    ## カスタムフックによるロジックの分離

    コンポーネントからロジックを切り出し、再利用性と可読性を高めます。

    ### 設計原則

    - 1つのカスタムフックは1つの責務
    - `use` プレフィックスを必ずつける
    - 戻り値の型を明示する

    ### useLocalStorage

    ```tsx
    function useLocalStorage<T>(key: string, initialValue: T) {
      const [value, setValue] = useState<T>(() => {
        if (typeof window === "undefined") return initialValue;
        try {
          const item = localStorage.getItem(key);
          return item ? JSON.parse(item) : initialValue;
        } catch {
          return initialValue;
        }
      });

      const setStoredValue = (newValue: T) => {
        setValue(newValue);
        localStorage.setItem(key, JSON.stringify(newValue));
      };

      return [value, setStoredValue] as const;
    }
    ```

    ### useDebounce

    ```tsx
    function useDebounce<T>(value: T, delay: number): T {
      const [debouncedValue, setDebouncedValue] = useState(value);

      useEffect(() => {
        const timer = setTimeout(() => setDebouncedValue(value), delay);
        return () => clearTimeout(timer);
      }, [value, delay]);

      return debouncedValue;
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc04_l3, position: 1) do |q|
  q.question    = "カスタムフックに切り出すべき処理はどれですか？（複数選択）"
  q.quiz_type   = "multiple_choice"
  q.explanation = "カスタムフックには複数のコンポーネントで再利用されるロジックや、コンポーネントをシンプルに保つために切り出すべきロジックを移します。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "複数コンポーネントで使う API 取得ロジック", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ローカルストレージの読み書き",              position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "単純な JSX の return 文",                  position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "デバウンス処理",                           position: 3) { |o| o.correct = true }
end

Quiz.find_or_create_by!(lesson: rc04_l3, position: 2) do |q|
  q.question       = "`function useDebounce<T>(value: T, delay: number): ___ {` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "T"
  q.explanation    = "`useDebounce` は遅延させた値を返すため、戻り値の型は入力値と同じ型 `T` になります。"
  q.position       = 2
end

# ============================================================
# Course RC-05: 状態管理の設計
# ============================================================
rc05 = Course.find_or_create_by!(title: "状態管理の設計 — Context・TanStack Query・Zustand") do |c|
  c.description = "state の置き場所の判断・Context API の最適化・TanStack Query・Zustand を学ぶ。"
  c.category    = "react"
  c.difficulty  = "advanced"
  c.position    = 10
end

rc05_l1 = Lesson.find_or_create_by!(course: rc05, position: 1) do |r|
  r.title   = "state の置き場所を決める原則"
  r.content = <<~MD
    ## state の置き場所を決める原則

    state をどこに置くかで設計の品質が大きく変わります。

    ### 判断フロー

    ```
    1. そのコンポーネント内だけで使う
       → ローカル state（useState）

    2. 兄弟コンポーネントと共有する
       → 共通の親に state を lift up

    3. 離れたコンポーネントと共有する
       → Context / 外部ストア（Zustand 等）

    4. サーバーのデータ（一覧・詳細など）
       → TanStack Query / SWR
    ```

    ### Props drilling の問題

    ```tsx
    // NG: UserAvatar まで user を drilling
    <App user={user}>
      <Header user={user}>
        <Nav user={user}>
          <UserAvatar user={user} />
        </Nav>
      </Header>
    </App>
    ```

    Context や外部ストアで解決できます。

    ### URL を state として使う

    フィルタ・ページネーション・タブの選択状態は URL の `searchParams` に持たせると
    ブックマーク・共有・ブラウザバックが自然に動きます。

    ```tsx
    const searchParams = useSearchParams();
    const category = searchParams.get("category") ?? "all";
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc05_l1, position: 1) do |q|
  q.question    = "Props drilling を解決する方法はどれですか？（複数選択）"
  q.quiz_type   = "multiple_choice"
  q.explanation = "Context API・外部ストア（Zustand 等）・コンポーネント合成が Props drilling の解決策です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "Context API を使う",                    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Zustand などの外部ストアを使う",         position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "コンポーネント合成（children パターン）", position: 2) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "さらに深いネストに props を渡す",        position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc05_l1, position: 2) do |q|
  q.question    = "URL の searchParams を state として使うメリットはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "URL に state を持たせることでブックマーク・共有・ブラウザバックが自然に機能します。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "ブックマークや URL 共有でも状態が復元される", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "サーバーに state が自動保存される",           position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "再レンダリングがなくなる",                    position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "localStorage より高速",                      position: 3) { |o| o.correct = false }
end

rc05_l2 = Lesson.find_or_create_by!(course: rc05, position: 2) do |r|
  r.title   = "Context API の設計と最適化"
  r.content = <<~MD
    ## Context API の設計と最適化

    ### Context を分割してre-renderを最小化

    ```tsx
    // 悪い例: 全てを1つの Context に入れる
    const AppContext = createContext({ user, theme, cart });
    // user が変わると theme や cart を使うコンポーネントも再レンダリング

    // 良い例: 関心ごとに分割
    const UserContext  = createContext<User | null>(null);
    const ThemeContext = createContext<"light" | "dark">("light");
    ```

    ### カスタムフックで Context を隠蔽

    ```tsx
    export function useUser() {
      const ctx = useContext(UserContext);
      if (!ctx) throw new Error("UserProvider の外で useUser を使っています");
      return ctx;
    }
    ```

    コンポーネントは `useContext(UserContext)` ではなく `useUser()` を呼ぶだけになります。

    ### Provider をネストする場合のパターン

    ```tsx
    export function AppProviders({ children }: { children: React.ReactNode }) {
      return (
        <UserProvider>
          <ThemeProvider>
            <QueryProvider>
              {children}
            </QueryProvider>
          </ThemeProvider>
        </UserProvider>
      );
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc05_l2, position: 1) do |q|
  q.question    = "Context を分割する主な理由はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Context の値が変わると全 consumers が再レンダリングされます。関心ごとに分割することで不要な再レンダリングを防げます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "不要な再レンダリングを防ぐため",              position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ファイルサイズを小さくするため",              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "TypeScript のエラーを減らすため",            position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Provider のネストを浅くするため",            position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc05_l2, position: 2) do |q|
  q.question       = "`export function useUser() { return useContext(___Context) }` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "User"
  q.explanation    = "`useContext(UserContext)` でユーザー情報を取得します。カスタムフックでラップすると使いやすくなります。"
  q.position       = 2
end

rc05_l3 = Lesson.find_or_create_by!(course: rc05, position: 3) do |r|
  r.title   = "TanStack Query によるサーバーデータ管理"
  r.content = <<~MD
    ## TanStack Query によるサーバーデータ管理

    サーバーのデータ（API レスポンス）はクライアントの UI state とは別物です。
    TanStack Query はサーバーデータの取得・キャッシュ・再検証を専門に扱います。

    ### useQuery の基本

    ```tsx
    const { data, isLoading, error } = useQuery({
      queryKey: ["courses"],
      queryFn: () => coursesApi.list(),
      staleTime: 60_000,  // 60秒間はキャッシュを使う
    });
    ```

    ### queryKey の役割

    - キャッシュの識別子
    - 同じ `queryKey` なら同じキャッシュを共有
    - 配列の要素が変わると再 fetch される

    ```tsx
    useQuery({ queryKey: ["courses", { category }], queryFn: ... })
    // category が変わると自動で再 fetch
    ```

    ### useMutation でデータ更新

    ```tsx
    const mutation = useMutation({
      mutationFn: (newCourse: CreateCourseInput) => coursesApi.create(newCourse),
      onSuccess: () => {
        queryClient.invalidateQueries({ queryKey: ["courses"] });
      },
    });

    mutation.mutate({ title: "新しいコース" });
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc05_l3, position: 1) do |q|
  q.question    = "`queryKey` の役割はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`queryKey` はキャッシュの識別子です。同じキーなら同じキャッシュを共有し、キーが変わると再 fetch されます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "キャッシュの識別子（同じキーなら同じキャッシュを共有）", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "API エンドポイントのパス",                              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "データの型情報",                                       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "リクエストのタイムアウト設定",                          position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc05_l3, position: 2) do |q|
  q.question    = "`staleTime: 60_000` の説明として正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`staleTime` はキャッシュが「古い（stale）」とみなされるまでの時間（ms）です。60_000ms = 60秒間はキャッシュを使い、再 fetch しません。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "60秒間は再 fetch せずキャッシュを使う",      position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "60秒後に自動でキャッシュを削除する",         position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "60秒ごとにバックグラウンドで fetch する",    position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "fetch のタイムアウトを60秒に設定する",       position: 3) { |o| o.correct = false }
end

rc05_l4 = Lesson.find_or_create_by!(course: rc05, position: 4) do |r|
  r.title   = "Zustand によるグローバル状態管理"
  r.content = <<~MD
    ## Zustand によるグローバル状態管理

    Zustand は Context より簡単・Redux より軽量なグローバル状態管理ライブラリです。

    ### 基本的なストア定義

    ```typescript
    import { create } from "zustand";

    interface AuthStore {
      user: User | null;
      setUser: (user: User | null) => void;
      logout: () => void;
    }

    const useAuthStore = create<AuthStore>((set) => ({
      user: null,
      setUser: (user) => set({ user }),
      logout: () => set({ user: null }),
    }));
    ```

    ### Selector で必要な値だけ取得

    ```tsx
    // コンポーネント全体を再レンダリングしない
    const user = useAuthStore((state) => state.user);
    const logout = useAuthStore((state) => state.logout);
    ```

    ### persist ミドルウェアで永続化

    ```typescript
    import { persist } from "zustand/middleware";

    const useAuthStore = create<AuthStore>()(
      persist(
        (set) => ({ user: null, setUser: (user) => set({ user }) }),
        { name: "auth-storage" }  // localStorage のキー名
      )
    );
    ```

    ### Next.js App Router での注意点

    Server Component では Zustand は使えません（ブラウザ専用）。
    `"use client"` コンポーネントからのみ呼び出してください。
  MD
end

Quiz.find_or_create_by!(lesson: rc05_l4, position: 1) do |q|
  q.question    = "Zustand の Selector（`useStore(state => state.user)` 形式）を使うメリットはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Selector を使うと必要な値だけ購読でき、その値が変わったときだけ再レンダリングされます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "必要な値だけ購読して不要な再レンダリングを防ぐ", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ストアの初期値を設定できる",                    position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "非同期処理を同期的に実行できる",                position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Server Component でも使えるようになる",         position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc05_l4, position: 2) do |q|
  q.question    = "Zustand は Next.js の Server Component でも使える。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。Zustand はブラウザ専用です。Server Component では使えません。`'use client'` のコンポーネントからのみ呼び出してください。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

# ============================================================
# Course RC-06: パフォーマンス最適化
# ============================================================
rc06 = Course.find_or_create_by!(title: "React パフォーマンス最適化") do |c|
  c.description = "re-render の計測・memo/useMemo/useCallback の実践・遅延ローディング・仮想スクロールを学ぶ。"
  c.category    = "react"
  c.difficulty  = "advanced"
  c.position    = 11
end

rc06_l1 = Lesson.find_or_create_by!(course: rc06, position: 1) do |r|
  r.title   = "re-render の仕組みと計測"
  r.content = <<~MD
    ## re-render の仕組みと計測

    ### re-render が発生する4つの条件

    1. **state が変化**した（`setState` が呼ばれた）
    2. **Props が変化**した（参照が変わった）
    3. **親コンポーネントが re-render** された
    4. **Context の値が変化**した（`useContext` を使っている場合）

    ### 重要: 親が re-render すると子も re-render

    Props が変わっていなくても、親が再レンダリングされると子も再レンダリングされます。
    これを防ぐには `memo()` を使います。

    ### React DevTools Profiler で計測

    1. Chrome の React DevTools を開く
    2. Profiler タブ → 録画ボタンをクリック
    3. UI を操作
    4. 録画停止 → どのコンポーネントが何ms かかったか確認

    ### 計測してから最適化

    ```
    ❌ 推測で最適化する（むやみに memo() を追加する）
    ✅ Profiler で計測 → 本当にコストが高い箇所を特定 → 最適化
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc06_l1, position: 1) do |q|
  q.question    = "re-render が発生する条件はどれですか？（複数選択）"
  q.quiz_type   = "multiple_choice"
  q.explanation = "state 変化・Props 変化・親の re-render・Context 変化の4つが re-render のトリガーです。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "state が変化した",          position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "親コンポーネントが re-render された", position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "使用している Context の値が変化した", position: 2) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ブラウザのウィンドウサイズが変わった", position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc06_l1, position: 2) do |q|
  q.question    = "Props が変わっていなくても親が re-render されると子も re-render される。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。これを防ぐには `memo()` でコンポーネントをラップします。ただし必ず計測してから適用しましょう。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

rc06_l2 = Lesson.find_or_create_by!(course: rc06, position: 2) do |r|
  r.title   = "memo・useMemo・useCallback の実践"
  r.content = <<~MD
    ## memo・useMemo・useCallback の実践

    ### memo() でコンポーネントをメモ化

    ```tsx
    // Props が変わらない限り再レンダリングしない
    const CourseCard = memo(function CourseCard({ course }: { course: Course }) {
      return <div>{course.title}</div>;
    });
    ```

    ### memo() が効かない例

    ```tsx
    // NG: 毎レンダリングで新しい関数・オブジェクトを渡している
    <CourseCard
      course={course}
      onSelect={() => handleSelect(course.id)}  // 毎回新しい参照
    />
    ```

    `useCallback` で関数をメモ化することで解決します。

    ### useMemo でリストのソート・フィルタをキャッシュ

    ```tsx
    const filteredCourses = useMemo(
      () => courses.filter(c => c.category === category),
      [courses, category]
    );
    ```

    ### アンチパターン

    - 計測せずにメモ化する
    - プリミティブ値（文字列・数値）をメモ化する
    - 全コンポーネントを `memo()` で囲む
    - 軽い計算を `useMemo` でメモ化する（オーバーヘッドのほうが大きい）
  MD
end

Quiz.find_or_create_by!(lesson: rc06_l2, position: 1) do |q|
  q.question    = "`useMemo` が有効な状況はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`useMemo` は計算コストが高い処理や、参照同一性が必要な場合に使います。単純な文字列結合などには不要です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "数万件のリストのフィルタリング・ソート処理", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "単純な文字列の結合",                        position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "true/false の切り替え",                    position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "全てのコンポーネントのプロパティ",          position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc06_l2, position: 2) do |q|
  q.question       = "コンポーネントを `memo()` でメモ化しても、子に `() => handleSelect(id)` を渡していると効果がない。これを解決するには `___` で関数をメモ化する。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "useCallback"
  q.explanation    = "`useCallback` で関数をメモ化することで、`memo()` した子コンポーネントへの不要な再レンダリングを防げます。"
  q.position       = 2
end

rc06_l3 = Lesson.find_or_create_by!(course: rc06, position: 3) do |r|
  r.title   = "遅延ローディングとコード分割"
  r.content = <<~MD
    ## 遅延ローディングとコード分割

    重いコンポーネントやライブラリを必要になってから読み込みます。

    ### React.lazy() + Suspense

    ```tsx
    import { lazy, Suspense } from "react";

    const HeavyChart = lazy(() => import("./HeavyChart"));

    function Dashboard() {
      return (
        <Suspense fallback={<div className="h-64 bg-gray-100 animate-pulse" />}>
          <HeavyChart />
        </Suspense>
      );
    }
    ```

    ### Next.js の dynamic()

    ```tsx
    import dynamic from "next/dynamic";

    // SSR を無効化（ブラウザ専用ライブラリ）
    const MonacoEditor = dynamic(() => import("@monaco-editor/react"), {
      ssr: false,
      loading: () => <div className="h-64 bg-gray-100 animate-pulse" />,
    });
    ```

    ### { ssr: false } を使うべき場面

    - `window` / `document` を直接使うライブラリ
    - LocalStorage を初期化時に読むコンポーネント
    - Web Audio API など Node.js に存在しない API を使うもの

    ### バンドルサイズを確認

    ```bash
    next build
    # .next/analyze/ でバンドルの可視化
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc06_l3, position: 1) do |q|
  q.question    = "`dynamic()` に `{ ssr: false }` を渡すべき状況はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`ssr: false` は `window` や `document` など Node.js に存在しない API を使うライブラリに必要です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "window オブジェクトを使うブラウザ専用ライブラリ", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "全てのサードパーティライブラリ",                 position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "React コンポーネント全般",                       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "API を呼ぶカスタムフック",                       position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc06_l3, position: 2) do |q|
  q.question       = "`const HeavyChart = React.___()`  でコンポーネントを遅延読み込みする `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "lazy"
  q.explanation    = "`React.lazy()` を使って動的インポートでコンポーネントを遅延読み込みします。必ず `Suspense` でラップしてください。"
  q.position       = 2
end

rc06_l4 = Lesson.find_or_create_by!(course: rc06, position: 4) do |r|
  r.title   = "仮想スクロールと大量データの扱い"
  r.content = <<~MD
    ## 仮想スクロールと大量データの扱い

    ### 問題: 10,000件のリストをそのまま render すると？

    全要素を DOM に追加するため、
    - 初期描画が遅い
    - スクロール時にカクつく
    - メモリ使用量が増大する

    ### 解決策: 仮想スクロール

    **画面に見えている部分だけ** DOM に描画します。
    スクロール位置に応じて描画する要素を動的に切り替えます。

    ```tsx
    import { useVirtual } from "react-virtual";

    function LargeList({ items }: { items: Item[] }) {
      const parentRef = useRef<HTMLDivElement>(null);
      const rowVirtualizer = useVirtual({
        size: items.length,
        parentRef,
        estimateSize: () => 50, // 1行の推定高さ
      });

      return (
        <div ref={parentRef} style={{ height: "500px", overflow: "auto" }}>
          <div style={{ height: rowVirtualizer.totalSize }}>
            {rowVirtualizer.virtualItems.map(virtualRow => (
              <div key={virtualRow.index} style={{ transform: `translateY(${virtualRow.start}px)` }}>
                {items[virtualRow.index].name}
              </div>
            ))}
          </div>
        </div>
      );
    }
    ```

    ### ページネーション vs 無限スクロール

    ```
    ページネーション: 管理系UI・検索結果（ブックマーク可能）
    無限スクロール:  SNS フィード・コンテンツ消費型UI
    ```

    **まずページネーションで十分か考える**のが現場の判断基準です。
  MD
end

Quiz.find_or_create_by!(lesson: rc06_l4, position: 1) do |q|
  q.question    = "仮想スクロールが解決する問題はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "仮想スクロールは画面に見えている部分だけ DOM に描画することで、大量データのレンダリングパフォーマンス問題を解決します。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "大量データを全て DOM に描画する際のパフォーマンス問題", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "API レスポンスの遅延問題",                             position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "CSS アニメーションの最適化",                           position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "サーバーサイドレンダリングの速度",                     position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc06_l4, position: 2) do |q|
  q.question    = "1万件のデータを全て DOM に描画してもパフォーマンスは問題ない。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。全要素を DOM に追加すると初期描画が遅くなり、スクロール時のカクつきやメモリ増大の原因になります。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

# ============================================================
# Course RC-07: React 19の新機能
# ============================================================
rc07 = Course.find_or_create_by!(title: "React 19 の新機能") do |c|
  c.description = "use Hook・Actions・useActionState・useOptimistic など React 19 の新 API を学ぶ。"
  c.category    = "react"
  c.difficulty  = "intermediate"
  c.position    = 12
end

rc07_l1 = Lesson.find_or_create_by!(course: rc07, position: 1) do |r|
  r.title   = "use Hook"
  r.content = <<~MD
    ## use Hook

    React 19 で追加された `use` は通常の Hook のルールとは異なる特別な Hook です。

    ### use(promise) で Promise をアンラップ

    ```tsx
    import { use, Suspense } from "react";

    function UserName({ userPromise }: { userPromise: Promise<User> }) {
      const user = use(userPromise); // Suspense でフォールバック UI を表示
      return <span>{user.name}</span>;
    }

    // 親コンポーネント
    function App() {
      const userPromise = fetchUser(1); // fetch を開始
      return (
        <Suspense fallback={<Spinner />}>
          <UserName userPromise={userPromise} />
        </Suspense>
      );
    }
    ```

    ### use(context) で Context を読む

    ```tsx
    const theme = use(ThemeContext); // useContext と同じ効果
    ```

    ### 通常の Hook との違い

    **通常の Hook**: コンポーネントのトップレベルのみで呼べる

    **use**: 条件分岐や早期 return の中でも呼べる

    ```tsx
    function Component({ show }: { show: boolean }) {
      if (show) {
        const data = use(dataPromise); // OK! 条件分岐内でも可
        return <div>{data.title}</div>;
      }
      return null;
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc07_l1, position: 1) do |q|
  q.question    = "`use()` が通常の Hooks と異なる点はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`use()` は条件分岐や早期 return の中でも呼べます。通常の Hooks はコンポーネントのトップレベルのみで呼ぶ必要があります。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "条件分岐の中でも呼べる",              position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Server Component でも使える",         position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "useState の代替として使える",          position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "副作用なしで API を呼べる",            position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc07_l1, position: 2) do |q|
  q.question    = "`use(promise)` を使うとき、親コンポーネントに必要な要素はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`use(promise)` は Promise が解決するまでサスペンドします。親コンポーネントに `<Suspense fallback={...}>` が必要です。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "Suspense",         position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ErrorBoundary",    position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "StrictMode",       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Profiler",         position: 3) { |o| o.correct = false }
end

rc07_l2 = Lesson.find_or_create_by!(course: rc07, position: 2) do |r|
  r.title   = "Actions と useActionState"
  r.content = <<~MD
    ## Actions と useActionState

    React 19 では、フォームの `action` に async 関数を渡せるようになりました。

    ### useActionState

    アクションの pending・error・result を管理します。

    ```tsx
    import { useActionState } from "react";

    async function loginAction(prevState: State, formData: FormData) {
      const email = formData.get("email") as string;
      const password = formData.get("password") as string;

      const result = await login(email, password);
      if (!result.success) {
        return { error: "ログインに失敗しました" };
      }
      return { success: true };
    }

    function LoginForm() {
      const [state, action, isPending] = useActionState(loginAction, null);

      return (
        <form action={action}>
          <input name="email" type="email" />
          <input name="password" type="password" />
          <button disabled={isPending}>
            {isPending ? "ログイン中..." : "ログイン"}
          </button>
          {state?.error && <p>{state.error}</p>}
        </form>
      );
    }
    ```

    ### useFormStatus

    フォームの送信状態を子コンポーネントから取得できます。

    ```tsx
    import { useFormStatus } from "react-dom";

    function SubmitButton() {
      const { pending } = useFormStatus();
      return <button disabled={pending}>{pending ? "送信中..." : "送信"}</button>;
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rc07_l2, position: 1) do |q|
  q.question    = "`useActionState` の第一引数に渡すものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`useActionState(actionFn, initialState)` の第一引数はアクション関数（`async` 関数）です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "async アクション関数",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "初期 state の値",         position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "フォームの ref",           position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "バリデーションスキーマ",  position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc07_l2, position: 2) do |q|
  q.question       = "`const [state, action, ___] = useActionState(myAction, null)` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "isPending"
  q.explanation    = "`useActionState` は `[state, action, isPending]` を返します。`isPending` はアクション実行中かどうかを示します。"
  q.position       = 2
end

rc07_l3 = Lesson.find_or_create_by!(course: rc07, position: 3) do |r|
  r.title   = "useOptimistic による楽観的更新"
  r.content = <<~MD
    ## useOptimistic による楽観的更新

    サーバーのレスポンスを待たずに UI を先に更新してユーザー体験を向上させます。

    ### 基本パターン

    ```tsx
    import { useOptimistic } from "react";

    function LikeButton({ post }: { post: Post }) {
      const [optimisticLikes, addOptimisticLike] = useOptimistic(
        post.likes,
        (currentLikes, newLike: Like) => [...currentLikes, newLike]
      );

      async function handleLike() {
        const tempLike = { id: Date.now(), userId: currentUser.id };
        addOptimisticLike(tempLike);  // 即座に UI を更新

        try {
          await likesApi.create(post.id);  // サーバーに送信
        } catch {
          // エラーが発生すると optimisticLikes は自動でロールバック
        }
      }

      return (
        <button onClick={handleLike}>
          ❤️ {optimisticLikes.length}
        </button>
      );
    }
    ```

    ### エラー時の自動ロールバック

    Server Action や `useTransition` の処理が失敗した場合、
    楽観的更新は自動的にロールバックされます。

    ### 現場での使いどころ

    - いいね・ブックマーク・チェック操作
    - ドラッグ&ドロップの順序変更
    - ステータスの切り替え
  MD
end

Quiz.find_or_create_by!(lesson: rc07_l3, position: 1) do |q|
  q.question    = "楽観的更新が有効な UI 操作はどれですか？（複数選択）"
  q.quiz_type   = "multiple_choice"
  q.explanation = "楽観的更新はレスポンスの速いフィードバックが重要な操作に有効です。いいね・ブックマーク・チェックなど即時性が重要な操作に使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "いいねボタンの押下",             position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ブックマークの追加",             position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "タスクの完了チェック",           position: 2) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ユーザー登録フォームの送信",     position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rc07_l3, position: 2) do |q|
  q.question    = "楽観的更新でエラーが発生した場合、自動で元の状態に戻る。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。`useOptimistic` はアクションが失敗した場合、楽観的に更新した値を自動でロールバックします。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

# ============================================================
# Course NX-02: エラーハンドリングとローディングUI
# ============================================================
nx02 = Course.find_or_create_by!(title: "エラーハンドリングとローディング UI") do |c|
  c.description = "loading.tsx・error.tsx・not-found.tsx を使ってユーザー体験を高めるエラー/ローディング設計を学ぶ。"
  c.category    = "nextjs"
  c.difficulty  = "intermediate"
  c.position    = 13
end

nx02_l1 = Lesson.find_or_create_by!(course: nx02, position: 1) do |r|
  r.title   = "loading.tsx でスケルトン UI を作る"
  r.content = <<~MD
    ## loading.tsx でスケルトン UI を作る

    `loading.tsx` を配置するだけで、そのルートのデータ取得中にスケルトン UI を表示できます。

    ### 仕組み

    `loading.tsx` は Next.js が自動的に `<Suspense>` でラップします。
    Server Component が非同期処理中の間、`loading.tsx` の内容が表示されます。

    ### スケルトン UI の実装

    ```tsx
    // app/courses/loading.tsx
    export default function CoursesLoading() {
      return (
        <div className="grid grid-cols-3 gap-6">
          {[...Array(6)].map((_, i) => (
            <div key={i} className="h-48 bg-gray-200 rounded-xl animate-pulse" />
          ))}
        </div>
      );
    }
    ```

    ### スコープ

    `loading.tsx` はそのディレクトリと配下のルートに適用されます。

    ```
    app/
      courses/
        loading.tsx     ← /courses と /courses/[courseId] に適用
        page.tsx
        [courseId]/
          page.tsx
    ```

    ### 現場価値

    実装コストが低く、体感速度の向上に大きく貢献します。
    `animate-pulse` の Tailwind クラスでアニメーションが簡単に追加できます。
  MD
end

Quiz.find_or_create_by!(lesson: nx02_l1, position: 1) do |q|
  q.question    = "`loading.tsx` が適用されるスコープの正しい説明はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`loading.tsx` はそのディレクトリと配下のルート全体に適用されます。Next.js が自動的に Suspense でラップします。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "配置したディレクトリと配下のルートに適用される",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "配置したディレクトリのみに適用される",              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "アプリ全体に適用される",                           position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "page.tsx と同じファイルにのみ適用される",          position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx02_l1, position: 2) do |q|
  q.question       = "`export default function Loading() { return <div className=\"animate-___\" /> }` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "pulse"
  q.explanation    = "Tailwind CSS の `animate-pulse` クラスでフェードするアニメーションを追加できます。スケルトン UI の標準的な実装です。"
  q.position       = 2
end

nx02_l2 = Lesson.find_or_create_by!(course: nx02, position: 2) do |r|
  r.title   = "error.tsx でエラー境界を実装する"
  r.content = <<~MD
    ## error.tsx でエラー境界を実装する

    `error.tsx` はルートレベルのエラー境界です。

    ### 必須: 'use client'

    ```tsx
    "use client"; // エラー境界は必ず Client Component

    interface ErrorProps {
      error: Error & { digest?: string };
      reset: () => void;
    }

    export default function CourseError({ error, reset }: ErrorProps) {
      return (
        <div className="flex flex-col items-center gap-4 p-8">
          <h2 className="text-xl font-bold">エラーが発生しました</h2>
          <p className="text-gray-600">{error.message}</p>
          <button
            onClick={reset}
            className="px-4 py-2 bg-blue-500 text-white rounded"
          >
            再試行
          </button>
        </div>
      );
    }
    ```

    ### 'use client' が必須な理由

    エラー境界の `reset` 関数やブラウザ API を使うため、
    クライアントサイドで実行する必要があります。

    ### 落とし穴

    `error.tsx` は**同階層の `layout.tsx` のエラーは捕捉できません**。
    root の layout エラーには `global-error.tsx` を使います。

    ### notFound() 関数

    ```tsx
    import { notFound } from "next/navigation";

    async function CoursePage({ params }: { params: { courseId: string } }) {
      const course = await getCoure(params.courseId);
      if (!course) notFound(); // 404 ページへ
      return <CourseDetail course={course} />;
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx02_l2, position: 1) do |q|
  q.question    = "`error.tsx` に `'use client'` が必須な理由はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "エラー境界は `reset` 関数（クライアントサイドの再試行）を使うため、Client Component である必要があります。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "reset 関数など Client Component の機能が必要なため", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Server Component ではエラーを捕捉できないため",      position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Next.js の制約で error.tsx は常に Client Component", position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "TypeScript のコンパイルエラーを防ぐため",            position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx02_l2, position: 2) do |q|
  q.question       = "`export default function Error({ error, ___ }: { error: Error, ___: () => void })` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "reset"
  q.explanation    = "`error.tsx` は `error` と `reset` の2つの props を受け取ります。`reset` を呼ぶと再試行できます。"
  q.position       = 2
end

nx02_l3 = Lesson.find_or_create_by!(course: nx02, position: 3) do |r|
  r.title   = "not-found.tsx と notFound() 関数"
  r.content = <<~MD
    ## not-found.tsx と notFound() 関数

    ### not-found.tsx の実装

    ```tsx
    // app/not-found.tsx
    import Link from "next/link";

    export default function NotFound() {
      return (
        <div className="flex flex-col items-center gap-6 py-24">
          <h1 className="text-6xl font-bold text-gray-300">404</h1>
          <h2 className="text-2xl font-semibold">ページが見つかりません</h2>
          <p className="text-gray-500">お探しのページは存在しないか、移動した可能性があります。</p>
          <Link href="/" className="text-blue-500 hover:underline">
            トップページへ戻る
          </Link>
        </div>
      );
    }
    ```

    ### 動的ページでの使い方

    ```tsx
    import { notFound } from "next/navigation";

    async function CoursePage({ params }: { params: { id: string } }) {
      const course = await fetchCourse(params.id);

      if (!course) {
        notFound(); // not-found.tsx が表示される
      }

      return <CourseDetail course={course} />;
    }
    ```

    ### エラー分類と対応方針

    ```
    404（存在しないリソース） → not-found.tsx
    API 失敗・予期せぬエラー → error.tsx（retry ボタン付き）
    root layout のエラー    → global-error.tsx
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx02_l3, position: 1) do |q|
  q.question    = "`notFound()` 関数を呼んだときの動作として正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`notFound()` を呼ぶと Next.js は `not-found.tsx` を表示します。動的ルートでリソースが存在しない場合に使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "not-found.tsx が表示される（404 レスポンス）", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "error.tsx が表示される",                      position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "ホームページにリダイレクトされる",             position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "コンポーネントが null をレンダリングする",     position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx02_l3, position: 2) do |q|
  q.question    = "`error.tsx` は同階層の `layout.tsx` のエラーも捕捉できる。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。`error.tsx` は同階層の `layout.tsx` のエラーは捕捉できません。root の layout のエラーには `global-error.tsx` を使います。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

# ============================================================
# Course NX-03: Server Actionsとデータ更新
# ============================================================
nx03 = Course.find_or_create_by!(title: "Server Actions とデータ更新") do |c|
  c.description = "'use server'・フォーム統合・revalidatePath・楽観的更新を使ったデータ更新パターンを学ぶ。"
  c.category    = "nextjs"
  c.difficulty  = "intermediate"
  c.position    = 14
end

nx03_l1 = Lesson.find_or_create_by!(course: nx03, position: 1) do |r|
  r.title   = "Server Actions の仕組みと制約"
  r.content = <<~MD
    ## Server Actions の仕組みと制約

    Server Actions を使うと、API Route を作らずにフォームの POST 処理をサーバーで書けます。

    ### 基本構文

    ```tsx
    // server action を定義
    async function createCourse(formData: FormData) {
      "use server"; // この関数はサーバーで実行される

      const title = formData.get("title") as string;
      await db.course.create({ data: { title } });
    }

    // フォームに直接渡す
    export default function NewCourseForm() {
      return (
        <form action={createCourse}>
          <input name="title" placeholder="コースタイトル" />
          <button type="submit">作成</button>
        </form>
      );
    }
    ```

    ### 'use server' ファイルで一元管理

    ```typescript
    // app/actions/courses.ts
    "use server";

    export async function createCourse(formData: FormData) { ... }
    export async function updateCourse(id: string, formData: FormData) { ... }
    export async function deleteCourse(id: string) { ... }
    ```

    ### 制約

    - サーバーで実行される → `window`・`localStorage` などブラウザ API は使えない
    - 引数は**シリアライズ可能な値**のみ（関数・クラスインスタンスは不可）
    - `redirect()` は `try-catch` の外で呼ぶ

    ### Progressive Enhancement

    JavaScript が無効でも動作します（HTML フォームの POST として機能）。
  MD
end

Quiz.find_or_create_by!(lesson: nx03_l1, position: 1) do |q|
  q.question    = "Server Action が実行される場所はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Server Action は `'use server'` ディレクティブにより、常にサーバー上で実行されます。クライアントからの呼び出しは HTTP リクエストに変換されます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "サーバー（Node.js 環境）",            position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ブラウザ（クライアント環境）",         position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Edge ランタイム",                     position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "呼び出し元に依存する",                position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx03_l1, position: 2) do |q|
  q.question       = "`async function createCourse(formData: ___) { 'use server'; }` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "FormData"
  q.explanation    = "フォームの `action` に Server Action を渡した場合、引数として `FormData` を受け取ります。"
  q.position       = 2
end

nx03_l2 = Lesson.find_or_create_by!(course: nx03, position: 2) do |r|
  r.title   = "フォームと Server Actions の統合"
  r.content = <<~MD
    ## フォームと Server Actions の統合

    ### useActionState でエラーを UI に返す

    ```tsx
    "use client";
    import { useActionState } from "react";
    import { loginAction } from "@/app/actions/auth";

    export function LoginForm() {
      const [state, action, isPending] = useActionState(loginAction, null);

      return (
        <form action={action}>
          <input name="email" type="email" required />
          <input name="password" type="password" required />
          {state?.error && (
            <p className="text-red-500">{state.error}</p>
          )}
          <button type="submit" disabled={isPending}>
            {isPending ? "ログイン中..." : "ログイン"}
          </button>
        </form>
      );
    }
    ```

    ### Server Action の実装

    ```typescript
    // app/actions/auth.ts
    "use server";
    import { redirect } from "next/navigation";

    type State = { error: string } | null;

    export async function loginAction(prevState: State, formData: FormData): Promise<State> {
      const email = formData.get("email") as string;
      const password = formData.get("password") as string;

      if (!email || !password) {
        return { error: "メールアドレスとパスワードは必須です" };
      }

      // 認証処理...
      const result = await authenticate(email, password);
      if (!result.success) {
        return { error: "認証に失敗しました" };
      }

      redirect("/dashboard"); // try-catch の外で呼ぶ
    }
    ```

    ### 落とし穴: redirect() は try-catch の中では使えない

    `redirect()` は内部的に例外を投げます。`try-catch` で囲むと捕捉されてしまいます。
  MD
end

Quiz.find_or_create_by!(lesson: nx03_l2, position: 1) do |q|
  q.question    = "`redirect()` を `try-catch` の中で呼んではいけない理由はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`redirect()` は内部的に例外を投げることでリダイレクトを実現します。`try-catch` の中では例外が捕捉されてリダイレクトが機能しません。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "内部的に例外を投げるため try-catch で捕捉されてしまう", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "redirect() は非同期関数だから",                        position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Server Action 内では redirect() は使えない",           position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "TypeScript の型エラーになるから",                      position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx03_l2, position: 2) do |q|
  q.question    = "Server Action でバリデーションエラーを UI に返す方法として正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Server Action からエラーオブジェクトを `return` することで、`useActionState` の `state` にエラーが反映されます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "エラーオブジェクトを return する",         position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "throw new Error() で例外を投げる",        position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "localStorage にエラーを保存する",         position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "console.error() でログを出力する",        position: 3) { |o| o.correct = false }
end

nx03_l3 = Lesson.find_or_create_by!(course: nx03, position: 3) do |r|
  r.title   = "revalidatePath・revalidateTag によるキャッシュ更新"
  r.content = <<~MD
    ## revalidatePath・revalidateTag によるキャッシュ更新

    Server Action でデータを更新した後、キャッシュを無効化して最新データを表示します。

    ### revalidatePath

    指定したパスのキャッシュを無効化します。

    ```typescript
    "use server";
    import { revalidatePath } from "next/cache";
    import { redirect } from "next/navigation";

    export async function createCourse(formData: FormData) {
      const title = formData.get("title") as string;

      await db.course.create({ data: { title } });

      revalidatePath("/courses"); // コース一覧のキャッシュを無効化
      redirect("/courses");       // 一覧ページへリダイレクト
    }
    ```

    ### revalidateTag

    タグベースで細かい制御ができます。

    ```typescript
    // データ取得時にタグを付ける
    const courses = await fetch("/api/courses", {
      next: { tags: ["courses"] }
    });

    // アクション後にタグで無効化
    revalidateTag("courses"); // "courses" タグのキャッシュを全て無効化
    ```

    ### revalidatePath vs revalidateTag

    ```
    revalidatePath: パス単位の無効化（シンプル）
    revalidateTag:  タグ単位の無効化（複数ページにまたがるデータ）
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx03_l3, position: 1) do |q|
  q.question    = "`revalidatePath` を呼ぶ適切なタイミングはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "DB を更新した後にキャッシュを無効化することで、次のアクセス時に最新データが取得されます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "DB を更新する Server Action の後",       position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ページをレンダリングする前",              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "useEffect の中で定期的に",               position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "アプリの起動時に一度だけ",              position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx03_l3, position: 2) do |q|
  q.question       = "`revalidatePath('___')` でコース一覧（/courses）を再検証するときの `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "/courses"
  q.explanation    = "`revalidatePath('/courses')` でコース一覧ページのキャッシュを無効化できます。"
  q.position       = 2
end

nx03_l4 = Lesson.find_or_create_by!(course: nx03, position: 4) do |r|
  r.title   = "楽観的更新（useOptimistic）with Server Actions"
  r.content = <<~MD
    ## 楽観的更新（useOptimistic）with Server Actions

    Server Action の完了を待たずに UI を先に更新してユーザー体験を向上させます。

    ### パターン

    ```tsx
    "use client";
    import { useOptimistic } from "react";
    import { toggleBookmark } from "@/app/actions/bookmarks";

    function BookmarkButton({ courseId, initialBookmarked }: Props) {
      const [optimisticBookmarked, setOptimisticBookmarked] = useOptimistic(
        initialBookmarked,
        (_, newValue: boolean) => newValue
      );

      async function handleToggle() {
        setOptimisticBookmarked(!optimisticBookmarked); // 即座に UI 更新
        await toggleBookmark(courseId);                  // Server Action
      }

      return (
        <button onClick={handleToggle}>
          {optimisticBookmarked ? "★ 保存済み" : "☆ 保存する"}
        </button>
      );
    }
    ```

    ### 注意点

    - Server Action が完了するとサーバーからの最新データで上書きされます
    - Server Action が失敗すると楽観的更新は自動でロールバックされます
    - Server Action は `startTransition` の中で呼ぶことが推奨されます
  MD
end

Quiz.find_or_create_by!(lesson: nx03_l4, position: 1) do |q|
  q.question    = "楽観的更新が失敗したとき（Server Action がエラーになったとき）の動作はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "楽観的更新は Server Action が失敗すると自動でロールバックされます。元の状態に戻ります。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "楽観的更新が自動でロールバックされる",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "エラーページに遷移する",                 position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "楽観的更新のまま状態が固定される",        position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "ページがリロードされる",                 position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx03_l4, position: 2) do |q|
  q.question    = "Server Action を呼ぶ前に `useOptimistic` の setter を呼ぶことで、サーバーのレスポンスを待たずに UI を更新できる。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。`setOptimisticValue()` を呼んだ後に Server Action を呼ぶことで、レスポンスを待たずに UI を先行更新できます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

# ============================================================
# Course NX-04: Middleware認証ガード
# ============================================================
nx04 = Course.find_or_create_by!(title: "Middleware 認証ガード") do |c|
  c.description = "middleware.ts で JWT を検証してページを保護する。Edge ランタイムの制約と対応ライブラリを学ぶ。"
  c.category    = "nextjs"
  c.difficulty  = "intermediate"
  c.position    = 15
end

nx04_l1 = Lesson.find_or_create_by!(course: nx04, position: 1) do |r|
  r.title   = "Middleware の仕組みと実行タイミング"
  r.content = <<~MD
    ## Middleware の仕組みと実行タイミング

    `middleware.ts` はリクエストがページに到達する**前**に実行されます。

    ### 配置場所と基本構文

    ```typescript
    // プロジェクトルート（src/ を使っている場合は src/middleware.ts）
    // middleware.ts

    import { NextRequest, NextResponse } from "next/server";

    export function middleware(request: NextRequest) {
      // リクエストの前処理
      return NextResponse.next(); // 次の処理へ
    }

    // どのパスに適用するか
    export const config = {
      matcher: ["/dashboard/:path*", "/courses/:path*"],
    };
    ```

    ### matcher の設定

    ```typescript
    export const config = {
      matcher: [
        // /dashboard と /dashboard/ 以下の全パス
        "/dashboard/:path*",
        // 静的ファイルと _next を除外するパターン
        "/((?!_next/static|_next/image|favicon.ico).*)",
      ],
    };
    ```

    ### Edge ランタイムで動く

    Middleware は Edge ランタイムで動くため:
    - 低レイテンシで実行される
    - Node.js の API が使えない（`fs`・`crypto` など）
    - `jsonwebtoken` は使えない → `jose` を使う
  MD
end

Quiz.find_or_create_by!(lesson: nx04_l1, position: 1) do |q|
  q.question    = "Middleware が実行されるタイミングはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Middleware はリクエストがページ・API Route・静的ファイルに到達する前に実行されます。認証チェックに最適なタイミングです。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "リクエストがページに到達する前",              position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "ページのレンダリング完了後",                  position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "クライアントがレスポンスを受信した後",         position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "データベースクエリの実行前のみ",              position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx04_l1, position: 2) do |q|
  q.question       = "`export const config = { matcher: ['___'] }` で `/dashboard` 以下の全パスを指定するときの `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "/dashboard/:path*"
  q.explanation    = "`:path*` は0個以上のパスセグメントにマッチします。`/dashboard/:path*` で `/dashboard` と配下の全パスに適用されます。"
  q.position       = 2
end

nx04_l2 = Lesson.find_or_create_by!(course: nx04, position: 2) do |r|
  r.title   = "JWT を Middleware で検証する"
  r.content = <<~MD
    ## JWT を Middleware で検証する

    ### jose ライブラリを使った JWT 検証

    Edge ランタイム対応の JWT ライブラリ `jose` を使います。

    ```typescript
    // middleware.ts
    import { NextRequest, NextResponse } from "next/server";
    import { jwtVerify } from "jose";

    const JWT_SECRET = new TextEncoder().encode(process.env.JWT_SECRET);

    export async function middleware(request: NextRequest) {
      const token = request.cookies.get("token")?.value;

      // トークンがない → ログインページへ
      if (!token) {
        return NextResponse.redirect(new URL("/login", request.url));
      }

      try {
        await jwtVerify(token, JWT_SECRET);
        return NextResponse.next(); // 検証成功
      } catch {
        // トークンが無効 → ログインページへ
        return NextResponse.redirect(new URL("/login", request.url));
      }
    }

    export const config = {
      matcher: ["/dashboard/:path*"],
    };
    ```

    ### 落とし穴: jsonwebtoken は Edge ランタイムでは動かない

    `jsonwebtoken` は Node.js 専用です。
    Middleware の Edge ランタイムでは **`jose`** を使いましょう。
  MD
end

Quiz.find_or_create_by!(lesson: nx04_l2, position: 1) do |q|
  q.question    = "Edge ランタイムの Middleware で JWT 検証に使えるライブラリはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`jose` は Edge ランタイムに対応した JWT ライブラリです。`jsonwebtoken` は Node.js 専用で Middleware では使えません。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "jose",          position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "jsonwebtoken",  position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "jwt-decode",    position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "passport-jwt",  position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx04_l2, position: 2) do |q|
  q.question    = "`jsonwebtoken` は Next.js の Middleware で使える。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。`jsonwebtoken` は Node.js 専用です。Middleware は Edge ランタイムで動くため、Edge 対応の `jose` を使う必要があります。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

nx04_l3 = Lesson.find_or_create_by!(course: nx04, position: 3) do |r|
  r.title   = "ログイン状態に応じたリダイレクト制御"
  r.content = <<~MD
    ## ログイン状態に応じたリダイレクト制御

    ### ログイン済みユーザーの /login アクセスを /dashboard へ

    ```typescript
    export async function middleware(request: NextRequest) {
      const token = request.cookies.get("token")?.value;
      const { pathname } = request.nextUrl;

      // 認証ページへのアクセス
      if (pathname.startsWith("/login") || pathname.startsWith("/register")) {
        if (token) {
          // ログイン済みなら /dashboard へ
          return NextResponse.redirect(new URL("/dashboard", request.url));
        }
        return NextResponse.next();
      }

      // 保護されたページへのアクセス
      if (!token) {
        // redirect パラメータでログイン後の遷移先を伝える
        const loginUrl = new URL("/login", request.url);
        loginUrl.searchParams.set("redirect", pathname);
        return NextResponse.redirect(loginUrl);
      }

      return NextResponse.next();
    }
    ```

    ### ログイン後に元のページへ

    ```tsx
    // /login?redirect=/dashboard/settings からアクセスした場合
    const searchParams = useSearchParams();
    const redirectTo = searchParams.get("redirect") ?? "/dashboard";

    // ログイン成功後
    router.push(redirectTo);
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx04_l3, position: 1) do |q|
  q.question    = "ログイン後に元のページへリダイレクトするベストプラクティスはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`/login?redirect=/original/path` のように URL パラメータで遷移先を伝え、ログイン成功後にそのパスへリダイレクトします。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "URL の redirect パラメータで遷移先を伝える",   position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "常に固定の /dashboard へリダイレクトする",     position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "localStorage に遷移先を保存する",              position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Cookie に遷移先を保存する",                    position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx04_l3, position: 2) do |q|
  q.question    = "Middleware でリダイレクトするには `NextResponse.___(new URL('/login', request.url))` を返す。"
  q.quiz_type   = "fill_in_blank"
  q.correct_answer = "redirect"
  q.explanation = "`NextResponse.redirect(url)` でリダイレクトレスポンスを返します。"
  q.position    = 2
end

# ============================================================
# Course NX-05: データフェッチパターン
# ============================================================
nx05 = Course.find_or_create_by!(title: "データフェッチパターンとキャッシュ戦略") do |c|
  c.description = "Server vs Client Component での fetch・Suspense による段階ローディング・Next.js の4種類のキャッシュを学ぶ。"
  c.category    = "nextjs"
  c.difficulty  = "intermediate"
  c.position    = 16
end

nx05_l1 = Lesson.find_or_create_by!(course: nx05, position: 1) do |r|
  r.title   = "Server Component vs Client Component でのデータ取得"
  r.content = <<~MD
    ## Server Component vs Client Component でのデータ取得

    ### どちらで fetch するかの判断基準

    **Server Component 向き:**
    - 初期表示データ（SEO が必要なコンテンツ）
    - 認証不要な一覧・詳細
    - API キーを隠す必要があるリクエスト
    - バンドルサイズを増やしたくない

    **Client Component 向き:**
    - ユーザー操作でデータが変わる（フィルタ・ソート）
    - リアルタイム更新
    - ブラウザ API が必要（LocalStorage 等）

    ### Server Component での fetch

    ```tsx
    // app/courses/page.tsx
    async function CoursesPage() {
      const courses = await fetchCourses(); // サーバーサイドで実行

      return (
        <ul>
          {courses.map(c => <li key={c.id}>{c.title}</li>)}
        </ul>
      );
    }
    ```

    ### 現場の設計思想

    **できるだけ Server Component にする**（クライアントバンドルサイズ削減）。
    インタラクションが必要な部分だけ Client Component にします。
  MD
end

Quiz.find_or_create_by!(lesson: nx05_l1, position: 1) do |q|
  q.question    = "Server Component での JWT 送信方法として正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Server Component ではブラウザの localStorage にアクセスできないため、Cookie から JWT を取得して Authorization ヘッダーに付与します。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "cookies() で Cookie から JWT を取得して Authorization ヘッダーに付与", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "localStorage から JWT を取得",                                        position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "JWT は自動的に付与されるため何もしなくてよい",                        position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "sessionStorage から JWT を取得",                                      position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx05_l1, position: 2) do |q|
  q.question    = "`Server ComponentからのAPIリクエストにJWTトークンを自動付与できる`（localStorage から）"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。Server Component はサーバーサイドで実行されるため localStorage にアクセスできません。JWT は Cookie から取得する必要があります。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

nx05_l2 = Lesson.find_or_create_by!(course: nx05, position: 2) do |r|
  r.title   = "Next.js のキャッシュ戦略"
  r.content = <<~MD
    ## Next.js のキャッシュ戦略

    Next.js には4種類のキャッシュレイヤーがあります。

    ### 4種類のキャッシュ

    ```
    1. Request Memoization
       同一レンダリング内での重複リクエストを排除

    2. Data Cache
       fetch 結果のサーバーサイドキャッシュ（デプロイをまたいで永続）

    3. Full Route Cache
       ビルド時の静的 HTML キャッシュ

    4. Router Cache
       クライアントサイドのルートキャッシュ
    ```

    ### fetch のキャッシュオプション

    ```typescript
    // デフォルト: キャッシュする（静的）
    fetch("/api/courses")

    // キャッシュしない（常に最新）
    fetch("/api/courses", { cache: "no-store" })

    // 60秒後に再検証（ISR）
    fetch("/api/courses", { next: { revalidate: 60 } })

    // タグベースの再検証
    fetch("/api/courses", { next: { tags: ["courses"] } })
    ```

    ### ルート単位のキャッシュ設定

    ```typescript
    // page.tsx or layout.tsx でエクスポート
    export const revalidate = 3600;        // 1時間ごとに再生成
    export const dynamic = "force-dynamic"; // 常に動的（no-store 相当）
    ```

    ### 判断フロー

    ```
    コンテンツが変わらない  → デフォルト（静的）
    定期的に更新           → revalidate: N秒
    リアルタイム・認証データ → cache: 'no-store'
    特定イベントで更新      → revalidateTag / revalidatePath
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx05_l2, position: 1) do |q|
  q.question    = "`fetch('/api/data', { next: { revalidate: 60 } })` の説明として正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`revalidate: 60` は60秒間キャッシュを使い、60秒後に次のリクエスト時に再 fetch します（ISR の動作）。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "60秒後に次のリクエスト時に再 fetch する（ISR）",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "60秒ごとにバックグラウンドで自動 fetch する",       position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "60秒以内のリクエストをキューに溜める",             position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "60秒後にキャッシュを削除する",                     position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx05_l2, position: 2) do |q|
  q.question       = "`export const ___ = 'force-dynamic'` でルートを動的レンダリングにする変数名を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "dynamic"
  q.explanation    = "`export const dynamic = 'force-dynamic'` でそのルートを常に動的レンダリングにします。`cache: 'no-store'` と同等の効果です。"
  q.position       = 2
end

nx05_l3 = Lesson.find_or_create_by!(course: nx05, position: 3) do |r|
  r.title   = "Suspense を使った段階的ローディング"
  r.content = <<~MD
    ## Suspense を使った段階的ローディング

    `<Suspense>` でコンポーネント単位のローディング UI を実現します。

    ### コンポーネント単位のローディング

    ```tsx
    import { Suspense } from "react";
    import { CourseList } from "./_components/CourseList";
    import { CourseListSkeleton } from "./_components/CourseListSkeleton";

    export default function CoursesPage() {
      return (
        <div>
          <h1>コース一覧</h1>
          <Suspense fallback={<CourseListSkeleton />}>
            <CourseList />  {/* 内部で async fetch */}
          </Suspense>
        </div>
      );
    }
    ```

    ### 並列 fetch で高速化

    ```tsx
    export default async function CoursePage({ params }) {
      // 並列で fetch（直列にすると遅い）
      const [course, reviews] = await Promise.all([
        fetchCourse(params.id),
        fetchReviews(params.id),
      ]);

      return <CourseDetail course={course} reviews={reviews} />;
    }
    ```

    ### loading.tsx vs Suspense の使い分け

    ```
    loading.tsx:  ページ全体のローディング（簡単に実装できる）
    Suspense:     コンポーネント単位の細かい制御が必要な場合
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx05_l3, position: 1) do |q|
  q.question    = "`loading.tsx` と `<Suspense>` の使い分けとして正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`loading.tsx` はページ全体に適用されます。コンポーネント単位で細かく制御したい場合は `<Suspense>` を直接使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "loading.tsx はページ全体、Suspense はコンポーネント単位の細かい制御", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "loading.tsx は Client Component、Suspense は Server Component 専用", position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "loading.tsx と Suspense は同じで片方だけ使えばよい",                  position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Suspense は React 18 以降では使えない",                              position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx05_l3, position: 2) do |q|
  q.question    = "複数のデータを取得する際、`await fetchA(); await fetchB();` のように直列で書くべきである。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。直列で書くと fetchB は fetchA が終わるまで始まりません。`Promise.all([fetchA(), fetchB()])` で並列 fetch する方が高速です。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

# ============================================================
# Course NX-06: Zodバリデーションとフォーム設計
# ============================================================
nx06 = Course.find_or_create_by!(title: "Zod バリデーションとフォーム設計") do |c|
  c.description = "Zod スキーマ定義・react-hook-form との統合・Server Actions でのバリデーションを学ぶ。"
  c.category    = "nextjs"
  c.difficulty  = "intermediate"
  c.position    = 17
end

nx06_l1 = Lesson.find_or_create_by!(course: nx06, position: 1) do |r|
  r.title   = "Zod の基本スキーマ定義"
  r.content = <<~MD
    ## Zod の基本スキーマ定義

    Zod を使うとバリデーションと型定義を一元管理できます。

    ### 基本的なスキーマ

    ```typescript
    import { z } from "zod";

    const userSchema = z.object({
      name:  z.string().min(1, "名前は必須です").max(50),
      email: z.string().email("有効なメールアドレスを入力してください"),
      age:   z.number().int().min(18, "18歳以上である必要があります"),
      role:  z.enum(["admin", "user"]).default("user"),
    });

    // スキーマから TypeScript 型を生成
    type User = z.infer<typeof userSchema>;
    ```

    ### parse vs safeParse

    ```typescript
    // parse: バリデーション失敗時に例外を投げる
    const user = userSchema.parse(data); // 失敗すると ZodError

    // safeParse: 例外を投げずに結果を返す（推奨）
    const result = userSchema.safeParse(data);
    if (result.success) {
      console.log(result.data); // 型安全なデータ
    } else {
      console.log(result.error.errors); // バリデーションエラー
    }
    ```

    ### 現場価値

    - バリデーションと型定義を1箇所で管理
    - バックエンドのスキーマ変更を即座に検知
    - フロントエンドとバックエンドでスキーマを共有できる
  MD
end

Quiz.find_or_create_by!(lesson: nx06_l1, position: 1) do |q|
  q.question    = "`z.infer<typeof userSchema>` の説明として正しいものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`z.infer<typeof schema>` はスキーマから TypeScript の型を自動生成します。スキーマと型を一元管理できます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "スキーマから TypeScript 型を自動生成する",       position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "スキーマのバリデーションを実行する",              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "型からスキーマを自動生成する",                   position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "スキーマをJSON形式に変換する",                   position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx06_l1, position: 2) do |q|
  q.question       = "`const schema = z.object({ email: z.string().___()`はメール形式のバリデーションを追加します。`___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "email()"
  q.explanation    = "`z.string().email()` でメール形式のバリデーションを追加できます。"
  q.position       = 2
end

nx06_l2 = Lesson.find_or_create_by!(course: nx06, position: 2) do |r|
  r.title   = "react-hook-form + Zod の統合"
  r.content = <<~MD
    ## react-hook-form + Zod の統合

    これが現在のフォーム実装のデファクトスタンダードです。

    ### セットアップ

    ```bash
    npm install react-hook-form zod @hookform/resolvers
    ```

    ### 実装例

    ```tsx
    "use client";
    import { useForm } from "react-hook-form";
    import { zodResolver } from "@hookform/resolvers/zod";
    import { z } from "zod";

    const loginSchema = z.object({
      email:    z.string().email("有効なメールアドレスを入力してください"),
      password: z.string().min(8, "パスワードは8文字以上です"),
    });

    type LoginInput = z.infer<typeof loginSchema>;

    export function LoginForm() {
      const {
        register,
        handleSubmit,
        formState: { errors, isSubmitting },
      } = useForm<LoginInput>({
        resolver: zodResolver(loginSchema),
      });

      const onSubmit = async (data: LoginInput) => {
        await login(data);
      };

      return (
        <form onSubmit={handleSubmit(onSubmit)}>
          <input {...register("email")} type="email" />
          {errors.email && <p>{errors.email.message}</p>}

          <input {...register("password")} type="password" />
          {errors.password && <p>{errors.password.message}</p>}

          <button disabled={isSubmitting}>ログイン</button>
        </form>
      );
    }
    ```

    ### react-hook-form のメリット

    - 入力のたびに**再レンダリングされない**（非制御コンポーネント）
    - バリデーションを `zodResolver` に委譲できる
    - `formState.errors` でフィールドごとのエラーを取得できる
  MD
end

Quiz.find_or_create_by!(lesson: nx06_l2, position: 1) do |q|
  q.question    = "`zodResolver` を使う利点はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`zodResolver` を使うと Zod スキーマのバリデーションを react-hook-form に統合できます。型定義とバリデーションを一元管理できます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "Zod スキーマのバリデーションを react-hook-form に統合できる", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "フォームの送信を自動化できる",                              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "CSS スタイルを自動適用できる",                             position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "API リクエストを自動送信できる",                           position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx06_l2, position: 2) do |q|
  q.question       = "`const { register } = useForm({ resolver: ___(loginSchema) })` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "zodResolver"
  q.explanation    = "`zodResolver(schema)` を `resolver` に渡すことで、Zod スキーマによるバリデーションが有効になります。"
  q.position       = 2
end

nx06_l3 = Lesson.find_or_create_by!(course: nx06, position: 3) do |r|
  r.title   = "Server Actions での Zod バリデーション"
  r.content = <<~MD
    ## Server Actions での Zod バリデーション

    クライアントとサーバー両方でバリデーションすることで、セキュリティと UX を両立します。

    ### なぜサーバー側でも必要か

    クライアントのバリデーションは**見た目上のバリデーション**です。
    悪意のあるユーザーは直接 API を呼べます。
    サーバー側でも必ず検証が必要です。

    ### Server Action での実装

    ```typescript
    "use server";
    import { z } from "zod";

    const createCourseSchema = z.object({
      title:       z.string().min(1).max(100),
      description: z.string().min(10).max(1000),
      category:    z.enum(["typescript", "react", "nextjs"]),
    });

    type State = { errors?: Record<string, string[]> } | null;

    export async function createCourse(
      prevState: State,
      formData: FormData
    ): Promise<State> {
      const raw = {
        title:       formData.get("title"),
        description: formData.get("description"),
        category:    formData.get("category"),
      };

      const result = createCourseSchema.safeParse(raw);

      if (!result.success) {
        return {
          errors: result.error.flatten().fieldErrors,
        };
      }

      // バリデーション成功後にDBへ保存
      await db.course.create({ data: result.data });
      revalidatePath("/courses");
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx06_l3, position: 1) do |q|
  q.question    = "クライアントでバリデーション済みでも、サーバー側で再度バリデーションが必要な理由はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "クライアントのバリデーションは UX のためです。悪意のあるユーザーは API を直接呼べるため、サーバー側でも必ず検証が必要です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "悪意のあるユーザーが API を直接呼ぶ可能性があるため",  position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "TypeScript の型チェックがあるから不要",               position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Next.js が自動でクライアントバリデーションを無効化するため", position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "SEO のために必要",                                   position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx06_l3, position: 2) do |q|
  q.question    = "`safeParse()` は例外を投げずに `{ success, data, error }` の形式で結果を返す。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。`safeParse()` は例外を投げず、`{ success: true, data: ... }` または `{ success: false, error: ... }` を返します。Server Action での使用に適しています。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

# ============================================================
# Course NX-07: Vercelデプロイと環境変数管理
# ============================================================
nx07 = Course.find_or_create_by!(title: "Vercel デプロイと環境変数管理") do |c|
  c.description = "NEXT_PUBLIC_ の使い分け・Vercel へのデプロイフロー・next.config.ts の重要設定を学ぶ。"
  c.category    = "nextjs"
  c.difficulty  = "beginner"
  c.position    = 18
end

nx07_l1 = Lesson.find_or_create_by!(course: nx07, position: 1) do |r|
  r.title   = "環境変数の分類と管理方針"
  r.content = <<~MD
    ## 環境変数の分類と管理方針

    ### NEXT_PUBLIC_ あり・なしの違い

    ```
    NEXT_PUBLIC_ なし:
      サーバーサイドのみで利用可能
      クライアントのバンドルに含まれない（安全）
      例: DATABASE_URL, JWT_SECRET, API_SECRET_KEY

    NEXT_PUBLIC_ あり:
      クライアント・サーバー両方で利用可能
      クライアントのバンドルに含まれる（誰でも見える）
      例: NEXT_PUBLIC_API_URL, NEXT_PUBLIC_GA_ID
    ```

    ### セキュリティルール

    - **APIキー・JWTシークレット・DBパスワードには絶対 `NEXT_PUBLIC_` をつけない**
    - `NEXT_PUBLIC_SECRET_KEY` のような名前はあってはならない

    ### ファイルの使い分け

    ```
    .env.local           → ローカル開発（Git 管理外）
    .env.development     → 開発環境のデフォルト値
    .env.production      → 本番環境のデフォルト値
    .env.test            → テスト環境
    ```

    ### Docker での渡し方

    ```yaml
    # compose.yml
    services:
      frontend:
        environment:
          - NEXT_PUBLIC_API_URL=http://localhost:3001
          - JWT_SECRET=${JWT_SECRET}  # ホストの環境変数から
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx07_l1, position: 1) do |q|
  q.question    = "`NEXT_PUBLIC_SECRET_KEY` という環境変数名はブラウザで見えてしまう。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。`NEXT_PUBLIC_` プレフィックスがついた環境変数はクライアントのバンドルに含まれます。シークレットな値には絶対に使わないでください。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx07_l1, position: 2) do |q|
  q.question    = "サーバーサイドのみで利用すべき環境変数として適切なものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`JWT_SECRET` はサーバーサイドでのみ使うべき秘密情報です。`NEXT_PUBLIC_` をつけてはいけません。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "JWT_SECRET（`NEXT_PUBLIC_` なし）",          position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "NEXT_PUBLIC_API_URL（`NEXT_PUBLIC_` あり）", position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "NEXT_PUBLIC_JWT_SECRET",                    position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "PUBLIC_SECRET",                             position: 3) { |o| o.correct = false }
end

nx07_l2 = Lesson.find_or_create_by!(course: nx07, position: 2) do |r|
  r.title   = "Vercel へのデプロイフロー"
  r.content = <<~MD
    ## Vercel へのデプロイフロー

    ### GitHub 連携でゼロ設定デプロイ

    1. Vercel アカウントを作成
    2. GitHub リポジトリを連携
    3. Next.js プロジェクトを自動検出
    4. 環境変数を設定
    5. デプロイ

    ### 環境変数の設定

    Vercel ダッシュボード → Settings → Environment Variables で設定します。

    ```
    環境の種類:
    - Production:  本番ブランチへのマージ時
    - Preview:     プルリクエスト時のプレビューデプロイ
    - Development: vercel dev コマンド使用時
    ```

    ### プレビューデプロイの活用

    PR ごとに自動でプレビュー URL が生成されます。
    レビュアーが実際に動作確認できるため、QA 効率が大幅に向上します。

    ### next.config.ts の重要設定

    ```typescript
    // next.config.ts
    const nextConfig = {
      images: {
        remotePatterns: [
          { protocol: "https", hostname: "example.com" },
        ],
      },
      output: "standalone", // Docker 本番用
    };
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx07_l2, position: 1) do |q|
  q.question    = "Vercel の Preview デプロイが生成されるタイミングはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Vercel は Pull Request を作成・更新するたびにプレビュー URL を自動生成します。レビュアーが実際に動作確認できます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "Pull Request の作成・更新時",              position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "本番ブランチへのマージ時のみ",             position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "手動でデプロイボタンを押した時のみ",       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "毎日自動で生成される",                    position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx07_l2, position: 2) do |q|
  q.question    = "Docker 本番環境向けに Next.js をビルドするとき `next.config.ts` に設定すべきオプションはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`output: 'standalone'` を設定すると、Node.js の依存関係を最小限に抑えた Docker に適した出力形式でビルドされます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "output: 'standalone'",  position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "output: 'export'",      position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "output: 'docker'",      position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "output: 'production'",  position: 3) { |o| o.correct = false }
end

nx07_l3 = Lesson.find_or_create_by!(course: nx07, position: 3) do |r|
  r.title   = "next.config.ts の重要設定"
  r.content = <<~MD
    ## next.config.ts の重要設定

    ### 外部画像の許可

    ```typescript
    const nextConfig = {
      images: {
        remotePatterns: [
          {
            protocol: "https",
            hostname: "images.example.com",
            pathname: "/uploads/**",
          },
        ],
      },
    };
    ```

    ### API のプロキシ（rewrites）

    ```typescript
    const nextConfig = {
      async rewrites() {
        return [
          {
            source: "/api/:path*",
            destination: "http://backend:3001/api/:path*",
          },
        ];
      },
    };
    ```

    ### セキュリティヘッダー（headers）

    ```typescript
    const nextConfig = {
      async headers() {
        return [
          {
            source: "/(.*)",
            headers: [
              { key: "X-Frame-Options", value: "SAMEORIGIN" },
              { key: "X-Content-Type-Options", value: "nosniff" },
            ],
          },
        ];
      },
    };
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx07_l3, position: 1) do |q|
  q.question    = "外部ドメインの画像を `next/image` で表示するために必要な設定はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`next.config.ts` の `images.remotePatterns` に外部ドメインを追加することで、`next/image` でその画像を表示できます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "next.config.ts の images.remotePatterns に追加",      position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: ".env.local に IMAGE_DOMAIN を設定",                   position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Image コンポーネントに domain prop を渡す",           position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "特に設定は不要",                                      position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx07_l3, position: 2) do |q|
  q.question    = "`rewrites` を使うと Next.js から別のサービスへのリクエストをプロキシできる。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。`rewrites` を使うと特定のパスへのリクエストを別のサービス（Rails API など）に転送できます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

# ============================================================
# Course NX-08: next/image・next/font・Metadata API
# ============================================================
nx08 = Course.find_or_create_by!(title: "next/image・next/font・Metadata API") do |c|
  c.description = "画像最適化・フォント最適化・SEO メタデータ設定を学んで Core Web Vitals を改善する。"
  c.category    = "nextjs"
  c.difficulty  = "intermediate"
  c.position    = 19
end

nx08_l1 = Lesson.find_or_create_by!(course: nx08, position: 1) do |r|
  r.title   = "next/image で画像を最適化する"
  r.content = <<~MD
    ## next/image で画像を最適化する

    `<img>` タグの代わりに `next/image` を使うことで、
    WebP 変換・遅延読み込み・サイズ最適化を自動で行います。

    ### 基本的な使い方

    ```tsx
    import Image from "next/image";

    // サイズ固定
    <Image
      src="/hero.png"
      alt="ヒーロー画像"
      width={800}
      height={400}
    />

    // 親要素いっぱいに広げる（fill モード）
    <div className="relative w-full h-64">
      <Image
        src="/cover.jpg"
        alt="カバー画像"
        fill
        className="object-cover"
      />
    </div>
    ```

    ### priority プロパティ

    ファーストビューの画像（LCP に関わる）に付けます。
    遅延読み込みを無効化して即座に読み込みます。

    ```tsx
    <Image src="/hero.png" alt="メインビジュアル" width={1200} height={600} priority />
    ```

    ### 落とし穴: fill モードには position: relative が必要

    ```tsx
    // NG: 親要素に position 指定なし
    <div>
      <Image fill src="..." alt="..." />
    </div>

    // OK: 親要素に relative を設定
    <div className="relative h-48">
      <Image fill src="..." alt="..." className="object-cover" />
    </div>
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx08_l1, position: 1) do |q|
  q.question    = "`priority` を付けるべき画像はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`priority` はファーストビューの LCP（Largest Contentful Paint）に関わる画像に付けます。遅延読み込みを無効化して即座に読み込みます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "ページを開いた時に最初に見えるメインビジュアル", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "フッターのロゴ画像",                            position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "スクロールしないと見えないカード画像",           position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "全ての画像に付けるのが推奨",                    position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx08_l1, position: 2) do |q|
  q.question       = "外部ドメインの画像を表示するには `next.config.ts` の `___` に設定が必要です。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "remotePatterns"
  q.explanation    = "`images.remotePatterns` に許可する外部ドメインを設定することで、`next/image` で外部画像を表示できます。"
  q.position       = 2
end

nx08_l2 = Lesson.find_or_create_by!(course: nx08, position: 2) do |r|
  r.title   = "next/font でフォントを最適化する"
  r.content = <<~MD
    ## next/font でフォントを最適化する

    `next/font` を使うとフォント読み込みをビルド時に解決し、
    レイアウトシフト（CLS）をゼロにできます。

    ### Noto Sans JP（Google フォント）の設定

    ```typescript
    // app/layout.tsx
    import { Noto_Sans_JP } from "next/font/google";

    const notoSansJP = Noto_Sans_JP({
      subsets: ["latin"],
      weight: ["400", "700"],
      display: "swap",
    });

    export default function RootLayout({ children }: { children: React.ReactNode }) {
      return (
        <html lang="ja" className={notoSansJP.className}>
          <body>{children}</body>
        </html>
      );
    }
    ```

    ### なぜ CLS がゼロになるか

    通常の Google フォント:
    1. ページ表示（システムフォントで描画）
    2. Google サーバーからフォントを取得
    3. フォントが切り替わってレイアウトシフト発生

    `next/font` の場合:
    - ビルド時にフォントをダウンロード
    - 自分のサーバーからホスト
    - 実行時に Google サーバーへの通信が不要
  MD
end

Quiz.find_or_create_by!(lesson: nx08_l2, position: 1) do |q|
  q.question    = "`next/font` を使うメリットはどれですか？（複数選択）"
  q.quiz_type   = "multiple_choice"
  q.explanation = "`next/font` はフォントをビルド時に解決するため、実行時の Google サーバーへの通信が不要になり、CLS もゼロになります。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "レイアウトシフト（CLS）がゼロになる",                  position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "実行時に Google サーバーへの通信が不要になる",         position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "フォントファイルのサイズを小さくできる",               position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "日本語フォントが全て無料で使える",                    position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx08_l2, position: 2) do |q|
  q.question    = "`next/font` を使うと実行時に Google のサーバーへのアクセスが発生する。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。`next/font` はビルド時にフォントをダウンロードして自分のサーバーからホストします。実行時に Google サーバーへの通信は発生しません。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

nx08_l3 = Lesson.find_or_create_by!(course: nx08, position: 3) do |r|
  r.title   = "Metadata API で SEO を制御する"
  r.content = <<~MD
    ## Metadata API で SEO を制御する

    ### 静的メタデータ

    ```typescript
    // app/courses/page.tsx
    import { Metadata } from "next";

    export const metadata: Metadata = {
      title: "コース一覧",
      description: "TypeScript・React・Next.js を現場レベルまで学べるコース一覧",
      openGraph: {
        title: "コース一覧 | Next.js 学習プラットフォーム",
        images: ["/og-image.png"],
      },
    };
    ```

    ### 動的メタデータ

    ```typescript
    // app/courses/[courseId]/page.tsx
    import { Metadata } from "next";

    type Props = { params: { courseId: string } };

    export async function generateMetadata({ params }: Props): Promise<Metadata> {
      const course = await fetchCourse(params.courseId);
      return {
        title: course.title,
        description: course.description,
      };
    }
    ```

    ### タイトルテンプレート

    ```typescript
    // app/layout.tsx
    export const metadata: Metadata = {
      title: {
        template: "%s | Next.js 学習プラットフォーム",
        default: "Next.js 学習プラットフォーム",
      },
    };
    // → 子ページで title: "コース一覧" と設定すると
    // → "コース一覧 | Next.js 学習プラットフォーム" になる
    ```

    ### Client Component では使えない

    Metadata API は Server Component のみで使用できます。
  MD
end

Quiz.find_or_create_by!(lesson: nx08_l3, position: 1) do |q|
  q.question       = "動的なメタデータを設定するための関数名を埋めてください: `export async function ___()`"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "generateMetadata"
  q.explanation    = "`generateMetadata` 関数を `export` することで、動的なメタデータを生成できます。API のデータを使ったタイトル・説明の設定に使います。"
  q.position       = 1
end

Quiz.find_or_create_by!(lesson: nx08_l3, position: 2) do |q|
  q.question    = "Client Component でも Metadata API を使える。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。Metadata API は Server Component のみで使用できます。`'use client'` がついたコンポーネントでは使えません。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

# ============================================================
# Course NX-09: Route Handlers
# ============================================================
nx09 = Course.find_or_create_by!(title: "Route Handlers（API ルート）") do |c|
  c.description = "app/api/ 配下の Route Handlers で Webhook・BFF・外部 API プロキシを実装する。"
  c.category    = "nextjs"
  c.difficulty  = "intermediate"
  c.position    = 20
end

nx09_l1 = Lesson.find_or_create_by!(course: nx09, position: 1) do |r|
  r.title   = "Route Handlers の仕組みと使いどころ"
  r.content = <<~MD
    ## Route Handlers の仕組みと使いどころ

    ### 基本構文

    ```typescript
    // app/api/hello/route.ts
    export async function GET(request: Request) {
      return Response.json({ message: "Hello" });
    }

    export async function POST(request: Request) {
      const body = await request.json();
      return Response.json({ received: body }, { status: 201 });
    }
    ```

    HTTP メソッド名が関数名になります（GET, POST, PUT, DELETE, PATCH）。

    ### 使いどころ

    ```
    Webhook の受信（Stripe・GitHub Actions など）
    外部 API キーの隠蔽（BFF パターン）
    Pages Router との互換性が必要な場合
    ファイルアップロード
    ```

    ### Server Actions vs Route Handlers

    ```
    フォームの送信・DB の CRUD → Server Actions（シンプル）
    外部サービスからの Webhook → Route Handlers（HTTP メソッド指定が必要）
    外部 API キーの隠蔽      → Route Handlers
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx09_l1, position: 1) do |q|
  q.question    = "Route Handlers が必要なシーンはどれですか？（複数選択）"
  q.quiz_type   = "multiple_choice"
  q.explanation = "外部サービスからの Webhook 受信・API キーの隠蔽（BFF）・ファイルアップロードなど、HTTP レベルの制御が必要な場合に Route Handlers を使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "Stripe からの Webhook 受信",           position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "外部 API キーをクライアントに隠す",     position: 1) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "単純なフォーム送信（DB への保存）",     position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "ファイルアップロード",                 position: 3) { |o| o.correct = true }
end

Quiz.find_or_create_by!(lesson: nx09_l1, position: 2) do |q|
  q.question       = "`export async function ___(request: Request)` で POST エンドポイントを定義するとき `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "POST"
  q.explanation    = "Route Handlers は HTTP メソッド名（大文字）を関数名として使います。POST エンドポイントは `POST` という名前の関数を export します。"
  q.position       = 2
end

nx09_l2 = Lesson.find_or_create_by!(course: nx09, position: 2) do |r|
  r.title   = "認証付き Route Handler と Cookies"
  r.content = <<~MD
    ## 認証付き Route Handler と Cookies

    ### cookies() で Cookie を読む

    ```typescript
    // app/api/profile/route.ts
    import { cookies } from "next/headers";

    export async function GET() {
      const token = (await cookies()).get("token")?.value;

      if (!token) {
        return Response.json({ error: "Unauthorized" }, { status: 401 });
      }

      // JWT を検証してユーザー情報を取得
      const user = await verifyTokenAndGetUser(token);
      return Response.json({ user });
    }
    ```

    ### NextRequest / NextResponse を使う場合

    ```typescript
    import { NextRequest, NextResponse } from "next/server";

    export async function GET(request: NextRequest) {
      // ヘッダーからトークンを取得
      const authorization = request.headers.get("Authorization");
      const token = authorization?.replace("Bearer ", "");

      if (!token) {
        return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
      }

      // ...
    }
    ```

    ### ステータスコードの使い分け

    ```
    200: 成功（GET・PUT・PATCH）
    201: 作成成功（POST）
    204: 成功・ボディなし（DELETE）
    400: リクエストが不正
    401: 未認証
    403: 権限なし
    404: リソースが見つからない
    500: サーバーエラー
    ```
  MD
end

Quiz.find_or_create_by!(lesson: nx09_l2, position: 1) do |q|
  q.question    = "`cookies()` を使うための import 元はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`cookies()` は `next/headers` からインポートします。Route Handler や Server Component で Cookie を読む際に使います。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "next/headers",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "next/navigation", position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "next/server",     position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "next/cookies",    position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx09_l2, position: 2) do |q|
  q.question       = "`return Response.json({ error: 'Unauthorized' }, { status: ___ })` の `___` を埋めてください。"
  q.quiz_type      = "fill_in_blank"
  q.correct_answer = "401"
  q.explanation    = "未認証の場合は HTTP ステータスコード 401（Unauthorized）を返します。"
  q.position       = 2
end

nx09_l3 = Lesson.find_or_create_by!(course: nx09, position: 3) do |r|
  r.title   = "外部 API のプロキシパターン"
  r.content = <<~MD
    ## 外部 API のプロキシパターン

    API キーをクライアントに漏らさないために Route Handler でプロキシします。

    ### プロキシの実装

    ```typescript
    // app/api/weather/route.ts
    export async function GET(request: Request) {
      const { searchParams } = new URL(request.url);
      const city = searchParams.get("city");

      if (!city) {
        return Response.json({ error: "city is required" }, { status: 400 });
      }

      // API キーはサーバーサイドのみに存在
      const apiKey = process.env.WEATHER_API_KEY;
      const res = await fetch(
        `https://api.weather.com/v1/current?city=${city}&key=${apiKey}`
      );

      const data = await res.json();
      return Response.json(data);
    }
    ```

    ### クライアントからの呼び出し

    ```typescript
    // クライアントは /api/weather を呼ぶだけ
    const weather = await fetch(`/api/weather?city=${city}`).then(r => r.json());
    ```

    ### 重要: NEXT_PUBLIC_ は絶対につけない

    `NEXT_PUBLIC_WEATHER_API_KEY` にすると、
    クライアントのバンドルに含まれてブラウザから丸見えになります。

    Route Handler でプロキシして `WEATHER_API_KEY`（プレフィックスなし）として管理しましょう。
  MD
end

Quiz.find_or_create_by!(lesson: nx09_l3, position: 1) do |q|
  q.question    = "外部 API キーを安全に使うためのパターンはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Route Handler でプロキシを実装し、API キーはサーバーサイドの環境変数として管理します。`NEXT_PUBLIC_` は絶対につけません。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "Route Handler でプロキシし、NEXT_PUBLIC_ なし環境変数で管理", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "NEXT_PUBLIC_ をつけてクライアントから直接呼ぶ",              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: ".env.local のみで管理（本番は不要）",                       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "API キーはコードに直接書く",                               position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: nx09_l3, position: 2) do |q|
  q.question    = "Route Handler で NEXT_PUBLIC_ をつけた環境変数を使うと API キーがクライアントに漏れる可能性がある。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。`NEXT_PUBLIC_` のついた環境変数はクライアントのバンドルに含まれます。Route Handler で使う API キーには絶対に `NEXT_PUBLIC_` をつけてはいけません。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

# ============================================================
# Course RN-01: JWT認証の完全フロー
# ============================================================
rn01 = Course.find_or_create_by!(title: "JWT 認証の完全フロー") do |c|
  c.description = "Rails での JWT 発行・Next.js での管理・axios インターセプター・トークンリフレッシュを実装する。"
  c.category    = "rails"
  c.difficulty  = "intermediate"
  c.position    = 21
end

rn01_l1 = Lesson.find_or_create_by!(course: rn01, position: 1) do |r|
  r.title   = "JWT 認証フローの全体像"
  r.content = <<~MD
    ## JWT 認証フローの全体像

    ### 認証フロー

    ```
    1. ユーザーがメール/パスワードを POST
       → POST /api/v1/auth/login

    2. Rails がパスワード検証
       → BCrypt でパスワードを比較
       → JWT を生成して返す

    3. Next.js が JWT を保存
       → localStorage または httpOnly Cookie

    4. 以降のリクエストに JWT を付与
       → Authorization: Bearer <token>

    5. Rails が JWT を検証してユーザーを特定
       → ApplicationController の before_action
    ```

    ### セッションベース vs JWT

    ```
    セッションベース:
      - サーバーにセッションを保存（ステートフル）
      - スケールアウトが難しい（セッションの共有が必要）

    JWT ベース:
      - サーバーに状態を持たない（ステートレス）
      - スケールアウトが容易
      - トークン失効が難しい（Blacklist が必要）
    ```

    ### JWT のペイロードに入れるべき情報

    ```
    入れるもの: user_id, role, exp（有効期限）, iat（発行時刻）
    入れないもの: パスワード, クレジットカード番号, 個人情報
    ```

    JWT のペイロードは Base64 エンコードされているだけで**暗号化されていません**。
    誰でも中身を読めます。
  MD
end

Quiz.find_or_create_by!(lesson: rn01_l1, position: 1) do |q|
  q.question    = "JWT のペイロードに含めるべきでない情報はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "JWT のペイロードは暗号化されていません（Base64 エンコードのみ）。パスワードや機密情報は含めてはいけません。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "パスワード",                    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "user_id",                      position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "role（ユーザーのロール）",       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "exp（有効期限）",               position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rn01_l1, position: 2) do |q|
  q.question    = "JWT はペイロードが暗号化されているため、機密情報を安全に入れられる。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。JWT のペイロードは Base64 エンコードされているだけで暗号化されていません。誰でも中身を読めるため、機密情報は入れてはいけません。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

rn01_l2 = Lesson.find_or_create_by!(course: rn01, position: 2) do |r|
  r.title   = "Rails の JWT 実装"
  r.content = <<~MD
    ## Rails の JWT 実装

    ### JwtService の実装

    ```ruby
    # app/services/jwt_service.rb
    class JwtService
      SECRET = Rails.application.credentials.jwt_secret!
      ALGORITHM = "HS256"
      EXPIRE_HOURS = 24

      def self.encode(payload)
        payload[:exp] = EXPIRE_HOURS.hours.from_now.to_i
        JWT.encode(payload, SECRET, ALGORITHM)
      end

      def self.decode(token)
        decoded = JWT.decode(token, SECRET, true, { algorithm: ALGORITHM })
        decoded[0].with_indifferent_access
      rescue JWT::ExpiredSignature
        raise AuthenticationError, "トークンの有効期限が切れています"
      rescue JWT::DecodeError
        raise AuthenticationError, "無効なトークンです"
      end
    end
    ```

    ### ApplicationController での認証

    ```ruby
    class ApplicationController < ActionController::API
      before_action :authenticate_user!

      private

      def authenticate_user!
        token = request.headers["Authorization"]&.split(" ")&.last
        raise AuthenticationError, "認証が必要です" unless token

        payload = JwtService.decode(token)
        @current_user = ::User.find(payload[:user_id])
      rescue ActiveRecord::RecordNotFound
        raise AuthenticationError, "ユーザーが見つかりません"
      end
    end
    ```

    ### 落とし穴: モジュール名の衝突

    `Api::V1::User` コントローラーの中で `User` と書くと
    `Api::V1::User`（自分自身）として解決されます。
    `::User` と書いてルート名前空間を明示しましょう。
  MD
end

Quiz.find_or_create_by!(lesson: rn01_l2, position: 1) do |q|
  q.question    = "`::User` とただの `User` の違いはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`::User` はルート名前空間（グローバル）の `User` を参照します。`User` だけだと現在のモジュール内で解決されるため、名前衝突が起きることがあります。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "::User はルート名前空間（グローバル）の User を参照する", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "::User は管理者ユーザーを表す",                        position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "::User と User は完全に同じ意味",                      position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "::User は非推奨の書き方",                              position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rn01_l2, position: 2) do |q|
  q.question    = "Rails の `before_action :authenticate_user!` で JWT 検証を行うことで、全エンドポイントで認証を強制できる。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。`ApplicationController` に `before_action :authenticate_user!` を定義することで、全コントローラーで認証が強制されます。認証不要なアクションには `skip_before_action` で除外できます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

rn01_l3 = Lesson.find_or_create_by!(course: rn01, position: 3) do |r|
  r.title   = "Next.js の JWT 管理戦略"
  r.content = <<~MD
    ## Next.js の JWT 管理戦略

    ### localStorage vs Cookie

    ```
    localStorage:
    - 実装が簡単
    - XSS 攻撃でトークンが盗まれる可能性がある
    - Server Component からアクセスできない

    Cookie（httpOnly）:
    - JavaScript からアクセスできない（XSS に強い）
    - CSRF 攻撃のリスク（SameSite 設定で対策）
    - Server Component からアクセスできる（cookies()）
    ```

    ### axios インターセプターで JWT を自動付与

    ```typescript
    // lib/api.ts
    import axios from "axios";

    const api = axios.create({
      baseURL: process.env.NEXT_PUBLIC_API_URL,
    });

    // リクエストインターセプター: JWT を自動付与
    api.interceptors.request.use((config) => {
      const token = localStorage.getItem("token");
      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }
      return config;
    });

    // レスポンスインターセプター: 401 で自動ログアウト
    api.interceptors.response.use(
      (response) => response,
      (error) => {
        if (error.response?.status === 401) {
          localStorage.removeItem("token");
          window.location.href = "/login";
        }
        return Promise.reject(error);
      }
    );

    export default api;
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rn01_l3, position: 1) do |q|
  q.question    = "httpOnly Cookie に JWT を保存する主なメリットはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "httpOnly Cookie は JavaScript からアクセスできないため、XSS 攻撃でトークンが盗まれにくいです。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "JavaScript からアクセスできないため XSS に強い",       position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "localStorage より読み書きが高速",                     position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "CSRF 攻撃が完全に防げる",                             position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Server Component から自動的に JWT が送信される",      position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rn01_l3, position: 2) do |q|
  q.question    = "axios のインターセプターを使うことで、全リクエストへの JWT 付与と 401 時の自動ログアウトを一元管理できる。"
  q.quiz_type   = "true_false"
  q.explanation = "正しい。axios のインターセプターはリクエスト・レスポンスの横断的処理を一元管理できます。JWT の自動付与と 401 エラーハンドリングに最適です。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = false }
end

rn01_l4 = Lesson.find_or_create_by!(course: rn01, position: 4) do |r|
  r.title   = "トークンリフレッシュとセッション継続"
  r.content = <<~MD
    ## トークンリフレッシュとセッション継続

    ### なぜ Refresh Token が必要か

    アクセストークンの有効期限を短くすること（15分〜1時間）でセキュリティが向上しますが、
    ユーザーが頻繁にログインし直す必要が生じます。

    Refresh Token で自動更新することでセキュリティと UX を両立します。

    ```
    Access Token:  有効期限 15分〜1時間（API リクエストに使う）
    Refresh Token: 有効期限 7日〜30日（Access Token の更新にのみ使う）
    ```

    ### 401 → トークン更新 → リトライのパターン

    ```typescript
    let isRefreshing = false;
    let failedQueue: Array<(token: string) => void> = [];

    api.interceptors.response.use(
      (response) => response,
      async (error) => {
        const originalRequest = error.config;

        if (error.response?.status === 401 && !originalRequest._retry) {
          originalRequest._retry = true;

          if (isRefreshing) {
            // リフレッシュ中なら待機してリトライ
            return new Promise((resolve) => {
              failedQueue.push((token) => {
                originalRequest.headers.Authorization = `Bearer ${token}`;
                resolve(api(originalRequest));
              });
            });
          }

          isRefreshing = true;
          const { data } = await api.post("/auth/refresh");
          const newToken = data.access_token;

          localStorage.setItem("token", newToken);
          failedQueue.forEach((cb) => cb(newToken));
          failedQueue = [];
          isRefreshing = false;

          return api(originalRequest);
        }

        return Promise.reject(error);
      }
    );
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rn01_l4, position: 1) do |q|
  q.question    = "Refresh Token を導入する主な目的はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Access Token の有効期限を短くしてセキュリティを高めつつ、Refresh Token で自動更新することでユーザーが頻繁にログインし直す必要をなくします。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "短命な Access Token でセキュリティを保ちながら UX を維持する", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Refresh Token は Access Token より長くして管理を簡単にする",  position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "CSRF 攻撃を完全に防ぐ",                                     position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "JWT の暗号化強度を上げる",                                  position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rn01_l4, position: 2) do |q|
  q.question    = "Access Token の推奨有効期限として適切なものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Access Token は短命にするほどセキュリティが高まります。一般的には15分〜1時間が推奨されます。Refresh Token で自動更新することで UX も維持できます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "15分〜1時間",   position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "30日間",        position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "1年間",         position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "有効期限なし",  position: 3) { |o| o.correct = false }
end

# ============================================================
# Course RN-02: CORS設計とトラブルシューティング
# ============================================================
rn02 = Course.find_or_create_by!(title: "CORS 設計とトラブルシューティング") do |c|
  c.description = "CORS の仕組み・rack-cors の設定・Docker 環境での SSR 通信の落とし穴・エラーレスポンス設計を学ぶ。"
  c.category    = "rails"
  c.difficulty  = "intermediate"
  c.position    = 22
end

rn02_l1 = Lesson.find_or_create_by!(course: rn02, position: 1) do |r|
  r.title   = "CORS の仕組みと必要な設定"
  r.content = <<~MD
    ## CORS の仕組みと必要な設定

    ### Same-Origin Policy（同一オリジンポリシー）

    ブラウザは異なるオリジン（プロトコル・ドメイン・ポートの組み合わせ）への
    リクエストをデフォルトでブロックします。

    ```
    Same Origin の例:
    https://example.com/api → https://example.com/other  ✅

    Cross Origin の例:
    https://frontend.com   → https://api.backend.com     ❌（デフォルトでブロック）
    http://localhost:3000  → http://localhost:3001        ❌（ポートが違う）
    ```

    ### CORS ヘッダー

    サーバーが以下のヘッダーを返すことでブラウザが許可します。

    ```
    Access-Control-Allow-Origin:  https://frontend.com
    Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
    Access-Control-Allow-Headers: Authorization, Content-Type
    Access-Control-Allow-Credentials: true  （Cookie を送る場合）
    ```

    ### rack-cors の設定

    ```ruby
    # config/initializers/cors.rb
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "http://localhost:3000", "https://yourapp.vercel.app"
        resource "*",
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true
      end
    end
    ```

    ### プリフライトリクエスト（OPTIONS）

    PUT・DELETE や `Authorization` ヘッダーを使うリクエストの前に、
    ブラウザが自動的に OPTIONS リクエストを送ります。
    Rails で OPTIONS を正しく処理することが重要です。
  MD
end

Quiz.find_or_create_by!(lesson: rn02_l1, position: 1) do |q|
  q.question    = "`http://localhost:3000` から `http://localhost:3001` へのリクエストは Same Origin ですか？"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。ポートが異なる（3000 vs 3001）ため Cross Origin です。CORS の設定が必要です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

Quiz.find_or_create_by!(lesson: rn02_l1, position: 2) do |q|
  q.question    = "Cookie を含むリクエストを許可するために必要な CORS ヘッダーはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`Access-Control-Allow-Credentials: true` を設定することで、Cookie を含むリクエストが許可されます。同時に `Access-Control-Allow-Origin` をワイルドカード(`*`)にはできません。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "Access-Control-Allow-Credentials: true",  position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Access-Control-Allow-Origin: *",           position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Access-Control-Allow-Cookie: true",        position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Access-Control-Cookie-Policy: all",        position: 3) { |o| o.correct = false }
end

rn02_l2 = Lesson.find_or_create_by!(course: rn02, position: 2) do |r|
  r.title   = "Docker 環境での SSR 通信の落とし穴"
  r.content = <<~MD
    ## Docker 環境での SSR 通信の落とし穴

    これはこのプロジェクトで実際に踏んだ問題です。

    ### 問題: SSR で `localhost:3001` に繋がらない

    ```
    ブラウザ（クライアント）:
      localhost:3001 → ホストマシンの 3001 番ポート ✅

    Next.js Server Component（コンテナ内）:
      localhost:3001 → コンテナ自身の 3001 番ポート ❌（backend は別コンテナ）
    ```

    Docker コンテナ内では `localhost` はそのコンテナ自身を指します。

    ### 解決策: 環境変数を分ける

    ```
    INTERNAL_API_URL=http://backend:3001    # SSR 用（コンテナ間通信）
    NEXT_PUBLIC_API_URL=http://localhost:3001  # CSR 用（ブラウザから）
    ```

    ### 実装パターン

    ```typescript
    // lib/apiClient.ts
    export function getApiBaseUrl() {
      if (typeof window === "undefined") {
        // Server Component / SSR: コンテナ名を使う
        return process.env.INTERNAL_API_URL;
      }
      // Client Component: ブラウザから見えるURL
      return process.env.NEXT_PUBLIC_API_URL;
    }
    ```

    ### 関連する落とし穴: Rails HostAuthorization

    Rails 6+ では `ActionDispatch::HostAuthorization` が有効です。
    `config.hosts` に Next.js コンテナからのリクエストが来るホスト名を追加しましょう。

    ```ruby
    # config/environments/development.rb
    config.hosts << "backend"  # Docker サービス名
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rn02_l2, position: 1) do |q|
  q.question    = "`docker compose restart` で `compose.yml` の環境変数変更が反映される。"
  q.quiz_type   = "true_false"
  q.explanation = "誤り。`docker compose restart` はコンテナを再起動しますが、`compose.yml` の変更は反映されません。変更を反映するには `docker compose up --force-recreate` が必要です。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "正しい", position: 0) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "誤り",   position: 1) { |o| o.correct = true }
end

Quiz.find_or_create_by!(lesson: rn02_l2, position: 2) do |q|
  q.question    = "Next.js の Server Component から Docker の backend コンテナに接続する正しい URL はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "Docker コンテナ間の通信はサービス名を使います。`http://backend:3001` のように `compose.yml` で定義したサービス名がホスト名になります。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "http://backend:3001（Docker サービス名）",     position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "http://localhost:3001",                       position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "http://127.0.0.1:3001",                       position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "http://0.0.0.0:3001",                         position: 3) { |o| o.correct = false }
end

rn02_l3 = Lesson.find_or_create_by!(course: rn02, position: 3) do |r|
  r.title   = "API 設計パターン（エラーレスポンス統一）"
  r.content = <<~MD
    ## API 設計パターン（エラーレスポンス統一）

    ### エラーレスポンスの形式を統一する

    ```json
    // 単一エラー
    { "error": "メッセージ" }

    // バリデーションエラー（複数）
    { "errors": { "name": ["必須です"], "email": ["形式が正しくありません"] } }
    ```

    ### Rails での rescue_from による一元管理

    ```ruby
    # app/controllers/application_controller.rb
    class ApplicationController < ActionController::API
      rescue_from AuthenticationError do |e|
        render json: { error: e.message }, status: :unauthorized
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { error: "リソースが見つかりません" }, status: :not_found
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        render json: { errors: e.record.errors }, status: :unprocessable_entity
      end
    end
    ```

    ### フロントエンドでのエラー型定義

    ```typescript
    interface ApiErrorResponse {
      error?: string;
      errors?: Record<string, string[]>;
    }

    function isApiError(error: unknown): error is { response: { data: ApiErrorResponse } } {
      return axios.isAxiosError(error) && error.response !== undefined;
    }

    // 使用例
    try {
      await createUser(data);
    } catch (error) {
      if (isApiError(error)) {
        const { errors } = error.response.data;
        setFieldErrors(errors ?? {});
      }
    }
    ```
  MD
end

Quiz.find_or_create_by!(lesson: rn02_l3, position: 1) do |q|
  q.question    = "Rails で全コントローラーのエラーを一元管理するための方法はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`ApplicationController` で `rescue_from` を使うことで、全コントローラーのエラーを一元管理できます。コードの重複を避け、一貫したエラーレスポンスを実現できます。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "ApplicationController で rescue_from を使う",    position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "各コントローラーに rescue メソッドを追加する",   position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Middleware でエラーを捕捉する",                  position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "フロントエンドでのみエラーを処理する",           position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rn02_l3, position: 2) do |q|
  q.question    = "バリデーションエラーのHTTPステータスコードとして適切なものはどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "422 Unprocessable Entity はリクエストの形式は正しいがバリデーションに失敗した場合に使います。Rails では `:unprocessable_entity` で指定できます。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "422 Unprocessable Entity", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "400 Bad Request",          position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "404 Not Found",            position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "500 Internal Server Error", position: 3) { |o| o.correct = false }
end

rn02_l4 = Lesson.find_or_create_by!(course: rn02, position: 4) do |r|
  r.title   = "環境別設定の管理（dev/prod）"
  r.content = <<~MD
    ## 環境別設定の管理（dev/prod）

    ### Rails の環境変数管理

    ```ruby
    # config/credentials.yml.enc（Git 管理）
    # rails credentials:edit で編集
    jwt_secret: your_secret_here
    database:
      password: your_db_password

    # 利用方法
    Rails.application.credentials.jwt_secret!
    ```

    ### Docker での環境変数整合

    ```yaml
    # compose.yml
    services:
      backend:
        environment:
          - RAILS_ENV=development
          - DATABASE_URL=postgresql://postgres:password@db:5432/app_development
          - JWT_SECRET=${JWT_SECRET}  # .env から読む

      frontend:
        environment:
          - INTERNAL_API_URL=http://backend:3001
          - NEXT_PUBLIC_API_URL=http://localhost:3001
    ```

    ### .env ファイルの管理方針

    ```
    .env               → Git 管理外（実際の値）
    .env.example       → Git 管理（テンプレート・値は空）
    .env.test          → テスト環境用（Git 管理可）
    ```

    ```bash
    # .env.example の内容（値は空にする）
    JWT_SECRET=
    DATABASE_URL=
    NEXT_PUBLIC_API_URL=
    ```

    新しいメンバーが `.env.example` をコピーして `.env` を作れるようにします。
  MD
end

Quiz.find_or_create_by!(lesson: rn02_l4, position: 1) do |q|
  q.question    = ".env ファイルの Git 管理について正しい方針はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "実際の値が入った `.env` は Git 管理外にします。テンプレートとして `.env.example`（値は空）を Git 管理します。"
  q.position    = 1
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: ".env は Git 管理外、.env.example（値は空）を Git 管理", position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: ".env も .env.example も両方 Git 管理する",              position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "全ての環境変数ファイルを Git 管理外にする",             position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "本番用の値を .env.production に書いて Git に含める",    position: 3) { |o| o.correct = false }
end

Quiz.find_or_create_by!(lesson: rn02_l4, position: 2) do |q|
  q.question    = "Rails の `credentials.yml.enc` が暗号化されている理由はどれですか？"
  q.quiz_type   = "single_choice"
  q.explanation = "`credentials.yml.enc` は `master.key` で暗号化されているため、Git に含めても安全です。`master.key` は Git 管理外にします。"
  q.position    = 2
end.tap do |q|
  QuizOption.find_or_create_by!(quiz: q, body: "Git に含めても安全なように暗号化されている",           position: 0) { |o| o.correct = true }
  QuizOption.find_or_create_by!(quiz: q, body: "Rails が高速に読み込むための圧縮形式",               position: 1) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "環境変数を暗号化しないと Rails が起動しない",         position: 2) { |o| o.correct = false }
  QuizOption.find_or_create_by!(quiz: q, body: "Docker コンテナへの受け渡しに必要な形式",             position: 3) { |o| o.correct = false }
end

puts "Done! Courses: #{Course.count}, Lessons: #{Lesson.count}, Quizzes: #{Quiz.count}, Options: #{QuizOption.count}"
