# PLAN

## 修復 README.md 內 Performance analysis 圖片 404

背景：圖片來源是 blog 專案 `~/Dropbox/projects/ernestchiang/www` 由 Hugo 產生的處理後圖檔。Hugo 0.140 之後把圖片處理輸出的檔名規則改成 `<basename>_hu_<16 位 hex>.png`，舊 URL 全數 404。原始圖檔本身沒有被改名，仍在 `www/assets/img/<year>/<slug>/`。

- [x] 第 29 行：2021 Homepage 圖，改用新 hash URL，維持 600w
- [x] 第 33 行：2024Q3 RPS 圖，改用新 hash URL，800w
- [x] 第 36 行：2024Q3 Latency 圖，改用新 hash URL，800w
- [x] 第 40 行：2024Q1 RPS 圖，改用新 hash URL，800w
- [x] 第 43 行：2024Q1 Latency 圖，改用新 hash URL，800w（原 URL 的 basename 被 Hugo 舊版長檔名機制截斷，經由檔名中的 byte 數 90147 反查確認對應 `nginx-php-fpm-01-phpinfo-latency-02-dot-by-php-minor-color.png`，原 URL 並沒有貼錯）
- [x] 全部五個新 URL 以 curl 驗證回傳 200

## 自產 Star History 圖表取代 star-history.com

背景：GitHub 已把 stargazers API 收進認證後才可存取（未帶 token 打 `/repos/{owner}/{repo}/stargazers` 回 401），star-history.com 的後端因此拿不到資料。實測 `api.star-history.com/svg` 回 500 timeout（`facebook/react` 亦然，屬服務層級故障），GitHub camo 代理該圖回 504，所有讀者都是破圖。改為自行產圖並存進 repo。

設計決策：

- 只用 Python 3 標準函式庫，不引入繪圖套件，因為本 repo 沒有任何建置工具鏈。
- 主色 `#4088e0`、墨色 `#6e7781`，已用 dataviz 驗證器確認在 `#ffffff` 與 `#0d1117` 兩種底色下亮度帶、彩度、對比全部 PASS，單一檔案即可同時服務 GitHub 淺色／深色主題與 Docker Hub。
- 圖表 x 軸結束於最後一顆星的日期而非「今天」，確保輸出只取決於資料，避免每次排程都產生無意義的 diff。
- 不做 hover／tooltip 互動層：README 圖片經 camo 代理後以 `<img>` 呈現，無法執行腳本。

- [x] 撰寫 `scripts/gen-star-history.py`，抓取全部 stargazers 的 `starred_at` 並分頁處理
- [x] 輸出 `docs/star-history.json`（原始時間戳，供日後改繪圖用）
- [x] 輸出 `docs/star-history.svg`（累積星數折線圖，含面積填色、年份刻度、末端直接標註數值）
- [x] 本機實際執行腳本產圖，並轉成點陣圖親眼檢視版面有無重疊或溢出
- [x] 新增 `.github/workflows/star-history.yml`，cron `0 3 1,15 * *` 加 `workflow_dispatch`，僅在內容變動時 commit
- [x] README 的 Star History 段落改引用 raw URL，連結指向 GitHub stargazers 頁面
- [x] push 後以 `workflow_dispatch` 實際觸發一次：預設 `GITHUB_TOKEN` 回 403 `You do not have permission to view the stargazers of this repository`，確認無權
- [x] workflow 改讀 `secrets.STAR_HISTORY_TOKEN`；腳本區分權限型 403 與速率限制型 403，前者不再無謂重試
- [x] 由 Ernest 建立 PAT 並設為 repo secret `STAR_HISTORY_TOKEN`
- [x] secret 設好後再觸發一次 workflow：run 29883757092 成功，抓到 177 筆並產出與已 commit 版本完全相同的檔案，因此輸出 `Star history unchanged, nothing to commit`
- [ ] 尚未實測的路徑：星數變動時的 commit + push 分支。要等下一次真的有人加星才會走到，屆時可到 Actions 頁面確認
- [ ] PAT 到期日到期前需更換，否則排程會靜默失敗
