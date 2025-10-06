# PHPUnit Test vs SonarQube MCP Server - 機能比較

## 概要

YokaKitプロジェクトにおける2つの品質検証ツールの機能比較

---

## 📊 比較表

| 機能カテゴリ | PHPUnit Coverage | SonarQube MCP | 重複 |
|------------|------------------|---------------|------|
| **テストカバレッジ分析** |
| プロジェクト全体のカバレッジ率 | ✅ 39.50% | ✅ 41.1% | ✅ |
| ファイル単位のカバレッジ | ✅ 全149ファイル | ❌ 取得不可 | ❌ |
| メソッド/関数単位のカバレッジ | ✅ 詳細表示 | ❌ 取得不可 | ❌ |
| 未カバー行番号の特定 | ✅ HTMLで視覚化 | ❌ 取得不可 | ❌ |
| カバレッジトレンド分析 | ❌ スナップショットのみ | ✅ 履歴追跡可能 | ❌ |
| **コード品質分析** |
| 静的解析（コード臭） | ❌ 不可 | ✅ 37件のIssue検出 | ❌ |
| 複雑度分析 | ❌ 不可 | ✅ 循環的複雑度871 | ❌ |
| コーディング規約違反 | ❌ 不可 | ✅ PSR2違反など | ❌ |
| 重複コード検出 | ❌ 不可 | ✅ 検出可能 | ❌ |
| セキュリティ脆弱性 | ❌ 不可 | ✅ 0件（検証済） | ❌ |
| **テスト実行** |
| ユニットテスト実行 | ✅ 425テスト | ❌ 不可 | ❌ |
| Feature/統合テスト実行 | ✅ 実行可能 | ❌ 不可 | ❌ |
| 並列実行 | ✅ ParaTest対応 | ❌ 不可 | ❌ |
| テスト失敗原因の特定 | ✅ 詳細なエラー出力 | ❌ 不可 | ❌ |
| **レポート機能** |
| HTMLレポート | ✅ 13MB, 視覚的 | ✅ WebUI | ✅ |
| コマンドライン出力 | ✅ リアルタイム | ✅ MCP経由 | ✅ |
| CI/CD統合 | ✅ 可能 | ✅ 可能 | ✅ |
| **Issue管理** |
| Issue一覧取得 | ❌ 不可 | ✅ 37件 | ❌ |
| Issue詳細（ファイル/行番号） | ❌ 不可 | ✅ 取得可能 | ❌ |
| Issueステータス変更 | ❌ 不可 | ✅ accept/false positive | ❌ |
| **Quality Gate** |
| 品質ゲート判定 | ❌ 不可 | ✅ OK/FAILED | ❌ |
| カスタム閾値設定 | ❌ 不可 | ✅ 設定可能 | ❌ |

---

## 🔵 PHPUnit Coverage でしかできないこと

### 1. ファイル単位の詳細カバレッジ分析
```
✅ 全149ファイルのカバレッジ率を個別に表示
✅ 0%カバレッジ: 59ファイル
✅ 1-40%: 21ファイル
✅ 40-70%: 10ファイル
✅ 70%+: 59ファイル
```

**例**: `Data/PayloadData.php` が172行すべて未カバーと特定可能

### 2. 未カバー行の視覚的表示
- HTMLレポートで**赤色**の行が未カバー箇所
- **緑色**の行がテスト済み
- クリックで該当コードにジャンプ可能

**SonarQubeではできない理由**: MCP Serverには`component_tree` APIが実装されていない

### 3. メソッド/関数単位のカバレッジ
```
Example: Models/Process.php
- __construct(): 100% (2/2 lines)
- isRunning(): 100% (1/1 lines)
- status(): 100% (3/3 lines)
```

各メソッドのカバレッジ率を個別に確認可能

### 4. テストの実行とデバッグ
```bash
# テスト実行
php artisan test

# 特定のテストのみ実行
php artisan test --filter LineTest

# 失敗時の詳細情報
✗ test validation fails with invalid data
Expected status code [422] but received [500].
Failed asserting that 500 is identical to 422.
```

**リアルタイムフィードバック**でテストの問題を即座に特定

### 5. カバレッジレポートのローカル生成
- VPN不要
- インターネット不要
- SonarCloud認証不要
- **完全オフライン動作**

---

## 🟠 SonarQube MCP でしかできないこと

### 1. 静的コード分析（Code Smells）

**検出可能な問題**:
```
✅ コメントアウトされたコード (11件)
   - PayloadData.php: 7箇所
   - ProductionService.php: 1箇所
   - DataBaseQueryServiceProvider.php: 1箇所

✅ return文の数超過 (8件)
   - ProductionHistoryService.php: 3メソッドで5個のreturn
   - 推奨: 最大3個

✅ 重複文字列 (1件 - CRITICAL)
   - UpdateAndonConfigRequest.php
   - "required|boolean" が12回重複
   - 推奨: 定数化
```

