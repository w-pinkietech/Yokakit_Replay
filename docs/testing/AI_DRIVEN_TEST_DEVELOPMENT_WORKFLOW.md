# AI駆動開発におけるテスト実装ワークフロー

## 概要

Claude Code（AI）を活用した効率的なテスト開発フローの確立

---

## シナリオ1: 既存コードへのテスト追加

### 目的
既存の未テストコード（例: `Data/PayloadData.php` 172行、0%カバレッジ）にテストを追加

### 🔄 推奨ワークフロー

#### Phase 1: 分析フェーズ（AI主導）

**Step 1: カバレッジ状況の把握**
```bash
# ユーザー操作
php artisan test --coverage-html=coverage-report

# Claude Codeへの依頼
"PayloadData.phpのカバレッジレポートを分析して、
未テストのメソッド一覧を優先度順に教えてください"
```

**AIの出力例**:
```markdown
## PayloadData.php 未テストメソッド分析

### 優先度 HIGH（ビジネスロジック）
1. goodCount() - 良品数計算（32行）
2. defectiveCount() - 不良品数計算（28行）
3. cycleTimeMinutes() - サイクルタイム計算（15行）

### 優先度 MEDIUM（データ変換）
4. toArray() - 配列変換（42行）
5. fromJson() - JSON変換（38行）

### 優先度 LOW（Getter/Setter）
6. getLineId() - ID取得（1行）
7. setLineId() - ID設定（1行）
```

**Step 2: コード理解と仕様抽出**
```
# Claude Codeへの依頼
"goodCount()メソッドのロジックを読んで、
以下を教えてください：
1. このメソッドの責務
2. 入力パラメータと型
3. 期待される出力
4. エッジケース（空配列、null、負数など）
5. 依存する他のメソッド/クラス"
```

**AIの出力例**:
```markdown
## goodCount() 仕様分析

### 責務
- 生産ライン上の良品数を計算
- defectiveCountsを差し引いた純良品数を返す

### シグネチャ
```php
public function goodCount(): int
```

### ロジック
```php
return $this->totalCount - array_sum($this->defectiveCounts);
```

### エッジケース
1. totalCount = 0 → 0を返す
2. defectiveCounts = [] → totalCountをそのまま返す
3. defectiveCounts の合計 > totalCount → 負数になる（バグの可能性）
4. totalCount が負数 → 異常値

### 依存関係
- Property: $this->totalCount (int)
- Property: $this->defectiveCounts (array)

### テストすべきケース
✅ 正常系: totalCount=100, defective=[5,3,2] → 90
✅ 境界値: totalCount=0 → 0
✅ 境界値: defectiveCounts=[] → totalCount
⚠️ 異常系: defective合計 > totalCount
```

#### Phase 2: テスト設計フェーズ（AI + 人間）

**Step 3: テストケース設計**
```
# Claude Codeへの依頼
"goodCount()のテストケースを Given-When-Then 形式で設計してください。
PHPUnit、Laravel、Factoryパターンを使用します。"
```

**AIの出力例**:
```php
/**
 * Test Cases for goodCount()
 */

// TC1: 正常系 - 不良品がある場合
// Given: 総数100、不良品[5, 3, 2]
// When: goodCount()を呼ぶ
// Then: 90を返す

// TC2: 正常系 - 不良品がゼロ
// Given: 総数100、不良品[]
// When: goodCount()を呼ぶ
// Then: 100を返す

// TC3: 境界値 - 総数ゼロ
// Given: 総数0、不良品[]
// When: goodCount()を呼ぶ
// Then: 0を返す

// TC4: 異常系 - 不良品が総数を超える
// Given: 総数50、不良品[30, 30]
// When: goodCount()を呼ぶ
// Then: -10を返す（要修正の可能性）
```

**Step 4: 人間によるレビュー**
```
👤 ユーザーの確認ポイント:
1. ビジネスロジックとして正しいか？
2. テストケースに漏れはないか？
3. TC4（不良品超過）の挙動は仕様として正しいか？
   → 修正が必要なら先にコード修正
```

#### Phase 3: テスト実装フェーズ（AI主導）

**Step 5: テストコード生成**
```
# Claude Codeへの依頼
"設計したテストケースをPHPUnitで実装してください。
既存のテストファイル構造（Tests/Unit/Data/）に従ってください。"
```

