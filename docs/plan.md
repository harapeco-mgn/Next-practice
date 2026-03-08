# 技術実装計画

## 概要

Rails × Next.js × TypeScript 学習プラットフォームの技術設計書。
コンテンツ設計は `docs/curriculum.md` を参照。

---

## 技術スタック

| 層 | ローカル開発 | 本番 |
|----|------------|------|
| DB | Docker (PostgreSQL 16) | Neon (Serverless PostgreSQL) |
| Backend | Docker (Rails 8.1 API mode) | Render (Web Service / Ruby) |
| Frontend | Docker (Next.js 16 App Router) | Render (Web Service / Node) |
| 認証 | JWT (bcrypt + jwt gem) | 同左 |

---

## ユーザー学習フロー

```
トップ
  └─ 未ログイン → 登録/ログイン
  └─ ログイン済み → ダッシュボード（進捗サマリー + 次に進むべきレッスン）

コース一覧（カテゴリ/難易度フィルタ）
  └─ コース詳細（レッスン一覧 + 進捗バー + ロック表示）
       └─ レッスンページ
            ├─ Markdownコンテンツを読む
            ├─ 「完了」ボタン
            ├─ クイズ（single_choice / multiple_choice / fill_in_blank / true_false）
            └─ 前後レッスンナビゲーション

ダッシュボード
  └─ 全体進捗 + コース別進捗 + 「続きから学習」ボタン
```

---

## ディレクトリ構成

```
Next-practice/
├── compose.yml
├── .env
├── docs/
│   ├── curriculum.md     # コンテンツ設計書
│   └── plan.md           # 技術実装計画（このファイル）
├── backend/
│   ├── Dockerfile
│   ├── Gemfile
│   ├── app/
│   │   ├── controllers/api/v1/
│   │   │   ├── auth_controller.rb
│   │   │   ├── courses_controller.rb
│   │   │   ├── lessons_controller.rb
│   │   │   ├── quizzes_controller.rb
│   │   │   └── user/progress_controller.rb
│   │   ├── models/
│   │   │   ├── user.rb
│   │   │   ├── course.rb
│   │   │   ├── lesson.rb
│   │   │   ├── quiz.rb
│   │   │   ├── quiz_option.rb
│   │   │   └── user_progress.rb
│   │   └── services/jwt_service.rb
│   └── db/
│       ├── seeds.rb
│       └── seeds/nextjs_typescript_guide.rb
└── frontend/
    ├── Dockerfile
    ├── app/
    │   ├── layout.tsx
    │   ├── page.tsx
    │   ├── (auth)/login/page.tsx
    │   ├── (auth)/register/page.tsx
    │   ├── courses/
    │   │   ├── page.tsx
    │   │   ├── loading.tsx              # 🚧 未実装
    │   │   └── [courseId]/
    │   │       ├── page.tsx
    │   │       └── lessons/[lessonId]/
    │   │           ├── page.tsx
    │   │           ├── loading.tsx      # 🚧 未実装
    │   │           └── error.tsx        # 🚧 未実装
    │   ├── dashboard/page.tsx
    │   └── quizzes/[quizId]/page.tsx
    ├── components/
    │   ├── auth/LoginForm.tsx
    │   ├── auth/RegisterForm.tsx
    │   ├── layout/AuthProvider.tsx
    │   ├── layout/Header.tsx
    │   ├── lesson/LessonContent.tsx
    │   ├── lesson/LessonCompleteButton.tsx
    │   ├── quiz/QuizCard.tsx            # single_choice / true_false のみ対応
    │   ├── quiz/MultipleChoiceQuizCard.tsx  # 🚧 未実装
    │   ├── quiz/FillInBlankQuizCard.tsx     # 🚧 未実装
    │   └── ui/
    ├── hooks/
    │   ├── useAuth.ts
    │   └── useQuiz.ts
    └── lib/
        ├── api.ts
        └── types.ts
```

---

## DBスキーマ

### users
| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint PK | |
| name | string NOT NULL | |
| email | string NOT NULL UNIQUE | |
| password_digest | string NOT NULL | bcrypt |
| role | string DEFAULT 'user' | user / admin |

