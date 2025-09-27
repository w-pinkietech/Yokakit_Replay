# YokaKit_Replay プロジェクト概要

## プロジェクト目的
YokaKit_Replayは、PinkieItで実施した開発工程をYokaKitにリプレイして最新版にアップデートするプロジェクトです。PinkieItはYokaKitをベースに開発されたより進化したシステムであり、その開発履歴（git log）を辿ることで、YokaKitからPinkieItへの改善工程を完全に再現できます。

## 技術スタック

### YokaKit（アップデート対象）
- **Backend**: Laravel 9.x（→ 10.xにアップグレード予定）
- **PHP**: 8.0.2+（→ 8.2+にアップグレード予定）
- **Frontend**: Bootstrap 4.6, jQuery, AdminLTE 3
- **Asset Building**: Laravel Mix
- **WebSocket**: Laravel WebSockets (beyondcode)
- **IoT**: PHP MQTT Client
- **Testing**: PHPUnit, Laravel Dusk
- **Code Quality**: Laravel Pint, Larastan (PHPStan)

### PinkieIt（参考システム）
- **Backend**: Laravel 10.x with PHP 8.2+
- **Database**: MariaDB 10.11.4
- **Real-time**: Laravel Reverb WebSocket server
- **IoT Communication**: MQTT (Eclipse Mosquitto)
- **Frontend**: Bootstrap 5, jQuery, Chart.js, AdminLTE 3
- **Containerization**: Docker with multi-stage builds
- **Code Quality**: PHPUnit with PCOV, Larastan (PHPStan), SonarQube Cloud

## アーキテクチャ
```
YokaKit_Replay/
├── YokaKit/          # 生産進捗管理システム（アップデート対象）
├── pinkieit/         # 製造実行システム（参考システム）
├── memory/           # 共有メモリ・設定・憲法
├── templates/        # プロジェクトテンプレート
├── scripts/          # 自動化スクリプト
└── specs/            # 機能仕様・実装計画
```

## 開発フェーズ（6段階）
1. **Phase 0**: GitHubリポジトリ初期化（現在）
2. **Phase 1**: Docker環境構築 + Laravel 10.x アップグレード
3. **Phase 2**: CI/CDパイプライン構築
4. **Phase 3**: テスト・品質管理ツール統合
5. **Phase 4**: WebSocket・リアルタイム機能モダナイズ
6. **Phase 5**: セキュリティ・パフォーマンス最適化

## 重要な制約
- **Identity Preservation**: YokaKit名を最後まで維持（PinkieIt名前変更コミットはスキップ）
- **Historical Fidelity**: PinkieItのgit履歴から改善工程を抽出して段階的適用
- **Sequential Phases**: 厳密なフェーズ順序（0→1→2→3→4→5）
- **Submodule Sync**: 各フェーズ完了時にYokaKitサブモジュール更新必須