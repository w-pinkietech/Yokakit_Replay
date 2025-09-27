# GitHub ラベル管理ガイド

**生成日**: 2025-09-27
**目的**: YokaKit_Replay プロジェクトのラベル体系と使用ガイドライン

## 🏷️ ラベル体系概要

YokaKit_Replay では、**4層の階層構造**でラベルを管理しています：

```
Epic (エピック) → Story (ストーリー) → Task (タスク) → Constitutional (憲法関連)
```

### 🎯 階層構造の定義

| 階層 | 目的 | 期間 | 例 |
|------|------|------|-----|
| **Epic** | Phase レベルの大規模機能群 | 4週間〜4ヶ月 | Docker Foundation, Framework Modernization |
| **Story** | 機能開発の論理的まとまり | 3-10日 | DevContainer Setup, Laravel 10.x Migration |
| **Task** | 具体的な実装・検証作業 | 1-3日 | Model Migration, Test Configuration |
| **Constitutional** | 憲法遵守の横断的要件 | 全期間 | Identity Preservation, Historical Fidelity |

---

## 📊 ラベル一覧と使用方法

### 🏗️ **Epic レベルラベル** (青色: #0052cc)

| ラベル | 説明 | 対象期間 |
|--------|------|----------|
| `epic:phase-0` | Phase 0: GitHub リポジトリ初期化 | ✅ 完了 |
| `epic:phase-1` | Phase 1: Docker Foundation & Development Environment | 4週間 |
| `epic:phase-2` | Phase 2: Quality Infrastructure Day | 1日集中 |
| `epic:phase-3` | Phase 3: Comprehensive Testing | 2週間 |
| `epic:phase-4` | Phase 4: Framework Modernization | 1週間 |
| `epic:phase-5` | Phase 5: Advanced Docker Optimization | 1週間 |
| `epic:phase-6` | Phase 6: CI/CD Integration & Final Polish | 1週間 |

**使用ガイドライン**:
- Phase レベルの大規模な機能開発に使用
- 複数の Story を含む包括的な作業
- マイルストーンと1:1で対応

### 📖 **Story レベルラベル** (緑色: #0e8a16)

| ラベル | 説明 | 典型的な作業内容 |
|--------|------|------------------|
| `story:feature` | 機能開発ストーリー | 新機能の設計・実装・テスト |
| `story:security` | セキュリティ実装 | 認証、認可、暗号化、脆弱性対応 |
| `story:ci-cd` | CI/CD 自動化 | ワークフロー、パイプライン、自動化 |
| `story:integration` | 統合開発 | サブモジュール、外部システム連携 |
| `story:documentation` | ドキュメント開発 | 技術文書、ガイド、仕様書作成 |

**使用ガイドライン**:
- 複数の Task から構成される論理的まとまり
- ユーザーストーリー形式で記述推奨
- 3-10日で完了可能な範囲

### ⚙️ **Task レベルラベル** (黄色: #fbca04)

| ラベル | 説明 | 典型的な作業時間 |
|--------|------|------------------|
| `task:implementation` | 実装作業 | 1-3日 |
| `task:validation` | 検証・確認作業 | 0.5-1日 |
| `task:testing` | テスト・QA作業 | 1-2日 |

**使用ガイドライン**:
- 具体的で測定可能な作業単位
- 1人が1-3日で完了可能
- 明確な完了条件を定義

### ⚖️ **Constitutional レベルラベル** (紫色: #5319e7)

| ラベル | 説明 | 適用範囲 |
|--------|------|----------|
| `constitutional:identity-preservation` | YokaKit アイデンティティ保持 **(必須)** | 全 Issue |
| `constitutional:historical-fidelity` | PinkieIt 歴史的忠実性維持 | リプレイ関連 |
| `constitutional:quality-first` | 品質ファースト実装 | 実装関連 |
| `constitutional:compliance` | 一般的憲法遵守 | 全般 |

**重要**: `constitutional:identity-preservation` は **NON-NEGOTIABLE** です。

---

## 🔄 **ステータス管理ラベル**

| ラベル | 色 | 説明 | 次のアクション |
|--------|-----|------|----------------|
| `status:needs-triage` | 赤 (#d93f0b) | 初期評価・割り当て必要 | 担当者アサイン |
| `status:in-progress` | 青 (#1d76db) | 作業中 | 進捗報告 |
| `status:blocked` | 濃赤 (#b60205) | 依存関係・問題により停止 | ブロッカー解決 |

---

## 📋 **標準ラベル** (GitHub デフォルト)

| ラベル | 説明 | 使用場面 |
|--------|------|----------|
| `bug` | 不具合報告 | 既存機能の問題 |
| `enhancement` | 機能改善要求 | 新機能・改善提案 |
| `documentation` | ドキュメント関連 | 文書化作業 |
| `question` | 質問・相談 | 技術相談、仕様確認 |

---

## 🎯 **ラベル使用のベストプラクティス**

### ✅ **推奨ラベル組み合わせ**

```bash
# Epic レベル Issue
epic:phase-1 + constitutional:identity-preservation

# Story レベル Issue
epic:phase-1 + story:feature + constitutional:quality-first

# Task レベル Issue
epic:phase-1 + story:feature + task:implementation + status:in-progress
```

### 🚫 **避けるべき組み合わせ**

```bash
# 複数の Epic ラベル
epic:phase-1 + epic:phase-2  # ❌ 1つのIssueは1つのPhaseに属する

# Story と Task の同時使用
story:feature + task:implementation  # ❌ 階層が異なる
```

### 📊 **Issue作成時のチェックリスト**

- [ ] 適切な階層レベル（Epic/Story/Task）を選択
- [ ] 該当する Phase ラベル（epic:phase-X）を付与
- [ ] 憲法関連ラベルを検討（特に identity-preservation）
- [ ] 必要に応じてステータスラベルを追加
- [ ] 標準ラベル（bug, enhancement等）を検討

---

## 🔍 **ラベル検索・フィルタリング**

### よく使用する検索クエリ

```bash
# Phase 1 の全 Issue
label:"epic:phase-1"

# 進行中の実装タスク
label:"task:implementation" label:"status:in-progress"

# 憲法遵守が必要な Issue
label:"constitutional:identity-preservation"

# ブロックされた Issue
label:"status:blocked"

# Story レベルの機能開発
label:"story:feature"
```

---

## 🔧 **ラベル管理・メンテナンス**

### ラベル更新ルール

1. **追加**: 新しい Story/Task カテゴリが必要な場合のみ
2. **変更**: 憲法改正時、または Phase 構造変更時のみ
3. **削除**: Phase 完了後、対応する epic ラベルをアーカイブ

### ラベル一貫性チェック

```bash
# 現在のラベル一覧確認
gh label list

# ラベル統計
gh issue list --label="epic:phase-1" --state=all
```

---

## 📚 **関連ドキュメント**

- [Issue & Milestone Guide](./ISSUE_MILESTONE_GUIDE.md) - Epic/Story/Task の詳細定義
- [GitHub運用方針](../../README.md#github運用方針) - 全体的な運用ルール
- [Constitutional Requirements](../../CLAUDE.md#constitutional-requirements) - 憲法要件

---

**最終更新**: 2025-09-27
**管理責任者**: プロジェクトリード
**レビュー周期**: Phase 完了時