**AIの実装例**:
```php
<?php

namespace Tests\Unit\Data;

use App\Data\PayloadData;
use Tests\TestCase;

class PayloadDataTest extends TestCase
{
    /** @test */
    public function good_count_calculates_correctly_with_defectives()
    {
        // Given
        $payload = new PayloadData(
            lineId: 1,
            defectiveCounts: [5, 3, 2],
            start: '2025-10-06 10:00:00',
            cycleTimeMs: 1000,
            overTimeMs: 500,
            plannedOutages: [],
            changeovers: [],
            indicator: true
        );
        // Assuming totalCount is set internally or via setter
        $payload->setTotalCount(100);

        // When
        $result = $payload->goodCount();

        // Then
        $this->assertEquals(90, $result);
    }

    /** @test */
    public function good_count_returns_total_when_no_defectives()
    {
        // Given
        $payload = new PayloadData(
            lineId: 1,
            defectiveCounts: [],
            start: '2025-10-06 10:00:00',
            cycleTimeMs: 1000,
            overTimeMs: 500,
            plannedOutages: [],
            changeovers: [],
            indicator: true
        );
        $payload->setTotalCount(100);

        // When
        $result = $payload->goodCount();

        // Then
        $this->assertEquals(100, $result);
    }

    /** @test */
    public function good_count_returns_zero_when_total_is_zero()
    {
        // Given
        $payload = new PayloadData(
            lineId: 1,
            defectiveCounts: [],
            start: '2025-10-06 10:00:00',
            cycleTimeMs: 1000,
            overTimeMs: 500,
            plannedOutages: [],
            changeovers: [],
            indicator: true
        );
        $payload->setTotalCount(0);

        // When
        $result = $payload->goodCount();

        // Then
        $this->assertEquals(0, $result);
    }

    /** @test */
    public function good_count_handles_defectives_exceeding_total()
    {
        // Given
        $payload = new PayloadData(
            lineId: 1,
            defectiveCounts: [30, 30],
            start: '2025-10-06 10:00:00',
            cycleTimeMs: 1000,
            overTimeMs: 500,
            plannedOutages: [],
            changeovers: [],
            indicator: true
        );
        $payload->setTotalCount(50);

        // When
        $result = $payload->goodCount();

        // Then
        // Note: This might be a bug - should this throw an exception instead?
        $this->assertEquals(-10, $result);
    }
}
```

**Step 6: テスト実行と調整**
```bash
# ユーザー操作
php artisan test --filter PayloadDataTest

# 失敗した場合
# Claude Codeへの依頼
"以下のエラーが出ました。修正してください：
[エラーメッセージをペースト]"
```

**AIの修正対応**:
```
分析:
- PayloadDataのコンストラクタにtotalCountパラメータがない
- setTotalCount()メソッドも存在しない
- totalCountは内部計算される（productionLinesから算出）

修正案:
- Factoryパターンでモックデータを作成
- または、実際のProductionLineと連携したテスト
```

#### Phase 4: カバレッジ検証フェーズ（AI補助）

**Step 7: カバレッジ再確認**
```bash
# ユーザー操作
php artisan test --coverage-html=coverage-report

# Claude Codeへの依頼
"PayloadData.phpのカバレッジが20%→60%になりました。
残りの40%の未カバー行を分析して、
次に追加すべきテストを教えてください。"
```

**Step 8: イテレーション**
```
Step 2に戻り、次のメソッド（defectiveCount()など）のテストを追加
```

---

## シナリオ2: 新規機能開発（テスト込み）

### 目的
新機能を TDD（Test-Driven Development）または BDD で実装

### 🔄 推奨ワークフロー（TDD Approach）

#### Phase 1: 仕様定義フェーズ（人間主導）

**Step 1: 要件の明確化**
```
👤 ユーザー:
"生産ラインの稼働率を計算する機能を追加したい。
- 稼働率 = 稼働時間 / (稼働時間 + 停止時間) × 100
- 計画停止は除外
- 結果はパーセンテージで返す"

🤖 Claude Code:
"要件を確認させてください：
1. 計画停止以外の停止は全て含めますか？（故障、段取り替え等）
2. 稼働率の範囲は 0-100% ですか？
3. データ取得期間はどう指定しますか？（開始日時-終了日時？）
4. どのクラスに実装しますか？（新規Service? 既存Modelに追加？）"
```

**Step 2: 仕様のフォーマル化**
```
# Claude Codeへの依頼
"以下の仕様を Given-When-Then 形式でテストケースにしてください"

要件:
- クラス名: ProductionEfficiencyService
- メソッド名: calculateOperationRate(Process $process, Carbon $start, Carbon $end): float
- 戻り値: 0.0 ~ 100.0 の float
```

