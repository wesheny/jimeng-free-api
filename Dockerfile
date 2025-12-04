# 1. 使用 Node.js 环境
FROM node:18-slim

# 2. 设置工作目录
WORKDIR /app

# 3. 复制所有文件
COPY . .

# 4. 安装依赖并编译 (TypeScript 项目必须编译)
RUN npm install
RUN npm run build

# 5. 创建非 root 用户 (Hugging Face 安全硬性要求)
RUN useradd -m -u 1000 user
USER user

# 6. 设置环境变量
# 强制让程序监听 7860 端口
ENV PORT=7860
# 设置时区
ENV TZ=Asia/Shanghai

# 7. 暴露端口
EXPOSE 7860

# 8. 启动命令
# 编译后的启动命令通常是 npm run start
CMD ["npm", "run", "start"]
