import axios from "axios";

// SSR (サーバー側): INTERNAL_API_URL を使用 (コンテナ間通信)
// CSR (ブラウザ側): NEXT_PUBLIC_API_URL を使用 (ブラウザ → ホスト経由)
const getBaseURL = () => {
  if (typeof window === "undefined") {
    return process.env.INTERNAL_API_URL ?? "http://backend:3001/api/v1";
  }
  return process.env.NEXT_PUBLIC_API_URL ?? "http://localhost:3001/api/v1";
};

export const apiClient = axios.create({
  baseURL: getBaseURL(),
  headers: { "Content-Type": "application/json" },
});

// リクエストインターセプター: JWTトークンを自動付与
apiClient.interceptors.request.use((config) => {
  if (typeof window !== "undefined") {
    const token = localStorage.getItem("token");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
  }
  return config;
});

// レスポンスインターセプター: 401 → ログアウト
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401 && typeof window !== "undefined") {
      localStorage.removeItem("token");
      window.location.href = "/login";
    }
    return Promise.reject(error);
  }
);

// SSR用: サーバーサイドでトークンを渡して直接リクエスト
export const fetchWithToken = async <T>(
  path: string,
  token: string
): Promise<T> => {
  const baseURL =
    process.env.INTERNAL_API_URL ?? "http://backend:3001/api/v1";
  const res = await fetch(`${baseURL}${path}`, {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
    cache: "no-store",
  });
  if (!res.ok) throw new Error(`API error: ${res.status}`);
  return res.json() as Promise<T>;
};