**AIの出力例**:
```markdown
## calculateOperationRate() テストケース設計

### TC1: 正常系 - 停止なし
Given: 期間8時間、停止0時間、計画停止0時間
When: calculateOperationRate()
Then: 100.0を返す

### TC2: 正常系 - 故障停止あり
Given: 期間8時間、故障停止2時間、計画停止0時間
When: calculateOperationRate()
Then: 75.0を返す (6/8 * 100)

### TC3: 正常系 - 計画停止を除外
Given: 期間8時間、故障停止1時間、計画停止2時間
When: calculateOperationRate()
Then: 85.7を返す (6/7 * 100)

### TC4: 境界値 - 全て停止
Given: 期間8時間、停止8時間
When: calculateOperationRate()
Then: 0.0を返す

### TC5: 異常系 - 期間がゼロ
Given: start = end
When: calculateOperationRate()
Then: 例外をスロー（InvalidArgumentException）
```

#### Phase 2: テストファースト実装（TDD Red-Green-Refactor）

**Step 3: 🔴 RED - 失敗するテストを書く**
```
# Claude Codeへの依頼
"上記のTC1のテストを実装してください。
まだProductionEfficiencyServiceクラスは存在しません。"
```

**AIの実装例**:
```php
<?php

namespace Tests\Unit\Services;

use App\Services\ProductionEfficiencyService;
use App\Models\Process;
use Carbon\Carbon;
use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ProductionEfficiencyServiceTest extends TestCase
{
    use RefreshDatabase;

    private ProductionEfficiencyService $service;

    protected function setUp(): void
    {
        parent::setUp();
        $this->service = new ProductionEfficiencyService();
    }

    /** @test */
    public function calculates_100_percent_when_no_downtime()
    {
        // Given
        $process = Process::factory()->create();
        $start = Carbon::parse('2025-10-06 08:00:00');
        $end = Carbon::parse('2025-10-06 16:00:00'); // 8 hours

        // No downtime records created

        // When
        $rate = $this->service->calculateOperationRate($process, $start, $end);

        // Then
        $this->assertEquals(100.0, $rate);
    }
}
```

**実行**:
```bash
php artisan test --filter ProductionEfficiencyServiceTest

# 結果: 🔴 FAIL (クラスが存在しない)
Error: Class 'App\Services\ProductionEfficiencyService' not found
```

**Step 4: 🟢 GREEN - 最小限の実装でテストを通す**
```
# Claude Codeへの依頼
"テストが通るように、ProductionEfficiencyServiceクラスを実装してください。
最小限の実装で構いません。"
```

**AIの実装例**:
```php
<?php

namespace App\Services;

use App\Models\Process;
use Carbon\Carbon;

class ProductionEfficiencyService
{
    public function calculateOperationRate(Process $process, Carbon $start, Carbon $end): float
    {
        // Simplest implementation to pass TC1
        return 100.0;
    }
}
```

**実行**:
```bash
php artisan test --filter ProductionEfficiencyServiceTest

# 結果: 🟢 PASS
✓ calculates 100 percent when no downtime
```

**Step 5: 次のテストケース追加（TC2）**
```
# Claude Codeへの依頼
"TC2（故障停止あり）のテストを追加してください"
```

**AIの実装例**:
```php
/** @test */
public function calculates_correct_rate_with_breakdown_downtime()
{
    // Given
    $process = Process::factory()->create();
    $start = Carbon::parse('2025-10-06 08:00:00');
    $end = Carbon::parse('2025-10-06 16:00:00'); // 8 hours

    // 2 hours breakdown downtime
    ProductionHistory::factory()->create([
        'process_id' => $process->id,
        'status' => ProductionStatus::Breakdown,
        'start' => '2025-10-06 10:00:00',
        'stop' => '2025-10-06 12:00:00', // 2 hours
    ]);

    // When
    $rate = $this->service->calculateOperationRate($process, $start, $end);

    // Then
    $this->assertEquals(75.0, $rate); // (8-2)/8 * 100
}
```

**実行**:
```bash
php artisan test --filter ProductionEfficiencyServiceTest

# 結果: 🔴 FAIL
Expected: 75.0
Actual: 100.0
```

**Step 6: 🟢 GREEN - 実装を改善**
```
# Claude Codeへの依頼
"TC2が失敗しました。実装を修正してください。"
```

