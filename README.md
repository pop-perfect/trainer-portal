# 培训师积分与展示邀约页

本项目是静态网页，可以直接打开 `index.html` 管理积分，也可以打开 `trainer-invite.html` 展示培训师并维护课题。发布到 GitHub Pages 后，页面自动进入只读展示模式。

## 本地使用

双击 `index.html` 打开积分看板，双击 `trainer-invite.html` 打开展示邀约页。积分明细、邀约记录和本地维护的课题会保存在当前浏览器本地。

## 分享预览

录入和复核完成后，点击积分看板顶部“导出分享预览”，会导出只读 `index.html`。展示邀约页独立维护和导出，可打开 `trainer-invite.html` 后点击“导出分享页”。

分享或发布时需要保持这三个内容在同一目录：

- `index.html`
- `trainer-invite.html`
- `assets/`

展示邀约页支持在本地给每位培训师新增课题。新增后请重新导出分享页或重新发布，外部只读页面才会看到新课题。

积分看板的分组明细和原表格式导出均为 CSV，Excel 可以直接打开；JSON 备份用于网页自身恢复数据。

## 腾讯表单与审批

邀约页预留了腾讯表单链接配置。拿到腾讯表单发布链接后，将 `trainer-invite.html` 中的 `TENCENT_FORM_URL` 替换为该链接。

腾讯表单建议设置这些提交字段：`邀约人`、`需求部门`、`邀约讲师姓名`、`邀约讲师部门`、`需求课题`、`期望时间`、`培训形式`、`需求说明`。腾讯表格建议额外设置审批列：`审批状态`、`审批人`、`审批意见`、`审批时间`。腾讯表单/表格自身可配置邮件或消息提醒，用于收到新邀约后及时查看。

## GitHub Pages 发布

1. 在 GitHub 新建一个空仓库，并把仓库 URL 提供给维护者。
2. 将本目录内容推送到该仓库，确保包含 `index.html`、`trainer-invite.html`、`assets/`、`.nojekyll`。
3. 在 GitHub 仓库设置中打开 `Settings -> Pages`。
4. Source 选择 `Deploy from a branch`，Branch 选择 `main`，目录选择 `/root`。
5. 保存后等待部署完成，访问页面给出的 `https://用户名.github.io/仓库名/`。

发布到 `github.io` 域名后，页面会自动进入只读模式。