**PHPUnitではできない理由**: テスト実行ツールであり、静的解析機能なし

### 2. 複雑度分析

```
✅ 循環的複雑度（Cyclomatic Complexity）
   - プロジェクト全体: 871
   - FinishBreakdownJob.php: 17（上限15超過）
   - FinishChangeoverJob.php: 18（上限15超過）

✅ 認知的複雑度（Cognitive Complexity）
   - 人間が理解しにくいコードを検出
```

### 3. セキュリティ脆弱性検出

```
✅ Vulnerabilities: 0件（優秀！）
✅ Security Rating: A
✅ Security Hotspots: 検出・レビュー可能
```

### 4. Quality Gate（品質ゲート）

```yaml
YokaKit Quality Gate Status: ✅ PASSED

Conditions:
  - New Reliability Rating: A (1/1) ✅
  - New Security Rating: A (1/1) ✅
  - New Maintainability Rating: A (1/1) ✅
  - New Security Hotspots Reviewed: 100% ✅
```

**自動品質判定**でCI/CDでのマージ可否を決定可能

### 5. コーディング規約違反検出

```
✅ PSR2標準違反
   - AbstractRepository.php: モディファイアの順序不正

✅ 命名規則
   - else if → elseif 推奨 (2件)

✅ 設計原則違反
   - PayloadData.php: 32メソッド（上限20超過）
   - PayloadRepository.php: 8パラメータ（上限7超過）
```

### 6. プロジェクトメトリクス

```
✅ Lines of Code: 6,634
✅ Classes: 149
✅ Functions: 565
✅ Bugs: 2
✅ Code Smells: 35
✅ Technical Debt: 計算可能
```

### 7. 履歴・トレンド分析

- カバレッジの時系列変化
- 新規コードの品質チェック
- 改善/悪化の追跡

**PHPUnitではできない理由**: スナップショットのみで履歴保持機能なし

---

## ✅ 両方でできること（重複機能）

### 1. プロジェクト全体のカバレッジ率

| ツール | 値 | 差異理由 |
|--------|-----|---------|
| PHPUnit | 39.50% (972/2,461) | ローカル実行の最新値 |
| SonarQube | 41.1% (1,245/3,026) | 最後のSonarCloud分析時点 |

**差異の原因**:
- 分析タイミングの違い
- 対象ファイルの微妙な違い（設定依存）

### 2. HTMLレポート

| PHPUnit | SonarQube |
|---------|-----------|
| ローカル生成（13MB） | WebUI（SonarCloud） |
| オフライン閲覧可能 | インターネット必須 |
| ファイル詳細 ✅ | ファイル詳細 ❌（MCP制限） |
| 行単位ハイライト ✅ | 行単位ハイライト ✅（WebUIのみ） |

### 3. CI/CD統合

両方とも GitHub Actions 等に統合可能:
```yaml
# PHPUnit
- run: php artisan test --coverage

# SonarQube
- uses: SonarSource/sonarcloud-github-action@master
```

---

## 🎯 使い分けガイド

### 場面別推奨ツール

| シチュエーション | 推奨ツール | 理由 |
|-----------------|-----------|------|
| 🔍 **テスト不足箇所の特定** | **PHPUnit** | ファイル/メソッド単位で詳細表示 |
| 🐛 **コード品質問題の発見** | **SonarQube** | 静的解析でCode Smell検出 |
| 🧪 **テストのデバッグ** | **PHPUnit** | テスト実行とエラー詳細 |
| 🔒 **セキュリティチェック** | **SonarQube** | 脆弱性・Security Hotspot検出 |
| 📊 **品質ゲート判定** | **SonarQube** | 自動化された品質基準 |
| 🎨 **リファクタリング対象の発見** | **SonarQube** | 複雑度・重複コード分析 |
| 💻 **ローカル開発での即時確認** | **PHPUnit** | オフライン、高速 |
| 📈 **品質トレンドの追跡** | **SonarQube** | 履歴・時系列分析 |
| 🚀 **CI/CDでの品質ゲート** | **SonarQube** | 自動判定機能 |
| 🔧 **テストカバレッジ向上作業** | **PHPUnit** | 未カバー行の視覚化 |

---

## 🔄 理想的なワークフロー

### フェーズ1: ローカル開発（PHPUnit中心）
```bash
# 1. テスト実行
php artisan test --coverage

# 2. カバレッジレポート確認
open coverage-report/index.html

# 3. 未カバー箇所を特定してテスト追加
# 例: Data/PayloadData.php が0% → テスト作成

# 4. 再実行して改善確認
php artisan test --coverage
```