**AIの修正例**:
```php
public function calculateOperationRate(Process $process, Carbon $start, Carbon $end): float
{
    $totalMinutes = $start->diffInMinutes($end);

    // Get all downtime (excluding planned outages)
    $downtime = ProductionHistory::where('process_id', $process->id)
        ->whereBetween('start', [$start, $end])
        ->whereIn('status', [
            ProductionStatus::Breakdown,
            ProductionStatus::Changeover,
        ])
        ->get()
        ->sum(function ($history) {
            return Carbon::parse($history->start)
                ->diffInMinutes(Carbon::parse($history->stop));
        });

    $operationMinutes = $totalMinutes - $downtime;

    return ($operationMinutes / $totalMinutes) * 100;
}
```

**実行**:
```bash
php artisan test --filter ProductionEfficiencyServiceTest

# 結果: 🟢 PASS
✓ calculates 100 percent when no downtime
✓ calculates correct rate with breakdown downtime
```

**Step 7: 🔵 REFACTOR - リファクタリング**
```
# Claude Codeへの依頼
"現在の実装をレビューして、改善点を提案してください"
```

**AIの提案例**:
```markdown
## リファクタリング提案

### 問題点
1. N+1問題の可能性（get()→sum()）
2. マジックナンバー（100）
3. エッジケース未処理（totalMinutes = 0）
4. 計画停止の除外ロジックが不明確

### 改善案
```php
public function calculateOperationRate(Process $process, Carbon $start, Carbon $end): float
{
    $totalMinutes = $start->diffInMinutes($end);

    if ($totalMinutes === 0) {
        throw new InvalidArgumentException('Time period must be greater than zero');
    }

    $downtimeMinutes = $this->calculateDowntimeMinutes($process, $start, $end);
    $operationMinutes = max(0, $totalMinutes - $downtimeMinutes);

    return round(($operationMinutes / $totalMinutes) * 100, 2);
}

private function calculateDowntimeMinutes(Process $process, Carbon $start, Carbon $end): int
{
    return ProductionHistory::where('process_id', $process->id)
        ->whereBetween('start', [$start, $end])
        ->whereIn('status', $this->getDowntimeStatuses())
        ->sum(DB::raw('TIMESTAMPDIFF(MINUTE, start, stop)'));
}

private function getDowntimeStatuses(): array
{
    return [
        ProductionStatus::Breakdown,
        ProductionStatus::Changeover,
        // Planned outages are excluded
    ];
}
```
```

**Step 8: テストを追加してリファクタリング検証**
```php
/** @test */
public function throws_exception_when_time_period_is_zero()
{
    // Given
    $process = Process::factory()->create();
    $start = Carbon::parse('2025-10-06 08:00:00');
    $end = Carbon::parse('2025-10-06 08:00:00'); // Same time

    // Then
    $this->expectException(InvalidArgumentException::class);

    // When
    $this->service->calculateOperationRate($process, $start, $end);
}
```

**Step 9: 全テストケース実装完了まで繰り返し**
```
TC1 → TC2 → TC3 → TC4 → TC5
各テストを追加 → 実装 → リファクタリング → 次のテストへ
```

#### Phase 3: カバレッジ確認と統合（AI補助）

**Step 10: カバレッジ検証**
```bash
php artisan test --filter ProductionEfficiencyServiceTest --coverage

# Claude Codeへの依頼
"ProductionEfficiencyServiceのカバレッジレポートを確認してください。
100%になっているか、未カバー箇所があれば追加テストを提案してください。"
```

**Step 11: 統合テスト追加**
```
# Claude Codeへの依頼
"ProductionEfficiencyServiceを実際のコントローラーから呼び出す
Feature Testを作成してください。"
```

**AIの実装例**:
```php
<?php

namespace Tests\Feature\Controllers;

use Tests\TestCase;
use App\Models\User;
use App\Models\Process;

class ProductionEfficiencyControllerTest extends TestCase
{
    /** @test */
    public function displays_operation_rate_on_dashboard()
    {
        // Given
        $user = User::factory()->create();
        $process = Process::factory()->create();

        // When
        $response = $this->actingAs($user)
            ->get("/processes/{$process->id}/efficiency");

        // Then
        $response->assertOk();
        $response->assertViewHas('operationRate');
        $response->assertSee('稼働率');
    }
}
```

---

## ベストプラクティス比較

### シナリオ1（既存コードへのテスト追加）vs シナリオ2（新規機能開発）

