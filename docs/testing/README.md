# Testing Documentation

YokaKitプロジェクトにおけるテスト戦略、ツール、ベストプラクティスに関するドキュメント集

## 📚 ドキュメント一覧

### 1. [PHPUnit vs SonarQube 比較](./PHPUNIT_VS_SONARQUBE_COMPARISON.md)
PHPUnit Coverage ReportとSonarQube MCPの機能比較、使い分けガイド

**内容**:
- 機能比較表（被っていること、それぞれでしかできないこと）
- PHPUnitでしかできないこと：ファイル単位カバレッジ、未カバー行の視覚化
- SonarQubeでしかできないこと：静的解析、複雑度分析、セキュリティ検出
- 両方でできること：プロジェクト全体カバレッジ、HTMLレポート
- 使い分けガイド：場面別推奨ツール

**こんな時に読む**:
- テストカバレッジツールを選ぶ時
- テスト不足箇所を特定したい時
- コード品質問題を発見したい時

---

### 2. [AI駆動テスト開発ワークフロー](./AI_DRIVEN_TEST_DEVELOPMENT_WORKFLOW.md)
Claude Code（AI）を活用した効率的なテスト開発フロー

**内容**:
- **シナリオ1**: 既存コードへのテスト追加（4時間で0%→90%）
- **シナリオ2**: 新規機能開発（TDD: Red-Green-Refactor）
- AIとの対話パターン（段階的詳細化、イテレーティブ改善、エラードリブン）
- AIに任せること vs 人間が判断すること
- SonarQube MCPとの連携

**こんな時に読む**:
- 未テストコードにテストを追加する時
- 新機能をTDDで開発する時
- AIを使ってテストを効率化したい時

---

### 3. [テスト品質検証ガイド](./TEST_QUALITY_VALIDATION_GUIDE.md)
AI生成テストが「意味のあるテスト」かを検証する方法

**内容**:
- 意味のないテストの例（トートロジー、モック過剰、アサーションなし）
- **4層防御戦略**:
  - Layer 1: 静的解析（Mutation Testing、PHPStan、SonarQube）
  - Layer 2: AI駆動レビュー（テスト品質スコアリング）
  - Layer 3: 振る舞い駆動検証（Property-Based Testing）
  - Layer 4: 実効性検証（バグ注入テスト）
- テスト品質チェックリスト（Level 1-4）
- CI/CD統合

**こんな時に読む**:
- AIが生成したテストが信頼できるか確認したい時
- テストの品質を向上させたい時
- Mutation Testingを導入したい時

---

### 4. [ソフトウェアテストの種類ガイド](./SOFTWARE_TESTING_TYPES_GUIDE.md)
すべてのテスト種類の網羅的解説

**内容**:
- **テストピラミッド**: Unit 70% / Integration 20% / E2E 10%
- **9種類のテスト詳細**:
  1. Unit Tests（単体）
  2. Integration Tests（統合）
  3. Feature Tests（機能）
  4. E2E Tests（エンドツーエンド）
  5. Regression Tests（回帰）
  6. Smoke Tests（スモーク）
  7. Performance Tests（性能）
  8. Security Tests（セキュリティ）
  9. その他（Mutation, Property-Based, Visual Regression等）
- YokaKitの現状と改善策（425テスト→1000テスト）
- どのテストをいつ書くか

**こんな時に読む**:
- テストの種類を理解したい時
- どのテストを書くべきか迷った時
- YokaKitのテスト戦略を見直したい時

---

### 5. [人間が必要なテストガイド](./HUMAN_REQUIRED_TESTING_GUIDE.md)
自動化できないテスト、人間の価値が高いテスト

**内容**:
- **自動化可能性マトリクス**（🤖 100% → 👤 100%）
- **人間必須のテスト**:
  1. Exploratory Testing（探索的）- 直感・創造性
  2. Usability Testing（ユーザビリティ）- 使いやすさ評価
  3. Acceptance Testing（受入）- ビジネス判断
  4. UX Testing（ユーザー体験）- 感情・満足度
  5. Security Penetration（侵入）- 創造的な攻撃
  6. Accessibility Testing（アクセシビリティ）- 実際の障害者による検証
