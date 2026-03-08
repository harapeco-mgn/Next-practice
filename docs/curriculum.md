# カリキュラム設計書

## 方針

「このWebアプリを使うことで現場レベルまで知識を持っていける体験型カリキュラム」

### 扱う領域

| 領域 | ✅ 含む | ❌ 含まない |
|------|--------|------------|
| TypeScript | 型システム・Generics・Utility Types・型ガード | - |
| React | Hooks・Context・パフォーマンス最適化・コンポーネント設計・React 19 | - |
| Next.js | App Router・SSR/SSG・Server Actions・認証・デプロイ | - |
| Rails × Next.js 連携 | JWT認証フロー・CORS・API設計・SSR時の通信 | Rails単体（RSpec・Pundit・N+1等） |

### レッスンの品質基準

各レッスンは以下の構成で書く：

```
## なぜ必要か（背景・動機）
## 概念の説明
## 実装例（現場で使うコード）
## よくある落とし穴・現場での注意点
## クイズ（最低2問、うち1問はコード読解か穴埋め）
```

### クイズの種類

| 種類 | 用途 |
|------|------|
| `single_choice` | 概念確認（4択） |
| `multiple_choice` | 複数正解がある問題 |
| `fill_in_blank` | コードの穴埋め（`__`を埋める） |
| `true_false` | 誤解されやすい概念の是非 |

---

## 学習パス構成

```
TypeScriptパス ─── TS-01基礎 → TS-02 Utility Types → TS-03型ガード → TS-04 Generics
                                                                    ↓
Reactパス ──── RC-01基礎とJSX → RC-02基本Hooks → RC-03応用Hooks
                                                       ↓
              RC-04コンポーネント設計 → RC-05状態管理 → RC-06パフォーマンス
                                                       ↓
Next.jsパス ─────── NX-01〜NX-09（App Router・Server Actions・Cache等）
                                                       ↓
              RC-07 React 19（← Next.js学習後に戻る）
                                                       ↓
連携パス ────────────────────────── RN-01 JWT認証 → RN-02 CORS・Docker通信
```

> **推奨学習順:** TS-01〜TS-04 → RC-01〜RC-06 → NX-01〜NX-09 → RC-07 → RN-01〜RN-02

---

## コース一覧・レッスン詳細

---

## 📘 TypeScript編

---

### TS-01｜TypeScript型システム基礎（既存・要拡充）
**カテゴリ:** typescript ／ **難易度:** beginner ／ **推定時間:** 30分

現状のレッスンをベースに、落とし穴と穴埋めクイズを追加する。

#### Lesson 1: はじめに・JavaScriptの歴史（既存）
- 追加: JavaScriptとTypeScriptの比較コード（型エラーが実行前に検出される実例）

#### Lesson 2: 実行環境とVS Codeセットアップ（既存）
- 追加: `tsconfig.json` の重要オプション解説（`strict`・`noImplicitAny`・`target`）

#### Lesson 3: Next.jsプロジェクト作成・package.json・Prettier・ESLint（既存）
- 追加: `tsconfig.json` の `paths` 設定（`@/*` エイリアス）

#### Lesson 4: 基本構文 - データ型・関数・配列・オブジェクト（既存）
- 追加クイズ: 穴埋め「`const user: ___ = { id: 1, name: "Alice" }` の型定義を完成させよ」

#### Lesson 5: 応用構文 - スプレッド・分割代入・ループ・標準関数（既存）
- 追加クイズ: コード読解「以下のreduceの実行結果は何か？」

---

### TS-02｜Utility Types実践
**カテゴリ:** typescript ／ **難易度:** intermediate ／ **推定時間:** 50分

#### Lesson 1: Partial・Required・Readonly
**カバーする内容:**
- `Partial<T>`: 全プロパティをオプショナルに → フォームの更新処理でよく使う
- `Required<T>`: 全プロパティを必須に → APIレスポンスの検証
- `Readonly<T>`: 変更不可に → Reduxのstateや設定オブジェクト
- **落とし穴**: `Partial`はネストしたオブジェクトには効かない（Shallow）

**クイズ:**
1. `Partial<User>` を使う適切なシーンはどれか（`single_choice`）
2. 穴埋め: `function updateUser(id: number, data: ___<User>) {}` （`fill_in_blank`）

#### Lesson 2: Pick・Omit・Record
**カバーする内容:**
- `Pick<T, K>`: 必要なプロパティだけ取り出す → APIレスポンス型の絞り込み
- `Omit<T, K>`: 特定プロパティを除外する → パスワードを含まない`SafeUser`型
- `Record<K, V>`: キーと値の型を指定したオブジェクト → ラベルマップ
- **現場パターン**: `Omit<User, "password_digest">` でAPIレスポンス型を定義

**クイズ:**
1. `Omit`を使ってパスワードを除いたUser型を定義するコードの穴埋め（`fill_in_blank`）
2. `Pick`と`Omit`の使い分けを問う問題（`single_choice`）

#### Lesson 3: ReturnType・Parameters・Awaited
**カバーする内容:**
- `ReturnType<typeof fn>`: 関数の戻り値型を取得 → 既存関数から型を逆引き
- `Parameters<typeof fn>`: 関数の引数型を取得
- `Awaited<T>`: Promise解決後の型を取得 → `Awaited<ReturnType<typeof fetchUser>>`
- **現場パターン**: APIクライアント関数の戻り値型を`ReturnType`で使い回す

**クイズ:**
1. `Awaited<Promise<string>>` の型は何か（`single_choice`）
2. 穴埋め: `type UserData = ___<typeof fetchUser>` （`fill_in_blank`）

#### Lesson 4: Utility Typesの組み合わせパターン
**カバーする内容:**
- `Partial<Pick<User, "name" | "email">>`: 更新可能フィールドの型
- `Required<Omit<Config, "optional">>`: 必須設定の型
- `Readonly<Record<string, string>>`: 変更不可のラベルマップ
- **現場での型設計**: 型定義ファイルの整理方法（`types/`ディレクトリ構成）

#### Lesson 5: Mapped Types
**カバーする内容:**
- Mapped Typesの基本構文: `{ [K in keyof T]: ... }`
  ```typescript
  // Partial の実装を読み解く
  type MyPartial<T> = { [K in keyof T]?: T[K] }
  // Readonly の実装を読み解く
  type MyReadonly<T> = { readonly [K in keyof T]: T[K] }
  ```
- プロパティを変換する: 値の型を変える
  ```typescript
  type Nullable<T> = { [K in keyof T]: T[K] | null }
  type Stringify<T> = { [K in keyof T]: string }
  ```
- `as` を使ったキーの再マッピング
  ```typescript
  type Getters<T> = {
    [K in keyof T as `get${Capitalize<string & K>}`]: () => T[K]
  }
  ```
- **現場価値**: Utility Typesがどう実装されているかを理解でき、型ライブラリを読めるようになる

**クイズ:**
1. `{ [K in keyof T]?: T[K] }` が実装している Utility Type は何か（`single_choice`: `Partial`）
2. 穴埋め: `type MyRecord<K extends string, V> = { [___ in K]: V }`

#### Lesson 6: satisfies 演算子（TypeScript 4.9+）
**カバーする内容:**
- `satisfies` とは: 型チェックをしながら型推論を保持する
  ```typescript
  // as を使った場合: 型は広くなる
  const palette = { red: [255, 0, 0], green: "#00ff00" } as Record<string, string | number[]>
  // → palette.red は string | number[] になってしまう

  // satisfies を使った場合: 型チェック + 推論を保持
  const palette = { red: [255, 0, 0], green: "#00ff00" } satisfies Record<string, string | number[]>
  // → palette.red は number[] のまま
  ```
- `as`・型注釈・`satisfies` の使い分け
  ```
  型注釈 (: Type): 型を広げる・明示する
  as: 型を強制変換（型安全性を犠牲にする可能性）
  satisfies: 型チェックしつつ推論を保持（最も安全）
  ```
- **現場での使いどころ**: 設定オブジェクト・ルーティング定義・カラーパレット

**クイズ:**
1. `satisfies` と型注釈の違い（`single_choice`）
2. `true_false`: 「`satisfies`は`as`と同じく型の安全性を犠牲にする」→ false

**章末課題（チェックリスト）:**
- [ ] `UpdateUserPayload` 型を `Partial<Pick<User, ...>>` を使って定義できた
- [ ] `SafeUser` 型を `Omit<User, "password">` を使って定義できた
- [ ] `ReturnType` を使って既存関数から型を取得できた
- [ ] `MyPartial<T>` を Mapped Types で自分で実装できた
- [ ] `satisfies` と `as` の違いをコードで説明できた

---

### TS-03｜型ガードとType Narrowing
**カテゴリ:** typescript ／ **難易度:** intermediate ／ **推定時間:** 45分

#### Lesson 1: typeof・instanceof による型ガード
**カバーする内容:**
- `typeof`による型絞り込み（`string`・`number`・`boolean`）
- `instanceof`によるクラスインスタンス確認
- **落とし穴**: `typeof null === "object"`（TypeScriptでも同じ）
- Narrowing後は型が絞られることをエディタで確認する

