import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Render デプロイ用: standalone モードで依存ファイルを最小化
  output: "standalone",
};

export default nextConfig;
