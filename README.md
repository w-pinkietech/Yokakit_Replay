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

### 📊 分析結果に基づく戦略的アプローチ
`docs/analysis/` の詳細分析により、以下の戦略的アプローチが確立されました：

#### **🔍 現状分析結果** ([技術ベースライン](./docs/analysis/current-state/yokakit-current-state-analysis.md))
- **YokaKit**: 9年間の製造業ドメイン専門知識を持つ Laravel 9.x MES システム
- **主要課題**: モデル配置問題（`app/Http/Requests/` に誤配置）、テスト未構築、Docker未対応
- **強み**: 93 PHP ファイル、45 マイグレーション、完全な IoT・MQTT 統合

#### **📈 実証済み改善パターン** ([PinkieIt開発履歴](./docs/analysis/timeline/pinkieit-development-timeline.md))
PinkieIt の 189 コミットから抽出された実証済み改善工程：

**⚠️ 憲法遵守**: PinkieIt コミット `643414f` の名前変更は**スキップ**し、YokaKit アイデンティティを維持

1. **Phase 1: Docker Foundation** (2024-07-01 パターン)
   - Docker + MariaDB 基盤構築
   - 構造修正（models を `app/Models/` へ移動）
   - DevContainer 開発環境

2. **Phase 2: Quality Infrastructure Day** (2025-06-13 単日実装パターン)
   - PHPUnit + PCOV テストフレームワーク
   - Larastan 静的解析
   - SonarQube 品質監視

3. **Phase 3: Comprehensive Testing** (2025-06-14-15 パターン)
   - レイヤー別テスト実装
   - 並列実行最適化（66% 改善）
   - カバレッジ向上

4. **Phase 4: Framework Modernization** (2025-06-16-24 パターン)
   - PHP 8.2 + Laravel 10.x アップグレード
   - Laravel Reverb WebSocket 移行
   - 依存関係モダナイゼーション

5. **Phase 5: Docker Optimization** (2025-06-26 - 2025-07-02 パターン)
   - Multi-stage Dockerfile
   - Multi-architecture ビルド (AMD64/ARM64)
   - パフォーマンス最適化

6. **Phase 6: CI/CD Integration** (2025-07-03+ パターン)
   - 包括的 CI/CD パイプライン
   - Bootstrap 5 UI モダナイゼーション
   - セキュリティスキャン統合

### 🎯 戦略的実装計画 ([戦略マスタープラン](./docs/analysis/timeline/development-timeline-analysis.md))

#### **成功確率: 85%+** (実証済みパターンによる高信頼性)

#### **Phase 0: GitHub Repository Infrastructure** ✅ **完了**
- ブランチ保護・ワークフロー自動化
- Issue テンプレート・マイルストーン構造
- 憲法遵守フレームワーク

#### **Phase 1: Docker Foundation & Development Environment** (4週間)
**Week 1**: Docker Foundation (PinkieIt 2024-07-01 パターン)
- 基本 Docker セットアップ + MariaDB
- コンテナ検証・ポート設定

**Week 2**: Development Environment (PinkieIt 2025-03 パターン)
- DevContainer VS Code 環境
- Claude 統合・Linting 設定

**Week 3**: Structural Cleanup (重要な構造修正)
- Models を `app/Http/Requests/` → `app/Models/` へ移動
- 名前空間修正・オートローダー再生成

**Week 4**: Quality Infrastructure Foundation
- PHPUnit + ファクトリー設定
- 基本 CI/CD パイプライン

#### **Phase 2: Quality Infrastructure Day** (1日集中実装)
**Timeline**: 1日集中実装
**Pattern Source**: PinkieIt 2025-06-13 (8 PRs in single day)

**午前 (06:00-12:00)**:
- Test Infrastructure (PHPUnit complete setup)
- Coverage Configuration (PCOV for fast reporting)
- Static Analysis (Larastan setup)

**午後 (12:00-18:00)**:
- SonarQube Integration (code quality monitoring)
- CI/CD Pipeline (automated quality pipeline)
- Database Testing (test connectivity)

**夕方 (18:00-21:00)**:
- Laravel Upgrade Planning (strategic preparation)
- Quality Validation (all systems operational)

#### **Phase 3: Comprehensive Testing** (2週間)
**Timeline**: 2週間
**Pattern Source**: PinkieIt June 14-15, 2025

**Week 1: Core Testing Implementation**
- Day 1-2: Model Tests (comprehensive unit tests)
- Day 3-4: Service/Repository Tests (business logic coverage)
- Day 5: Controller Tests (HTTP layer coverage)

