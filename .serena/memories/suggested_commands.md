# 推奨コマンド一覧

## Git・プロジェクト管理
```bash
# サブモジュール管理
git submodule update --init --recursive    # サブモジュール初期化
git submodule status                        # サブモジュール状態確認

# ブランチ管理
git checkout -b phase-{N}-{feature-name}   # フィーチャーブランチ作成

# PinkieIt履歴分析
cd pinkieit && git log --oneline --reverse  # 開発履歴確認（時系列）
cd pinkieit && git log --grep="Docker\|Laravel\|CI/CD" --oneline  # 特定改善確認
```

## YokaKit開発（Laravel 9.x）
```bash
cd YokaKit

# 依存関係管理
composer install                    # PHP依存関係インストール
composer update                     # 依存関係更新
npm install                         # Node.js依存関係インストール

# 開発・ビルド
npm run dev                         # 開発ビルド
npm run watch                       # ファイル監視
npm run prod                        # プロダクションビルド

# Laravel コマンド
php artisan migrate                 # マイグレーション実行
php artisan db:seed                 # シードデータ投入
php artisan optimize:clear          # キャッシュクリア

# テスト
php artisan test                    # PHPUnitテスト実行
php artisan dusk                    # ブラウザテスト実行

# コード品質
./vendor/bin/pint                   # Laravel Pint（コード整形）
./vendor/bin/phpstan analyse        # Larastan（静的解析）
```

## PinkieIt参考（Laravel 10.x + Docker）
```bash
cd pinkieit

# Docker環境
docker compose up -d --build              # サービス起動・ビルド
docker compose exec web-app [command]     # コンテナ内コマンド実行
docker compose logs -f web-app            # アプリケーションログ

# 開発（コンテナ内）
docker compose exec web-app composer install
docker compose exec web-app npm run dev
docker compose exec web-app php artisan test --coverage
docker compose exec web-app ./vendor/bin/pint
```

## プロジェクト仕様管理
```bash
# フィーチャー仕様作成・管理（.specifyディレクトリの利用）
./scripts/bash/create-new-feature.sh       # 新機能作成

# プロジェクト状態確認
./scripts/bash/check-prerequisites.sh      # 前提条件確認
```

## システムコマンド（Linux）
```bash
# ファイル・ディレクトリ操作
ls -la                              # ファイル一覧表示
find . -name "*.php" -type f        # PHPファイル検索
grep -r "pattern" ./                # パターン検索

# プロセス・ネットワーク
ps aux | grep php                   # PHPプロセス確認
netstat -tulpn | grep :80           # ポート80使用状況確認
```

## CI/CD・品質管理（Phase 2以降）
```bash
# GitHub Actions ローカルテスト
gh act --list                       # ワークフロー一覧
gh act workflow_dispatch --dryrun   # ワークフロー実行テスト

# SonarQube・セキュリティスキャン（PinkieIt参考）
# GitHub Actionsにより自動実行
```