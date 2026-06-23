# 培训师积分与展示邀约页

本项目是两个相互独立的静态网页：`index.html` 用于积分管理，`trainer-invite.html` 用于培训师展示与校培邀约流程。发布到 GitHub Pages 后，页面自动进入公开只读展示模式。

## 本地使用

双击 `index.html` 打开积分看板，双击 `trainer-invite.html` 打开展示邀约页。积分明细、培训师资料和本地维护的课题会保存在当前浏览器本地。

本地打开页面时保留维护能力；发布到 `github.io` 域名后会自动隐藏编辑入口，外部人员只能查看。

## 分享预览

录入和复核完成后，点击积分看板顶部“导出分享预览”，会导出只读 `index.html`。展示邀约页独立维护和导出，可打开 `trainer-invite.html` 后点击“导出分享页”。

分享或发布时需要保持这三个内容在同一目录：

- `index.html`
- `trainer-invite.html`
- `assets/`

展示邀约页支持在本地维护培训师信息、照片路径和课题，可新增、编辑、删除课题。新增或修改后请重新导出分享页或重新发布，外部只读页面才会看到更新。

积分看板的分组明细和原表格式导出均为 CSV，Excel 可以直接打开；JSON 备份用于网页自身恢复数据。

## 校培邀约流程

展示邀约页不再让外部用户直接填写网页表单，而是展示校培邀约流程，并提供“一键发起邮件”。

默认邮件收件人：`fz_px@xdf.cn`。默认抄送：人力总监邮箱 `chenliyun@xdf.cn`。需求方仍需按实际情况补充部门总监邮箱及其他需要抄送的人。

流程包括：需求方先与意向培训师初步确认档期和需求；发送需求邮件；人力资源部确认培训任务并在 3 天内回复；培训结束后 3 天内完成满意度问卷；人力资源部发起课酬报批与发放。

## GitHub Pages 发布

1. 在 GitHub 新建一个空仓库，并把仓库 URL 提供给维护者。
2. 将本目录内容推送到该仓库，确保包含 `index.html`、`trainer-invite.html`、`assets/`、`.nojekyll`。
3. 在 GitHub 仓库设置中打开 `Settings -> Pages`。
4. Source 选择 `Deploy from a branch`，Branch 选择 `main`，目录选择 `/root`。
5. 保存后等待部署完成，访问页面给出的 `https://用户名.github.io/仓库名/`。

发布到 `github.io` 域名后，页面会自动进入只读模式。

## 第二阶段：Supabase 云端后台

展示邀约页已预留 Supabase 云端后台能力。未配置时仍按本地静态版运行；配置后，公网访客只读查看，管理员登录后可在线维护培训师资料、课题和照片。

配置步骤：

1. 在 Supabase 新建项目。
2. 打开 Supabase 的 SQL Editor，复制并执行 `supabase-schema.sql`。
3. 在 Supabase Auth 中创建你的管理员邮箱和密码；不要开放陌生人自助注册。
4. 在 Supabase Project Settings -> API 中复制 Project URL 和 anon public key。
5. 打开 `supabase-config.js`，填入：

```js
window.TRAINER_PORTAL_SUPABASE = {
  url: "你的 Project URL",
  anonKey: "你的 anon public key",
  photoBucket: "trainer-photos"
};
```

6. 上传 `trainer-invite.html`、`supabase-config.js`、`supabase-schema.sql` 和 `assets/` 到 GitHub。
7. 打开展示邀约页，点击“管理员登录”，登录后可维护资料；点击“同步云端”可把当前页面资料写入 Supabase。

说明：`anon public key` 可以放在前端页面中，真正的编辑权限由 Supabase 登录和 RLS 策略控制。