**クイズ:**
1. `typeof null` の結果は何か（`true_false`: "nullを返す" → false）
2. 穴埋め: `if (typeof value === "___") { return value.toUpperCase() }`

#### Lesson 2: ユーザー定義型ガード（is演算子）
**カバーする内容:**
- `value is Type` 形式のtype predicate
- `isApiError`関数: `error is ApiError`
- **現場パターン**: axiosのエラー判定に使う
  ```typescript
  function isAxiosError(error: unknown): error is AxiosError {
    return axios.isAxiosError(error)
  }
  ```

**クイズ:**
1. type predicateの書き方として正しいもの（`single_choice`）
2. 穴埋め: `function isUser(value: unknown): value ___ User {`

#### Lesson 3: Discriminated Union パターン
**カバーする内容:**
- `type` フィールドで型を判別するパターン
  ```typescript
  type Result = { status: "success"; data: User } | { status: "error"; message: string }
  ```
- `switch`文との組み合わせ
- **現場パターン**: APIレスポンス・カスタムエラー・Reduxアクション型

**クイズ:**
1. Discriminated Unionが有効なシーンはどれか（`single_choice`）
2. コード読解: switchで`status`を判別するコードの結果を問う

#### Lesson 4: Exhaustive Check（網羅性チェック）
**カバーする内容:**
- `never`型を使った網羅性チェック
  ```typescript
  function assertNever(x: never): never {
    throw new Error("Unhandled case: " + x)
  }
  ```
- switch文の`default`に仕込む
- **現場価値**: enumやunion型に新しいケースを追加した時にコンパイルエラーで気づける

**クイズ:**
1. `never`型の説明として正しいもの（`single_choice`）
2. exhaustive checkが機能するケースの穴埋め

---

### TS-04｜Generics実践
**カテゴリ:** typescript ／ **難易度:** advanced ／ **推定時間:** 60分

#### Lesson 1: Generic関数の基礎
**カバーする内容:**
- `<T>`の基本構文と型推論
- `identity<T>(value: T): T`
- `first<T>(arr: T[]): T | undefined`
- **現場パターン**: `useState<User | null>(null)` はGenericsの使用例

**コードチャレンジ（Phase 3）:** `first<T>(arr: T[]): T | undefined` を実装

#### Lesson 2: Generic制約（extends）
**カバーする内容:**
- `<T extends object>`で制約をつける
- `<K extends keyof T>` で型安全なプロパティアクセス
  ```typescript
  function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
    return obj[key]
  }
  ```
- **落とし穴**: 制約がないとプロパティアクセスでエラーになる

**コードチャレンジ（Phase 3）:** `getProperty<T, K extends keyof T>` を実装

#### Lesson 3: Generic型（インターフェース・型エイリアス）
**カバーする内容:**
- `interface ApiResponse<T>` パターン
- `type Maybe<T> = T | null | undefined`
- **現場パターン**: カスタムフック `useApiRequest<T>()` の型設計

**クイズ:**
1. `ApiResponse<User[]>` の `data` の型は何か（`single_choice`）
2. 穴埋め: `interface Paginated<___> { data: T[]; total: number }`

#### Lesson 4: 条件型（Conditional Types）
**カバーする内容:**
- `T extends U ? X : Y`
- `NonNullable<T>`: `T extends null | undefined ? never : T`
- `IsArray<T>`: `T extends any[] ? true : false`
- **現場での使い所**: ライブラリの型定義を読む時に理解できるようになる

**コードチャレンジ（Phase 3）:** `IsArray<T>` と `Flatten<T>` を実装

---

## 📗 React編

---

### RC-01｜React基礎とJSX
**カテゴリ:** react ／ **難易度:** beginner ／ **推定時間:** 40分

#### Lesson 1: Reactとは何か・仮想DOMの仕組み
**カバーする内容:**
- Reactが解決する問題（DOMの直接操作の辛さ）
- 仮想DOM（Virtual DOM）とReconciliationの仕組み
- 「UIは状態の関数」という考え方: `UI = f(state)`
- **現場価値**: なぜJQueryやバニラJSではなくReactを使うのかを言語化できる

**クイズ:**
1. 仮想DOMの説明として正しいもの（`single_choice`）
2. `true_false`: 「Reactは変更があった部分のみ実際のDOMを更新する」→ true

#### Lesson 2: JSXの書き方と注意点
**カバーする内容:**
- JSXはJavaScriptの糖衣構文（`React.createElement`に変換される）
- HTMLとの違い: `className` / `htmlFor` / `style={{ }}` / 自己閉じタグ
- 式の埋め込み: `{}` の中にはJavaScript式のみ（文は書けない）
- `key` プロパティの必要性とアンチパターン（indexをkeyにする問題）
- **落とし穴**: `{condition && <Component />}` で `condition` が `0` の場合 `0` が表示される

**クイズ:**
1. 穴埋め: `<div ___Name="container">` の正しいJSXの属性名（`fill_in_blank`）
2. `key` にインデックスを使ってはいけない理由（`single_choice`）

#### Lesson 3: コンポーネントとPropsの設計
**カバーする内容:**
- 関数コンポーネント vs クラスコンポーネント（現在は関数一択）
- Propsは読み取り専用（イミュータブル）
- `children` Props パターン
- コンポーネントの分割基準（Single Responsibility）
- **現場パターン**: Propsの型定義は `interface` か `type` か（どちらでもよいが統一する）

**クイズ:**
1. `true_false`: 「コンポーネント内でPropsを直接変更してよい」→ false
2. 穴埋め: `function Card({ title, ___ }: { title: string; ___: React.ReactNode })`

#### Lesson 4: 条件付きレンダリングとリストレンダリング
**カバーする内容:**
- 条件: `&&` / 三項演算子 / 早期return
- リスト: `map()` + `key` の必須化
- `null` を返すとコンポーネントが非表示になる
- フラグメント: `<>...</>` で余分なdivを避ける
- **落とし穴**: `0 && <Component />` と `"" && <Component />` の挙動の違い

**クイズ:**
1. `{0 && <div>表示</div>}` の実行結果（`single_choice`: `0` が表示される）
2. リストに `key` が必要な理由（`single_choice`）

---

### RC-02｜基本Hooks（useState・useEffect・useReducer・useContext）
**カテゴリ:** react ／ **難易度:** intermediate ／ **推定時間:** 50分

#### Lesson 1: useStateの内部動作と正しい使い方
**カバーする内容:**
- stateの更新は**非同期**（直後に値を読んでも更新されていない）
- 関数型更新: `setCount(prev => prev + 1)` が必要なケース
- オブジェクトstateの更新: スプレッドでイミュータブルに
  ```typescript
  // NG: 直接変更
  user.name = "Bob"; setUser(user)
  // OK: 新しいオブジェクトを作る
  setUser(prev => ({ ...prev, name: "Bob" }))
  ```
- 複数stateをまとめるか分けるかの判断基準
- **落とし穴**: 同一レンダリング内で同じstateを複数回setしてもまとめられる（Batching）

**クイズ:**
1. 穴埋め: `setCount(___ => ___ + 1)` 前の値を使った更新（`fill_in_blank`）
2. `true_false`: 「`setState`直後に`state`の値を読むと新しい値が得られる」→ false

#### Lesson 2: useEffectの正しい使い方と依存配列
**カバーする内容:**
- 依存配列の3パターン（なし・空・値あり）と実行タイミング
- クリーンアップ関数の必要性（タイマー・イベントリスナー・サブスクリプション）
  ```typescript
  useEffect(() => {
    const timer = setInterval(() => setCount(c => c + 1), 1000)
    return () => clearInterval(timer)  // クリーンアップ必須
  }, [])
  ```
- **落とし穴**: 依存配列に関数・オブジェクトを入れると毎回実行される
- React 18以降の Strict Mode で開発時に2回実行される理由
- useEffectでデータ取得することの問題点（競合状態・ウォーターフォール）

**クイズ:**
1. クリーンアップ関数が必要なケースはどれか（`multiple_choice`）
2. `true_false`: 「開発環境でuseEffectが2回実行されるのはバグ」→ false（Strict Modeの意図的な動作）

#### Lesson 3: useReducer・useContext
**カバーする内容:**
- `useState` vs `useReducer` の使い分け
  ```
  useState向き: 独立した単純な値
  useReducer向き: 複数の値が連動して変わる・次の状態が現在の状態に依存する
  ```
- `useReducer` の基本形（action/reducer/dispatch）
- `useContext` でコンポーネントツリー全体に値を配布
- Context + useReducer でシンプルなグローバル状態管理
- **落とし穴**: Contextの値が変わると全consumers再レンダリングされる

**クイズ:**
1. `useReducer` が適している状況（`single_choice`）
2. 穴埋め: `const [state, ___] = useReducer(reducer, initialState)`

---

### RC-03｜応用Hooks（useMemo・useCallback・useRef・並行処理）
**カテゴリ:** react ／ **難易度:** intermediate〜advanced ／ **推定時間:** 65分

