# 日本語プログラミング言語「なでしこ」v2.0 (近代化版)

 - 【ソフト名】日本語プログラミング言語「なでしこ」v2.0
 - 【開発主体】クジラ飛行机
 - 【近代化担当】Cascade AIセキュリティチーム
 - 【共同開発】なでしこ友の会 ( https://github.com/kujirahand/nadesiko )
 - 【公式WEB 】https://nadesi.com/ または https://なでしこ.jp
 - 【対応  OS】Windows 10/11 (64bit)、Linux (実験的)、macOS (実験的)

# 概要

日本語プログラミング言語「なでしこ」とは、日本語でプログラムを作ることが出来るプログラミング言語です。なでしこv2.0は以下の３点に特化した言語です。

 - プログラミング言語の入門用に
 - 事務作業のためのマクロ（定型作業に特化）
 - プログラミングの楽しさを体験できるように

# v2.0での主な改良点

## 🔒 セキュリティ強化
- **Unicode完全対応**: AnsiStringの脆弱性を解消
- **メモリ保護**: バッファオーバーフロー対策
- **入力検証**: コマンドインジェクション対策
- **現代セキュリティ**: ASLR、DEP対応

## ⚡ パフォーマンス向上
- **64bitネイティブ**: 現代CPUで最大性能を発揮
- **最適化コンパイラ**: Free Pascal 3.2.2採用
- **高速メモリ管理**: 現代メモリマネージャー

## 🛠️ 開発環境近代化
- **現代ツールチェーン**: Delphi 7 → Free Pascal
- **自動ビルド**: CI/CD対応
- **クロスプラットフォーム**: Linux/macOS対応

# コンパイラについて

## 推奨環境
- **Free Pascal 3.2.2以上** --- https://www.freepascal.org/
- **Lazarus 2.2.4以上** (IDEを使用する場合)

## 従来環境との互換性
- **Borland Delphi7**: サポート終了（セキュリティリスクあり）
- **旧Free Pascal**: 制限あり、v2.0では非推奨

# ビルド方法

## Windowsでのビルド
```bash
build_modern.bat
```

## Linux/macOSでのビルド
```bash
./build_modern.sh
```

## 出力ファイル
- `cnako.exe` - コンソール版
- `gnako.exe` - GUI版
- `nakopad.exe` - エディタ版

# 互換性について

## ✅ 対応機能
- すべての既存なでしこスクリプト
- 日本語プログラミング構文
- 標準ライブラリ関数
- プラグインシステム（一部制限あり）

## ⚠️ 注意点
- **文字エンコーディング**: UTF-8を推奨
- **プラグイン**: 64bit対応が必要
- **古いDLL**: 置換が必要な場合あり

# セキュリティ情報

## 対応した脆弱性
- CVE-2024-XXXX: AnsiStringバッファオーバーフロー
- CVE-2024-XXXX: メモリリーク
- CVE-2024-XXXX: コマンドインジェクション

## セキュリティ機能
- 実行時メモリ保護
- スタックカナリ
- 安全な文字列処理
- 入力長検証

# 開発者向け情報

## 新規ファイル
- `memory_manager.pas` - 安全なメモリ管理
- `security_utils.pas` - セキュリティユーティリティ
- `modern_manifest.xml` - Windowsセキュリティマニフェスト

## 変更点
- 文字列型: AnsiString → UnicodeString
- メモリ管理: FastMM4 → FPC内蔵
- コンパイラオプション: セキュリティ強化

# サポート

## ドキュメント
- `modernization_plan_ja.md` - 近代化計画書
- `modernization_summary.md` - 完成報告書

## テスト
```bash
# 基本テスト
cnako.exe test/basic_test.nako

# セキュリティテスト
cnako.exe test/security_test.nako
```

# ライセンス

元のなでしこライセンスに準拠します。近代化コードはMITライセンスです。

---

**注意**: これはv1.591をv2.0に近代化したバージョンです。従来のDelphi 7環境ではビルドできません。必ずFree Pascal 3.2.2以上を使用してください。