| 観点 | 既存コードへのテスト追加 | 新規機能開発（TDD） |
|------|----------------------|-------------------|
| **開始点** | 実装コードが既に存在 | テストから始める |
| **AI依頼の焦点** | コード理解と仕様抽出 | 要件明確化とテスト設計 |
| **テストの役割** | 仕様ドキュメント化 + リグレッション防止 | 設計ガイド + 仕様保証 |
| **リスク** | 既存バグをテストで固定化する可能性 | 過剰設計になる可能性 |
| **カバレッジ目標** | 段階的（20%→40%→60%） | 最初から100% |
| **リファクタリング** | 慎重（動作変更リスク） | 積極的（テストが保証） |

---

## AI（Claude Code）の効果的な使い方

### ✅ AIに任せるべきこと

1. **コードの分析と理解**
   ```
   "このメソッドの責務と依存関係を教えてください"
   ```

2. **テストケースの洗い出し**
   ```
   "このロジックのエッジケースを全て列挙してください"
   ```

3. **ボイラープレートコードの生成**
   ```
   "このテストケースをPHPUnitで実装してください"
   ```

4. **エラーの診断と修正**
   ```
   "このエラーの原因と修正方法を教えてください"
   ```

5. **リファクタリング提案**
   ```
   "このコードの改善点を提案してください"
   ```

### ⚠️ 人間が判断すべきこと

1. **ビジネスロジックの正しさ**
   - AIはコードの構造は理解できるが、業務仕様は知らない
   - 「この計算式はビジネス要件として正しいか？」は人間が判断

2. **テスト戦略の決定**
   - どのメソッドを優先的にテストするか
   - カバレッジ目標（80%? 90%? 100%?）
   - 統合テストの範囲

3. **リファクタリングの是非**
   - AIは改善案を提示できるが、実施タイミングは人間が判断
   - 「今リファクタリングすべきか、後回しにするか」

4. **エッジケースの受容**
   - 「この異常系は例外をスローすべきか、デフォルト値を返すべきか」
   - ビジネスポリシーに依存する判断

---

## 推奨する対話パターン

### Pattern 1: 段階的詳細化
```
👤 "PayloadDataにテストを追加したい"
        ↓
🤖 "PayloadDataは32メソッドあります。どれから始めますか？"
        ↓
👤 "ビジネスロジックの重要度順で"
        ↓
🤖 "goodCount()が最重要です。このメソッドの仕様を分析します"
        ↓
👤 "OK、テストケースを設計して"
        ↓
🤖 [テストケース設計を提示]
        ↓
👤 "TC4の挙動は仕様として正しいか確認したい"
        ↓
🤖 "現在は負数を返しますが、例外をスローする方が安全かもしれません"
        ↓
👤 "じゃあ先にコード修正して"
```

### Pattern 2: イテレーティブ改善
```
👤 "新機能：稼働率計算を実装したい"
        ↓
🤖 "要件を確認させてください：[質問リスト]"
        ↓
👤 [回答]
        ↓
🤖 "テストケースを設計しました：TC1-TC5"
        ↓
👤 "TC1のテストを実装して"
        ↓
🤖 [テスト実装]
        ↓
👤 "実行したら失敗した（クラスがない）"
        ↓
🤖 "最小限の実装を作成しました"
        ↓
👤 "テスト通った。次のTC2を追加して"
        ↓
🤖 [TC2実装]
        ↓
👤 "失敗した"
        ↓
🤖 "実装を修正しました"
        ↓
... [繰り返し]
```

### Pattern 3: エラードリブン開発
```
👤 "テスト実行したらこのエラーが出た：[エラー貼り付け]"
        ↓
🤖 "原因：Factoryでリレーションが設定されていません"
        ↓
🤖 "修正案：[コード提示]"
        ↓
👤 "修正したけどまだエラー：[新しいエラー]"
        ↓
🤖 "次の原因：データベースのマイグレーションが必要です"
        ↓
... [エラーがなくなるまで繰り返し]
```

---

## 実践例: Data/PayloadData.php への完全テスト追加

### タイムライン（想定）

| フェーズ | 時間 | 作業内容 |
|---------|-----|---------|
| Phase 1 | 30分 | カバレッジ分析 + メソッド優先順位付け |
| Phase 2 | 2時間 | 上位10メソッドのテスト追加（AIが8割自動化） |
| Phase 3 | 1時間 | 残り22メソッドのテスト追加 |
| Phase 4 | 30分 | カバレッジ検証 + 未カバー箇所の追加テスト |
| **合計** | **4時間** | **0% → 90%+ カバレッジ達成** |