### フェーズ2: コミット前チェック（両方）
```bash
# PHPUnit: テストが通るか確認
php artisan test

# SonarQube: 新規Issue確認（MCP経由）
# - 新しいCode Smellが発生していないか
# - 複雑度が上がっていないか
```

### フェーズ3: CI/CD（両方）
```yaml
# GitHub Actions例
jobs:
  test:
    - name: Run PHPUnit
      run: php artisan test --coverage-clover=clover.xml

    - name: SonarCloud Scan
      uses: SonarSource/sonarcloud-github-action@master
      env:
        SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

    # Quality Gate確認
    - name: Check Quality Gate
      run: |
        # SonarQubeのQuality Gateが失敗ならマージ拒否
```

---

## 📌 YokaKit の現状と推奨アクション

### 現状サマリー
- **PHPUnit**: 425/425テスト成功（100%）
- **カバレッジ**: 39.50%（目標80%まで+40.5%必要）
- **SonarQube**: Quality Gate PASSED、37件のIssue（改善余地あり）

### 優先アクション

#### Priority 1: テストカバレッジ向上（PHPUnit）
```
🎯 目標: 39.50% → 80%

対象ファイル（未カバー行数順）:
1. Data/PayloadData.php - 172行 (0%)
2. Jobs/* - 260行 (0%)
3. Services/ProductionHistoryService.php - 54行 (20.6%)
```

**ツール**: PHPUnit Coverage Report で未カバー行を特定

#### Priority 2: Code Smell解消（SonarQube）
```
🎯 目標: 37件 → 0件

対象Issue（重要度順）:
1. CRITICAL (3件)
   - 重複文字列の定数化
   - 複雑度削減リファクタリング

2. MAJOR (24件)
   - コメントアウトコード削除 (11件)
   - return文削減 (8件)
```

**ツール**: SonarQube MCP で Issue一覧取得

#### Priority 3: 継続的品質維持（両方）
```
✅ PHPUnit: 新規コードには必ずテスト追加
✅ SonarQube: Quality Gateを厳格化
   - Coverage on New Code > 80%
   - Bugs = 0
   - Vulnerabilities = 0
```

---

## 🔑 重要な洞察

### PHPUnitの強み
> **"どこをテストすべきか"を教えてくれる**
- 具体的なファイル名と行番号
- メソッド単位の粒度
- 視覚的にわかりやすい

### SonarQubeの強み
> **"どこを改善すべきか"を教えてくれる**
- テスト以外の品質問題も検出
- 長期的な技術的負債を可視化
- プロジェクト全体の健全性評価

### 最適な組み合わせ
```
PHPUnit Coverage (詳細) + SonarQube Quality Gate (総合評価)
        ↓                           ↓
  テストカバレッジ向上          コード品質向上
        ↓                           ↓
            高品質なコードベース
```

---

## 📊 具体例: Data/PayloadData.php の改善

### 現状（PHPUnitで発見）
```
❌ Coverage: 0.00% (0/172 lines)
❌ 全32メソッドが未テスト
```

### SonarQubeでの検出
```
❌ MAJOR: Class has 32 methods (limit: 20)
💡 提案: より小さなクラスに分割
```

### 改善アプローチ
1. **PHPUnit**: テストを書きながらコードの問題に気づく
   ```php
   // テスト作成中に発見
   // - メソッドが多すぎて何をテストすべきか不明確
   // - 責務が多すぎる（Single Responsibility違反）
   ```

2. **SonarQube**: 設計レベルの問題を確認
   ```
   Issue: Class has 32 methods
   → リファクタリング提案を受け入れる
   ```

3. **リファクタリング**: クラス分割
   ```
   PayloadData
   ├─ PayloadDataCalculator  (計算ロジック)
   ├─ PayloadDataFormatter   (フォーマット)
   └─ PayloadDataValidator   (検証)
   ```

4. **再テスト**: 分割後、各クラスを個別にテスト
   ```
   ✅ PayloadDataCalculator: 80% coverage
   ✅ PayloadDataFormatter: 85% coverage
   ✅ PayloadDataValidator: 90% coverage
   ```

5. **SonarQube再確認**: Issue解消
   ```
   ✅ 3クラスすべて20メソッド以下
   ✅ Code Smell解消
   ```

---

## まとめ

| 側面 | PHPUnit Coverage | SonarQube MCP |
|------|------------------|---------------|
| **主目的** | テストカバレッジ詳細分析 | 総合コード品質評価 |
| **強み** | ファイル/行単位の精密な分析 | 静的解析・品質ゲート |
| **弱み** | コード品質分析なし | ファイル別カバレッジ取得不可（MCP制限） |
| **利用場面** | ローカル開発、テスト作成 | CI/CD、長期品質追跡 |
| **補完関係** | 🤝 互いに補完し合う必須ツール |

**結論**: 両方を併用することで、テストカバレッジとコード品質の両面から最高の結果が得られる！
