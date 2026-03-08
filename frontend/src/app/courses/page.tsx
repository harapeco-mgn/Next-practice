import Link from "next/link";
import type { Course } from "@/lib/types";

async function getCourses(): Promise<Course[]> {
  const baseURL =
    process.env.INTERNAL_API_URL ?? "http://backend:3001/api/v1";
  const res = await fetch(`${baseURL}/courses`, { cache: "no-store" });
  if (!res.ok) throw new Error("コース一覧の取得に失敗しました");
  const data = await res.json();
  return data.courses;
}

const difficultyLabel: Record<string, string> = {
  beginner: "初級",
  intermediate: "中級",
  advanced: "上級",
};
const categoryLabel: Record<string, string> = {
  typescript: "TypeScript",
  react: "React",
  nextjs: "Next.js",
  rails: "Rails",
};
const difficultyColor: Record<string, string> = {
  beginner: "bg-green-100 text-green-700",
  intermediate: "bg-yellow-100 text-yellow-700",
  advanced: "bg-red-100 text-red-700",
};

export default async function CoursesPage() {
  const courses = await getCourses();

  return (
    <div className="mx-auto max-w-5xl px-6 py-12">
      <h1 className="mb-8 text-3xl font-bold text-gray-900">コース一覧</h1>
      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {courses.map((course) => (
          <Link
            key={course.id}
            href={`/courses/${course.id}`}
            className="rounded-xl border bg-white p-6 shadow-sm transition hover:shadow-md"
          >
            <div className="mb-3 flex items-center gap-2">
              <span className="rounded-full bg-indigo-100 px-2.5 py-0.5 text-xs font-medium text-indigo-700">
                {categoryLabel[course.category] ?? course.category}
              </span>
              <span
                className={`rounded-full px-2.5 py-0.5 text-xs font-medium ${difficultyColor[course.difficulty] ?? ""}`}
              >
                {difficultyLabel[course.difficulty] ?? course.difficulty}
              </span>
            </div>
            <h2 className="mb-2 text-lg font-semibold text-gray-900">
              {course.title}
            </h2>
            <p className="text-sm text-gray-700">{course.description}</p>
          </Link>
        ))}
      </div>
    </div>
  );
}