- YokaKit推奨バランス：自動90% / 人間10%（カバレッジ）
- 年間スケジュール例

**こんな時に読む**:
- 自動テストの限界を知りたい時
- ユーザビリティテストを実施したい時
- 受入テストの計画を立てる時

---

## 🎯 クイックガイド: どのドキュメントを読むべきか

### 状況別推奨ドキュメント

| 状況 | 推奨ドキュメント |
|------|----------------|
| テストカバレッジを上げたい | 📄 PHPUnit vs SonarQube<br>📄 AI駆動ワークフロー |
| AIでテストを効率化したい | 📄 AI駆動ワークフロー<br>📄 テスト品質検証 |
| テストの種類を理解したい | 📄 ソフトウェアテストの種類 |
| テストの品質を確認したい | 📄 テスト品質検証 |
| ユーザビリティテストをしたい | 📄 人間が必要なテスト |
| 新規機能をTDDで開発したい | 📄 AI駆動ワークフロー |
| セキュリティテストを実施したい | 📄 人間が必要なテスト |

---

## 📊 YokaKit テスト戦略サマリー

### 現状（2025-10-06）
- **自動テスト**: 425個（Unit 94, Feature 331, E2E 0）
- **カバレッジ**: 39.50% (PHPUnit) / 41.1% (SonarQube)
- **Quality Gate**: ✅ PASSED
- **Issues**: 37件（コード品質改善余地あり）

### 目標（1年後）
- **自動テスト**: 1000個（Unit 700, Integration 150, Feature 200, E2E 100）
- **カバレッジ**: 80%+
- **人間テスト**: 月2回の探索的テスト、四半期ごとのユーザビリティテスト

### 優先アクション
1. **Data/PayloadData.php** など未テストコード（172行）へのテスト追加
2. Mutation Testing 導入（Infection PHP）
3. 探索的テストの定期実施（月2回）

---

## 🛠️ 関連ツール

### テスト実行
- **PHPUnit**: `php artisan test --coverage-html=coverage-report`
- **ParaTest**: `php artisan test --parallel --processes=4`
- **Laravel Dusk**: `php artisan dusk`

### カバレッジ分析
- **PHPUnit Coverage**: HTMLレポート生成（ファイル単位詳細）
- **SonarQube MCP**: プロジェクト全体分析、Issue検出

### 品質検証
- **Infection PHP**: Mutation Testing（テストの品質検証）
- **PHPStan/Larastan**: 静的解析、型チェック
- **SonarQube**: 複雑度、重複コード、セキュリティ

---

## 📁 関連ディレクトリ

```
YokaKit_Replay/
├── coverage-report/              # PHPUnit HTMLカバレッジレポート
│   ├── index.html               # メインダッシュボード
│   └── FILE_COVERAGE_LIST.md    # 全149ファイルの詳細リスト
├── docs/
│   ├── testing/                 # 👈 このディレクトリ
│   ├── analysis/                # 分析ドキュメント
│   └── github-management/       # GitHub管理ガイド
└── YokaKit/                     # Submodule（実装コード）
    └── tests/                   # 実際のテストコード
        ├── Unit/
        ├── Feature/
        └── Browser/
```

---

## 🔗 関連リンク

- [YokaKit Phase 3 完了レポート](../../YokaKit/PHASE_3_COMPLETION_REPORT.md) - テスト基盤構築の詳細
- [YokaKit Phase 4 完了レポート](../../YokaKit/PHASE_4_COMPLETION_REPORT.md) - 425/425テスト達成
- [CLAUDE.md](../../CLAUDE.md) - プロジェクト全体コンテキスト

---

## 📝 更新履歴

| 日付 | 更新内容 |
|------|---------|
| 2025-10-06 | 初版作成（5つのドキュメント整理） |

---

## 💡 フィードバック

これらのドキュメントに関するフィードバックや質問は、GitHub Issuesまたはプロジェクトチャンネルでお願いします。
