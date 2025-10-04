# Phase 2 修正が必要な項目

## 🚨 重大な憲法違反（Constitutional Violations）

### 1. compose.yml - 完全にpinkieit命名のまま

**現状**:
```yaml
image: pinkieit-web-app
container_name: pinkieit-web-app
networks:
  - pinkieit
MARIADB_DATABASE: ${DB_DATABASE:-pinkieit}
MARIADB_USER: ${DB_USERNAME:-pinkieit}
```

**必要な修正**:
```yaml
image: yokakit-web-app
container_name: yokakit-web-app
networks:
  - yokakit
MARIADB_DATABASE: ${DB_DATABASE:-yokakit}
MARIADB_USER: ${DB_USERNAME:-yokakit}
```

**影響**: 全コンテナ名・ネットワーク名がpinkieitで起動
**優先度**: 🔴 最高

---

## ⚠️ アプリケーション動作の問題

### 2. Volume mount によるvendor隠蔽

**現状**:
```yaml
volumes:
  - ./app/laravel:/var/www/html  # for development only
```

**問題**:
- Dockerfileでビルドした`vendor/`ディレクトリがマウントで隠される
- `composer install`の成果物が使えない
- `vendor/autoload.php`が見つからずLaravel起動不可

**解決策**:
1. **開発環境用**: volumeマウントを維持し、ホスト側で`composer install`実行
2. **検証用**: volumeマウントを削除してDockerイメージのvendorを使用
3. **推奨**: named volumeで`vendor`だけ永続化

```yaml
volumes:
  - ./app/laravel:/var/www/html
  - vendor-data:/var/www/html/vendor  # vendorは別volume
```

**優先度**: 🟠 高

### 3. .env ファイルの不在

**現状**: YokaKitルートに`.env`が存在しない

**必要な対応**:
- `.env.example`から`.env`作成済み（検証時に作成）
- `DB_PASSWORD`などの環境変数設定が必要
- Dockerfileは`.env`をCOPYするが、開発環境ではvolume mountで上書き

**優先度**: 🟡 中

---

## 📋 修正手順（推奨）

### Step 1: compose.yml の憲法遵守修正

```bash
cd /mnt/shared_data/YokaKit_Replay/YokaKit

# pinkieit → yokakit 一括置換
sed -i 's/pinkieit/yokakit/g' compose.yml

# 確認
grep -i "pinkieit" compose.yml  # 結果なしを期待
```

### Step 2: Volume mount 対策（2つの選択肢）

**選択肢A - 開発環境として動作させる**:
```bash
# ホスト側でcomposer install
cd app/laravel
composer install
cd ../..

# または、コンテナ内で実行
docker compose run --rm web-app composer install
```

**選択肢B - 検証用にvolume mountを無効化**:
```yaml
# compose.ymlから以下を削除
# volumes:
#   - ./app/laravel:/var/www/html
```

### Step 3: .env 設定

```bash
# 既に作成済みだが、必要な設定を追加
cat >> .env << 'EOF'
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=yokakit
DB_USERNAME=yokakit
DB_PASSWORD=yokakit_password
EOF
```

### Step 4: 再ビルド＆起動

```bash
# 古いコンテナ・イメージを削除
docker compose down -v
docker rmi yokakit-web-app

# 再ビルド
DOCKER_BUILDKIT=1 docker build -t yokakit-web-app .

# 起動
docker compose up -d

# 確認
docker compose ps
docker compose logs web-app
```

### Step 5: 憲法遵守確認

```bash
# コンテナ名確認
docker ps --format "{{.Names}}" | grep -E "yokakit|pinkieit"
# 期待: yokakit のみ

# ネットワーク名確認
docker network ls | grep -E "yokakit|pinkieit"
# 期待: yokakit のみ

# 設定確認
docker compose config | grep -i "pinkieit"
# 期待: 結果なし
```

---

## 🔍 根本原因分析

### なぜcompose.ymlが戻ってしまったか

1. **T009**: PinkieIt f9340aaからcompose.ymlを抽出＆yokakit置換 ✅
2. **T022**: `target: production` → `development`に変更時、**sedで直接ファイル編集せずEditツール使用**
3. **Editツール**: 古いcompose.ymlの一部だけ書き換え、**pinkieit命名が残存**

### 教訓

- ファイル全体の変換を確認せずに部分編集すると、以前の状態が混入する
- 憲法遵守チェック（T012）が不完全だった
- 実行時検証（runtime validation）が重要

---

## ✅ 修正後の期待される動作

1. **コンテナ名**: `yokakit-web-app`, `yokakit-db`, `yokakit-mqtt-broker`
2. **ネットワーク名**: `yokakit_yokakit`
3. **データベース**: `yokakit`データベース、`yokakit`ユーザー
4. **アプリケーション**: `http://localhost:18080`でLaravel起動画面表示
5. **憲法遵守**: pinkieit参照ゼロ

---

**作成日**: 2025-10-03
**Phase**: 2 - Docker Architecture Optimization
**状態**: 修正待ち
