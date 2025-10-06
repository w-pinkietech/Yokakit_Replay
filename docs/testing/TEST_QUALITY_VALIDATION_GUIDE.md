# テスト品質検証ガイド - AI生成テストの妥当性確認

## 問題の本質

### ❌ よくある「意味のないテスト」の例

```php
// Example 1: トートロジー（同語反復）テスト
/** @test */
public function good_count_returns_good_count()
{
    $payload = new PayloadData(...);
    $result = $payload->goodCount();

    // ❌ 何も検証していない
    $this->assertEquals($result, $result);
}

// Example 2: 実装の詳細をテストしている
/** @test */
public function uses_array_sum_internally()
{
    // ❌ 実装方法に依存（リファクタリングで壊れる）
    $this->assertStringContainsString('array_sum', file_get_contents('PayloadData.php'));
}

// Example 3: モックだらけで実質何も動いていない
/** @test */
public function calculates_operation_rate()
{
    $service = Mockery::mock(ProductionEfficiencyService::class);
    $service->shouldReceive('calculateOperationRate')->andReturn(75.0);

    // ❌ 本物のロジックは一切実行されていない
    $result = $service->calculateOperationRate($process, $start, $end);
    $this->assertEquals(75.0, $result);
}

// Example 4: アサーションがない
/** @test */
public function creates_user()
{
    User::factory()->create();

    // ❌ 何も確認していない（常に成功）
}

// Example 5: 常に成功する無意味なアサーション
/** @test */
public function validates_email()
{
    $result = true; // Always true
    $this->assertTrue($result); // ❌ 無意味
}
```

---

## 🔍 テスト品質検証の多層アプローチ

### Layer 1: 静的解析（自動）

#### 1-1. Mutation Testing（変異テスト）

**原理**: コードを意図的に壊して、テストが失敗するか確認

