# FlowPlan Project Gantt

在线项目甘特图，支持任务排期、依赖、资源、基线、风险、报表、项目组合、工时审批和 PDF 导出。

## GitHub 部署

在已登录 GitHub CLI 的终端中运行：

```bash
bash deploy.sh
```

脚本会创建或更新公开仓库 `project-gantt`，推送代码并启用 GitHub Pages。公网地址通常为：

`https://<github用户名>.github.io/project-gantt/`

### 自动部署助手

Codex 无法直接读取 macOS 钥匙串中的 GitHub 凭证，但用户终端可以。启动一次自动部署助手后，后续更新无需再次手动部署：

```bash
bash auto-deploy.sh
```

请保持该终端窗口打开。助手启动时会先发布当前修改，以后收到部署请求会自动执行 `deploy.sh`。部署过程会记录到 `deploy.log`。

## Supabase 实时数据与登录

1. 创建 Supabase 项目。
2. 在 SQL Editor 执行 `supabase-schema.sql`。
3. 在 Authentication > Providers > Email 中创建管理员账号，并自行设置登录邮箱和密码。
4. 首次设置完成后关闭公开注册，只保留指定账号登录。
5. 从 Project Settings > API 复制 Project URL 和 anon public key。
6. 填入 `supabase-config.js`，提交并重新推送。

配置完成后：

- 未登录访客可以打开公网链接查看公开项目数据。
- 指定账号登录后可以编辑，修改会保存到 Supabase。
- 在线修改通过 Supabase Realtime 实时同步到其他已打开页面。
- 登录账号和密码不会写入前端源码。

## 项目数据迁移

网页地址不同或浏览器不同，浏览器本机保存的数据不会自动互通。例如 GitHub Pages 在线页面与 `file://` 本地页面就是两个独立存储空间。

可使用 JSON 备份迁移：

1. 在有项目数据的页面点击“导出”。
2. 选择“JSON 完整备份”，确认导出。
3. 在目标页面打开“导出”弹窗，点击底部“导入 JSON 项目备份”。
4. 选择刚下载的 JSON 文件。导入后会自动切换到该项目，并恢复任务、资源、基线和视图配置。

若已经登录 Supabase，导入或修改后会继续走云端实时同步；否则数据只保存在当前浏览器。
