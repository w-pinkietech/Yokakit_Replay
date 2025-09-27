# コードベース構造

## プロジェクト全体構造
```
YokaKit_Replay/
├── .github/              # GitHub設定（Phase 0で作成予定）
├── .claude/              # Claude Code設定
├── .mcp.json            # MCP設定
├── .serena/             # Serena設定
├── .specify/            # プロジェクト仕様管理
├── YokaKit/             # 生産進捗管理システム（サブモジュール）
├── pinkieit/            # 製造実行システム（サブモジュール・参考）
├── memory/              # 共有メモリ・憲法
├── scripts/             # 自動化スクリプト
├── specs/               # 機能仕様・実装計画
├── templates/           # プロジェクトテンプレート
├── CLAUDE.md           # Claude Code設定
└── README.md           # プロジェクト説明
```

## YokaKit構造（Laravel 9.x）
```
YokaKit/
├── app/                 # Laravelアプリケーション
│   ├── Http/           # コントローラー・ミドルウェア
│   ├── Models/         # Eloquentモデル
│   └── Services/       # ビジネスロジック
├── config/             # 設定ファイル
├── database/           # マイグレーション・シーダー
├── public/             # 公開ディレクトリ
├── resources/          # ビュー・アセット
│   ├── views/          # Bladeテンプレート
│   ├── js/             # JavaScript
│   └── sass/           # Sassスタイルシート
├── routes/             # ルート定義
├── composer.json       # PHP依存関係
├── package.json        # Node.js依存関係
└── webpack.mix.js      # Laravel Mix設定
```

## PinkieIt構造（Laravel 10.x + Docker）
```
pinkieit/
├── .github/            # GitHub Actions ワークフロー
│   └── workflows/      # CI/CD設定
├── app/                # Laravelアプリケーション
├── mqtt/               # MQTT設定
├── docs/               # プロジェクト文書
├── compose.yml         # Docker Compose設定
├── Dockerfile          # Multi-stage Dockerfile
└── CLAUDE.md          # Claude Code設定
```

## specs/ ディレクトリ（機能仕様管理）
```
specs/
└── 001-implement-phase-0/
    ├── spec.md         # 機能仕様
    ├── plan.md         # 実装計画
    ├── research.md     # 技術調査
    ├── data-model.md   # データモデル
    ├── quickstart.md   # セットアップガイド
    └── contracts/      # APIスキーマ・バリデーション
```

## scripts/ ディレクトリ（自動化）
```
scripts/
└── bash/
    ├── common.sh                    # 共通関数
    ├── check-prerequisites.sh      # 前提条件確認
    ├── create-new-feature.sh       # 新機能作成
    ├── setup-plan.sh              # プラン設定
    └── update-agent-context.sh     # エージェントコンテキスト更新
```

## 重要なファイル

### 設定ファイル
- **CLAUDE.md**: Claude Code用プロジェクト設定
- **memory/constitution.md**: プロジェクト憲法（v1.1.0）
- **.gitmodules**: サブモジュール設定

### 開発ツール設定
- **composer.json**: PHP依存関係（Laravel、テストツール等）
- **package.json**: Node.js依存関係（ビルドツール、フロントエンド）
- **webpack.mix.js**: アセットビルド設定

## サブモジュール管理

### YokaKit（アップデート対象）
- Laravel 9.x ベース
- 各Phase完了時にサブモジュール更新必須
- メインプロジェクトと同期維持

### PinkieIt（参考システム）
- Laravel 10.x + Docker完成版
- 改善工程のリファレンスとして使用
- git履歴から改善パターン抽出

## アーキテクチャパターン

### 現在（YokaKit）
- **MVCパターン**: Laravel標準構造
- **Repository Pattern**: データアクセス層分離（部分的）
- **WebSocket**: Laravel WebSockets使用
- **MQTT**: php-mqtt/laravel-client使用

### 目標（PinkieIt参考）
- **Repository Pattern**: 完全分離
- **Event-Driven**: リアルタイム更新
- **Job Queue**: 非同期MQTT処理
- **DTO**: Type-safe データハンドリング