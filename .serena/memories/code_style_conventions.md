# コードスタイル・規約

## PHP（Laravel）規約

### コードスタイル
- **Laravel Pint**: 自動コード整形ツール使用必須
- **PSR-12準拠**: PHP Standard Recommendationに従う
- **名前空間**: `App\` をルートネームスペースとして使用

### 静的解析
- **Larastan (PHPStan)**: 静的解析ツール使用
- **メモリ制限**: `--memory-limit=512M` で実行

### テスト
- **PHPUnit**: 単体・統合テスト
- **Laravel Dusk**: ブラウザテスト（E2E）
- **カバレッジ**: PCOV使用（PinkieItではPHP 8.2+で利用）

## JavaScript/Frontend規約

### コードスタイル
- **semistandard**: JavaScriptリンターとして使用（PinkieIt）
- **Bootstrap**: UI フレームワーク（YokaKit: 4.6, PinkieIt: 5）
- **jQuery**: DOM操作ライブラリ
- **AdminLTE 3**: 管理画面テーマ

### ビルドツール
- **Laravel Mix**: アセットコンパイル
- **Sass**: CSSプリプロセッサ
- **Webpack**: モジュールバンドラー（Laravel Mix経由）

## ファイル・ディレクトリ命名

### ブランチ命名
- **フィーチャーブランチ**: `phase-{N}-{feature-name}`
- **Phase完了ブランチ**: `phase-{N}-complete`

### コミットメッセージ
- **フォーマット**: Conventional Commits準拠
- **PinkieIt参照**: 各コミットでPinkieItコミットハッシュを参照
- **例**: `feat: Phase 1 complete - Docker環境構築 (ref: pinkieit@a5d3b77)`

## Docker規約（Phase 1以降）

### Dockerfile
- **Multi-stage builds**: 本番・開発環境分離
- **Multi-architecture**: AMD64/ARM64対応
- **Layer optimization**: キャッシュ効率化

### compose.yml
- **サービス分離**: web-app, db, mqtt
- **Volume管理**: 開発時のみソースマウント
- **ネットワーク**: 専用ブリッジネットワーク使用

## 品質基準

### 必須チェック
- **テスト**: 100%通過必須
- **静的解析**: PHPStan エラーゼロ
- **コード整形**: Laravel Pint 適用済み
- **セキュリティ**: SonarQube スキャン通過（Phase 2以降）

### CI/CD統合（Phase 2以降）
- **GitHub Actions**: 自動ビルド・テスト・デプロイ
- **Branch protection**: main ブランチ保護
- **Required checks**: ビルド・テスト・セキュリティスキャン必須