### courses
| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint PK | |
| title | string NOT NULL | |
| description | text | |
| category | string NOT NULL | typescript / react / nextjs / rails |
| difficulty | string NOT NULL | beginner / intermediate / advanced |
| position | integer DEFAULT 0 | 表示順 |

### lessons
| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint PK | |
| course_id | FK | |
| title | string NOT NULL | |
| content | text | Markdown |
| position | integer DEFAULT 0 | |

### quizzes
| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint PK | |
| lesson_id | FK | |
| question | text NOT NULL | |
| explanation | text | 解説 |
| quiz_type | string DEFAULT 'single_choice' | single_choice / multiple_choice / true_false / fill_in_blank |
| correct_answer | text | fill_in_blank の正解テキスト |
| position | integer DEFAULT 0 | |

### quiz_options
| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint PK | |
| quiz_id | FK | |
| body | text NOT NULL | 選択肢テキスト |
| correct | boolean DEFAULT false | |
| position | integer DEFAULT 0 | |

### user_progresses
| カラム | 型 | 説明 |
|--------|-----|------|
| id | bigint PK | |
| user_id | FK | |
| lesson_id | FK nullable | |
| quiz_id | FK nullable | |
| status | string | not_started / in_progress / completed |
| score | integer | クイズのスコア |
| selected_option_id | integer nullable | 単一選択の回答 |

---

## API設計

### 認証
| メソッド | パス | 認証 | 説明 |
|----------|------|------|------|
| POST | /api/v1/auth/register | - | ユーザー登録 |
| POST | /api/v1/auth/login | - | ログイン → JWT返却 |
| GET | /api/v1/auth/me | ✅ | 現在のユーザー情報 |

### コース・レッスン
| メソッド | パス | 認証 | 説明 |
|----------|------|------|------|
| GET | /api/v1/courses | - | コース一覧（category・difficultyフィルタ） |
| GET | /api/v1/courses/:id | - | コース詳細 + レッスン一覧 |
| GET | /api/v1/lessons/:id | - | レッスン詳細 + クイズ + prev/next |
| POST | /api/v1/lessons/:id/complete | ✅ | レッスン完了マーク |

### クイズ
| メソッド | パス | 認証 | 説明 |
|----------|------|------|------|
| GET | /api/v1/quizzes/:id | - | クイズ取得 |
| POST | /api/v1/quizzes/:id/answer | ✅ | 回答送信 |

回答のリクエストボディ:
```json
// single_choice / true_false
{ "option_id": 1 }

// multiple_choice
{ "option_ids": [1, 3] }

// fill_in_blank
{ "text_answer": "Partial" }
```

### 進捗
| メソッド | パス | 認証 | 説明 |
|----------|------|------|------|
| GET | /api/v1/user/progress | ✅ | 全体進捗サマリー |
| GET | /api/v1/user/progress/courses/:id | ✅ | コース別進捗 |

---

## 環境変数

### Backend (.env → compose.yml経由)
| 変数名 | 説明 |
|--------|------|
| DATABASE_URL | PostgreSQL接続文字列 |
| SECRET_KEY_BASE | Rails用シークレット |
| JWT_SECRET | JWT署名鍵 |
| FRONTEND_ORIGIN | CORSの許可オリジン（http://localhost:8000） |

### Frontend
| 変数名 | 説明 | 使用箇所 |
|--------|------|----------|
| NEXT_PUBLIC_API_URL | ブラウザからのAPIアクセスURL | Client Component |
| INTERNAL_API_URL | SSR時のコンテナ内部URL | Server Component |

---

## Docker構成

| サービス | ポート | 説明 |
|----------|--------|------|
| db | 5432 | PostgreSQL 16 |
| backend | 3001 | Rails API |
| frontend | 8000 (→3000) | Next.js |

**注意点:**
- `docker compose restart` では compose.yml の環境変数変更が反映されない
- 環境変数変更後は `docker compose up -d --force-recreate` が必要
- SSRからbackendへのアクセスは `http://backend:3001`（コンテナ名）を使う
- Rails の `HostAuthorization` に `config.hosts << "backend"` の追加が必要

---

## 実装フェーズと進捗

### ✅ Phase 0: インフラ構築（完了）
- [x] compose.yml / Dockerfile 作成
- [x] Rails API mode セットアップ
- [x] Next.js + TypeScript + Tailwind セットアップ
- [x] Docker 3サービス起動確認
- [x] CORS設定

