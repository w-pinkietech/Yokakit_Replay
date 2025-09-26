# タスク完了時のワークフロー

## 基本ワークフロー

### 1. コード品質チェック
```bash
# YokaKit での作業完了後
cd YokaKit

# Laravel Pint でコード整形
./vendor/bin/pint

# Larastan で静的解析
./vendor/bin/phpstan analyse --memory-limit=512M

# テスト実行（100%通過必須）
php artisan test

# ブラウザテスト（必要に応じて）
php artisan dusk
```

### 2. PinkieIt参考確認（該当する場合）
```bash
cd pinkieit

# Dockerコンテナでの品質チェック
docker compose exec web-app ./vendor/bin/pint
docker compose exec web-app ./vendor/bin/phpstan analyse --memory-limit=512M
docker compose exec web-app php artisan test --coverage
```

### 3. フロントエンド品質チェック
```bash
# アセットビルド確認
npm run prod

# JavaScript リント（PinkieItの場合）
npm run lint  # semistandard
```

## Phase別完了要件

### Phase 0（現在）: GitHub リポジトリ初期化
- ✅ ブランチ保護設定
- ✅ Issue テンプレート作成
- ✅ マイルストーン設定（6フェーズ）
- ✅ ワークフローテンプレート準備
- ✅ プロジェクト文書構造構築

### Phase 1: Docker環境構築 + Laravel 10.x
- 🔄 Dockerfile作成（multi-stage builds）
- 🔄 docker-compose設定
- 🔄 Laravel フレームワーク更新（9.x → 10.x）
- 🔄 PHP 8.2対応

### Phase 2: CI/CD パイプライン構築
- ⏳ GitHub Actions設定
- ⏳ SonarQube Cloud連携
- ⏳ セキュリティスキャン自動化

### Phase 3: テスト・品質管理ツール統合
- ⏳ PHPUnit + PCOV設定
- ⏳ カバレッジ測定
- ⏳ 自動化された品質ゲート

### Phase 4: WebSocket・リアルタイム機能モダナイズ
- ⏳ Laravel Reverb移行
- ⏳ MQTT統合最適化

### Phase 5: セキュリティ・パフォーマンス最適化
- ⏳ セキュリティパッチ適用
- ⏳ パフォーマンス最適化
- ⏳ DevContainer対応

## 必須確認事項

### コード品質
- [ ] Laravel Pint による整形完了
- [ ] PHPStan による静的解析エラーゼロ
- [ ] PHPUnit テスト100%通過
- [ ] フロントエンドビルドエラーなし

### Git・プロジェクト管理
- [ ] 適切なコミットメッセージ（PinkieIt参照付き）
- [ ] フィーチャーブランチでの作業
- [ ] プルリクエスト作成準備
- [ ] サブモジュール状態確認

### Phase完了時追加要件
- [ ] マイルストーン完了
- [ ] Issue解決確認
- [ ] YokaKitサブモジュール更新
- [ ] 次Phase準備確認

## エラー対応

### 品質チェック失敗時
1. エラー内容詳細確認
2. 該当コード修正
3. 再度品質チェック実行
4. 全チェック通過まで繰り返し

### テスト失敗時
1. 失敗テスト詳細分析
2. アプリケーションロジック確認
3. テストケース見直し（必要に応じて）
4. 修正後再テスト

### Docker関連エラー（Phase 1以降）
1. コンテナログ確認: `docker compose logs -f web-app`
2. 依存関係確認: `docker compose exec web-app composer install`
3. 設定ファイル確認
4. 必要に応じてコンテナ再ビルド