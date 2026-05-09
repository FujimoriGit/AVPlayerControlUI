# AVPlayerControlUI

AVPlayerに被せるYouTube風コントロールUIのSDK (個人プロジェクト)。
仕事でUIKit版を作っていて、設計検討の参考とするため手元でも作る。

## 要件
- UIKit優先、SwiftUIも見据える (UIKit版に引きずられず差し替えやすい構造で)
- 配布: Swift Package + xcframework
- カスタマイズ性は重要
- YouTube風コントロール: 再生/一時停止、シークバー、字幕、設定、全画面、Duration、閉じる
- 最低サポート iOS 15

## 設計・コーディング規約

### Swiftセマンティクス
- `struct` と `class` を適切に使い分け、副作用は `class` 側に隔離する
- POP (Protocol-Oriented Programming) で設計する
- protocol 命名 (Apple API Design Guidelines 準拠):
  - "何であるか" を表す protocol は **名詞** (例: `Collection`)
  - "能力" を表す protocol は **`-able` / `-ible` / `-ing`** 接尾辞 (例: `Equatable`, `ProgressReporting`)

## Claudeへの指示 (このプロジェクトでの進め方)

- **1メッセージ = 1論点**。テーブルや長いリストで論点を並列にぶつけない
- 「以下、確認したいこと全部出します」のような全列挙宣言をしない
- 用語を初めて出す時は1〜2行で定義してから使う ("Core"を未定義で投げない等)
- 設計を詰めてから実装スコープの話。「どこまで実装しますか」を勝手に聞かない
- 記録 (フィードバック・決定事項) はこのCLAUDE.mdに書く。ユーザーから見えない場所に隠さない
