# 開発ガイドライン

## 基本原則

### 憲法遵守（非交渉）
- **Identity Preservation**: YokaKit名を最後まで維持
- **Historical Fidelity**: PinkieItのgit履歴から改善工程を段階的に抽出・適用
- **Sequential Phases**: 厳密なフェーズ順序（0→1→2→3→4→5）
- **Submodule Sync**: 各フェーズ完了時にYokaKitサブモジュール更新必須

### 品質ファースト
- すべての改善は機能テストによる検証後にサブモジュール更新
- 品質ゲートが次フェーズ進行の前提条件
- CI/CD、自動テスト、静的解析を段階的導入

## ブランチ戦略

### 命名規則
- **フィーチャーブランチ**: `phase-{N}-{feature-name}`
- **Phase完了ブランチ**: `phase-{N}-complete`
- **例**: `phase-1-docker-setup`, `phase-1-complete`

### ワークフロー
1. メインブランチから フィーチャーブランチ作成
2. 機能実装・テスト
3. プルリクエスト作成
4. CI/CD自動チェック通過必須
5. コードレビュー・承認
6. Squash and Merge実行
7. フィーチャーブランチ自動削除

### 保護設定
- **main ブランチ**: 直接push禁止
- **必須チェック**: ビルド、テスト、セキュリティスキャン、カバレッジ、リント
- **レビュー必須**: 最低1名の承認が必要

## コミット規約

### メッセージフォーマット
```
<type>: <description>

[body]

Ref: pinkieit@<commit-hash>
```

### 例
```
feat: Phase 1 complete - Docker環境構築

- multi-stage Dockerfile追加
- docker-compose.yml設定
- Laravel 10.x アップグレード完了

Ref: pinkieit@a5d3b77
```

### Type一覧
- **feat**: 新機能追加
- **fix**: バグ修正
- **docs**: ドキュメント更新
- **style**: コードスタイル修正
- **refactor**: リファクタリング
- **test**: テスト追加・修正
- **chore**: その他の変更

## PinkieIt参照パターン

### 履歴分析コマンド
```bash
# 完全な開発履歴を時系列で確認
cd pinkieit && git log --oneline --reverse

# 特定改善の抽出
cd pinkieit && git log --grep="Docker\|Laravel\|CI/CD" --oneline

# コミット詳細確認
cd pinkieit && git show <commit-hash>
```

### 改善工程抽出
1. **PinkieItコミット特定**: 対象となる改善のコミットハッシュ確認
2. **変更内容分析**: `git show` で詳細確認
3. **YokaKit適用**: 名前変更を除き、改善をYokaKitに適用
4. **テスト実行**: 品質チェック完了
5. **コミット**: PinkieItハッシュ参照付きでコミット

## Issue・マイルストーン管理

### ラベル体系
- **Phase**: `phase-0`, `phase-1`, `phase-2`, `phase-3`, `phase-4`, `phase-5`
- **種別**: `enhancement`, `bug`, `documentation`, `question`
- **優先度**: `priority-high`, `priority-medium`, `priority-low`
- **状態**: `blocked`, `in-review`, `needs-info`

### マイルストーン
- **Phase 0**: GitHubリポジトリ初期化 (v0.1.0)
- **Phase 1**: Docker環境構築 + Laravel 10.x (v0.2.0)
- **Phase 2**: CI/CDパイプライン構築 (v0.3.0)
- **Phase 3**: テスト・品質管理ツール統合 (v0.4.0)
- **Phase 4**: WebSocket・リアルタイム機能モダナイズ (v0.5.0)
- **Phase 5**: セキュリティ・パフォーマンス最適化 (v1.0.0)

## セキュリティ要件

### 必須設定
- **2FA**: 全開発者で有効化
- **ブランチ保護**: main ブランチ保護設定
- **シークレット管理**: GitHub Secrets使用
- **アクセス制御**: 最小権限原則

### スキャン・監査
- **依存関係**: Dependabot自動更新
- **コード**: CodeQL分析
- **コンテナ**: セキュリティスキャン（Phase 1以降）
- **SonarQube**: 品質・セキュリティ分析（Phase 2以降）

## 禁止事項

### 絶対禁止
- **直接push**: main ブランチへの直接変更
- **名前変更**: YokaKit → PinkieIt変更の適用
- **フェーズスキップ**: 順序を無視した実装
- **品質ゲート無視**: テスト失敗・静的解析エラーでの進行

### 注意事項
- **サブモジュール更新**: Phase完了前の更新は禁止
- **設定変更**: セキュリティ設定の勝手な変更禁止
- **依存関係**: 無許可での大幅バージョンアップ禁止