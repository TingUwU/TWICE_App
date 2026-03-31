# 🍭 TWICE App

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## 📱 專案簡介 (Overview)
本專案是一款以跨平台框架 Flutter 開發的 TWICE 專屬粉絲應用程式。旨在提供一個集中化、視覺美觀且互動流暢的資訊平台。專案著重於 UI/UX 設計實作、跨頁面路由管理、以及行動裝置的記憶體效能優化。

## ✨ 核心功能 (Key Features)

* **動態進場畫面 (Splash Screen)**：使用自定義 GIF 動畫優化 App 啟動時的載入體驗。
* **新聞與公告區 (News Board)**：採用 `ExpansionTile` 實作手風琴式折疊選單，優化長篇文本的閱讀動線，並支援預設展開重要頭條。
* **影音推薦卡片 (Video Recommendations)**：實作 YouTube 風格的預覽卡片，支援高畫質大圖顯示與防呆機制。
* **全局導航 (Global Navigation)**：封裝共用元件 `SharedDrawer`，實現多頁面間的高效路由切換。

## 🎨 畫面展示 (Screenshots)
> | 首頁 (Home) | 新聞區 (News) | 影音推薦 (Videos) |
> | :---: | :---: | :---: |
> | <img width="300" height="717" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-03-31 at 23 56 33" src="https://github.com/user-attachments/assets/611ddcd9-17c1-468e-9c0a-eadf60c056b9" />
| <img width="300" height="717" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-03-31 at 22 13 29" src="https://github.com/user-attachments/assets/161ca831-7b16-4891-bc83-8ab26d620c83" />
| <img width="300" height="717" alt="Simulator Screenshot - iPhone 17 Pro Max - 2026-03-31 at 23 57 24" src="https://github.com/user-attachments/assets/8682e451-a8fb-4f2a-9025-17de75c5342f" />
|
## 🛠️ 技術挑戰與效能優化 (Troubleshooting)

在開發過程中，為確保 App 於實機上的穩定性，進行了以下深度優化：

1. **記憶體溢出 (OOM) 防護與優化**：
   * **問題**：載入多張高解析度圖片時，iPhone 實機出現記憶體飆升與靜默閃退。
   * **解決**：全面替換 `DecorationImage`，改用 `Image.asset` 並配置 `cacheWidth: 800`，強制 Flutter 引擎在解碼時按比例縮小圖片，大幅降低 RAM 佔用；同時實作 `errorBuilder` 優雅處理圖片遺失錯誤。
2. **iOS 實機部署與憑證簽名 (Code Signing)**：
   * **問題**：部署至實機時遭遇 Xcode 憑證錯誤 (`No profiles found`)。
   * **解決**：重新設定 Bundle Identifier 避免衝突，並於 Mac 鑰匙圈授權本地憑證，成功克服 Apple 開發者安全機制的阻礙。
3. **YAML 解析與自動化腳本修復**：
   * **問題**：執行 `flutter_launcher_icons` 腳本時引發編譯環境崩潰。
   * **解決**：排查 Error Log 後定位為 `pubspec.yaml` 縮排問題。嚴格校正 YAML 父子節點的半形空白縮排，清空暫存後成功觸發機器人腳本，完成雙平台 App Icon 自動化部署。

## 🚀 本機執行 (Getting Started)

1. 確認已安裝 Flutter SDK (>= 3.0.0)。
2. Clone 此專案：`git clone [你的 GitHub 專案網址]`
3. 取得依賴套件：`flutter pub get`
4. 執行專案：`flutter run`
