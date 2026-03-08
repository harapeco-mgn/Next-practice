// ユーザー
export type User = {
  id: number;
  name: string;
  email: string;
  role: "user" | "admin";
};

// 認証レスポンス
export type AuthResponse = {
  token: string;
  user: User;
};

// コース
export type Difficulty = "beginner" | "intermediate" | "advanced";
export type Category = "rails" | "nextjs" | "typescript" | "react";

export type Course = {
  id: number;
  title: string;
  description: string;
  category: Category;
  difficulty: Difficulty;
  position: number;
  lessons_count?: number;
};

// レッスン
export type Lesson = {
  id: number;
  course_id: number;
  title: string;
  content: string;
  position: number;
  prev_lesson_id?: number | null;
  next_lesson_id?: number | null;
};

// クイズ
export type QuizType =
  | "single_choice"
  | "multiple_choice"
  | "true_false"
  | "fill_in_blank"
  | "code_challenge";

export type QuizOption = {
  id: number;
  body: string;
  position: number;
};

export type Quiz = {
  id: number;
  lesson_id: number;
  question: string;
  explanation: string | null;
  quiz_type: QuizType;
  correct_answer: string | null;
  starter_code: string | null;
  test_code: string | null;
  hints: string[] | null;
  position: number;
  quiz_options: QuizOption[];
};

// 進捗
export type ProgressStatus = "not_started" | "in_progress" | "completed";

export type UserProgress = {
  id: number;
  lesson_id: number | null;
  quiz_id: number | null;
  status: ProgressStatus;
  score: number | null;
};

// APIエラー
export type ApiError = {
  error?: string;
  errors?: string[];
};
