# YokaKit_Replay - 開発工程リプレイプロジェクト

**PinkieItで実施した開発工程をYokaKitにリプレイして最新版にアップデートするプロジェクト**

## 📋 プロジェクト概要

YokaKit_Replayは、**PinkieIt = YokaKit + 段階的改善** という開発系譜に基づく開発工程リプレイプロジェクトです。

PinkieItはYokaKitをベースに開発されたより進化したシステムであり、その開発履歴（git log）を辿ることで、YokaKitからPinkieItへの改善工程を完全に再現できます。このプロジェクトでは、PinkieItの開発履歴を段階的にYokaKitに適用してモダナイゼーションを実施します。

### 🔄 リプレイ対象コンポーネント

| コンポーネント | 役割 | 状態 |
|---------------|------|------|
| **PinkieIt** | 参考元システム<br>完成済みのモダンなLaravel MES | ✅ 完成済み (Laravel 10.x, Docker, CI/CD) |
| **YokaKit** | アップデート対象システム<br>これから改善する生産進捗管理システム | 🔄 アップデート中 (Laravel 9.x → 最新版) |

## 🎯 リプレイ目標

### 📈 PinkieIt開発履歴から抽出される改善工程
PinkieItのgit履歴から以下の改善フェーズが確認できます：

**⚠️ 注意**: PinkieItではコミット `643414f` でYokaKit→PinkieItに名前変更していますが、この**リプレイプロジェクトではYokaKitの名前を最後まで維持**します。

1. **初期Docker化** (`a5d3b77` - `3f0687b`)
   - Dockerfile, docker-compose.yml追加
   - MQTT コンテナ統合
   - ⚠️ 名前変更は**スキップ**

2. **CI/CD構築** (`3f0687b` - `25af011`)
   - GitHub Actions ワークフロー
   - マルチアーキテクチャビルド対応

3. **開発環境改善** (`0cc0475` - `bec10e3`)
   - VS Code DevContainer
   - GitHub Codespaces対応

4. **コード品質向上** (`f10e4ba` - `b9deaf4`)
   - semistandard導入
   - Laravel Pint統合
   - PHPUnit + カバレッジ設定

5. **Laravel モダナイゼーション** (`5b63757` - `adeab2b`)
   - Laravel 10.x アップグレード
   - PHP 8.2 対応
   - Laravel Reverb 移行

6. **Docker最適化** (`b980f1e` - `6bb70e1`)
   - multi-stage Dockerfile
   - マルチアーキテクチャ対応

### 🔧 段階的アップデート手順

#### Phase 0: GitHubリポジトリ初期化
- **ラベル・マイルストーン設定**: issue管理体制構築
- **ワークフローテンプレート**: GitHub Actions準備
- **ドキュメント構造**: README, CONTRIBUTING, docs/構築

#### Phase 1: Docker環境構築 + Laravel 10.x アップグレード
- **Dockerfile作成**: multi-stage builds
- **docker-compose設定**: 開発環境構築
- **Laravel フレームワーク更新**: 9.x → 10.x

#### Phase 2: CI/CD パイプライン構築
- **GitHub Actions**: docker-build.yml, sonarqube.yml
- **SonarQube Cloud**: コード品質・カバレッジ連携
- **セキュリティスキャン**: 脆弱性検出自動化

#### Phase 3: テスト・品質管理ツール統合
- **PHPUnit + PCOV**: テストカバレッジ測定
- **Laravel Pint**: コード整形自動化
- **Larastan (PHPStan)**: 静的解析導入

#### Phase 4: WebSocket・リアルタイム機能モダナイズ
- **Laravel Reverb**: WebSocket サーバー移行
- **MQTT統合**: IoTデバイス通信最適化

#### Phase 5: セキュリティ・パフォーマンス最適化
- **PHP 8.2対応**: パフォーマンス向上
- **依存関係更新**: セキュリティパッチ適用
- **DevContainer**: VS Code, GitHub Codespaces対応

## 🏗️ アーキテクチャ

```text
YokaKit_Replay/
├── YokaKit/          # 生産進捗管理システム
│   ├── Laravel 9.x
│   ├── WebSocket (Laravel Echo Server)
│   └── MQTT Client
├── pinkieit/         # 製造実行システム
│   ├── Laravel 10.x
│   ├── MariaDB
│   └── Docker環境
├── memory/           # 共有メモリ・設定
├── templates/        # プロジェクトテンプレート
└── scripts/          # 自動化スクリプト
```

## ⚙️ GitHub運用方針

### ブランチ戦略
- **メインブランチ**: `main` (保護設定、直接pushは禁止)
- **フィーチャーブランチ**: `feature/phase-{N}-{feature-name}` (例: `feature/phase-1-docker-setup`)
- **Phase完了ブランチ**: `phase-{N}-complete` (各Phase完了時)

### プルリクエスト運用
- **必須レビュー**: 最低1名の承認が必要
- **CI/CDチェック**: 全てのチェックが通過必要
- **マージ戦略**: Squash and Merge (履歴の整理)
- **自動削除**: マージ後のフィーチャーブランチは自動削除

### Issue・マイルストーン管理

