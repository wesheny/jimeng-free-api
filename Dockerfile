# 1. 使用 Node.js 环境
FROM node:18-slim

# 2. 设置工作目录
WORKDIR /app

# 3. 复制所有文件
COPY . .

# 4. 安装依赖并编译
RUN npm install
RUN npm run build

# 5. 【关键修改】修复权限问题
# node 镜像自带一个叫 node 的用户(UID 1000)，我们直接把文件权限给它
RUN chown -R node:node /app

# 6. 切换到内置的 node 用户 (不再使用 useradd 创建新用户)
USER node

# 7. 设置环境变量
ENV PORT=7860
ENV TZ=Asia/Shanghai

# 8. 暴露端口
EXPOSE 7860

# 9. 启动命令
CMD ["npm", "run", "start"]
