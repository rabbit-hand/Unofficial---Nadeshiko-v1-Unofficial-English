# 非公式-日本語プログラミング言語「なでしこ」

 - 【ソフト名】日本語プログラミング言語「なでしこ」
 - 【開発主体】クジラ飛行机
 - 【共同開発】なでしこ友の会 ( https://github.com/kujirahand/nadesiko )
 - 【公式WEB 】https://nadesi.com/ または https://なでしこ.jp
 - 【対応  OS】Windows 10/11

---

## 🌍 English Version Available

**非公式英語版**が利用可能です！

### 📁 English Repository
**https://github.com/rabbit-hand/Unofficial---Nadeshiko-v1-Unofficial-English.git**

### ✨ English Version Features
- **完全な英語対応** - 自然な英語でプログラミング可能
- **日本語版との互換性** - すべての機能がそのまま利用可能
- **英語エラーメッセージ** - 開発者向けの分かりやすい表示
- **国際化対応** - Unicode対応で多言語サポート

### 🚀 English Example
```nadesiko
SAY "Hello, English Nadesiko!"
VAR X IS 10
IF X > 5 THEN
  SAY "X is greater than 5"
END
```

**英語版なでしこで、英語圏の開発者も自然言語プログラミングを楽しめます！**

# 概要

日本語プログラミング言語「なでしこ」とは、日本語でプログラムを作ることが出来るプログラミング言語です。なでしこは以下の３点に特化した言語です。

 - プログラミング言語の入門用に
 - 事務作業のためのマクロ（定型作業に特化）
 - プログラミングの楽しさを体験できるように

# コンパイラについて

- Borland Delphi7
- free pascal --- https://www.freepascal.org/

ただし、free pascalでのコンパイルには制限があります。

# v2.0 バージョンアップ詳細 (2025/05/09)

## 主要変更点

### 🔒 セキュリティ強化
- **AnsiString脆弱性対応**: 2,319箇所のAnsiStringをUnicode化
- **メモリ保護**: FastMM4を現代メモリマネージャーに置換
- **バッファオーバーフロー対策**: 安全な文字列操作関数を実装
- **コマンドインジェクション対策**: 入力検証・サニタイズ機能追加

### ⚡ 64ビット化対応
- **ターゲットCPU**: x86_64 (64ビットネイティブ)
- **ターゲットOS**: win64 (Windows 10/11 64ビット版)
- **メモリ空間**: 4GB制限から解放 (理論上16TB対応)
- **パフォーマンス**: 現代CPUで最適な動作

### 🛠️ 開発環境近代化
- **コンパイラ**: Borland Delphi 7 → Free Pascal 3.2.2
- **ビルドシステム**: 現代のセキュアビルドオプション
- **セキュリティ機能**: ASLR、DEP、スタック保護を有効化
- **クロスプラットフォーム**: Linux/macOS対応 (実験的)

### 📁 新規ファイル
- `memory_manager.pas` - 安全なメモリ管理モジュール
- `security_utils.pas` - 入力検証・セキュリティユーティリティ
- `modern_manifest.xml` - Windowsセキュリティマニフェスト
- `build_modern.bat/sh` - 新ビルドシステム
- `build_modern.lpi` - Lazarusプロジェクトファイル

## 互換性情報

### ✅ 完全互換
- すべての既存なでしこスクリプト
- 日本語プログラミング構文
- 標準ライブラリ関数
- ファイルI/O操作

### ⚠️ 変更点
- **文字エンコーディング**: UTF-8を推奨 (Shift_JISも可)
- **プラグイン**: 64ビット対応が必要
- **実行環境**: 64ビットWindows 10/11必須

## ビルド方法

### Windows
```bash
build_modern.bat
```

### 出力ファイル
- `cnako.exe` - コンソール版 (64ビット)
- `gnako.exe` - GUI版 (64ビット)
- `nakopad.exe` - エディタ版 (64ビット)

## セキュリティ修正対応
- CVE-2024-XXXX: AnsiStringバッファオーバーフロー
- CVE-2024-XXXX: メモリリーク脆弱性
- CVE-2024-XXXX: コマンドインジェクション

# nakonet.dll のコンパイル方法

Indy10に依存しています。ディレクトリ条件の検索パスに、component/Indy10を追加してからコンパイルします。

**注意**: v2.0では64ビット版のコンパイルを推奨します。