> **注意:** `useMemo` / `useCallback` はこの章で**概念と構文**を学ぶ。
> **計測を伴う実践・最適化判断**は RC-06（パフォーマンス最適化）で行う。

#### Lesson 1: useMemo・useCallback の正しい使い方
**カバーする内容:**
- `useMemo`: 計算結果をメモ化（重い計算・参照同一性の維持）
  ```typescript
  const sorted = useMemo(() =>
    [...items].sort((a, b) => a.price - b.price),
    [items]
  )
  ```
- `useCallback`: 関数をメモ化（`memo()`した子コンポーネントへのProps渡し）
- **重要**: むやみに使うと逆にパフォーマンスが悪化する
- 使うべきタイミングの判断基準
  ```
  useMemo: 計算コストが高い / 参照同一性が必要（依存配列に入れる値）
  useCallback: memo化した子コンポーネントへ渡す関数
  ```
- **現場のアドバイス**: 計測してから最適化する。最初からmemo化しない

**クイズ:**
1. `useCallback` を使うべき状況（`single_choice`）
2. `true_false`: 「全てのコンポーネントをmemo()で囲むとパフォーマンスが向上する」→ false

#### Lesson 2: useRef の活用パターン
**カバーする内容:**
- DOM参照: フォーカス・スクロール・サイズ取得
- 再レンダリングをまたいで値を保持（再レンダリングを起こさない）
  ```typescript
  const prevValue = useRef<string>("")
  useEffect(() => {
    prevValue.current = currentValue  // 前回の値を保持
  })
  ```
- `useRef` vs `useState` の使い分け（表示に使う → state、内部処理のみ → ref）
- タイマーIDの保持パターン

**クイズ:**
1. `useRef` と `useState` の違い（`single_choice`）
2. 穴埋め: `const inputRef = useRef<___>(null)` でinput要素への参照

#### Lesson 3: useTransition・useDeferredValue（並行処理）
**カバーする内容:**
- React 18の並行機能（Concurrent Features）とは
- `useTransition`: 低優先度の状態更新をマークする
  ```typescript
  const [isPending, startTransition] = useTransition()

  function handleSearch(value: string) {
    setInput(value)                        // 高優先度: 即座に反映
    startTransition(() => setQuery(value)) // 低優先度: 余裕ができたら実行
  }
  ```
- `useDeferredValue`: 受け取った値を遅延させる（Props経由の場合）
  ```typescript
  const deferredQuery = useDeferredValue(query)
  // deferredQueryが古い間はisPendingとして扱える
  ```
- `useTransition` vs `useDeferredValue` の使い分け
  ```
  useTransition: 自分でsetStateを呼ぶとき
  useDeferredValue: Propsや外から来た値を遅延させるとき
  ```
- **現場での使いどころ**: 大量データのフィルタリング・検索UI・タブ切替

**クイズ:**
1. `startTransition` 内に入れるべき処理（`single_choice`: 低優先度のstate更新）
2. 穴埋め: `const [___, startTransition] = useTransition()`
3. `true_false`: 「`useDeferredValue`はネットワークリクエストを遅延させる」→ false（state更新の優先度制御）

#### Lesson 4: useLayoutEffect・useImperativeHandle
**カバーする内容:**
- `useLayoutEffect`: DOMが更新された直後・ペイント前に同期実行
  ```typescript
  useLayoutEffect(() => {
    // DOMのサイズ・位置を読んで即座に調整
    const rect = ref.current?.getBoundingClientRect()
    setHeight(rect?.height ?? 0)
  }, [])
  ```
- `useEffect` vs `useLayoutEffect` の使い分け
  ```
  useLayoutEffect: DOM計測・スクロール位置調整・アニメーション初期値設定
  useEffect: APIリクエスト・サブスクリプション・ログ送信
  ```
- **落とし穴**: `useLayoutEffect` はSSRで警告が出る（サーバーではDOMがない）→ `useEffect`へのフォールバックパターン
- `useImperativeHandle`: 親から子コンポーネントのメソッドを呼べるようにする
  ```typescript
  useImperativeHandle(ref, () => ({
    focus: () => inputRef.current?.focus(),
    clear: () => setValue(''),
  }))
  ```
- **現場での使いどころ**: Modalのopen/closeを親からトリガー・フォームのリセット

**クイズ:**
1. `useLayoutEffect` を使うべき状況（`single_choice`）
2. `true_false`: 「`useLayoutEffect` はSSRでも問題なく動作する」→ false

---

### RC-04｜コンポーネント設計パターン
**カテゴリ:** react ／ **難易度:** intermediate ／ **推定時間:** 75分

#### Lesson 1: ディレクトリ構造パターンと選び方
**カバーする内容:**
- なぜディレクトリ構造が重要か（チーム開発・スケール時の認知負荷）
- 主要4パターンの比較

**① タイプ別（Type-based）**
```
components/
  auth/       # LoginForm, RegisterForm
  layout/     # Header, Footer
  ui/         # Button, Badge, Input
hooks/
lib/
```
→ 初心者・小規模向け。`components/` が肥大化しやすい。

**② フィーチャー別（Feature-based）**
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
components/       # アプリ全体で使う共通UIのみ
```
→ 中〜大規模向け。**現場で最も多く使われる**。機能単位でまとまるので削除・移植が容易。

**③ Atomic Design**
```
components/
  atoms/       # Button, Input, Icon（最小単位）
  molecules/   # FormField, QuizOption（atomsの組み合わせ）
  organisms/   # QuizCard, Header（moleculesの組み合わせ）
  templates/   # LessonLayout（ページ構造）
```
→ デザインシステムを持つ大規模チーム向け。粒度の判断が難しく小規模では過剰になりやすい。

**④ コロケーション（Colocation）**
```
app/
  courses/
    _components/          # courses専用（外から使わない）
    [courseId]/
      _components/        # courseId専用
      page.tsx
