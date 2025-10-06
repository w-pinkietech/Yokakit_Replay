# ソフトウェアテストの種類 - 完全ガイド

## 📚 目次

1. [テストピラミッド（全体像）](#テストピラミッド全体像)
2. [テストの分類軸](#テストの分類軸)
3. [テスト種類の詳細](#テスト種類の詳細)
4. [YokaKitでの実例](#yokakitでの実例)
5. [どのテストをいつ書くか](#どのテストをいつ書くか)

---

## テストピラミッド（全体像）

### 基本概念

```
           ┌─────────────────┐
          /    E2E Tests      \    ← 少ない（遅い、高コスト）
         /      (UI Tests)     \      10-20個
        /─────────────────────\
       /   Integration Tests    \   ← 中程度
      /    (Feature Tests)       \    100-200個
     /───────────────────────────\
    /        Unit Tests            \ ← 多い（速い、低コスト）
   /   (単体テスト)                 \  1000+個
  /───────────────────────────────\
```

### 黄金比率

| テスト種類 | 割合 | 数 | 実行時間 | コスト |
|-----------|-----|-----|---------|--------|
| Unit Tests | 70% | 1000+ | 秒単位 | 低 |
| Integration Tests | 20% | 200-300 | 分単位 | 中 |
| E2E Tests | 10% | 10-50 | 分-時間 | 高 |

### なぜピラミッド型？

**❌ アンチパターン（逆ピラミッド）**:
```
  ┌───────────────┐
  │  E2E Tests    │ 500個  ← 遅すぎて実行できない
  │───────────────│
  │ Integration   │ 100個
  │───────────────│
 /  Unit Tests    \ 50個   ← 少なすぎて役に立たない
/─────────────────\
```

**✅ 正しいピラミッド**:
- **速い**: 開発中に何度も実行できる
- **安い**: 保守コストが低い
- **安定**: 外部依存が少なく壊れにくい

---

## テストの分類軸

### 軸1: テストスコープ（範囲）

```
単一関数 → クラス → モジュール → システム全体
   ↓          ↓         ↓           ↓
  Unit    Integration  Feature     E2E
```

### 軸2: テスト目的

| 目的 | テスト種類 |
|------|----------|
| **機能が動くか** | Functional Tests（機能テスト） |
| **性能は十分か** | Performance Tests（性能テスト） |
| **セキュリティは安全か** | Security Tests（セキュリティテスト） |
| **使いやすいか** | Usability Tests（ユーザビリティテスト） |

### 軸3: テストの知識レベル

| 知識レベル | テスト種類 | 説明 |
|-----------|----------|------|
| **ホワイトボックス** | Unit Tests | コード内部構造を知っている |
| **グレーボックス** | Integration Tests | 一部の内部構造を知っている |
| **ブラックボックス** | E2E Tests | 内部構造を知らない（ユーザー視点） |

### 軸4: テストの自動化レベル

| レベル | テスト種類 |
|--------|----------|
| **完全自動** | Unit, Integration, E2E（CI/CD） |
| **半自動** | Visual Regression Tests |
| **手動** | Exploratory Tests（探索的テスト） |

---

## テスト種類の詳細

### 1️⃣ Unit Tests（単体テスト）

#### 定義
**1つの関数/メソッド/クラス**を独立してテストする

#### 特徴
- ✅ **最も速い**（1テスト < 10ms）
- ✅ **最も安い**（書きやすい、保守しやすい）
- ✅ **最も安定**（外部依存なし）
- ❌ **統合の問題は検出できない**

#### YokaKit での例

```php
<?php
// Tests/Unit/Models/LineTest.php

namespace Tests\Unit\Models;

use App\Models\Line;
use Tests\TestCase;

class LineTest extends TestCase
{
    /** @test */
    public function pin_number_formatting_adds_leading_zero()
    {
        // Given: ピン番号が1桁
        $line = new Line(['pin_number' => 5]);

        // When: フォーマットされたピン番号を取得
        $formatted = $line->formattedPinNumber();

        // Then: 先頭にゼロが付く
        $this->assertEquals('05', $formatted);
    }

    /** @test */
    public function defective_line_is_excluded_from_production()
    {
        // Given: 不良ラインを作成
        $line = Line::factory()->create(['defective' => true]);

        // When: 生産可能ラインを取得
        $productionLines = Line::productionLines()->get();

        // Then: 不良ラインは含まれない
        $this->assertNotContains($line->id, $productionLines->pluck('id'));
    }
}
```

#### いつ書く？
- ✅ **ビジネスロジック**がある関数/メソッド
- ✅ **複雑な計算**（稼働率計算、サイクルタイム計算など）
- ✅ **条件分岐**が多い処理
- ✅ **データ変換**（JSON→配列、フォーマット等）
- ❌ Getter/Setterのみのシンプルなプロパティ

---

### 2️⃣ Integration Tests（統合テスト）

#### 定義
**複数のクラス/モジュール**を組み合わせてテストする

#### 特徴
- ✅ **統合の問題を検出**（A単体とB単体は動くが、組み合わせると失敗）
- ✅ **実際のDBやAPIを使用**
- ⚠️ **Unit Testsより遅い**（1テスト < 100ms）
- ❌ **外部依存があるため不安定になりやすい**

#### YokaKit での例

```php
<?php
// Tests/Unit/Repositories/ProductionHistoryRepositoryTest.php

namespace Tests\Unit\Repositories;

use App\Repositories\ProductionHistoryRepository;
use App\Models\ProductionHistory;
use App\Models\Process;
use App\Enums\ProductionStatus;
use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ProductionHistoryRepositoryTest extends TestCase
{
    use RefreshDatabase;

    private ProductionHistoryRepository $repository;

    protected function setUp(): void
    {
        parent::setUp();
        $this->repository = new ProductionHistoryRepository();
    }

    /** @test */
    public function store_history_creates_new_production_history()
    {
        // Given: プロセスと設定データ
        $process = Process::factory()->create();
        $data = [
            'process_id' => $process->id,
            'status' => ProductionStatus::Running,
            'goal' => 100,
        ];

        // When: リポジトリ経由で保存
        $history = $this->repository->storeHistory($data);

        // Then: DBに保存され、正しい値が設定される
        $this->assertDatabaseHas('production_histories', [
            'id' => $history->id,
            'process_id' => $process->id,
            'status' => ProductionStatus::Running->value,
            'goal' => 100,
        ]);
    }

    /** @test */
    public function histories_returns_paginated_results()
    {
        // Given: 15件の生産履歴
        $process = Process::factory()->create();
        ProductionHistory::factory()->count(15)->create([
            'process_id' => $process->id,
        ]);

        // When: ページサイズ10で取得
        $paginator = $this->repository->histories($process->id, 10);

        // Then: 最初のページに10件、合計15件
        $this->assertCount(10, $paginator->items());
        $this->assertEquals(15, $paginator->total());
        $this->assertEquals(2, $paginator->lastPage());
    }
}
```

#### Unit Testsとの違い

| 観点 | Unit Tests | Integration Tests |
|------|-----------|------------------|
| **DB使用** | ❌ モック | ✅ 実際のDB（テスト用） |
| **複数クラス** | ❌ 1クラスのみ | ✅ 複数クラス連携 |
| **外部API** | ❌ モック | ⚠️ テスト用APIまたはモック |
| **速度** | 超高速（< 10ms） | 高速（< 100ms） |

---

### 3️⃣ Feature Tests（機能テスト）

#### 定義
**HTTPリクエスト→レスポンス**のフロー全体をテストする（Laravelの用語）

#### 特徴
- ✅ **エンドツーエンドの動作確認**（Controller → Service → Repository → DB）
- ✅ **ユーザーシナリオに近い**
- ⚠️ **Integration Testsより遅い**（1テスト < 500ms）
- ❌ **失敗原因の特定が難しい**（どこで問題が起きたか分かりにくい）

#### YokaKit での例

```php
<?php
// Tests/Feature/Controllers/ProductionHistoryControllerTest.php

namespace Tests\Feature\Controllers;

use App\Models\User;
use App\Models\Process;
use App\Models\ProductionHistory;
use App\Enums\ProductionStatus;
use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ProductionHistoryControllerTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function authenticated_user_can_view_production_histories()
    {
        // Given: 認証済みユーザーとプロセス、履歴
        $user = User::factory()->create();
        $process = Process::factory()->create();
        $histories = ProductionHistory::factory()->count(5)->create([
            'process_id' => $process->id,
        ]);

        // When: 生産履歴一覧ページにアクセス
        $response = $this->actingAs($user)
            ->get("/processes/{$process->id}/histories");

        // Then: 200 OKで履歴が表示される
        $response->assertOk();
        $response->assertViewHas('histories');
        foreach ($histories as $history) {
            $response->assertSee($history->id);
        }
    }

    /** @test */
    public function unauthenticated_user_is_redirected_to_login()
    {
        // Given: 未認証状態
        $process = Process::factory()->create();

        // When: 生産履歴ページにアクセス
        $response = $this->get("/processes/{$process->id}/histories");

        // Then: ログインページにリダイレクト
        $response->assertRedirect('/login');
    }

    /** @test */
    public function user_can_create_new_production_history()
    {
        // Given: 認証済みユーザーとプロセス
        $user = User::factory()->create();
        $process = Process::factory()->create();

        // When: 生産開始のPOSTリクエスト
        $response = $this->actingAs($user)
            ->post("/processes/{$process->id}/histories", [
                'status' => ProductionStatus::Running->value,
                'goal' => 100,
            ]);

        // Then: リダイレクトされ、DBに保存される
        $response->assertRedirect();
        $this->assertDatabaseHas('production_histories', [
            'process_id' => $process->id,
            'status' => ProductionStatus::Running->value,
            'goal' => 100,
        ]);
    }

    /** @test */
    public function validation_fails_with_invalid_data()
    {
        // Given: 認証済みユーザー
        $user = User::factory()->create();
        $process = Process::factory()->create();

        // When: 不正なデータでPOST
        $response = $this->actingAs($user)
            ->post("/processes/{$process->id}/histories", [
                'status' => 'invalid_status',  // 不正な値
                'goal' => -10,  // 負数
            ]);

        // Then: 422バリデーションエラー
        $response->assertStatus(422);
        $response->assertSessionHasErrors(['status', 'goal']);
    }
}
```

#### Feature Testsのカバー範囲

```
HTTP Request
    ↓
[Middleware] ← 認証チェック等
    ↓
[Route]
    ↓
[Controller] ← バリデーション
    ↓
[Service] ← ビジネスロジック
    ↓
[Repository] ← データ永続化
    ↓
[Database]
    ↓
HTTP Response
```

**全て**がテストされる！

---

### 4️⃣ E2E Tests（エンドツーエンドテスト）

#### 定義
**実際のブラウザ**を使って、ユーザーの操作を再現するテスト

#### 特徴
- ✅ **最もユーザー体験に近い**
- ✅ **JavaScript動作も検証**（Ajaxリクエスト、動的UI等）
- ✅ **クロスブラウザテスト可能**
- ❌ **最も遅い**（1テスト 数秒〜数分）
- ❌ **最も不安定**（タイミング問題、ネットワークエラー等）
- ❌ **保守コストが高い**

#### YokaKit での例（Laravel Dusk）

```php
<?php
// Tests/Browser/ProductionFlowTest.php

namespace Tests\Browser;

use App\Models\User;
use App\Models\Process;
use Laravel\Dusk\Browser;
use Tests\DuskTestCase;

class ProductionFlowTest extends DuskTestCase
{
    /** @test */
    public function user_can_complete_full_production_cycle()
    {
        $user = User::factory()->create();
        $process = Process::factory()->create();

        $this->browse(function (Browser $browser) use ($user, $process) {
            $browser
                // ログイン
                ->visit('/login')
                ->type('email', $user->email)
                ->type('password', 'password')
                ->press('ログイン')
                ->assertPathIs('/home')

                // プロセス選択
                ->visit("/processes/{$process->id}")
                ->assertSee($process->name)

                // 生産開始
                ->press('生産開始')
                ->waitForText('生産中')
                ->assertSee('稼働中')

                // 良品カウント追加
                ->press('良品+1')
                ->pause(500)
                ->assertSee('良品数: 1')

                // 不良品記録
                ->press('不良品記録')
                ->waitFor('#defective-modal')
                ->select('defective_type', '傷')
                ->press('記録')
                ->waitUntilMissing('#defective-modal')

                // 生産停止
                ->press('生産停止')
                ->waitForText('停止確認')
                ->press('確定')
                ->assertSee('生産完了');

            // DB確認
            $this->assertDatabaseHas('production_histories', [
                'process_id' => $process->id,
                'status' => 'complete',
            ]);
        });
    }

    /** @test */
    public function andon_display_updates_in_realtime()
    {
        $process = Process::factory()->create();

        $this->browse(function (Browser $browser1, Browser $browser2) use ($process) {
            // ブラウザ1: アンドン表示画面
            $browser1
                ->visit('/andon')
                ->assertSee($process->name)
                ->assertDontSee('異常停止');

            // ブラウザ2: 管理画面で異常停止を発生させる
            $browser2
                ->loginAs(User::factory()->admin()->create())
                ->visit("/processes/{$process->id}")
                ->press('緊急停止')
                ->press('確定');

            // ブラウザ1: リアルタイムで更新されるか確認
            $browser1
                ->waitForText('異常停止', 5)  // 5秒以内に表示されるはず
                ->assertSee('異常停止')
                ->assertHasClass("#process-{$process->id}", 'alert-danger');
        });
    }
}
```

#### E2E Testsのツール比較

| ツール | 言語 | 速度 | 難易度 | YokaKitでの使用 |
|-------|------|-----|--------|----------------|
| **Laravel Dusk** | PHP | 中 | 低 | ✅ 推奨 |
| **Cypress** | JavaScript | 高 | 中 | ⚠️ API分離が必要 |
| **Playwright** | JS/Python/C# | 高 | 中 | ⚠️ API分離が必要 |
| **Selenium** | 多言語 | 低 | 高 | ❌ 非推奨（古い） |

---

### 5️⃣ Regression Tests（回帰テスト）

#### 定義
既存機能が**壊れていないことを確認**するテスト

#### 特徴
- ✅ **リファクタリング時に必須**
- ✅ **既存のUnit/Integration/Feature Testsを再実行**
- ⚠️ **テストスイート全体の実行時間が課題**

#### YokaKit での例

```bash
# 全テスト実行（回帰テスト）
php artisan test

# 結果
Tests:    425 passed (2347 assertions)
Duration: 12.24s
```

#### CI/CD での自動化

```yaml
# .github/workflows/regression.yml
name: Regression Tests

on:
  pull_request:
    branches: [main]

jobs:
  regression:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run All Tests
        run: php artisan test
      - name: Check Coverage
        run: php artisan test --coverage --min=80
```

---

### 6️⃣ Smoke Tests（スモークテスト）

#### 定義
システムの**基本機能が動くか**を素早く確認するテスト

#### 特徴
- ✅ **最小限のテスト**（数分で完了）
- ✅ **デプロイ直後に実行**
- ✅ **重大な問題を早期発見**
- ❌ **詳細な問題は検出できない**

#### YokaKit での例

```php
<?php
// Tests/Smoke/BasicSmokeTest.php

namespace Tests\Smoke;

use Tests\TestCase;

class BasicSmokeTest extends TestCase
{
    /** @test */
    public function application_loads()
    {
        $response = $this->get('/');
        $response->assertOk();
    }

    /** @test */
    public function database_is_accessible()
    {
        $this->assertDatabaseCount('users', '>', 0);
    }

    /** @test */
    public function login_page_loads()
    {
        $response = $this->get('/login');
        $response->assertOk();
        $response->assertSee('ログイン');
    }

    /** @test */
    public function api_health_check()
    {
        $response = $this->getJson('/api/health');
        $response->assertOk();
        $response->assertJson(['status' => 'healthy']);
    }
}
```

#### デプロイパイプラインでの位置づけ

```
Deploy to Staging
    ↓
🔥 Smoke Tests (5分)
    ↓ PASS
Deploy to Production
    ↓
🔥 Smoke Tests (5分)
    ↓ PASS
Monitor
```

---

### 7️⃣ Performance Tests（性能テスト）

#### 定義
システムの**速度・スループット・リソース使用量**を測定するテスト

#### サブカテゴリ

##### 7-1. Load Testing（負荷テスト）
**通常の負荷**でのパフォーマンスを確認

```php
// 例: 100ユーザーが同時アクセス
for ($i = 0; $i < 100; $i++) {
    dispatch(new SimulateUserRequest());
}
```

##### 7-2. Stress Testing（ストレステスト）
**限界まで負荷をかけて**破綻点を見つける

```
ユーザー数: 10 → 100 → 1000 → 10000 → ...
どこで崩壊するか？
```

##### 7-3. Spike Testing（スパイクテスト）
**急激な負荷増加**に耐えられるか

```
通常: 100 req/s
突然: 10000 req/s ← 耐えられる？
```

##### 7-4. Endurance Testing（耐久テスト）
**長時間の運用**でメモリリークなどがないか

```
24時間連続で1000 req/s
→ メモリ使用量が増え続ける？
```

#### YokaKit での例（Apache JMeter使用）

```xml
<!-- jmeter/production_load_test.jmx -->
<ThreadGroup>
  <stringProp name="ThreadGroup.num_threads">100</stringProp>
  <stringProp name="ThreadGroup.ramp_time">60</stringProp>
  <stringProp name="ThreadGroup.duration">300</stringProp>

  <HTTPSamplerProxy>
    <stringProp name="HTTPSampler.domain">localhost</stringProp>
    <stringProp name="HTTPSampler.path">/processes/1/histories</stringProp>
    <stringProp name="HTTPSampler.method">GET</stringProp>
  </HTTPSamplerProxy>

  <ResultCollector>
    <Assertion>
      <collectionProp>
        <stringProp>response_time < 500ms</stringProp>
        <stringProp>error_rate < 1%</stringProp>
      </collectionProp>
    </Assertion>
  </ResultCollector>
</ThreadGroup>
```

#### 結果の見方

```
Target: 100 concurrent users
Duration: 5 minutes

Results:
  Average Response Time: 234ms ✅
  95th Percentile: 456ms ✅
  Max Response Time: 1.2s ⚠️
  Error Rate: 0.3% ✅
  Throughput: 450 req/s ✅
```

---

### 8️⃣ Security Tests（セキュリティテスト）

#### 定義
システムの**脆弱性**を見つけるテスト

#### サブカテゴリ

##### 8-1. Vulnerability Scanning（脆弱性スキャン）
既知の脆弱性をチェック

```bash
# SonarQube（YokaKitで使用中）
./vendor/bin/sonar-scanner

# 結果
Vulnerabilities: 0 ✅
Security Hotspots: 2 ⚠️
```

##### 8-2. Penetration Testing（侵入テスト）
攻撃者の視点でシステムを攻撃

```bash
# OWASP ZAP（自動ペンテスト）
zap-cli quick-scan http://localhost:8000

# 検出例
- SQL Injection vulnerability in /search?q=
- XSS vulnerability in /comments
```

##### 8-3. Authentication & Authorization Tests
認証・認可の抜け穴をチェック

```php
/** @test */
public function non_admin_cannot_delete_users()
{
    // Given: 一般ユーザー
    $user = User::factory()->create(['role' => Role::User]);
    $targetUser = User::factory()->create();

    // When: 他ユーザーの削除を試みる
    $response = $this->actingAs($user)
        ->delete("/users/{$targetUser->id}");

    // Then: 403 Forbidden
    $response->assertForbidden();
    $this->assertDatabaseHas('users', ['id' => $targetUser->id]);
}
```

##### 8-4. CSRF/XSS/SQL Injection Tests

```php
/** @test */
public function csrf_token_is_required()
{
    $response = $this->post('/login', [
        'email' => 'test@example.com',
        'password' => 'password',
    ], [
        'X-CSRF-TOKEN' => 'invalid-token'  // 不正なトークン
    ]);

    $response->assertStatus(419);  // CSRF token mismatch
}

/** @test */
public function xss_attempt_is_sanitized()
{
    $response = $this->post('/comments', [
        'body' => '<script>alert("XSS")</script>',
    ]);

    $response->assertDontSee('<script>', false);  // エスケープされる
    $response->assertSee('&lt;script&gt;');
}
```

---

### 9️⃣ その他の特殊テスト

#### 9-1. Mutation Testing（変異テスト）
既に説明した通り、テストの品質を検証

#### 9-2. Property-Based Testing
ランダム入力で不変条件を検証

#### 9-3. Visual Regression Testing（ビジュアル回帰テスト）
UI の見た目が変わっていないか確認

```bash
# Percy.io を使った例
npm install --save-dev @percy/cli @percy/cypress

# スナップショット撮影
cy.percySnapshot('Production Dashboard');

# 差分検出
Percy detects visual changes:
  ❌ Button color changed (red → blue)
  ❌ Table layout shifted 5px
```

#### 9-4. Accessibility Testing（アクセシビリティテスト）
障害者が使えるか確認（WCAG準拠）

```php
/** @test */
public function form_has_proper_labels()
{
    $response = $this->get('/login');

    // すべてのinputにlabelがあるか
    $response->assertSee('<label for="email">', false);
    $response->assertSee('<input id="email"', false);
}
```

#### 9-5. Exploratory Testing（探索的テスト）
**手動で自由に**システムを触ってバグを探す

- スクリプト化されていない
- テスターの経験と直感に依存
- 自動テストでは見つからないUX問題を発見

---

## YokaKitでの実例

### 現状のテスト構成（425テスト）

```
YokaKit/tests/
├── Unit/                           # 94 tests - ユニットテスト
│   ├── Models/                     # 51 tests
│   │   ├── LineTest.php           # 5 tests
│   │   ├── ProcessTest.php        # 23 tests
│   │   ├── ProductionHistoryTest.php  # 27 tests
│   │   └── UserTest.php           # 18 tests
│   ├── Repositories/              # 26 tests
│   │   ├── AbstractRepositoryTest.php
│   │   ├── ProcessRepositoryTest.php
│   │   └── ProductionHistoryRepositoryTest.php
│   └── Services/                  # 15 tests
│       ├── AndonServiceTest.php
│       └── SwitchServiceTest.php
├── Feature/                       # 331 tests - 機能テスト
│   ├── Controllers/               # 256 tests
│   │   ├── LineControllerTest.php     # 35 tests
│   │   ├── PartNumberControllerTest.php  # 31 tests
│   │   ├── ProcessControllerTest.php     # 23 tests
│   │   ├── ProductionHistoryControllerTest.php  # 20 tests
│   │   ├── SensorControllerTest.php      # 28 tests
│   │   ├── SwitchControllerTest.php      # 18 tests
│   │   └── UserControllerTest.php        # 44 tests
│   ├── BasicRoutesTest.php        # 3 tests
│   └── AndonControllerTest.php    # 7 tests
└── Browser/                       # 0 tests - E2Eテスト（未実装）
    └── (empty)
```

### テスト分布の分析

| カテゴリ | 数 | 割合 | 理想 | 評価 |
|---------|-----|------|------|------|
| Unit Tests | 94 | 22% | 70% | ❌ 不足 |
| Feature Tests | 331 | 78% | 20% | ⚠️ 過剰 |
| E2E Tests | 0 | 0% | 10% | ❌ 未実装 |

**問題点**:
- Unit Testsが少なすぎる（22% vs 理想70%）
- Feature Testsが多すぎる（78% vs 理想20%）
- E2E Testsが全くない

**改善策**:
1. **Data/PayloadData.php** など未テストクラスにUnit Tests追加
2. Feature Testsの一部をUnit Testsに分解
3. 重要フロー（ログイン→生産開始→完了）のE2E Tests追加

---

## どのテストをいつ書くか

### フェーズ別推奨テスト

#### Phase 1: 開発初期
```
✅ Unit Tests (70%)
   - 新規ビジネスロジック全て
   - 計算、変換、バリデーション

⚠️ Integration Tests (20%)
   - Repository層（DB連携）
   - Service層（複数クラス連携）

❌ E2E Tests (0%)
   - まだ早い（UIが固まっていない）
```

#### Phase 2: 機能開発中
```
✅ Unit Tests (継続)
   - 新規メソッド毎に追加

✅ Feature Tests (追加)
   - HTTPエンドポイント毎に追加
   - バリデーションテスト

⚠️ E2E Tests (少しずつ)
   - 主要フローのみ（ログイン、CRUD）
```

#### Phase 3: リリース前
```
✅ Regression Tests
   - 全テストスイート実行

✅ Performance Tests
   - 負荷テスト実施

✅ Security Tests
   - 脆弱性スキャン

✅ E2E Tests (強化)
   - ユーザーシナリオ網羅
```

#### Phase 4: 運用中
```
✅ Smoke Tests
   - デプロイ後の動作確認

✅ Monitoring Tests
   - 本番環境のヘルスチェック

✅ Exploratory Tests
   - 手動でのバグ探索
```

### 機能別推奨テスト

| 機能タイプ | Unit | Integration | Feature | E2E |
|-----------|------|-------------|---------|-----|
| **計算ロジック** | ✅✅✅ | - | - | - |
| **データ変換** | ✅✅✅ | ⚠️ | - | - |
| **DB操作** | ⚠️ | ✅✅✅ | ⚠️ | - |
| **API** | ⚠️ | ✅✅ | ✅✅✅ | - |
| **認証** | - | ✅ | ✅✅✅ | ⚠️ |
| **UI操作** | - | - | ⚠️ | ✅✅✅ |
| **リアルタイム** | - | - | - | ✅✅✅ |

### コスト vs 価値マトリクス

```
高価値
 ↑
 │  Unit Tests        Feature Tests
 │  (計算ロジック)     (重要フロー)
 │       ●                 ●
 │
 │  Integration Tests  E2E Tests
 │  (DB操作)          (全体フロー)
 │       ●                 ●
 │
 └────────────────────────────→ 高コスト
低コスト                      高コスト
```

---

## まとめ: テストの選び方

### 簡単な判断基準

```
この関数/機能をテストしたい...

Q1: 外部依存（DB/API）がある？
  NO → Unit Test
  YES → Q2へ

Q2: HTTPリクエストが関係する？
  NO → Integration Test
  YES → Q3へ

Q3: ブラウザ操作が必要？
  NO → Feature Test
  YES → E2E Test
```

### 迷ったら

**「速いテストから書く」原則**:
```
Unit Test で書けるか試す
  ↓ できない
Integration Test で書けるか試す
  ↓ できない
Feature Test で書く
  ↓ それでも不十分
E2E Test を追加
```

### YokaKitへの適用

**現状**:
- Unit: 94 (22%)
- Feature: 331 (78%)
- E2E: 0 (0%)

**目標** (1年後):
- Unit: 700 (70%)
- Feature: 200 (20%)
- E2E: 100 (10%)

**アクション**:
1. 未カバーのビジネスロジックにUnit Tests追加（+600テスト）
2. Feature Testsの一部をUnit/Integrationに分解（-130テスト）
3. 主要フローのE2E Tests追加（+100テスト）

**所要時間見積もり**:
- Unit Tests追加: 200時間（AI駆動で80%削減）
- リファクタリング: 40時間
- E2E Tests追加: 80時間
- **合計: 320時間 ≈ 2ヶ月**（1人月×2）

これで、YokaKitのテストピラミッドが健全化します！