### ✅ Phase 1-A: 認証機能（完了）
- [x] users テーブル・マイグレーション
- [x] User モデル (has_secure_password)
- [x] JwtService (encode/decode)
- [x] AuthController (register / login / me)
- [x] authenticate_user! concern
- [x] Frontend: login / register ページ
- [x] Frontend: useAuth hook・AuthProvider
- [x] Frontend: api.ts (axios + JWT interceptor)

### ✅ Phase 1-B: コース・レッスン（完了）
- [x] courses / lessons マイグレーション・モデル
- [x] CoursesController / LessonsController
- [x] seed データ（TypeScript / Next.js / Rails 基礎コース）
- [x] Frontend: コース一覧・コース詳細・レッスンページ
- [x] Frontend: Markdownレンダリング（react-markdown + syntax highlight）

### ✅ Phase 1-C: クイズ基本（完了）
- [x] quizzes / quiz_options マイグレーション・モデル
- [x] QuizzesController (show / answer)
- [x] seed データ（基礎クイズ）
- [x] Frontend: QuizCard（single_choice / true_false）

### ✅ Phase 1-D: 進捗管理基本（完了）
- [x] user_progresses マイグレーション・モデル
- [x] ProgressController
- [x] Frontend: ダッシュボード

### 🚧 Phase 2: クイズ拡張・UX改善
- [x] Backend: fill_in_blank 対応（correct_answer カラム追加）
- [x] Backend: multiple_choice 対応（option_ids 複数送信）
- [x] Backend: レッスン prev/next をAPIレスポンスに追加
- [ ] Frontend: MultipleChoiceQuizCard コンポーネント
- [ ] Frontend: FillInBlankQuizCard コンポーネント
- [ ] Frontend: QuizRouter（quiz_typeに応じたコンポーネント切り替え）
- [ ] Frontend: レッスン前後ナビゲーションボタン
- [ ] Frontend: courses/loading.tsx
- [ ] Frontend: lessons/[lessonId]/loading.tsx
- [ ] Frontend: lessons/[lessonId]/error.tsx
- [ ] seed データ: 新規コース（TS-02〜TS-04・RC-01〜RC-06・NX-02〜NX-09・RN-01〜RN-02）

### ⬜ Phase 3: 学習パス・ロック機能
- [ ] learning_paths テーブル（コースの順序定義）
- [ ] レッスンロック機能（前のレッスン未完了なら鍵マーク）
- [ ] 章末課題チェックリストUI
- [ ] ダッシュボード: 「続きから学習」ボタン
- [ ] コース詳細: 進捗バー + レッスン完了表示

### ⬜ Phase 4: ターミナル風コードチャレンジ
- [ ] Monaco Editor 導入（dynamic import / SSR無効）
- [ ] TypeScript Compiler API をブラウザで動かす設定
- [ ] Webワーカーでサンドボックス eval 実行
- [ ] ターミナル風Outputコンポーネント
- [ ] コードチャレンジ専用クイズタイプ（`code_challenge`）
- [ ] 編集不可ゾーン（テストケース部分）の実装
- [ ] ヒント機能（段階的表示・スコア減点）
- [ ] DB: quizzes に `starter_code`・`test_code`・`hints` カラム追加

---

## Phase 4 技術設計: ターミナル風コードチャレンジ

### アーキテクチャ概要

```
[Monaco Editor]
      ↓ ユーザーがコードを編集（TypeScript LSP でリアルタイムエラー表示）
[▶ 実行ボタン]
      ↓
[Web Worker]
  ├─ TypeScript Compiler API でコンパイル（型チェック）
  ├─ コンパイルエラー → ターミナルにエラー表示
  └─ 成功 → 生成されたJSをsandbox evalで実行
      ↓
[ターミナル風Output]
  ├─ ✅ テスト1通過
  ├─ ❌ テスト2失敗 + 理由
  └─ Score表示
```

### DBスキーマ追加（quizzes テーブル）

| カラム | 型 | 説明 |
|--------|-----|------|
| starter_code | text | エディタの初期コード（編集可能ゾーン） |
| test_code | text | テストケース（編集不可・ユーザーには隠す） |
| hints | jsonb | `[{"level": 1, "text": "..."}, ...]` |

