# PLAN

## 修復 README.md 內 Performance analysis 圖片 404

背景：圖片來源是 blog 專案 `~/Dropbox/projects/ernestchiang/www` 由 Hugo 產生的處理後圖檔。Hugo 0.140 之後把圖片處理輸出的檔名規則改成 `<basename>_hu_<16 位 hex>.png`，舊 URL 全數 404。原始圖檔本身沒有被改名，仍在 `www/assets/img/<year>/<slug>/`。

- [x] 第 29 行：2021 Homepage 圖，改用新 hash URL，維持 600w
- [x] 第 33 行：2024Q3 RPS 圖，改用新 hash URL，800w
- [x] 第 36 行：2024Q3 Latency 圖，改用新 hash URL，800w
- [x] 第 40 行：2024Q1 RPS 圖，改用新 hash URL，800w
- [x] 第 43 行：2024Q1 Latency 圖，改用新 hash URL，800w（原 URL 的 basename 被 Hugo 舊版長檔名機制截斷，經由檔名中的 byte 數 90147 反查確認對應 `nginx-php-fpm-01-phpinfo-latency-02-dot-by-php-minor-color.png`，原 URL 並沒有貼錯）
- [x] 全部五個新 URL 以 curl 驗證回傳 200
