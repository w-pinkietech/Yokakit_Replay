# YokaKit_Replay - 開発工程リプレイプロジェクト

**PinkieItで実施した開発工程をYokaKitにリプレイして最新版にアップデートするプロジェクト**

## 📋 プロジェクト概要

YokaKit_Replayは、**PinkieIt = YokaKit + 段階的改善** という開発系譜に基づく開発工程リプレイプロジェクトです。

PinkieItはYokaKitをベースに開発されたより進化したシステムであり、その開発履歴（git log）を辿ることで、YokaKitからPinkieItへの改善工程を完全に再現できます。このプロジェクトでは、PinkieItの開発履歴を段階的にYokaKitに適用してモダナイゼーションを実施します。

### 🏗️ リポジトリの役割と関係性

#### YokaKit_Replay（このリポジトリ）
**役割**: 戦略的計画・分析・実装オーケストレーションリポジトリ
**目的**:
- 包括的な実装計画と設計（specs/）
- PinkieItからの歴史的パターン分析（docs/analysis/）
- 憲法遵守ガバナンス（memory/constitution.md）
- GitHub管理ガイダンス（docs/github-management/）
- 開発ワークフローオーケストレーション

**開発活動**: 計画、ドキュメント、分析（アプリケーションコード変更は行わない）

#### YokaKitリポジトリ（サブモジュール、独立GitHubリポジトリ）
**役割**: 実際の開発が行われるメインリポジトリ
**GitHub URL**: `https://github.com/YOUR_ORG/YokaKit`（独立リポジトリ）
**目的**:
- 本番Laravelアプリケーションコードベース
- リプレイプロセスから改善を受け取る
- 実際の開発のためのGitHub Issue/PR管理
- Docker環境、構造修正、モダナイゼーションの対象

**GitHub管理**:
- **ラベル**: YokaKit_Replayから移行された4層階層
- **Issue**: 開発タスクはここで作成（YokaKit_Replayではない）
- **マイルストーン**: Phase 0-6追跡
- **プルリクエスト**: コードレビューとマージワークフロー

**YokaKit_Replayとの関係**: 調整のためGitサブモジュールとして参照されるが、Issue/PR管理のため独立したGitHubアイデンティティを維持

#### PinkieItリポジトリ（サブモジュール、参照のみ）
**役割**: 実証済みパターンの歴史的参照リポジトリ
**GitHub URL**: `https://github.com/w-pinkietech/pinkieit`（読み取り専用参照）
**目的**:
- 実証済みモダナイゼーションパターンのソース（189コミット）
- 監査証跡のためのコミットハッシュ参照
- YokaKit改善のためのパターン抽出
- 憲法遵守検証

**使用方法**: 読み取り専用分析、直接コードコピー禁止（憲法要件）

### 🔄 開発ワークフロー

#### 計画フェーズ（YokaKit_Replay）
1. `specs/###-feature/`に実装計画を作成
2. コミット履歴からPinkieItパターンを調査
3. 契約、データモデル、クイックスタートガイドを設計
4. 憲法遵守要件を更新

#### 実装フェーズ（YokaKitリポジトリ）
1. **YokaKitリポジトリにGitHub Issueを作成**（移行されたラベルを使用）
2. **YokaKitアプリケーションコードに変更を実装**
3. **YokaKitリポジトリにプルリクエストを提出**
4. **監査証跡のためコミットメッセージでPinkieItコミットを参照**
5. **フェーズ完了後にYokaKit_Replayサブモジュール参照を更新**

### 🔄 リプレイ対象コンポーネント