### quiz_type に `code_challenge` を追加

```ruby
QUIZ_TYPES = %w[single_choice multiple_choice true_false fill_in_blank code_challenge].freeze
```

### APIの変更

**クイズ取得（GET /quizzes/:id）**
```json
{
  "id": 1,
  "question": "Partial<T> を Mapped Types で実装してください",
  "quiz_type": "code_challenge",
  "starter_code": "type MyPartial<T> = {\n  // ここに実装\n}",
  "hints": [
    { "level": 1, "text": "Mapped Types は [K in keyof T] の構文を使います" },
    { "level": 2, "text": "プロパティをオプショナルにするには ? をつけます" },
    { "level": 3, "text": "{ [K in keyof T]?: T[K] } が答えです" }
  ]
}
```
※ `test_code` はAPIレスポンスに含めない（クライアントに漏れると答えがわかる）

**回答送信（POST /quizzes/:id/answer）**
```json
{ "user_code": "type MyPartial<T> = { [K in keyof T]?: T[K] }" }
```
→ サーバー側でテストコードと結合してコンパイルチェック（将来的な設計）
→ Phase 4初期はクライアントサイド評価で実装し、後でサーバー側に移行

### フロントエンドの実装構成

```
components/
└── quiz/
    └── CodeChallengeQuizCard.tsx   # メインコンポーネント
        ├── MonacoEditor             # dynamic import（SSR無効）
        ├── TerminalOutput           # ターミナル風Output
        └── HintPanel                # ヒント表示

lib/
└── typescriptRunner.ts              # Web Worker + TSコンパイラ連携

workers/
└── ts-eval.worker.ts                # TypeScript評価Worker
```

### Monaco Editor 設定のポイント

```typescript
// dynamic import（SSR無効）
const MonacoEditor = dynamic(() => import('@monaco-editor/react'), {
  ssr: false,
  loading: () => <div className="h-64 bg-gray-900 animate-pulse rounded" />,
})

// エディタの設定
<MonacoEditor
  language="typescript"
  value={userCode}
  onChange={setUserCode}
  options={{
    minimap: { enabled: false },
    fontSize: 14,
    theme: 'vs-dark',
    readOnly: false,
  }}
/>
```

### 編集不可ゾーンの実装

Monaco Editor の `deltaDecorations` API で テストコード部分を視覚的に区別し、
`onKeyDown` イベントで該当行の編集をブロックする。

```typescript
// テストコードの行範囲を計算して編集禁止に
editor.onKeyDown((e) => {
  const position = editor.getPosition()
  if (position && position.lineNumber > editableLines) {
    e.preventDefault() // テストコードゾーンは編集不可
  }
})
```

### ターミナル風Outputの表示仕様

```
$ checking types...                        ← グレー（実行中）
✅ テスト1: MyPartial<{name: string}> 通過  ← グリーン
❌ テスト2: readonly が期待されます        ← レッド
   Expected: { readonly name?: string }
   Received: { name?: string }

Score: 1/2  ヒント使用: 1回  最終スコア: 1点
```

### セキュリティ考慮

- eval は Web Worker 内で実行（メインスレッドから分離）
- Worker内で `setTimeout` / DOM API へのアクセスはなし
- 無限ループ対策: Worker に 5秒タイムアウトを設定
- `test_code` はサーバーからは返さない（クライアントに漏れない設計）

### 技術的な判断

| 決定事項 | 理由 |
|----------|------|
| ブラウザ内TypeScript評価を採用 | 学習目的（型チェック中心）なのでNode.js環境不要、サーバーコスト削減 |
| test_codeをAPIに含めない | 答えがソースコードに見えてしまうため |
| Phase初期はクライアントサイド評価 | 実装が速い・将来サーバー評価に移行可能 |
| Webワーカーで実行 | メインスレッドのブロッキングとセキュリティリスクを回避 |
| ヒント段階表示 | 最初から答えを見せない・スコアに差をつけて達成感を演出 |

---

## 実装詳細リファレンス

### バージョン一覧

| 項目 | バージョン |
|------|---------|
| Ruby | 3.3 (slim) |
| Rails | ~> 8.1.2 |
| Node.js | 20 (alpine) |
| Next.js | 16.1.6 |
| React | 19.2.3 |
| PostgreSQL | 16 (alpine) |
| TypeScript | ^5 |
| Tailwind CSS | ^4 |