#### ラベル体系
- **Phase**: `phase-0`, `phase-1`, `phase-2`, `phase-3`, `phase-4`, `phase-5`
- **種別**: `enhancement`, `bug`, `documentation`, `question`
- **優先度**: `priority-high`, `priority-medium`, `priority-low`
- **状態**: `blocked`, `in-review`, `needs-info`

#### マイルストーン
- **Phase 0**: GitHubリポジトリ初期化 (v0.1.0)
- **Phase 1**: Docker環境構築 + Laravel 10.x (v0.2.0)
- **Phase 2**: CI/CDパイプライン構築 (v0.3.0)
- **Phase 3**: テスト・品質管理ツール統合 (v0.4.0)
- **Phase 4**: WebSocket・リアルタイム機能モダナイズ (v0.5.0)
- **Phase 5**: セキュリティ・パフォーマンス最適化 (v1.0.0)

### サブモジュール管理
- **YokaKit更新**: 各Phase完了時に必須
- **バージョンタグ**: Phase完了時に対応するタグを作成
- **同期確認**: `git submodule status`でサブモジュール状態確認

### セキュリティ運用
- **ブランチ保護**: `main`ブランチへの直接push禁止
- **必須チェック**: CI/CD、セキュリティスキャン通過必須
- **アクセス制御**: コラボレーター権限管理
- **秘匿情報**: 環境変数・シークレット管理

### リリース管理
- **リリースノート**: 各Phase完了時に自動生成
- **チェンジログ**: CHANGELOG.mdの自動更新
- **デプロイメント**: Production環境への自動デプロイ

## 🚀 リプレイ開始手順

### 前提条件
- Git 2.30+ (submodule対応)
- Docker 20.10+ & Docker Compose v2.17+ (PinkieIt参考用)
- Node.js 16+ (YokaKit開発用)

### プロジェクト開始

1. **リポジトリクローン + サブモジュール初期化**
   ```bash
   git clone --recursive <repository-url>
   cd YokaKit_Replay
   git submodule update --init --recursive
   ```

2. **開発履歴分析**
   ```bash
   # PinkieItの完全な開発履歴を時系列で確認
   cd pinkieit && git log --oneline --reverse

   # YokaKit（現状）の確認
   cd ../YokaKit && git log --oneline -10

   # 改善工程の抽出（例：Docker化、Laravel 10アップグレード等）
   cd ../pinkieit && git log --grep="Docker\|Laravel\|CI/CD" --oneline
   ```

3. **開発フェーズ開始**
   ```bash
   # Phase 0: YokaKitリポジトリ初期化（名前はYokaKitのまま維持）
   cd YokaKit
   # GitHub設定: ラベル, マイルストーン, ワークフローテンプレート
   # 注意: PinkieItの名前変更コミットはスキップする

   # 各フェーズでYokaKitを改善後、submodule更新
   cd ..
   git add YokaKit
   git commit -m "feat: Phase 0 complete - YokaKit repository initialization"
   git commit -m "feat: Phase 1 complete - YokaKit Docker環境構築"
   ```

### 参考環境アクセス
- **PinkieIt**: http://localhost:18080 (参考用完成版)

## 🛠️ 開発

### 開発環境
```bash
# PinkieIt開発
cd pinkieit
docker compose exec web-app composer install
docker compose exec web-app npm run dev

# YokaKit開発
cd YokaKit
npm install
npm run dev
```

### テスト実行
```bash
# PinkieIt
docker compose exec web-app php artisan test --coverage

# YokaKit
cd YokaKit
npm test
```

### コード品質
```bash
# Laravel Pint (コード整形)
docker compose exec web-app ./vendor/bin/pint

# PHPStan (静的解析)
docker compose exec web-app ./vendor/bin/phpstan analyse

# SonarQube連携
# GitHub Actionsにより自動実行
```

## 📁 プロジェクト構造

### 設定管理
- `/.claude/` - Claude Code設定
- `/.specify/` - プロジェクト仕様管理
- `/memory/` - 共有メモリ・憲法
- `/templates/` - 開発テンプレート

### Git管理
- サブモジュール構成
- 統合ワークフロー対応
- 自動CI/CD連携

## 🔒 セキュリティ

- Laravel Sanctum認証
- HTTPS/WSS暗号化通信
- Docker セキュリティベストプラクティス
- SonarQube セキュリティスキャン

## 📚 ドキュメント

- [PinkieIt詳細](./pinkieit/README.md)
- [YokaKit詳細](./YokaKit/README.md)
- [CI/CDワークフロー](./pinkieit/docs/CI_CD_WORKFLOW.md)
- [Claude Code設定](./pinkieit/CLAUDE.md)

## 🤝 コントリビューション

1. フィーチャーブランチ作成
2. コード実装・テスト
3. プルリクエスト作成
4. CI/CD自動チェック通過
5. コードレビュー・マージ

## 📄 ライセンス

- **YokaKit**: Apache License 2.0
- **PinkieIt**: Apache License 2.0

---

**製造業のデジタル変革を、統合プラットフォームで実現**

🏭 YokaKit_Replay - リアルタイム製造実行システム