components/               # 本当に全体で共通のものだけ
```
→ Next.js App Router推奨。使う場所の近くにコンポーネントを置く。

- **選び方の基準**
  ```
  一人 / 小規模 → タイプ別 or コロケーション
  チーム / 中規模 → フィーチャー別
  デザインシステムあり → Atomic Design
  Next.js App Router → コロケーション + フィーチャー別の組み合わせ
  ```
- **現場の実態**: 最初はタイプ別で始め、機能が増えたらフィーチャー別に移行するパターンが多い
- **アンチパターン**: 最初からAtomic Designを導入して途中で破綻する

**クイズ:**
1. フィーチャー別構成のメリット（`multiple_choice`）
2. `true_false`: 「Atomic Designはどんな規模のプロジェクトにも適している」→ false
3. このプロジェクトでは `features/quiz/` に何を置くべきか（`single_choice`）

#### Lesson 2: TypeScript × React の型パターン
**カバーする内容:**
- イベントハンドラの正しい型
  ```typescript
  // NG: any になってしまう
  const handleClick = (e) => { ... }

  // OK: 明示的に型を指定
  const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => { ... }
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => { ... }
  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => { ... }
  ```
- `React.ReactNode` vs `React.ReactElement` vs `JSX.Element` の違い
  ```typescript
  React.ReactNode     // 最も広い（string・number・nullも含む）← childrenの型はこれ
  React.ReactElement  // JSXが返すオブジェクト（nullは含まない）
  JSX.Element         // React.ReactElement と同じ（古い書き方）
  ```
- `React.ComponentProps` でHTML要素の型を再利用
  ```typescript
  // buttonの全Propsを継承した拡張コンポーネント
  interface ButtonProps extends React.ComponentProps<'button'> {
    variant?: 'primary' | 'secondary'
  }
  function Button({ variant = 'primary', ...props }: ButtonProps) {
    return <button {...props} className={`btn-${variant}`} />
  }
  ```
- Generic コンポーネント
  ```typescript
  function List<T extends { id: number }>({ items, renderItem }: {
    items: T[]
    renderItem: (item: T) => React.ReactNode
  }) {
    return <ul>{items.map(item => <li key={item.id}>{renderItem(item)}</li>)}</ul>
  }
  ```
- `React.FC` を使わない理由（childrenが自動で付かなくなった・型推論の妨げになる）

**クイズ:**
1. `children` の型として最も適切なもの（`single_choice`: `React.ReactNode`）
2. 穴埋め: `const handleChange = (e: React.___Event<HTMLInputElement>) => {}`
3. `React.ComponentProps<'button'>` を使うメリット（`single_choice`）

#### Lesson 3: 再利用可能なコンポーネントの設計
**カバーする内容:**
- 汎用コンポーネントと特化コンポーネントの使い分け
- Propsの設計原則: 必要最小限・具体的な型・わかりやすい名前
- `as` Props パターン（ポリモーフィックコンポーネント）
  ```typescript
  interface ButtonProps {
    as?: "button" | "a" | "div"
    children: React.ReactNode
  }
  ```
- Compound Componentパターン（`Tabs`, `Tabs.Tab`, `Tabs.Panel`）

**クイズ:**
1. 汎用コンポーネントを作る判断基準（`single_choice`）
2. `children` の型として最も適切なもの（`single_choice`: `React.ReactNode`）

#### Lesson 4: カスタムフックによるロジックの分離
**カバーする内容:**
- カスタムフック設計の原則（1つのカスタムフックは1つの責務）
- `useLocalStorage<T>` の実装（型安全・SSR対応）
- `useDebounce<T>` の実装（入力遅延）
- `useWindowSize` の実装（リサイズ検知）
- **現場パターン**: UIロジックをカスタムフックに切り出すことでコンポーネントをシンプルに保つ

**クイズ:**
1. カスタムフックに切り出すべき処理（`multiple_choice`）
2. 穴埋め: `function useDebounce<T>(value: T, delay: number): ___ {`

#### Lesson 5: フォームの状態管理パターン
**カバーする内容:**
- 非制御コンポーネント（`useRef`）vs 制御コンポーネント（`useState`）
- react-hook-form が解決する問題（再レンダリングの最小化）
- `register` / `handleSubmit` / `formState.errors` の基本
- フォームのリセット・デフォルト値の設定
- **落とし穴**: inputのvalueに `undefined` を渡すと非制御コンポーネントになる

**クイズ:**
1. 制御コンポーネントと非制御コンポーネントの違い（`single_choice`）
2. `true_false`: 「react-hook-formは入力のたびに再レンダリングされる」→ false

#### Lesson 6: エラーバウンダリとSuspense
**カバーする内容:**
- エラーバウンダリ: クラスコンポーネントで実装（またはreact-error-boundary）
- `<Suspense fallback={...}>` でローディングUIを宣言的に書く
- Next.jsの `error.tsx` / `loading.tsx` はこれを抽象化したもの
- **現場パターン**: react-error-boundaryライブラリで関数コンポーネントから使う

**クイズ:**
1. Suspenseの `fallback` に渡すもの（`single_choice`）
2. `true_false`: 「エラーバウンダリは関数コンポーネントのみで実装できる」→ false

---

### RC-05｜状態管理の設計
**カテゴリ:** react ／ **難易度:** intermediate ／ **推定時間:** 50分

#### Lesson 1: stateの置き場所を決める原則
**カバーする内容:**
- stateをどこに置くかの判断フロー
  ```
  1. そのコンポーネント内だけで使う → ローカルstate
  2. 兄弟コンポーネントと共有 → 共通の親にlift up
  3. 離れたコンポーネントと共有 → Context / 外部ストア
  4. サーバーデータ → TanStack Query / SWR
  ```
- Props drilling の問題点と解決策
- URLをstateとして使う（`searchParams`）

**クイズ:**
1. Props drillingを解決する適切な方法（`multiple_choice`）
2. URLのsearchParamsをstateとして使うメリット（`single_choice`）

#### Lesson 2: Context APIの設計と最適化
**カバーする内容:**
- Contextを分割してre-renderを最小化
  ```typescript
  // 悪い例: 全てを1つのContextに
  const AppContext = createContext({ user, theme, cart, ... })

  // 良い例: 関心ごとに分割
  const UserContext = createContext<User | null>(null)
  const ThemeContext = createContext<Theme>("light")
  ```
- カスタムフックでContextを隠蔽 (`useUser()` / `useTheme()`)
- ProviderをCompose（ネストを減らすパターン）

**クイズ:**
1. Contextを分割する理由（`single_choice`）
2. 穴埋め: `export function useUser() { return useContext(___Context) }`

#### Lesson 3: サーバーデータの状態管理（TanStack Query入門）
**カバーする内容:**
- サーバーデータとクライアントデータを分けて考える
- `useEffect` + fetch の問題点（重複リクエスト・キャッシュなし・ローディング管理の煩雑さ）
- TanStack Query のコアコンセプト
  ```typescript
  const { data, isLoading, error } = useQuery({
    queryKey: ['courses'],
    queryFn: () => coursesApi.list(),
    staleTime: 60_000,  // 60秒間はキャッシュを使う
  })
  ```
- `useMutation` でデータ更新 + 楽観的更新
- **Next.js App Routerとの使い分け**: Server Componentでfetch vs TanStack Query

**クイズ:**
1. `queryKey` の役割（`single_choice`）
2. `staleTime` の説明（`single_choice`）

#### Lesson 4: Zustand によるグローバル状態管理
**カバーする内容:**
- なぜZustand か（Contextより簡単・Reduxより軽量）
  ```typescript
  import { create } from 'zustand'

  interface AuthStore {
    user: User | null
    setUser: (user: User | null) => void
    logout: () => void
  }

  const useAuthStore = create<AuthStore>((set) => ({
    user: null,
    setUser: (user) => set({ user }),
    logout: () => set({ user: null }),
  }))
  ```
- Selectorで必要な値だけ取得（re-render最適化）
- `persist` ミドルウェアでlocalStorageに永続化
- **Next.js App Routerとの注意点**: Server ComponentではZustandは使えない

**章末課題:**
- [ ] `useAuthStore` を Zustand で実装し、ログイン状態を管理した
- [ ] `useQuery` を使ってコース一覧をキャッシュ付きで取得した
- [ ] Context を分割して不要な re-render を削減した

---

### RC-06｜パフォーマンス最適化
**カテゴリ:** react ／ **難易度:** advanced ／ **推定時間:** 50分

#### Lesson 1: re-renderの仕組みと計測
**カバーする内容:**
- re-renderが発生する4つの条件（state変化・Props変化・親のre-render・Context変化）
- React DevToolsのProfilerで計測する方法
- `why-did-you-render` ライブラリで不要なre-renderを検知
- **現場の原則**: 計測してから最適化する（推測で最適化しない）

**クイズ:**
1. re-renderが発生する条件（`multiple_choice`）
2. `true_false`: 「Propsが変わっていなくても親がre-renderされると子もre-renderされる」→ true

#### Lesson 2: memo・useMemo・useCallbackの実践（計測ありき）
> **RC-03との役割分担:** RC-03では構文・概念を学んだ。このレッスンでは**DevToolsで計測しながら**最適化の判断を練習する。

**カバーする内容:**
- React DevTools Profiler で計測し、最適化が本当に必要か判断する
- `memo()` が効果的なシーンと効果がないシーン
- `useMemo` でリストのソート・フィルタリング結果をキャッシュ
- `useCallback` とmemo化の組み合わせパターン
- **アンチパターン**: 計測せずにメモ化する・プリミティブ値をメモ化する・全てをメモ化する

**クイズ:**
1. `useMemo` が有効な状況（`single_choice`）
2. コード読解: `memo()` が効かない理由を問う問題

#### Lesson 3: 遅延ローディングとコード分割
**カバーする内容:**
- `React.lazy()` + `Suspense` でコンポーネントを動的インポート
- Next.js の `dynamic()` との関係
- 重いライブラリ（Monaco Editor・recharts等）の遅延ロード
  ```typescript
  const MonacoEditor = dynamic(() => import('@monaco-editor/react'), {
    ssr: false,
    loading: () => <div className="h-64 bg-gray-100 animate-pulse" />,
  })
  ```
- バンドルサイズを `next build` で確認する

**クイズ:**
1. `dynamic()` に `{ ssr: false }` を渡すべき状況（`single_choice`）
2. 穴埋め: `const HeavyChart = React.___()`

#### Lesson 4: 仮想スクロール・大量データの扱い
**カバーする内容:**
- 10,000件のリストをそのままrenderする問題
- `react-virtual` / `react-window` による仮想スクロールの仕組み
- ページネーション vs 無限スクロールの使い分け
- **現場での判断**: まずページネーションで十分かを考える

**クイズ:**
1. 仮想スクロールが解決する問題（`single_choice`）
2. `true_false`: 「1万件のデータを全てDOMに描画してもパフォーマンスは問題ない」→ false

---

### RC-07｜React 19の新機能
**カテゴリ:** react ／ **難易度:** advanced ／ **推定時間:** 45分

> ⚠️ **学習順序の注意:** `useActionState` はNext.jsのServer Actionsが前提知識となる。
> **Next.js編（NX-01〜NX-09）を終えてからこの章に戻ることを推奨。**

#### Lesson 1: use Hook
**カバーする内容:**
- `use(promise)` でPromiseをアンラップ（Suspense連携）
- `use(context)` でContextを読む（条件分岐内でも使える）
- `use` は通常のHookのルール（トップレベルのみ）と異なり条件分岐内でも使える
  ```typescript
  function UserName({ userPromise }: { userPromise: Promise<User> }) {
    const user = use(userPromise)  // SuspenseでフォールバックUI
    return <span>{user.name}</span>
  }
  ```

**クイズ:**
1. `use()`が通常のHooksと異なる点（`single_choice`）
2. `use(promise)` を使う時に必要な親コンポーネントの要素（`single_choice`: `Suspense`）

#### Lesson 2: Actions と useActionState
**カバーする内容:**
- フォームの `action` にasync関数を渡せるようになった
- `useActionState` でアクションの状態（pending・error・result）を管理
- Next.jsのServer Actionsはこれを基盤にしている
- `useFormStatus` でフォーム送信中の状態を取得

**クイズ:**
1. `useActionState` の第一引数に渡すもの（`single_choice`）
2. 穴埋め: `const [state, action, ___] = useActionState(myAction, null)`

#### Lesson 3: useOptimistic
**カバーする内容:**
- サーバーレスポンスを待たずにUIを先に更新する
  ```typescript
  const [optimisticLikes, addOptimisticLike] = useOptimistic(
    likes,
    (state, newLike) => [...state, newLike]
  )
  ```
- エラー時のロールバックの仕組み
- **現場での使いどころ**: いいね・ブックマーク・チェック操作

**クイズ:**
1. 楽観的更新が有効なUI操作の例（`multiple_choice`）
2. `true_false`: 「楽観的更新でエラーになった場合、自動で元の状態に戻る」→ true

#### Lesson 4: React 19 のその他の改善
**カバーする内容:**
- `ref` をPropsとして直接受け取れる（`forwardRef` 不要に）
  ```typescript
  // React 19以前
  const Input = forwardRef<HTMLInputElement, InputProps>((props, ref) => ...)
  // React 19以降
  function Input({ ref, ...props }: InputProps & { ref?: React.Ref<HTMLInputElement> }) ...
  ```
- `<form>` タグの `action` 属性がネイティブサポート
- ドキュメントメタデータ（`<title>` / `<meta>`）をコンポーネント内に書ける
- `use client` / `use server` の使い方の変化

**章末課題:**
- [ ] `use()` を使ってPromiseをSuspenseで処理した
- [ ] `useOptimistic` でいいね機能を楽観的更新で実装した
- [ ] React 19の `ref` をPropsとして受け取るコンポーネントを書いた

---

## 📗 Next.js編

---

### NX-01｜Next.js App Router基礎（既存・要拡充）
**カテゴリ:** nextjs ／ **難易度:** beginner〜intermediate ／ **推定時間:** 40分

既存のレッスンに以下を追加：

#### Lesson 1: App RouterとPages Routerの違い（既存）
- 追加: `layout.tsx` の入れ子構造の解説
- 追加クイズ: 穴埋め「`app/courses/[courseId]/page.tsx` のパスが対応するURLは `___`」

#### Lesson 2: 動的ルートとパラメータ（既存）
- 追加: `generateStaticParams` の実装例
- 追加: `loading.tsx` / `error.tsx` の配置場所と効果

#### Lesson 3: App Router のディレクトリ規約
**カバーする内容:**
- `app/` 配下の特殊ファイル一覧
  ```
  page.tsx        # ルートのUI（公開エンドポイント）
  layout.tsx      # 共通レイアウト（入れ子可）
  loading.tsx     # Suspenseフォールバック
  error.tsx       # エラー境界（'use client'必須）
  not-found.tsx   # 404 UI
  route.ts        # APIエンドポイント（Route Handler）
  middleware.ts   # リクエスト前処理（プロジェクトルート）
  ```
- `_components/` コロケーションパターン
  ```
  app/
    courses/
      _components/          # このルートでのみ使うコンポーネント
      │  CourseCard.tsx
      │  CourseFilter.tsx
      [courseId]/
        _components/
        │  LessonList.tsx
        page.tsx
      page.tsx
  components/               # アプリ全体で共通のもののみ
  ```
  - `_` プレフィックスによりNext.jsのルーティング対象から除外される
  - 「このコンポーネントはどこで使われているか」が一目でわかる
- `(グループ名)/` でURLに影響しないグループ化
  ```
  app/
    (auth)/
      login/page.tsx    # → /login
      register/page.tsx # → /register
    (app)/
      dashboard/page.tsx # → /dashboard
  ```
- **現場での判断基準**
  ```
  2つ以上のルートで使う → components/ に置く
  1つのルートでしか使わない → そのルートの _components/ に置く
  ```

**クイズ:**
1. `_components/` に置くべきコンポーネントはどれか（`single_choice`）
2. 穴埋め: URLに影響しないグループ化は `(___)` の形式で書く
3. `error.tsx` に必ず `'use client'` が必要な理由（`single_choice`）

#### Lesson 4: ナビゲーション Hooks（新規追加）
**カバーする内容:**
- `useRouter`: プログラマティックなナビゲーション
  ```typescript
  'use client'
  import { useRouter } from 'next/navigation'

  const router = useRouter()
  router.push('/courses')        // ページ遷移
  router.replace('/login')       // 履歴を残さず遷移
  router.back()                  // 前のページへ
  router.refresh()               // Server Componentを再取得
  ```
- `usePathname`: 現在のパスを取得（ナビゲーションのアクティブ表示に使う）
  ```typescript
  const pathname = usePathname()  // 例: "/courses/1/lessons/2"
  const isActive = pathname.startsWith('/courses')
  ```
- `useSearchParams`: URLのクエリパラメータを取得・設定
  ```typescript
  const searchParams = useSearchParams()
  const category = searchParams.get('category') // ?category=typescript
  ```
- `useParams`: 動的セグメントの取得（`[courseId]` など）
- **重要**: これらは全てClient Component限定（`'use client'`必須）
- **落とし穴**: `next/router` ではなく `next/navigation` からimportする（App Router）

**クイズ:**
1. `useRouter` をimportする正しいパス（`single_choice`: `next/navigation`）
2. 穴埋め: `const ___ = usePathname()` で現在のURLパスを取得

---

### NX-02｜エラーハンドリングとローディングUI
**カテゴリ:** nextjs ／ **難易度:** intermediate ／ **推定時間:** 45分

#### Lesson 1: loading.tsx でスケルトンUIを作る
**カバーする内容:**
- `loading.tsx` の配置場所とスコープ（最も近い上位layoutまで）
- Suspense Boundaryとの関係
- スケルトンUIのTailwind実装
  ```tsx
  // app/courses/loading.tsx
  export default function CoursesLoading() {
    return (
      <div className="grid grid-cols-3 gap-6">
        {[...Array(6)].map((_, i) => (
          <div key={i} className="h-48 bg-gray-200 rounded-xl animate-pulse" />
        ))}
      </div>
    )
  }
  ```
- **現場価値**: ユーザー体験の大幅改善。実装コスト低

**クイズ:**
1. `loading.tsx` が適用されるスコープの説明（`single_choice`）
2. 穴埋め: `export default function Loading() { return <div className="animate-___" /> }`

#### Lesson 2: error.tsx でエラー境界を実装する
**カバーする内容:**
- `error.tsx` はClient Component必須（`'use client'`）
- `error`と`reset`プロパティの型
- APIエラーとルーティングエラーの違い
- **落とし穴**: `error.tsx` は同階層のlayout.tsxのエラーは捕捉できない

**クイズ:**
1. `error.tsx` が `'use client'` 必須な理由（`single_choice`）
2. 穴埋め: `export default function Error({ error, ___ }: { error: Error, ___: () => void })`

#### Lesson 3: not-found.tsx のカスタマイズ
**カバーする内容:**
- `notFound()` 関数の呼び出し方
- `not-found.tsx` のデザイン
- 動的ページでのパターン: `if (!course) notFound()`
- **現場パターン**: 404ページにサイトマップや検索へのリンクを入れる

#### Lesson 4: グローバルエラーとフォールバック戦略
**カバーする内容:**
- `global-error.tsx` の役割（rootのlayout.tsxエラーを捕捉）
- エラーの分類と対応方針
  ```
  404 → not-found.tsx（ユーザーへのナビゲーション提示）
  API失敗 → error.tsx（retry + フォールバックUI）
  予期せぬエラー → global-error.tsx（シンプルなメッセージ）
  ```
- Sentryなどの外部エラー監視への送信パターン

**章末課題:**
- [ ] `/courses/[courseId]` に `loading.tsx` を実装した
- [ ] `error.tsx` でリトライボタンを実装した
- [ ] `notFound()` で存在しないコースIDへのアクセスを404に飛ばした

---

### NX-03｜Server Actionsとデータ更新
**カテゴリ:** nextjs ／ **難易度:** intermediate ／ **推定時間:** 55分

#### Lesson 1: Server Actionsの仕組みと制約
**カバーする内容:**
- `'use server'` ディレクティブ
- フォームの`action`属性にServer Actionを渡す
- Progressive Enhancement（JSなしでも動く）
- **制約**: Server Actionはサーバーで実行される → クライアントの状態に直接アクセスできない
- **現場での位置づけ**: フォームのPOST処理をAPI Route不要で書ける

**クイズ:**
1. Server Actionが実行される場所（`single_choice`）
2. 穴埋め: `async function createCourse(formData: ___) { 'use server'; ... }`

#### Lesson 2: フォームとServer Actionsの統合
**カバーする内容:**
- `useFormState` / `useActionState` の使い方
- バリデーションエラーをUIに返す
  ```tsx
  async function loginAction(prevState: State, formData: FormData) {
    'use server'
    const email = formData.get('email') as string
    // バリデーション → エラーを返す
    if (!email) return { error: 'メールアドレスは必須です' }
    // 成功 → redirect
  }
  ```
- **落とし穴**: `redirect()` は `try-catch` の中では使えない

#### Lesson 3: revalidatePath / revalidateTag
**カバーする内容:**
- Mutate後にキャッシュを無効化する仕組み
- `revalidatePath('/courses')` で一覧を最新化
- `revalidateTag('courses')` でタグベースの細かい制御
- **現場パターン**: Server ActionでDBを更新後に`revalidatePath`してリダイレクト

**クイズ:**
1. `revalidatePath`を呼ぶ適切なタイミング（`single_choice`）
2. 穴埋め: `revalidatePath('___')` でコース一覧を再検証する

#### Lesson 4: 楽観的更新（useOptimistic）
**カバーする内容:**
- `useOptimistic`でUIを先に更新してUXを改善
- Server Actionの完了を待たずに表示を変える
- エラー時のロールバック
- **現場での使いどころ**: いいね・チェック・ステータス変更など

---

### NX-04｜Middleware認証ガード
**カテゴリ:** nextjs ／ **難易度:** intermediate ／ **推定時間:** 50分

#### Lesson 1: Middlewareの仕組みと実行タイミング
**カバーする内容:**
- `middleware.ts` の配置（プロジェクトルート）
- `matcher` 設定でどのパスに適用するか指定
- Edgeランタイムで動く → Node.js APIが使えない制約
- リクエストの前に実行される → 認証チェックに最適

**クイズ:**
1. Middlewareが実行されるタイミング（`single_choice`）
2. 穴埋め: `export const config = { matcher: ['___'] }` で `/dashboard` 以下を指定

#### Lesson 2: JWTをMiddlewareで検証する
**カバーする内容:**
- `jose`ライブラリ（Edge互換のJWT検証）
- `cookies()`でJWTを取得
- 検証失敗時に`/login`へリダイレクト
  ```typescript
  // middleware.ts
  import { jwtVerify } from 'jose'
  export async function middleware(request: NextRequest) {
    const token = request.cookies.get('token')?.value
    if (!token) return NextResponse.redirect(new URL('/login', request.url))
    try {
      await jwtVerify(token, new TextEncoder().encode(process.env.JWT_SECRET))
    } catch {
      return NextResponse.redirect(new URL('/login', request.url))
    }
  }
  ```
- **落とし穴**: `jsonwebtoken`はNode.js専用でEdgeランタイムでは動かない → `jose`を使う

**クイズ:**
1. EdgeランタイムでJWT検証に使えるライブラリ（`single_choice`: `jose`が正解）
2. `true_false`: 「`jsonwebtoken`はMiddlewareで使える」→ false

#### Lesson 3: ロールベースのページ保護
**カバーする内容:**
- JWTのpayloadからroleを取得
- `admin`ロール限定ページへのアクセス制御
- 一般ユーザーを`/dashboard`にリダイレクト

#### Lesson 4: ログイン状態に応じたリダイレクト制御
**カバーする内容:**
- ログイン済みユーザーが`/login`にアクセスした時`/dashboard`へ
- 未ログインユーザーの`/dashboard`アクセスを`/login?redirect=/dashboard`へ
- `redirect`クエリパラメータを使ったログイン後の遷移先復元

**章末課題:**
- [ ] `middleware.ts` でJWT検証を実装した
- [ ] 未ログイン時に `/login` へリダイレクトされることを確認した
- [ ] ログイン後に元のページへリダイレクトされる動作を実装した

---

### NX-05｜データフェッチパターン（Server vs Client）
**カテゴリ:** nextjs ／ **難易度:** intermediate ／ **推定時間:** 45分

#### Lesson 1: いつServer Componentでfetchし、いつClient Componentにするか
**カバーする内容:**
- 判断基準の整理
  ```
  Server Component向き:
  - 初期表示データ（SEO対象）
  - 認証不要な一覧・詳細
  - APIキーを隠す必要がある

  Client Component向き:
  - ユーザー操作でデータが変わる
  - リアルタイム更新
  - ブラウザAPIが必要（localStorage等）
  ```
- **現場での設計思想**: できるだけServer Componentにする（バンドルサイズ削減）

#### Lesson 2: Server ComponentからAPIを呼ぶ時の注意点
**カバーする内容:**
- Dockerコンテナ内では`localhost`ではなくサービス名を使う（実際に踏んだ落とし穴）
- `INTERNAL_API_URL` と `NEXT_PUBLIC_API_URL` の使い分け
- `typeof window === 'undefined'` による分岐
- Rails `HostAuthorization` の落とし穴（config.hosts設定）

**クイズ:**
1. `true_false`: 「Server ComponentからのAPIリクエストにJWTトークンを自動付与できる」→ false（localStorageがない）
2. Server ComponentでのJWT送信方法（`single_choice`: cookiesから取得）

#### Lesson 3: Suspenseを使った段階的ローディング
**カバーする内容:**
- `<Suspense fallback={...}>` でコンポーネント単位のローディング
- 複数データを並列fetchする（`Promise.all`）
- `loading.tsx` vs `<Suspense>` の使い分け

#### Lesson 4: Client Componentでのデータ取得パターン
**カバーする内容:**
- `useEffect` + `fetch` の基本パターン（とその問題点）
- カスタムフック `useApiRequest<T>()` でのラップ
- SWR / TanStack Queryの概念（導入は任意）
- **現場の選択肢**: 小規模なら自作フック、大規模なら TanStack Query

#### Lesson 5: Next.jsのキャッシュ戦略（深掘り）
**カバーする内容:**
- Next.jsのキャッシュレイヤーを理解する（4種類）
  ```
  1. Request Memoization: 同一リクエストの重複排除（同一レンダリング内）
  2. Data Cache: fetch結果のサーバーサイドキャッシュ
  3. Full Route Cache: ビルド時の静的HTML キャッシュ
  4. Router Cache: クライアントサイドのルートキャッシュ
  ```
- `fetch` のキャッシュオプション
  ```typescript
  // デフォルト: キャッシュする（静的）
  fetch('/api/courses')

  // キャッシュしない（動的）
  fetch('/api/courses', { cache: 'no-store' })

  // 一定時間後に再検証（ISR）
  fetch('/api/courses', { next: { revalidate: 60 } })  // 60秒

  // タグベースの再検証
  fetch('/api/courses', { next: { tags: ['courses'] } })
  ```
- `dynamic` / `revalidate` エクスポートによるルート単位の設定
  ```typescript
  export const revalidate = 3600  // 1時間ごとに再生成
  export const dynamic = 'force-dynamic'  // 常に動的（no-store相当）
  ```
- **現場での判断フロー**
  ```
  コンテンツが変わらない → デフォルト（静的）
  定期的に更新 → revalidate: N（秒数）
  リアルタイム or 認証データ → cache: 'no-store'
  特定イベントで更新 → revalidateTag / revalidatePath
  ```
- **落とし穴**: `cookies()` や `headers()` を呼ぶと自動的に動的レンダリングになる

**クイズ:**
1. `fetch('/api/data', { next: { revalidate: 60 } })` の説明（`single_choice`）
2. `cache: 'no-store'` を使うべき状況（`multiple_choice`）
3. 穴埋め: `export const ___ = 'force-dynamic'` でルートを動的にする

---

### NX-06｜Zodバリデーションとフォーム設計
**カテゴリ:** nextjs ／ **難易度:** intermediate ／ **推定時間:** 50分

#### Lesson 1: Zodの基本スキーマ定義
**カバーする内容:**
- `z.string()` / `z.number()` / `z.boolean()` / `z.object()`
- `z.infer<typeof schema>` で型を生成
- バリデーション実行: `schema.parse()` vs `schema.safeParse()`
- **現場価値**: バリデーションと型定義を一元管理できる

**クイズ:**
1. `z.infer<typeof userSchema>` の説明（`single_choice`）
2. 穴埋め: `const schema = z.object({ email: z.string().___()`は何のバリデーション？

#### Lesson 2: APIレスポンスの型安全な検証
**カバーする内容:**
- バックエンドから受け取ったデータをZodで検証
- `safeParse`を使ったエラーハンドリング
- **現場価値**: バックエンドのスキーマ変更を即座に検知できる
- **落とし穴**: `parse()`は例外を投げる → APIクライアントで使う場合は注意

#### Lesson 3: react-hook-form + Zodの統合
**カバーする内容:**
- `@hookform/resolvers/zod` を使ったバリデーション
- `useForm<z.infer<typeof schema>>({ resolver: zodResolver(schema) })`
- フィールドごとのエラー表示
- **現場パターン**: これがフォーム実装のデファクトスタンダード

**クイズ:**
1. zodResolverを使う利点（`single_choice`）
2. 穴埋め: `const { register } = useForm({ resolver: ___(loginSchema) })`

#### Lesson 4: Server ActionsでのZodバリデーション
**カバーする内容:**
- Server Action内でのFormData → Zodスキーマ検証
- エラーをUIに返すパターン
- クライアントとサーバー両方でバリデーションする理由

---

### NX-07｜Vercelデプロイと環境変数管理
**カテゴリ:** nextjs ／ **難易度:** intermediate ／ **推定時間:** 40分

#### Lesson 1: 環境変数の分類と管理方針
**カバーする内容:**
- `NEXT_PUBLIC_` あり/なしの違い（バンドルに含まれるかどうか）
- `.env.local` / `.env.production` / `.env.development` の使い分け
- **セキュリティ**: APIキー・JWTシークレットに絶対`NEXT_PUBLIC_`をつけない
- Dockerでの環境変数の渡し方（`compose.yml` の `environment`）

**クイズ:**
1. `true_false`: 「`NEXT_PUBLIC_SECRET_KEY`はブラウザで見えてしまう」→ true
2. 穴埋め: サーバーサイドのみに公開するには `___` プレフィックスをつけない

#### Lesson 2: Vercelへのデプロイフロー
**カバーする内容:**
- GitHubリポジトリとの連携
- Vercelダッシュボードでの環境変数設定
- `vercel.json` の設定（rewriteなど）
- プレビューデプロイとプロダクションデプロイの使い分け

#### Lesson 3: next.config.tsの重要設定
**カバーする内容:**
- `images.remotePatterns`（外部画像ドメインの許可）
- `rewrites`（APIのプロキシ）
- `headers`（セキュリティヘッダーの追加）
- `output: 'standalone'`（Docker本番用）

---

### NX-08｜next/image・next/font・Metadata API
**カテゴリ:** nextjs ／ **難易度:** intermediate ／ **推定時間:** 50分

#### Lesson 1: next/image で画像を最適化する
**カバーする内容:**
- `<img>` タグとの違い（自動WebP変換・遅延読み込み・サイズ最適化）
- 必須Props: `src`・`alt`・`width`・`height`
  ```tsx
  import Image from 'next/image'

  // サイズ固定の場合
  <Image src="/hero.png" alt="ヒーロー画像" width={800} height={400} />

  // 親要素いっぱいに広げる場合
  <div className="relative w-full h-64">
    <Image src="/cover.jpg" alt="カバー" fill className="object-cover" />
  </div>
  ```
- `priority`: LCP（Largest Contentful Paint）に関わる画像に付ける
- 外部ドメイン画像: `next.config.ts` の `remotePatterns` 設定が必要
- **落とし穴**: `fill` を使う場合は親要素に `position: relative` が必要

**クイズ:**
1. `priority` を付けるべき画像はどれか（`single_choice`: ファーストビューのメイン画像）
2. 穴埋め: 外部画像を表示するには `next.config.ts` の `___` に設定が必要

#### Lesson 2: next/font でフォントを最適化する
**カバーする内容:**
- Googleフォントの読み込みとパフォーマンス問題（FOUT・レイアウトシフト）
- `next/font/google` でのゼロCLS実現
  ```typescript
  import { Noto_Sans_JP } from 'next/font/google'

  const notoSansJP = Noto_Sans_JP({
    subsets: ['latin'],
    weight: ['400', '700'],
    display: 'swap',
  })

  export default function RootLayout({ children }) {
    return <html className={notoSansJP.className}>{children}</html>
  }
  ```
- ローカルフォント: `next/font/local`
- **現場価値**: フォント読み込みをビルド時に解決するため実行時にGoogleサーバーへの通信が不要

**クイズ:**
1. `next/font`を使うメリット（`multiple_choice`）
2. `true_false`: 「`next/font`を使うとGoogleのサーバーにアクセスが発生する」→ false

#### Lesson 3: Metadata APIでSEOを制御する
**カバーする内容:**
- 静的メタデータ: `metadata` オブジェクトのエクスポート
  ```typescript
  export const metadata: Metadata = {
    title: 'Next.js学習プラットフォーム',
    description: 'TypeScript・React・Next.jsを現場レベルまで学べる',
    openGraph: {
      title: 'Next.js学習プラットフォーム',
      images: ['/og-image.png'],
    },
  }
  ```
- 動的メタデータ: `generateMetadata` 関数（APIデータを使う場合）
  ```typescript
  export async function generateMetadata({ params }: Props): Promise<Metadata> {
    const course = await coursesApi.get(params.courseId)
    return { title: course.title, description: course.description }
  }
  ```
- タイトルテンプレート: `{ template: '%s | サイト名', default: 'サイト名' }`
- **現場価値**: SSRで生成されるため、SNSシェア時のOGPも正しく機能する

**クイズ:**
1. 動的なメタデータを設定するための関数名（`fill_in_blank`: `generateMetadata`）
2. `true_false`: 「Client ComponentでもMetadata APIは使える」→ false（Server Componentのみ）

#### Lesson 4: next/script でサードパーティスクリプトを制御する
**カバーする内容:**
- `<Script>` コンポーネントの `strategy` オプション
  ```
  beforeInteractive: ページがインタラクティブになる前（アナリティクス必須）
  afterInteractive: インタラクティブ後（GA・タグマネージャー）← デフォルト
  lazyOnload: アイドル時（チャットウィジェット等）
  ```
- `onLoad` コールバックでスクリプト読み込み後の処理
- **現場での使いどころ**: Google Analytics・Hotjar・インターコム等の導入

**章末課題:**
- [ ] `next/image` で外部ドメインの画像を表示した
- [ ] `next/font` でGoogleフォントを設定し、CLSが0であることを確認した
- [ ] 動的ルートページで `generateMetadata` を実装した

---

### NX-09｜Route Handlers（APIルート）
**カテゴリ:** nextjs ／ **難易度:** intermediate ／ **推定時間:** 55分

#### Lesson 1: Route Handlersの仕組みと使いどころ
**カバーする内容:**
- `app/api/.../route.ts` でAPIエンドポイントを定義
- Pages Routerの `pages/api/` との違い
- `GET`・`POST`・`PUT`・`DELETE` のHTTPメソッドを関数名で定義
  ```typescript
  // app/api/hello/route.ts
  export async function GET(request: Request) {
    return Response.json({ message: 'Hello' })
  }

  export async function POST(request: Request) {
    const body = await request.json()
    return Response.json({ received: body }, { status: 201 })
  }
  ```
- **使いどころ**: Webhookの受信・外部APIキーの隠蔽・BFF（Backend for Frontend）

**クイズ:**
1. Route Handlersが必要なシーン（`multiple_choice`）
2. 穴埋め: `export async function ___(request: Request)` でPOSTエンドポイント

#### Lesson 2: 認証付きRoute HandlerとCookies
**カバーする内容:**
- `cookies()` でCookieを読む
- JWTをCookieから取得してユーザー認証
  ```typescript
  import { cookies } from 'next/headers'

  export async function GET() {
    const token = (await cookies()).get('token')?.value
    if (!token) return Response.json({ error: 'Unauthorized' }, { status: 401 })
    // JWTを検証してユーザー情報取得...
  }
  ```
- `NextRequest` / `NextResponse` でより詳細な制御
- リクエストヘッダーの取得: `headers()` API

**クイズ:**
1. `cookies()` を使うための import 元（`single_choice`: `next/headers`）
2. 穴埋め: `return Response.json({ error: 'Unauthorized' }, { status: ___ })`

#### Lesson 3: 外部APIのプロキシパターン
**カバーする内容:**
- APIキーをクライアントに漏らさないためのプロキシ
  ```typescript
  // app/api/weather/route.ts
  export async function GET(request: Request) {
    const { searchParams } = new URL(request.url)
    const city = searchParams.get('city')

    const res = await fetch(
      `https://api.weather.com/v1/current?city=${city}&key=${process.env.WEATHER_API_KEY}`
    )
    const data = await res.json()
    return Response.json(data)
  }
  ```
- `CORS` ヘッダーの付け方
- **現場での重要性**: `NEXT_PUBLIC_` をつけると即座にブラウザに漏れる → Route Handlerで隠蔽

#### Lesson 4: Webhookの受信（Stripe・GitHub例）
**カバーする内容:**
- Webhookのシグネチャ検証の重要性
- `request.text()` でRawボディを取得（JSONパース前に署名検証が必要）
- `NextResponse` でのレスポンス返却
- **現場パターン**: Stripeの支払い完了Webhookを受けてDBを更新する

**章末課題:**
- [ ] `GET /api/status` でサーバーの状態を返すRoute Handlerを実装した
- [ ] 認証付きRoute Handlerで401レスポンスを返す処理を書いた
- [ ] 外部APIキーをRoute Handler経由で隠蔽するプロキシを実装した

---

## 📙 Rails × Next.js 連携編

---

### RN-01｜JWT認証の完全フロー
**カテゴリ:** rails ／ **難易度:** intermediate ／ **推定時間:** 60分

#### Lesson 1: JWT認証フローの全体像
**カバーする内容:**
- 認証フロー全体図
  ```
  1. ユーザーがメール/パスワードをPOST
  2. Railsがパスワード検証 → JWTを生成して返す
  3. Next.jsがJWTをlocalStorage/Cookieに保存
  4. 以降のリクエストにAuthorizationヘッダーでJWTを付与
  5. RailsがJWTを検証してユーザーを特定
  ```
- SessionベースとJWTベースの違い（ステートレス）
- JWTのペイロードに入れるべき情報と入れてはいけない情報

#### Lesson 2: RailsのJwt実装詳解
**カバーする内容:**
- `JwtService.encode` / `.decode` の実装
- 有効期限（exp）の設計（24時間 vs Refresh Token）
- `AuthenticationError` カスタム例外の設計
- `Api::V1::User` モジュールとの名前衝突と `::User` での解決（実際に踏んだ落とし穴）

**クイズ:**
1. `::User` とただの `User` の違い（`single_choice`）
2. JWTのpayloadに含めるべきでないものはどれか（`single_choice`: パスワード）

#### Lesson 3: Next.jsのJWT管理戦略
**カバーする内容:**
- localStorage vs Cookie の比較（セキュリティ・使いやすさ）
  ```
  localStorage: XSS脆弱性あり、簡単
  Cookie（httpOnly）: XSS耐性、CSRFリスク
  ```
- `api.ts` のaxiosインターセプターでのJWT自動付与
- 401レスポンス時の自動ログアウト処理

#### Lesson 4: トークンリフレッシュとセッション継続
**カバーする内容:**
- Refresh Tokenの概念と設計
- `401`レスポンス → トークン更新 → リクエストリトライの実装パターン
- **現場での判断**: 短命なアクセストークン + 長命なリフレッシュトークン

**章末課題:**
- [ ] JWTの3つの構成要素（Header/Payload/Signature）を説明できる
- [ ] axiosインターセプターでJWTを自動付与するコードを書けた
- [ ] 401エラー時に自動ログアウトする処理を実装した

---

### RN-02｜CORS設計とトラブルシューティング
**カテゴリ:** rails ／ **難易度:** intermediate ／ **推定時間:** 40分

#### Lesson 1: CORSの仕組みと必要な設定
**カバーする内容:**
- Same-Origin Policyとは
- CORSヘッダーの意味（`Access-Control-Allow-Origin` 等）
- プリフライトリクエスト（OPTIONS）の仕組み
- `rack-cors`の設定

#### Lesson 2: Docker環境でのSSR通信の落とし穴（実体験）
**カバーする内容:**
- SSR（Server Component）はコンテナ内で実行される
- `localhost:3001`はコンテナ内ではbackendに繋がらない
- `INTERNAL_API_URL=http://backend:3001`と`NEXT_PUBLIC_API_URL`の使い分け
- `docker compose restart` vs `up --force-recreate` の違い
- Rails `ActionDispatch::HostAuthorization` の落とし穴と `config.hosts` の設定
- **これはこのプロジェクトで実際に踏んだ問題をそのままコンテンツ化する**

**クイズ:**
1. `true_false`: 「`docker compose restart`で`compose.yml`の環境変数変更が反映される」→ false
2. Next.jsのSSRからDockerのbackendに接続する正しいURLは（`single_choice`: `http://backend:3001`）

#### Lesson 3: API設計パターン（エラーレスポンス統一）
**カバーする内容:**
- エラーレスポンスの形式を統一する
  ```json
  { "error": "メッセージ" }         // 単一エラー
  { "errors": ["...", "..."] }      // バリデーションエラー
  ```
- Railsでの`rescue_from`による一元管理
- フロントエンドでのエラー型定義とハンドリング

#### Lesson 4: 環境別設定の管理（dev/prod）
**カバーする内容:**
- `.env` / `.env.production` の管理方針
- Railsの`credentials.yml.enc`とDockerの環境変数の使い分け
- フロントエンドとバックエンドの環境変数を整合させる設計

---

## コース全体像

| コースID | タイトル | レッスン数 | 推定時間 |
|---------|---------|-----------|---------|
| TS-01 | TypeScript型システム基礎 | 5 | 30分 |
| TS-02 | Utility Types実践 | 6 | 50分 |
| TS-03 | 型ガードとType Narrowing | 4 | 45分 |
| TS-04 | Generics実践 | 4 | 60分 |
| RC-01 | React基礎とJSX | 4 | 40分 |
| RC-02 | 基本Hooks | 3 | 50分 |
| RC-03 | 応用Hooks | 4 | 65分 |
| RC-04 | コンポーネント設計パターン | 6 | 75分 |
| RC-05 | 状態管理の設計 | 4 | 50分 |
| RC-06 | パフォーマンス最適化 | 4 | 50分 |
| RC-07 | React 19の新機能 | 4 | 45分 |
| NX-01 | Next.js App Router基礎 | 4 | 40分 |
| NX-02 | エラーハンドリング・ローディングUI | 4 | 45分 |
| NX-03 | Server Actionsとデータ更新 | 4 | 55分 |
| NX-04 | Middleware認証ガード | 4 | 50分 |
| NX-05 | データフェッチパターン・キャッシュ戦略 | 5 | 45分 |
| NX-06 | Zodバリデーションとフォーム設計 | 4 | 50分 |
| NX-07 | Vercelデプロイと環境変数管理 | 3 | 40分 |
| NX-08 | next/image・next/font・Metadata API | 4 | 50分 |
| NX-09 | Route Handlers | 4 | 55分 |
| RN-01 | JWT認証の完全フロー | 4 | 60分 |
| RN-02 | CORS設計とトラブルシューティング | 4 | 40分 |
| **合計** | **22コース** | **約96レッスン** | **約約18時間** |

---

## MVP（最初に公開する最小セット）

全96レッスンを一度に作るのは現実的でないため、**最初に公開するMVP**を定義する。

### MVPコース（推奨学習パスの骨格）

| コースID | 選定理由 |
|---------|---------|
| TS-01 | 既存コンテンツあり・入口として必須 |
| TS-02 | Utility Typesは現場で毎日使う |
| RC-01 | React入門として必須 |
| RC-02 | Hooksは基本中の基本 |
| RC-04 | ディレクトリ設計・TypeScript×Reactの型は必須 |
| NX-01 | App Router基礎は必須 |
| NX-05 | SSR・キャッシュ戦略は現場で最も詰まる部分 |
| RN-01 | JWT認証フローはこのプロジェクト固有の価値 |
| RN-02 | Docker通信の落とし穴は実体験からくる価値 |

**MVP合計: 9コース・約40レッスン・約7時間**

残りのコースは MVP 公開後に順次追加する。

---

## 実装ロードマップ

### Phase 1（まず着手）
1. 上記コース設計に基づいてseedデータを作成
2. `multiple_choice` クイズUIの実装
3. `fill_in_blank` クイズUIの実装
4. レッスン前後ナビゲーションの実装
5. `loading.tsx` / `error.tsx` の実コードに追加
6. NX-08・NX-09・RC-02追加分・TS-02追加分のseedデータ作成

### Phase 2
1. 学習パス（learning_paths）DBとUI
2. レッスンロック機能
3. 章末課題チェックリスト

### Phase 3
1. Monaco Editor + コードチャレンジ
2. ヒント機能
3. クライアントサイド評価（TypeScript）

### Phase 4: ターミナル風コードチャレンジ UI

#### 画面構成
```
┌─────────────────────────────────────────┐
│ 問題: Partial<T> を自分で実装してください  │
│ 条件: Mapped Types を使うこと           │
└─────────────────────────────────────────┘

┌── Editor（Monaco）─────────────────────┐
│ type MyPartial<T> = {                   │
│   [K in keyof T]?: T[K]               │
│ }                                       │
│ // テストケース（編集不可ゾーン）       │
│ type Result = MyPartial<{name: string}> │
└─────────────────────────────────────────┘
         [▶ 実行]   [ヒントを見る]

┌── Output（ターミナル風）───────────────┐
│ $ checking types...                     │
│ ✅ テスト1: MyPartial<User> 通過        │
│ ❌ テスト2: readonly プロパティが必要   │
│ Score: 1/2                              │
└─────────────────────────────────────────┘
```

#### 評価方式
- **Monaco Editor**（TypeScript言語サービス有効）でリアルタイム型エラー表示
- 「実行」ボタンで **TypeScript Compiler API（ブラウザ内）** によるコンパイル
- **Webワーカー内でサンドボックス eval()** してテストケースを実行
- 結果をターミナル風エリアに表示（✅ / ❌ / スコア）

#### コードチャレンジを配置するレッスン（curriculum.md 内でマーク済み）

| レッスン | チャレンジ内容 |
|---------|---------------|
| TS-04 Lesson 1 | `first<T>(arr: T[]): T \| undefined` を実装 |
| TS-04 Lesson 2 | `getProperty<T, K extends keyof T>` を実装 |
| TS-04 Lesson 4 | `IsArray<T>` と `Flatten<T>` を実装 |
| TS-02 Lesson 5 | `MyPartial<T>` を Mapped Types で実装 |
| RC-02 Lesson 1 | バッチング動作を確認するコードを書く |

#### ヒント機能
- 最大3段階のヒントを順番に表示
- ヒント使用でスコア減点（3問正解満点 → ヒント1回で2点換算）
- ヒント内容は seed データで管理

---

## 用語・品質統一ルール

- コード例は必ずTypeScriptで書く（JSは原則使わない）
- 変数名・コメントは日本語でもよい（学習者が読みやすいことを優先）
- 「落とし穴」セクションは必ず入れる（現場で詰まる原因を事前に教える）
- クイズは最低2問/レッスン、難易度を上げたい場合は穴埋めを使う
- 「なぜこれが必要か」を必ず書く（Whatより先にWhy）