### 具体的な対話フロー例

#### 1回目のイテレーション（goodCount()）

```
👤 User:
"coverage-report/Data/PayloadData.php.html を見て、
テストを追加すべきメソッドを優先度順に10個教えてください"

🤖 Claude Code:
[ファイルを読み込み、分析]

優先度順メソッドリスト：
1. goodCount() - 良品数計算（ビジネスロジック）
2. defectiveCount() - 不良品数計算
3. cycleTimeMinutes() - サイクルタイム
4. toArray() - データ変換
... (省略)

👤 User:
"goodCount()の仕様を教えてください"

🤖 Claude Code:
[PayloadData.phpを読み込み]

## goodCount() 仕様
[先ほどの分析結果を出力]

👤 User:
"TC4（不良品超過）は仕様としておかしいので、
コードを修正してから例外をスローするようにしてください"

🤖 Claude Code:
[PayloadData.phpを修正]

```php
public function goodCount(): int
{
    $defectiveTotal = array_sum($this->defectiveCounts);

    if ($defectiveTotal > $this->totalCount) {
        throw new InvalidArgumentException(
            "Defective count ({$defectiveTotal}) exceeds total count ({$this->totalCount})"
        );
    }

    return $this->totalCount - $defectiveTotal;
}
```

修正完了。次にテストを実装しましょうか？

👤 User:
"はい、TC1-TC4のテストを実装してください"

🤖 Claude Code:
[Tests/Unit/Data/PayloadDataTest.php を作成]

```php
<?php
namespace Tests\Unit\Data;
// [完全なテストコード]
```

実装完了。実行してください：
`php artisan test --filter PayloadDataTest::good_count`

👤 User:
[実行]
"全部通りました！"

🤖 Claude Code:
素晴らしい！goodCount()のカバレッジは100%になりました。
次は defectiveCount() に進みますか？

👤 User:
"はい、同じ流れでお願いします"

🤖 Claude Code:
[defectiveCount()の分析開始...]
```

---

## SonarQube MCP との連携

### テスト追加後の品質確認フロー

```
👤 User:
"PayloadDataのテストを全部追加したので、
SonarQubeで品質チェックしてください"

🤖 Claude Code:
[SonarQube MCP を使用]

## PayloadData.php の品質分析結果

### Before（テスト追加前）
- Coverage: 0%
- Issues: 3件
  - MAJOR: 32メソッド（上限20超過）
  - MAJOR: return文4個（上限3超過）
  - MAJOR: コメントアウトコード7箇所

### After（テスト追加後）
- Coverage: 92%（+92%！）
- Issues: 依然3件（テスト追加ではIssue解消されず）

### 推奨アクション
1. クラス分割でメソッド数削減
2. return文のリファクタリング
3. コメントアウトコード削除

👤 User:
"じゃあクラス分割を提案してください"

🤖 Claude Code:
[リファクタリング提案...]
```

---

## まとめ: AI駆動開発における黄金則

### 🥇 既存コードへのテスト追加

```
1. AIに分析させる（カバレッジ、優先度、仕様）
2. 人間が判断する（ビジネスロジックの正しさ）
3. AIにテスト生成させる
4. 人間が実行して確認
5. エラーがあればAIに修正させる
6. カバレッジが上がるまで繰り返し
```

**時間配分**: AI 80% | 人間 20%

### 🥇 新規機能開発（TDD）

```
1. 人間が要件を定義
2. AIに質問させて要件を明確化
3. AIにテストケース設計させる
4. 人間がレビュー（ビジネスロジック検証）
5. AIにテスト実装させる（RED）
6. AIに最小実装させる（GREEN）
7. 人間が次のテストを指示
8. AIに実装改善させる（GREEN）
9. AIにリファクタリング提案させる（REFACTOR）
10. 人間が判断して実施
```

**時間配分**: AI 70% | 人間 30%

### 🎯 成功の鍵

1. **AIに「なぜ」を聞く**: "このエッジケースが必要な理由は？"
2. **人間が「何を」決める**: "これはビジネスロジックとして正しいか？"
3. **AIに「どうやって」任せる**: "このテストケースを実装して"
4. **小さく反復する**: 1メソッドずつ、1テストケースずつ
5. **常にフィードバックループ**: 実行 → エラー → 修正 → 再実行

この方法で、YokaKitの未テストコード（1,489行）も効率的にカバレッジ90%+まで引き上げられます！