**Week 2: Testing Optimization**
- Day 1-2: Extended Controller Tests
- Day 3: Test Performance (parallel execution - 66% improvement target)
- Day 4-5: Test Cleanup (remove redundant cases)

#### **Phase 4: Framework Modernization** (1週間)
**Timeline**: 1週間
**Pattern Source**: PinkieIt June 16-24, 2025

- Day 1: PHP 8.2 Upgrade (infrastructure platform)
- Day 2-3: Laravel 10.x Migration (major framework upgrade)
- Day 4: Dependency Updates (composer modernization)
- Day 5: Laravel Reverb (WebSocket modernization)

#### **Phase 5: Advanced Docker Optimization** (1週間)
**Timeline**: 1週間
**Pattern Source**: PinkieIt June 26 - July 2, 2025

- Day 1-2: Docker Baseline Metrics (performance measurement)
- Day 3: Multi-stage Consolidation (single Dockerfile architecture)
- Day 4: Multi-Architecture Support (AMD64/ARM64)
- Day 5: DevContainer Optimization (development environment integration)

#### **Phase 6: CI/CD Integration & Final Polish** (1週間)
**Timeline**: 1週間
**Pattern Source**: PinkieIt July 3, 2025 + ongoing

- Day 1-3: Comprehensive CI/CD (multi-architecture builds, security scanning)
- Day 4: Bootstrap 5 Migration (UI framework modernization)
- Day 5: Final Quality Validation (all systems integration test)

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

#### ラベル体系 (4層階層構造)
- **Epic レベル**: `epic:phase-0` ～ `epic:phase-6` (Phase レベルの大規模機能群)
- **Story レベル**: `story:feature`, `story:security`, `story:ci-cd`, `story:integration`, `story:documentation`
- **Task レベル**: `task:implementation`, `task:validation`, `task:testing`
- **Constitutional**: `constitutional:identity-preservation` (必須), `constitutional:historical-fidelity`, `constitutional:quality-first`, `constitutional:compliance`
- **ステータス**: `status:needs-triage`, `status:in-progress`, `status:blocked`
- **標準**: `enhancement`, `bug`, `documentation`, `question`

#### マイルストーン
- **Phase 0**: GitHubリポジトリ初期化 (v0.1.0)
- **Phase 1**: Docker Foundation & Development Environment (v0.2.0)
- **Phase 2**: Quality Infrastructure Day (v0.3.0)
- **Phase 3**: Comprehensive Testing (v0.4.0)
- **Phase 4**: Framework Modernization (Laravel 10.x + PHP 8.2) (v0.5.0)
- **Phase 5**: Advanced Docker Optimization (v0.6.0)
- **Phase 6**: CI/CD Integration & Final Polish (v1.0.0)

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

### 分析・ドキュメント
```text
docs/analysis/
├── README.md                           # 分析文書概要
├── RESPONSIBILITY_MATRIX.md           # 文書責任分離マトリックス
├── current-state/                     # 技術ベースライン
│   └── yokakit-current-state-analysis.md
├── timeline/                          # 戦略・履歴
│   ├── development-timeline-analysis.md    # 戦略マスタープラン
│   └── pinkieit-development-timeline.md   # PinkieIt開発履歴
└── quality-assurance/                 # 品質保証
    └── document-inconsistencies-analysis.md

docs/github-management/
├── LABEL_GUIDE.md                     # ラベル体系と使用ガイドライン
├── ISSUE_MILESTONE_GUIDE.md           # Epic/Story/Task定義
└── README.md                          # GitHub管理概要
```

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

### 分析・戦略文書
- [分析文書概要](./docs/analysis/README.md) - 分析文書の全体構造と使用方法
- [YokaKit技術ベースライン](./docs/analysis/current-state/yokakit-current-state-analysis.md) - 現在のシステム詳細分析
- [戦略マスタープラン](./docs/analysis/timeline/development-timeline-analysis.md) - 段階的実装戦略
- [PinkieIt開発履歴](./docs/analysis/timeline/pinkieit-development-timeline.md) - 実証済み改善パターン
- [文書品質保証](./docs/analysis/quality-assurance/document-inconsistencies-analysis.md) - 分析文書の精度検証

### GitHub管理・運用
- [ラベル管理ガイド](./docs/github-management/LABEL_GUIDE.md) - 4層階層ラベル体系と使用方法
- [Issue & Milestone ガイド](./docs/github-management/ISSUE_MILESTONE_GUIDE.md) - Epic/Story/Task の使い分け

### 技術詳細
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