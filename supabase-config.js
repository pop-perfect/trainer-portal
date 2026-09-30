/* ============================================================
 * Supabase 云端配置
 * ------------------------------------------------------------
 * ★★ 使用方法 ★★
 * 1. 注册/登录 https://supabase.com（免费版即可），新建一个项目
 * 2. 在项目的 SQL Editor 中，粘贴运行仓库里的 supabase-schema.sql 全文
 *    （自动创建 trainers / topics / invite_requests / score_states 表、
 *      访问权限规则、trainer-photos 照片存储桶）
 * 3. Authentication → Users → Add user：创建管理员账号（邮箱+密码，可建多个）
 * 4. Settings → API：把 Project URL 和 anon public key 填到下面两行
 *
 * 说明：anonKey 是公开密钥，放在前端代码里是安全的，
 *       数据安全靠 supabase-schema.sql 里的行级权限（RLS）控制：
 *       访客只能浏览、只能提交邀约申请；增删改必须管理员登录。
 * ============================================================ */
window.TRAINER_PORTAL_SUPABASE = {
  url: "https://cajisfoeegolaxoturhy.supabase.co",
  anonKey: "sb_publishable_LRfzILnVEhBj6xurlK2NZg_4FNf4caz",
  photoBucket: "trainer-photos"
};