**ツール**: [Infection PHP](https://infection.github.io/)

```bash
# インストール
composer require --dev infection/infection

# 実行
./vendor/bin/infection --test-framework=phpunit
```

**実例**:
```php
// Original Code
public function goodCount(): int
{
    return $this->totalCount - array_sum($this->defectiveCounts);
}

// Mutation 1: 演算子変更
public function goodCount(): int
{
    return $this->totalCount + array_sum($this->defectiveCounts); // - → +
}

// Mutation 2: 定数変更
public function goodCount(): int
{
    return $this->totalCount - array_sum($this->defectiveCounts) + 1;
}
```

**結果の見方**:
```
Mutation Score Indicator (MSI): 85%
Mutation Code Coverage: 92%
Covered Code MSI: 92%

Mutations:
  - Killed: 34 (テストが検出した変異)
  - Escaped: 6  (❌ テストが検出できなかった変異 = テストが不十分)
  - Not Covered: 3 (未カバーコード)
```

**Escaped Mutationの例**:
```
Escaped Mutation in PayloadData.php:145
- Original: return $total - $defective;
+ Mutant:   return $total + $defective;

テストが失敗しなかった → このケースをカバーするテストが不足
```

#### 1-2. PHPStan/Larastan による型チェック

```bash
composer require --dev larastan/larastan

# 実行
./vendor/bin/phpstan analyse tests/
```

**検出できる問題**:
```php
/** @test */
public function calculates_total()
{
    $result = $this->service->calculate(100, 50);

    // ❌ PHPStan: Method expects float, but test asserts int
    $this->assertEquals(150, $result); // Should be 150.0
}
```

#### 1-3. カスタム静的解析ルール

**SonarQube カスタムルール**で以下を検出:
```yaml
# .sonarqube/custom-rules.yml
rules:
  - id: test-without-assertions
    pattern: "public function test_.*\\(\\).*{[^}]*}"
    not-contains: "assert"
    message: "Test method has no assertions"
    severity: CRITICAL

  - id: mock-everything-antipattern
    pattern: "shouldReceive.*andReturn"
    count: "> 5"  # 1テストで5個以上のモック
    message: "Too many mocks - test may be meaningless"
    severity: MAJOR
```

---

### Layer 2: AI駆動レビュー（半自動）

#### 2-1. Claude Code によるテストレビュープロンプト

**プロンプトテンプレート**:
```
以下のテストコードをレビューしてください。
特に以下の観点で問題を指摘してください：

【チェック項目】
1. Assertion の妥当性
   - トートロジーになっていないか
   - 意味のあるアサーションか
   - エッジケースを検証しているか

2. テストの独立性
   - 他のテストに依存していないか
   - テスト順序に依存していないか

3. モックの適切性
   - 過剰なモックになっていないか
   - 本物のロジックが実行されているか

4. Given-When-Then の明確性
   - テストの意図が明確か
   - 何を検証したいのか分かるか

5. ビジネスロジックの検証
   - 実装の詳細ではなく、振る舞いをテストしているか
   - 境界値・異常系がカバーされているか

【テストコード】
```php
{test_code_here}
```

【対象の本番コード】
```php
{production_code_here}
```

以下の形式で回答してください：
- 🟢 Good: 良い点
- 🟡 Warning: 改善推奨
- 🔴 Critical: 修正必須
- 💡 Suggestion: テストケース追加提案
```

**実行例**:
```
👤 User:
[上記プロンプト + テストコード貼り付け]

🤖 Claude Code:
## テストレビュー: PayloadDataTest::good_count_calculates_correctly

### 🟢 Good
- Given-When-Thenが明確
- 実際の計算ロジックが実行されている（モックなし）
- アサーションが具体的（assertEquals(90, $result)）

### 🟡 Warning
1. テストデータが固定値
   - defectiveCounts: [5, 3, 2] は毎回同じ
   - 推奨: ランダム値やFactory使用で堅牢性向上

2. 境界値テストが不足
   - defectiveCounts が空配列のケースがない
   - defectiveCounts が大きな値のケースがない

### 🔴 Critical
1. **負数ケースの検証が甘い**
   ```php
   // 現在のテスト
   $this->assertEquals(-10, $result);

   // 問題: 負数を「期待値」として受け入れている
   // これはバグの可能性が高い
   ```

   推奨修正:
   ```php
   $this->expectException(InvalidArgumentException::class);
   $result = $payload->goodCount();
   ```

### 💡 Suggestion
以下のテストケース追加を推奨:

1. **境界値: defectiveCounts が空**
   ```php
   /** @test */
   public function good_count_equals_total_when_no_defectives()
   {
       $payload = new PayloadData(..., defectiveCounts: []);
       $payload->setTotalCount(100);
       $this->assertEquals(100, $payload->goodCount());
   }
   ```

2. **境界値: totalCount がゼロ**
   ```php
   /** @test */
   public function good_count_returns_zero_when_total_is_zero()
   ```

3. **異常系: defectiveCounts に負数**
   ```php
   /** @test */
   public function throws_exception_when_defective_count_is_negative()
   ```
```

#### 2-2. テスト品質スコアリング

**AIに以下を計算させる**:
```
👤 User:
"このテストファイルの品質を0-100点でスコアリングしてください。
以下の基準で評価：
- Assertion の有意義さ (30点)
- カバレッジの網羅性 (25点)
- Given-When-Then の明確性 (20点)
- エッジケース検証 (15点)
- 独立性・保守性 (10点)"

🤖 Claude Code:
## PayloadDataTest.php 品質スコア: 68/100

### 評価詳細
| 項目 | 配点 | 得点 | 理由 |
|------|-----|------|------|
| Assertion の有意義さ | 30 | 24 | ✅ 具体的な値を検証<br>❌ 一部トートロジー的 |
| カバレッジの網羅性 | 25 | 15 | ❌ 32メソッド中5つのみ<br>❌ 境界値不足 |
| Given-When-Then | 20 | 18 | ✅ 構造明確<br>⚠️ コメント不足 |
| エッジケース検証 | 15 | 6 | ❌ 空配列未検証<br>❌ null未検証 |
| 独立性・保守性 | 10 | 5 | ⚠️ Factory未使用<br>⚠️ 固定値多用 |

### 改善アクション（優先度順）
1. 🔴 残り27メソッドのテスト追加
2. 🔴 エッジケース（空、null、境界値）追加
3. 🟡 Factory使用でテストデータ動的化
4. 🟡 Given-When-Then コメント追加
```

---

### Layer 3: 振る舞い駆動検証（手動+AI補助）

#### 3-1. Property-Based Testing

**コンセプト**: ランダムな入力で不変条件を検証

**ツール**: [Pest PHP Property Testing](https://pestphp.com/docs/properties)

```php
use function Pest\property;

property('good count is never negative', function () {
    $totalCount = random_int(0, 1000);
    $defectiveCounts = array_map(fn() => random_int(0, 100), range(1, 5));

    $payload = new PayloadData(..., defectiveCounts: $defectiveCounts);
    $payload->setTotalCount($totalCount);

    $result = $payload->goodCount();

    // Property: 良品数は必ず0以上
    expect($result)->toBeGreaterThanOrEqual(0);
})
->with([
    // 100回ランダム実行
    ...range(1, 100)
]);
```

**メリット**:
- 人間が考えつかないエッジケースを発見
- 不変条件（invariants）の検証に最適

#### 3-2. Snapshot Testing

**コンセプト**: 出力を「スナップショット」として保存し、変更を検出

```php
/** @test */
public function payload_serialization_format()
{
    $payload = PayloadData::factory()->create();

    // 初回実行時にスナップショット保存
    // 2回目以降は差分検出
    $this->assertMatchesSnapshot($payload->toArray());
}
```

**ユースケース**:
- JSON API のレスポンス形式
- HTMLレンダリング結果
- 複雑なデータ構造の変換

#### 3-3. Approval Testing（承認テスト）

**コンセプト**: AIが生成したテスト結果を人間が「承認」する

**ワークフロー**:
```bash
# 1. AIがテスト生成
👤 "goodCount()のテストを生成して"
🤖 [テストコード生成]

# 2. テスト実行して結果を保存
php artisan test --filter good_count_calculates_correctly > test_output.txt

# 3. 人間が結果をレビュー
👤 [test_output.txt を確認]
   "結果が正しい → 承認"

# 4. 承認ファイルとして保存
mv test_output.txt tests/approved/good_count.approved.txt

# 5. 以降のテストは承認ファイルと比較
php artisan test --filter good_count_calculates_correctly | diff - tests/approved/good_count.approved.txt
```

---

### Layer 4: テスト実効性の検証（実践的）

#### 4-1. 「バグ注入テスト」

**手順**:
```
1. 本番コードに意図的にバグを入れる
2. テストを実行
3. テストが失敗するか確認
4. バグを元に戻す
```

**自動化例**:
```bash
#!/bin/bash
# bug-injection-test.sh

echo "=== Bug Injection Test ==="

# オリジナルファイルをバックアップ
cp app/Data/PayloadData.php app/Data/PayloadData.php.bak

# バグ注入: 演算子を変更
sed -i 's/totalCount - array_sum/totalCount + array_sum/g' app/Data/PayloadData.php

# テスト実行
echo "Running tests with injected bug..."
php artisan test --filter PayloadDataTest 2>&1 | tee test_result.txt

# 失敗したかチェック
if grep -q "FAILURES!" test_result.txt; then
    echo "✅ PASS: Test detected the bug"
    EXIT_CODE=0
else
    echo "❌ FAIL: Test did NOT detect the bug (meaningless test!)"
    EXIT_CODE=1
fi

# 元に戻す
mv app/Data/PayloadData.php.bak app/Data/PayloadData.php

exit $EXIT_CODE
```

**Claude Codeとの連携**:
```
👤 "PayloadDataに5種類のバグを注入して、
   どのテストが検出できるか確認してください"

🤖 Claude Code:
## バグ注入実験結果

### バグ1: 演算子変更（- → +）
- 注入箇所: goodCount() line 145
- 検出: ✅ 5/5 テストが失敗
- 評価: テストが有効

### バグ2: 境界値エラー（0 → 1）
- 注入箇所: cycleTimeMinutes() line 203
- 検出: ❌ 0/3 テストが失敗
- 評価: ⚠️ 境界値テスト不足

### バグ3: null チェック削除
- 注入箇所: toArray() line 267
- 検出: ❌ 0/2 テストが失敗
- 評価: ❌ null安全性未検証

### 総合評価
- 検出率: 5/10 (50%)
- 推奨: バグ2, 3 に対応するテスト追加
```

#### 4-2. コードカバレッジの「質」分析

**単なるカバレッジ率では不十分**:
```php
// ❌ カバレッジ100%だが無意味
public function complexLogic($value) {
    if ($value > 100) {
        return 'high';
    } elseif ($value > 50) {
        return 'medium';
    } else {
        return 'low';
    }
}

/** @test */
public function covers_all_branches() {
    $this->assertEquals('high', $this->complexLogic(150));
    $this->assertEquals('medium', $this->complexLogic(75));
    $this->assertEquals('low', $this->complexLogic(25));

    // ✅ カバレッジ100%
    // ❌ でも境界値（100, 50）が未検証！
}
```

**Claude Codeに分析させる**:
```
👤 "このテストのカバレッジは100%ですが、
   境界値が検証されているか確認してください"

🤖 Claude Code:
## カバレッジ品質分析

### 現状
- Line Coverage: 100% ✅
- Branch Coverage: 100% ✅
- **Boundary Coverage: 0%** ❌

### 未検証の境界値
1. value = 100 (境界)
   - 期待値: 'medium' or 'high'?
   - 現在: 未検証

2. value = 50 (境界)
   - 期待値: 'medium' or 'low'?
   - 現在: 未検証

3. value = 101 (境界+1)
   - 現在: 未検証

### 推奨追加テスト
```php
/** @test */
public function handles_exact_boundary_values()
{
    $this->assertEquals('medium', $this->complexLogic(100)); // 境界
    $this->assertEquals('low', $this->complexLogic(50));     // 境界
    $this->assertEquals('high', $this->complexLogic(101));   // 境界+1
    $this->assertEquals('medium', $this->complexLogic(51));  // 境界+1
}
```
```

#### 4-3. 「テストのテスト」メトリクス

**独自メトリクスを定義**:

| メトリクス | 計算式 | 目標値 |
|-----------|--------|--------|
| **Test Assertion Density** | アサーション数 / テストメソッド数 | ≥ 3 |
| **Test Complexity** | Cyclomatic Complexity / テスト | ≤ 5 |
| **Mock Ratio** | モック使用数 / テストメソッド数 | ≤ 2 |
| **Boundary Coverage** | 境界値テスト数 / 境界値総数 | 100% |
| **Exception Coverage** | 例外テスト数 / throw文数 | 100% |

**計測スクリプト**:
```bash
#!/bin/bash
# test-quality-metrics.sh

echo "=== Test Quality Metrics ==="

# Assertion Density
ASSERTIONS=$(grep -r "assert" tests/ | wc -l)
TEST_METHODS=$(grep -r "@test" tests/ | wc -l)
DENSITY=$(echo "scale=2; $ASSERTIONS / $TEST_METHODS" | bc)
echo "Assertion Density: $DENSITY (target: ≥3.0)"

# Mock Ratio
MOCKS=$(grep -r "mock\|shouldReceive" tests/ | wc -l)
MOCK_RATIO=$(echo "scale=2; $MOCKS / $TEST_METHODS" | bc)
echo "Mock Ratio: $MOCK_RATIO (target: ≤2.0)"
```

---

## 🔧 実践ワークフロー

### ステップ1: AI生成テストの自動検証

```bash
# 1. AIにテスト生成させる
👤 "PayloadDataの全メソッドのテストを生成してください"
🤖 [Tests/Unit/Data/PayloadDataTest.php 生成]

# 2. Mutation Testing実行
./vendor/bin/infection --test-framework=phpunit --only-covered --threads=4

# 3. 結果確認
# MSI < 80% なら問題あり
```

### ステップ2: AIレビュー

```bash
👤 "生成したPayloadDataTest.phpをレビューして、
   以下を確認してください：
   1. トートロジーテストがないか
   2. モックが過剰でないか
   3. 境界値が検証されているか
   4. 例外ケースが網羅されているか"

🤖 Claude Code:
[詳細レビュー結果]
```

### ステップ3: バグ注入テスト

```bash
# AIに自動でバグ注入・検出させる
👤 "PayloadData.phpに10種類のバグを注入して、
   テストが検出できるか確認してください。
   検出できなかったバグについては追加テストを提案してください。"

🤖 Claude Code:
## バグ注入実験
検出: 7/10 (70%)
未検出バグ:
- バグ3: null参照
- バグ7: 境界値オフバイワン
- バグ9: 型変換エラー

推奨テスト追加:
[テストコード生成]
```

### ステップ4: Property-Based Testing追加

```bash
👤 "PayloadDataの不変条件を5つ定義して、
   Property-Based Testを生成してください"

🤖 Claude Code:
## PayloadData 不変条件

1. goodCount() ≥ 0 (良品数は非負)
2. goodCount() ≤ totalCount (良品数は総数以下)
3. defectiveCount() ≥ 0 (不良品数は非負)
4. goodCount() + defectiveCount() = totalCount (総数一致)
5. cycleTimeMinutes() > 0 (サイクルタイムは正)

[Property Tests生成]
```

### ステップ5: 承認プロセス

```bash
# AIが提案したテストを人間がレビュー
👤 [テストコード確認]
   - ビジネスロジックとして正しいか？
   - 境界値は適切か？
   - 例外処理は妥当か？

# 承認 or 修正指示
👤 "不変条件4は間違い。計画停止を除外する必要がある"
🤖 [修正版生成]

# 最終承認
👤 "OK、このテストで確定"
```

---

## 📋 テスト品質チェックリスト

### ✅ Level 1: 基本（自動検証可能）

- [ ] すべてのテストにアサーションがある
- [ ] トートロジーテストがない（`assertEquals($x, $x)`）
- [ ] テストメソッド名が意味を表している
- [ ] Given-When-Then構造が明確
- [ ] テストが独立している（順序依存なし）

### ✅ Level 2: 網羅性（AI補助）

- [ ] 正常系がカバーされている
- [ ] 境界値がカバーされている（0, 最大値, null等）
- [ ] 異常系がカバーされている（例外、エラー）
- [ ] エッジケースがカバーされている（空配列、負数等）
- [ ] すべての public メソッドにテストがある

### ✅ Level 3: 妥当性（人間判断+AI補助）

- [ ] ビジネスロジックとして正しい検証をしている
- [ ] 実装の詳細ではなく、振る舞いをテストしている
- [ ] モックが適切（過剰でない、本質的なロジックは実行）
- [ ] テストが失敗する条件が明確
- [ ] バグ注入テストで検出率 80% 以上

### ✅ Level 4: 保守性（長期的視点）

- [ ] テストコードが読みやすい
- [ ] Factoryパターンでテストデータ管理
- [ ] マジックナンバーがない
- [ ] テストが壊れやすくない（実装変更に強い）
- [ ] ドキュメントとしての価値がある

---

## 🎯 YokaKit への適用例

### 現状分析

```
👤 "YokaKitの既存テスト（425個）の品質を分析してください。
   特に以下を確認：
   1. トートロジーテストの割合
   2. Assertion Density
   3. Mock Ratio
   4. 境界値カバレッジ"

🤖 Claude Code:
[tests/ ディレクトリをスキャン]

## YokaKit テスト品質分析

### 全体スコア: 72/100

### 詳細メトリクス
| メトリクス | 実績 | 目標 | 評価 |
|-----------|-----|------|------|
| Assertion Density | 2.8 | ≥3.0 | 🟡 |
| Mock Ratio | 1.2 | ≤2.0 | ✅ |
| Boundary Coverage | 45% | 100% | 🔴 |
| Exception Coverage | 30% | 100% | 🔴 |

### 問題のあるテスト（例）

1. `Tests/Unit/Models/LineTest.php:42`
   ```php
   /** @test */
   public function fillable_attributes()
   {
       $line = Line::factory()->create();
       $this->assertNotNull($line); // ❌ トートロジー
   }
   ```
   推奨修正: 実際のfillable属性を検証

2. `Tests/Unit/Services/ProductionServiceTest.php:78`
   ```php
   /** @test */
   public function calculates_total()
   {
       // ❌ 境界値未検証（0, 負数, null）
       $this->assertEquals(100, $service->calculate(50, 50));
   }
   ```
   推奨追加: 境界値テスト

### 改善アクション
1. 🔴 境界値テスト追加: 推定120テストケース
2. 🔴 例外テスト追加: 推定80テストケース
3. 🟡 Assertion強化: 50テスト修正
```

### 改善実施

```bash
# Mutation Testing で問題箇所を特定
./vendor/bin/infection --min-msi=80 --threads=4

# Escaped Mutations の分析
👤 "Infection の結果を分析して、
   Escaped Mutationsに対応するテストを生成してください"

🤖 Claude Code:
## Escaped Mutations 分析

### Mutation 1: ProductionService.php:145
```diff
- return $total - $cost;
+ return $total + $cost;
```
検出失敗理由: 負数ケースのテストがない

推奨テスト:
```php
/** @test */
public function throws_exception_when_cost_exceeds_total()
{
    $this->expectException(InvalidArgumentException::class);
    $this->service->calculate(total: 100, cost: 150);
}
```

[以下、全Escaped Mutationsについて生成]
```

---

## 🚀 完全自動化フロー（理想形）

### CI/CDパイプライン統合

```yaml
# .github/workflows/test-quality.yml
name: Test Quality Validation

on: [pull_request]

jobs:
  test-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Run Tests
        run: php artisan test

      - name: Mutation Testing
        run: ./vendor/bin/infection --min-msi=80

      - name: AI Test Review
        run: |
          # Claude Code API経由でテストレビュー
          python scripts/ai_test_review.py \
            --changed-files=$(git diff --name-only origin/main) \
            --output=test-review.md

      - name: Quality Gate Check
        run: |
          MSI=$(grep "MSI:" infection.log | awk '{print $2}')
          if [ "$MSI" -lt 80 ]; then
            echo "❌ Mutation Score too low: $MSI%"
            exit 1
          fi

      - name: Comment PR
        uses: actions/github-script@v6
        with:
          script: |
            const fs = require('fs');
            const review = fs.readFileSync('test-review.md', 'utf8');
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: review
            });
```

---

## まとめ: 4層防御戦略

```
Layer 1: 静的解析（自動）
├─ Mutation Testing (Infection)
├─ 型チェック (PHPStan/Larastan)
└─ カスタムルール (SonarQube)
         ↓
Layer 2: AI駆動レビュー（半自動）
├─ Claude Code によるテストレビュー
├─ テスト品質スコアリング
└─ 改善提案の自動生成
         ↓
Layer 3: 振る舞い検証（実践的）
├─ Property-Based Testing
├─ Snapshot Testing
└─ Approval Testing
         ↓
Layer 4: 実効性検証（最終確認）
├─ バグ注入テスト
├─ カバレッジ質分析
└─ テストのテストメトリクス
         ↓
    高品質なテスト
```

この4層アプローチで、AIが生成したテストでも「意味のあるテスト」を保証できます！
