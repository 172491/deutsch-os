# Deutsch OS｜德语学习系统

> **当前发布包：[Deutsch OS v1.8](deutsch-os-v1.8.zip)**。项目介绍：面向 A1→B2 的德语学习系统，包含 Goethe 校准、分级 Redemittel 等学习内容。此仓库目前保存发布压缩包和部署脚本；压缩包内的应用源码须解压后查看，仓库根目录本身没有完整的 `src/`、`public/` 和 `package.json`。

## 版本与入口

- **[v1.8 发布包（当前）](deutsch-os-v1.8.zip)**：当前拟部署版本。解压后的应用目录为 `deutsch-os-v1.8/`，其中应有 `package.json`、`src/`、`public/`、`supabase.sql`、`vite.config.ts` 等项目文件。实际内容及运行要求以压缩包为准。
- [v1.7.2 发布包（历史）](deutsch-os-v1.7.2.zip)：历史压缩包，保留以便版本回溯；不覆盖v1.8。
- [Cloudflare构建脚本](build-cloudflare.sh)：从仓库**根目录**的 `deutsch-os-v1.8.zip` 解压、在临时目录应用 `ts-fsrs` 类型补丁、执行 `npm install` 和 `npm run build`，复制构建结果到仓库根目录的 `dist/`。脚本只针对v1.8的指定压缩包结构。
- [Cloudflare重新部署标记](CLOUDFLARE_REDEPLOY.txt)：既有部署辅助文件；单凭该文件无法确认线上部署状态。

## 注意

`build-cloudflare.sh` 使用固定的根目录ZIP路径和解压目录名；**不要仅为使目录整齐而移动、改名或删除v1.8压缩包**，否则须同时修改并测试部署脚本。`dist/` 为运行脚本后生成的构建产物，仓库中存在构建脚本不等于已完成构建或线上部署。将来若按源码仓库方式重组，应先在单独分支处理压缩包解包、依赖与部署验证，再调整README。