### backend/Gemfile

```ruby
gem "rails", "~> 8.1.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "bcrypt", "~> 3.1.7"
gem "jwt", "~> 2.9"
gem "rack-cors"
gem "kaminari"

group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end
group :test do
  gem "shoulda-matchers"
end
```

### backend/Dockerfile

```dockerfile
FROM ruby:3.3-slim
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential libpq-dev libyaml-dev postgresql-client curl git && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3
COPY . .
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
```

※ `libyaml-dev` が必須（psych gem のビルドに必要）

### frontend/package.json 主要パッケージ

```json
{
  "dependencies": {
    "next": "16.1.6",
    "react": "19.2.3",
    "react-dom": "19.2.3",
    "axios": "^1.13.6",
    "lucide-react": "^0.577.0",
    "react-markdown": "^10.1.0",
    "react-syntax-highlighter": "^16.1.1"
  },
  "devDependencies": {
    "tailwindcss": "^4",
    "@tailwindcss/postcss": "^4",
    "typescript": "^5"
  }
}
```

### frontend/Dockerfile

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci
COPY . .
EXPOSE 3000
```

### config/initializers/cors.rb

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch("FRONTEND_ORIGIN", "http://localhost:8000")
    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ["Authorization"]
  end
end
```

### config/environments/development.rb（Docker用追加設定）

```ruby
config.hosts << "backend"
config.hosts << /backend:\d+/
```

### config/routes.rb

```ruby
namespace :api do
  namespace :v1 do
    post "auth/register", to: "auth#register"
    post "auth/login",    to: "auth#login"
    get  "auth/me",       to: "auth#me"

    resources :courses, only: [:index, :show] do
      resources :lessons, only: [:show], shallow: true do
        member { post :complete }
      end
    end

    resources :quizzes, only: [:show] do
      member { post :answer }
    end

    namespace :user do
      get "progress",                    to: "progress#index"
      get "progress/courses/:course_id", to: "progress#course"
    end
  end
end
```

### services/jwt_service.rb

```ruby
class JwtService
  SECRET = ENV.fetch("JWT_SECRET", "development_jwt_secret")
  ALGORITHM = "HS256".freeze
  EXPIRY = 24.hours

  def self.encode(payload)
    payload = payload.merge(exp: EXPIRY.from_now.to_i)
    JWT.encode(payload, SECRET, ALGORITHM)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET, true, { algorithm: ALGORITHM })
    HashWithIndifferentAccess.new(decoded.first)
  rescue JWT::DecodeError, JWT::ExpiredSignature => e
    raise AuthenticationError, e.message
  end
end
```

### lib/api.ts（SSR/CSR URL切り替えパターン）

```typescript
const API_BASE =
  typeof window === 'undefined'
    ? (process.env.INTERNAL_API_URL || 'http://backend:3001/api/v1')
    : (process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3001/api/v1')
```

---

## 技術的な判断記録

| 決定事項 | 理由 |
|----------|------|
| SSRのAPI URLを分ける（INTERNAL / PUBLIC） | Dockerコンテナ内では localhost:3001 がbackendに繋がらない |
| Rails HostAuthorization に "backend" を追加 | コンテナ名でのリクエストがデフォルトでブロックされる |
| `docker compose up --force-recreate` を使う | `restart` では環境変数変更が反映されない |
| `::User` でグローバル参照 | `Api::V1::User` モジュールとの名前衝突を回避 |
| fill_in_blank は大文字小文字を無視して比較 | 学習者の入力ミスを減らすため |
| Markdownはサーバー側で保存、フロントでレンダリング | 管理がシンプル・将来的にCMS化も可能 |
| 本番DBはNeon（Serverless PostgreSQL）を採用 | 無料枠・スケールアウト容易・Renderとの相性が良い |
| 本番デプロイはRender（Backend + Frontend両方） | GitHubと連携して自動デプロイが容易 |
| 本番でINTERNAL_API_URLとNEXT_PUBLIC_API_URLは同値 | Render上ではSSRもインターネット経由でAPIアクセスするため |
| Neon接続には?sslmode=require が必須 | Neonはデフォルトでssl必須 |