| コンポーネント | 役割 | リポジトリタイプ | 状態 |
|---------------|------|----------------|------|
| **YokaKit_Replay** | 計画・分析・オーケストレーション | メタリポジトリ | ✅ Phase 5完了 |
| **YokaKit** | 実際の開発対象アプリケーション | 独立GitHubリポジトリ<br>（サブモジュール参照） | ✅ Phase 5完了<br>**Multi-Arch Docker (AMD64/ARM64)**<br>**425/425 tests (100%)** 🎉<br>📋 Phase 6計画準備中 |
| **PinkieIt** | 実証済みパターン参照 | 読み取り専用サブモジュール | ✅ 完成済み (Laravel 10.x, Docker, CI/CD) |

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
   - 構造修正（app/ → app/laravel/ 大規模リファクタリング）
   - MQTT コンテナ統合

2. **Phase 2: Docker Architecture Optimization** (2025-06-26 パターン)
   - Multi-stage Dockerfile 統合
   - BuildKit キャッシュ最適化
   - 本番対応 Docker アーキテクチャ

3. **Phase 3: Comprehensive Testing** ✅ **完了** (2 日間, 2025-10-03~04)
   - ✅ Model/Service/Feature テスト実装 (425/425 tests, 100%)
   - ✅ ParaTest 並列実行対応
   - ✅ テストクリーンアップ (146 行削除)
   - ✅ 6 PRs マージ (#97-#102)

4. **Phase 4: Framework Modernization & DevContainer** ✅ **完了** (1日, 2025-10-04)
   - ✅ DevContainer統合実装 (PR #117) - 40+ VS Code拡張機能
   - ✅ PHP 8.2.27 アップグレード (PR #118)
   - ✅ Laravel 10.49.1 アップグレード (PR #118)
   - ✅ PHPUnit 10.x 移行 (PR #118)
   - ✅ AdminLTE 3.15.0 互換性 (PR #118)
   - ✅ Laravel Reverb 1.4.8 WebSocket 移行 (Manual merge)
   - ✅ DevContainer完全統合 (Reverb + MQTT + Queue)
   - ✅ 425/425 tests passing (100%) 🎉

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

#### **Phase 1: Docker Foundation** ✅ **完了**
**Timeline**: 2-3 weeks (commit-based replay)
**Pattern Source**: PinkieIt 2024-07-01 (commits a5d3b77..13b40d1)
**Spec**: [specs/002-phase-1-docker/](./specs/002-phase-1-docker/)

**CR1 (a5d3b77)**: Initial Docker Foundation
- docker-compose.yml (3-container stack: web-app, db, mqtt)
- Dockerfile (PHP 8.2 + Apache base)
- Basic environment configuration

**CR3 (fad82e6)**: Application Structure Reorganization
- app/ → app/laravel/ migration (200+ files)
- Namespace restructuring
- Autoloader regeneration

**CR4-6 (bfd075e, 3a0f1cd, 13b40d1)**: Docker Refinement
- docker-compose.yml enhancements (networking, healthcheck)
- Volume optimizations
- MQTT container integration

**Note**: DevContainer implementation deferred to Phase 4 (actual PinkieIt timeline: commit 0cc0475, 2025-02-20)

#### **Phase 2: Docker Architecture Optimization** ✅ **完了**
**Timeline**: 1 day (2025-10-03)
**Pattern Source**: PinkieIt 2025-06-26 (4 commits: b980f1e..08ac389)
**Spec**: [specs/003-phase-2-docker/](./specs/003-phase-2-docker/)
**Completion Report**: [YokaKit/PHASE_2_COMPLETION_REPORT.md](./YokaKit/PHASE_2_COMPLETION_REPORT.md)

**CR1 (b980f1e)**: Docker Build Context Optimization
- .dockerignore (123 lines, 99.5% build context reduction)
- Excluded: Git, node_modules, vendor, tests, logs, IDE configs

**CR2 (f9340aa)**: Multi-Stage Dockerfile Consolidation
- Dockerfile (128 lines, base → build → production stages)
- docker-compose.yml → compose.yml (Docker Compose v2)
- Constitutional adaptations: pinkieit → yokakit naming (100% compliance)

**CR3 (fe2acac)**: BuildKit Cache Optimization
- BuildKit cache mounts (composer, npm, apt)
- Rebuild time: <30 seconds (from 5 minutes)
- Requires DOCKER_BUILDKIT=1 environment variable

**CR4 (08ac389)**: Final Stage Consolidation
- Dockerfile simplification (115 lines, optimized from 141)
- Merged stages for better caching
- Production-ready architecture with minimal image size

**Critical Fixes**:
- Constitutional compliance (compose.yml pinkieit → yokakit)
- Missing .htaccess (resolved 404 routing errors)
- app-entrypoint.sh production script
- Environment configuration (APP_KEY, storage permissions)

**Validation**: ✅ All services operational, login functional, 100% YokaKit identity preserved

#### **Phase 3: Comprehensive Testing** ✅ **完了** (2日間)
**Timeline**: 2025-10-03~04 (2日間完了 - 計画より大幅短縮)
**Pattern Source**: PinkieIt June 14-15, 2025 (7コミット)

**実装内容**:
- ✅ **Day 1**: Model Tests (5 models, 74/75 tests) - PR #98
- ✅ **Day 1**: Service/Repository Tests (8 tests, 94/94) - PR #99
- ✅ **Day 2**: Feature/Controller Tests (13 tests, 256/256) - PR #100
- ✅ **Day 2**: ParaTest 並列実行 - PR #101
- ✅ **Day 2**: テストクリーンアップ (146 行削除) - commit 3191d5c
- ✅ **Day 2**: PasswordResetNotification 修正 - PR #102

**最終結果**: **425/425 tests passing (100%)** 🎉

#### **Phase 4: Framework Modernization & DevContainer** ✅ **完了** (1日, 2025-10-04)
**Timeline**: 1 day actual (specification + implementation)
**Pattern Source**: PinkieIt 2025-02-20, 2025-06-17-27 (9 commits)
**Spec**: [specs/005-phase-4-e0eaabd/](./specs/005-phase-4-e0eaabd/)
**Completion Report**: [PHASE_4_COMPLETION_REPORT.md](./PHASE_4_COMPLETION_REPORT.md)

**Phase 4A: DevContainer Unified Implementation** (PR #117):
- ✅ VS Code devcontainer.json with 40+ Laravel extensions
- ✅ PHP 8.2 & Laravel 10 optimized settings
- ✅ Quality tools integration (PHPUnit, Larastan, SonarLint)
- ✅ Development service (port 18081)
- ✅ GitHub Codespaces ready
- **PinkieIt**: 0cc0475 + 65eea6a + cdd8d6f (unified)

**Phase 4B: Framework Modernization** (PR #118 + manual merge):
- ✅ **PHP 8.2.27** (e0eaabd): Composer updates, Larastan migration
- ✅ **Laravel 10.49.1** (4152b54, 862d537): Framework, PHPUnit 10, Monolog 3.x, AdminLTE 3.15.0
- ✅ **Laravel Reverb 1.4.8** (d4db04f, dc67938, 524c1c3): Modern WebSocket, frontend integration
- ✅ **DevContainer Services**: Apache + Reverb + MQTT + Queue all running
- ✅ **Test Coverage**: 425/425 tests passing (100%)

**Implementation Result**: Production-ready modern development environment with complete framework stack upgrade

#### **Phase 5: Multi-Architecture Docker Support** ✅ **完了** (4時間, 2025-10-04)
**Timeline**: 4時間実績（見積4-6時間）
**Pattern Source**: PinkieIt 2025-06-26 (1 commit: 9bfa0b5)
**Spec**: [specs/006-phase-5-multi/](./specs/006-phase-5-multi/)
**GitHub PR**: [YokaKit #129](https://github.com/w-pinkietech/YokaKit/pull/129)

**実装完了**:
- ✅ **Docker Buildx v0.26+** マルチアーキテクチャビルド設定
- ✅ **Platform Targets**: linux/amd64, linux/arm64
- ✅ **BuildKit最適化**: sharing=locked キャッシュマウント
- ✅ **Image最適化**: --no-install-recommends, apt cleanup
- ✅ **QEMU binfmt**: ARM64 クロスコンパイル対応
- ✅ **Test Coverage**: 425/425 tests passing (100%) on AMD64
- ✅ **PinkieIt Reference**: 9bfa0b5 (1 commit)

**実装結果**: クロスプラットフォーム対応Dockerイメージビルド環境完成

#### **Phase 6: CI/CD Integration & Final Polish** (1週間) 📋 NEXT
**Timeline**: 1週間
**Pattern Source**: PinkieIt July 3, 2025 + ongoing

- Day 1-3: Comprehensive CI/CD (multi-architecture builds, security scanning)
- Day 4: Bootstrap 5 Migration (UI framework modernization)
- Day 5: Final Quality Validation (all systems integration test)

## 🏗️ アーキテクチャ

### リポジトリ構造（関心の分離）
```text
YokaKit_Replay/                    # メタリポジトリ（計画・分析）
├── specs/                         # 実装計画（Phase毎）
│   ├── 001-implement-phase-0/     # Phase 0計画 ✅
│   ├── 002-phase-1-docker/        # Phase 1計画 ✅
│   └── 003-phase-2-docker/        # Phase 2計画 ← 現在
├── docs/                          # 分析・ガイダンス
│   ├── analysis/timeline/         # PinkieItパターン抽出
│   └── github-management/         # ラベル/Issue/マイルストーンガイド
├── memory/constitution.md         # 憲法要件 v1.2.0
├── templates/                     # プロジェクトテンプレート
├── scripts/                       # 自動化スクリプト
├── YokaKit/                       # サブモジュール → 独立リポジトリ
└── pinkieit/                      # サブモジュール → 参照専用

YokaKit/（独立GitHubリポジトリ）   # 実際の開発リポジトリ
├── app/                           # Laravelアプリケーション
│   ├── Models/                    # ← 移動先（Phase 1で修正）
│   └── Http/Requests/             # ← 移動元（誤配置モデル）
├── docker/                        # ← NEW（Phase 1で追加）
├── .devcontainer/                 # ← NEW（Phase 1で追加）
├── docker-compose.yml             # ← NEW（Phase 1で追加）
└── scripts/validation/            # ← NEW（Phase 1で追加）

# GitHub Issue/PR管理はYokaKitリポジトリで実施
# コード変更もYokaKitリポジトリで実施
# YokaKit_Replayは計画・ガイダンスのみ提供

pinkieit/（読み取り専用参照）     # パターン参照リポジトリ
├── Laravel 10.x                   # 参照：フレームワークバージョン
├── docker/                        # 参照：Docker構成パターン
├── .devcontainer/                 # 参照：開発環境パターン
└── 189 commits                    # 参照：実証済み改善履歴
```

### 開発フロー（リポジトリ間連携）
```text
1. 計画（YokaKit_Replay）
   /plan コマンド → specs/002-phase-1-docker/ 生成

2. GitHub準備（YokaKitリポジトリ）
   gh label create --repo YOUR_ORG/YokaKit ...
   gh issue create --repo YOUR_ORG/YokaKit ...

3. 実装（YokaKitリポジトリ）
   cd YokaKit/
   # Docker環境追加、モデル移動など
   git commit -m "feat: Docker foundation (PinkieIt: a5d3b77)"
   git push origin feature/phase-1-docker

4. PR作成（YokaKitリポジトリ）
   gh pr create --repo YOUR_ORG/YokaKit

5. サブモジュール更新（YokaKit_Replay）
   cd ../  # YokaKit_Replayに戻る
   git add YokaKit
   git commit -m "chore: update YokaKit to Phase 1 completion"
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

**重要**: GitHub Issue/PR管理は**YokaKitリポジトリ**で実施
- YokaKit_Replayは計画・ガイダンスリポジトリ（Issue管理なし）
- YokaKitリポジトリで実際の開発Issue/PRを作成・追跡

#### ラベル体系 (4層階層構造) - YokaKitリポジトリに適用
- **Epic レベル**: `epic:phase-0` ～ `epic:phase-6` (Phase レベルの大規模機能群)
- **Story レベル**: `story:feature`, `story:security`, `story:ci-cd`, `story:integration`, `story:documentation`
- **Task レベル**: `task:implementation`, `task:validation`, `task:testing`
- **Constitutional**: `constitutional:identity-preservation` (必須), `constitutional:historical-fidelity`, `constitutional:quality-first`, `constitutional:compliance`
- **ステータス**: `status:needs-triage`, `status:in-progress`, `status:blocked`
- **標準**: `enhancement`, `bug`, `documentation`, `question`

**ラベル移行**: YokaKit_Replayで定義 → YokaKitリポジトリに`gh`コマンドで適用

#### マイルストーン - YokaKitリポジトリに適用
- **Phase 0**: GitHubリポジトリ初期化 (v0.1.0) ✅ 完了
- **Phase 1**: Docker Foundation & Development Environment (v0.2.0) ✅ 完了
- **Phase 2**: Quality Infrastructure Day (v0.3.0) ✅ 完了
- **Phase 3**: Comprehensive Testing (v0.4.0) ✅ **完了 - 425/425 tests (100%)**
- **Phase 4**: Framework Modernization (Laravel 10.x + PHP 8.2) (v0.5.0) 📋 次へ
- **Phase 5**: Advanced Docker Optimization (v0.6.0)
- **Phase 6**: CI/CD Integration & Final Polish (v1.0.0)

#### Issue作成例（YokaKitリポジトリ）
```bash
# YokaKitリポジトリにEpic Issue作成
gh issue create --repo YOUR_ORG/YokaKit \
  --title "[EPIC] Phase 1: Docker Foundation & Development Environment" \
  --label "epic:phase-1,constitutional:identity-preservation" \
  --milestone "Phase 1: Docker Foundation"

# YokaKitリポジトリにTask Issue作成
gh issue create --repo YOUR_ORG/YokaKit \
  --title "[TASK] Create docker-compose.yml with YokaKit naming" \
  --label "epic:phase-1,task:implementation,constitutional:identity-preservation" \
  --body "Reference: PinkieIt commit a5d3b77"
```

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
   # PinkieItの完全な開発履歴を確認（277コミット、35PR）
   cat .specify/memory/pinkieit-commit-pr-history.md

   # または、pinkieitサブモジュールで直接確認
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

.specify/memory/
└── pinkieit-commit-pr-history.md      # PinkieIt全コミット・PR履歴（277コミット、35PR）
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
- [PinkieItコミット・PR履歴](./.specify/memory/pinkieit-commit-pr-history.md) - 全コミット・PR履歴（277コミット、35PR）
- [文書品質保証](./docs/analysis/quality-assurance/document-inconsistencies-analysis.md) - 分析文書の精度検証

### GitHub管理・運用
- [ラベル管理ガイド](./docs/github-management/LABEL_GUIDE.md) - 4層階層ラベル体系と使用方法
- [Issue & Milestone ガイド](./docs/github-management/ISSUE_MILESTONE_GUIDE.md) - Epic/Story/Task の使い分け

### 技術詳細
- [PinkieIt詳細](./pinkieit/README.md)
- [YokaKit詳細](./YokaKit/README.md)
- [CI/CDワークフロー](./pinkieit/docs/CI_CD_WORKFLOW.md)
- [Claude Code設定](./pinkieit/CLAUDE.md)

## 📐 Spec作成ガイドライン（重要：Phase 1の教訓）

### MUST: PinkieItの実際のコミット履歴を必ず確認

**仮定に基づく計画は禁止**。PinkieItの実際のコミットを**必ず確認**してから計画を作成する。

#### Phase 1で学んだ教訓

**初期の誤り** ❌:
```
想定: "Docker Foundation" = 単純なDockerfile + docker-compose.yml
想定: "モデル移動" = app/Http/Requests → app/Models
結果: 仮定ベースで48タスク作成 → 不正確
```

**現実確認** ✅:
```bash
cd pinkieit
git log --oneline --reverse a5d3b77..13b40d1

実態:
a5d3b77: 初期Docker（想定通り）
643414f: YokaKit→PinkieItリネーム（スキップ必須）
fad82e6: app/全体をapp/laravel/に移動（大規模！）
bfd075e: docker-compose洗練（network, healthcheck）
3a0f1cd: volume調整
13b40d1: MQTTコンテナ追加
```

**修正後のアプローチ** ✅:
- 各コミットを`git show {hash} --stat`で分析
- 実際のファイル変更を理解（fad82e6は200+ファイル！）
- コミット単位のリプレイタスク作成（47タスク）
- 正確な期間: 2-3週間（4週間ではない）

### 全フェーズ共通の必須ワークフロー

#### ステップ1: 関連するPinkieItコミットを特定
```bash
# Phase 2（品質基盤）の例
cd pinkieit
git log --oneline --grep="test\|quality\|phpunit\|coverage" --reverse

# または日付範囲で検索（timeline analysisから判明している場合）
git log --oneline --after="2025-06-13" --before="2025-06-14" --reverse
```

#### ステップ2: 各コミットを詳細分析
```bash
git show {hash} --stat        # ファイルリスト
git show {hash}               # 完全なdiff
git show {hash}:path/to/file  # 特定ファイルの内容
```

#### ステップ3: 憲法要件とのマッピング
```
各コミットに対して:
  IF YokaKit→PinkieItリネーム:
    → スキップ（憲法要件III）
  ELSE IF PinkieItブランディング追加:
    → YokaKit名前で適応
  ELSE:
    → YokaKitアイデンティティ保持してリプレイ
```

#### ステップ4: コミットベースのtasks.md作成
```markdown
## COMMIT REPLAY 1: {hash} - {説明}
**PinkieIt Commit**: `{完全hash}`
**Tasks**: T001-T00X

各コミットの実際の変更に基づくタスク生成
```

#### ステップ5: GitHub Issue作成前の検証
- [ ] 全コミット分析済み？（最初と最後だけではダメ）
- [ ] 憲法スキップ文書化済み？（643414f等）
- [ ] 命名適応計画済み？（pinkieit → yokakit）
- [ ] ファイルパス正確？（実際のdiff確認）
- [ ] 依存関係明確？（コミット順序重要）

### Phase 1の具体例

**修正前**: Week 1-4の週ベース計画（不正確）
**修正後**: CR1, CR3, CR4-6, PVのコミットベース（正確）

```
Story #20: CR1 (a5d3b77) - 初期Docker基盤
Story #21: CR3 (fad82e6) - app/laravel/構造 ⚠️大規模
Story #22: CR4-6 - 洗練とMQTT
Story #23: PV - 検証と品質
```

## 🤝 コントリビューション

### 実装フロー
1. PinkieItコミット履歴確認（**必須**）
2. コミットベースのタスク作成
3. YokaKitリポジトリでGitHub Issue作成
4. フィーチャーブランチで実装
5. プルリクエスト作成（PinkieItコミット参照）
6. CI/CD自動チェック通過
7. コードレビュー・マージ
8. YokaKit_Replayサブモジュール更新

## 📄 ライセンス

- **YokaKit**: Apache License 2.0
- **PinkieIt**: Apache License 2.0

---

**製造業のデジタル変革を、統合プラットフォームで実現**

🏭 YokaKit_Replay - リアルタイム製造実行システム