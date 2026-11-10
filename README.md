# FlowPlan Project Gantt

在线项目甘特图，支持任务排期、依赖、资源、基线、风险、报表、项目组合、工时审批和 PDF 导出。

## GitHub 部署

在已登录 GitHub CLI 的终端中运行：

```bash
bash deploy.sh
```

脚本会创建或更新公开仓库 `project-gantt`，推送代码并启用 GitHub Pages。公网地址通常为：

`https://<github用户名>.github.io/project-gantt/`

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
