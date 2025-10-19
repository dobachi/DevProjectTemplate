# DevProjectTemplate

AI支援開発のためのラッパープロジェクトテンプレート

## 概要

このプロジェクトは、他のプロジェクトの開発をAIで支援するためのラッパープロジェクトテンプレートです。
`projects/` ディレクトリ配下に開発対象プロジェクトをgit cloneして、AI指示書システムを活用しながら開発を進めることができます。

## 特徴

- **AI指示書システム統合**: タスクに応じた専門的な指示書を選択・使用
- **プロジェクト分離**: `projects/` 配下で複数プロジェクトを並行管理
- **チェックポイント管理**: タスク進捗を追跡・記録
- **Worktree対応**: 複雑なタスクは専用ブランチで作業可能
- **安全なコミット**: AI署名を自動除去するコミットスクリプト

## ディレクトリ構造

```
DevProjectTemplate/
├── projects/              # 開発対象プロジェクトを配置（git clone先）
│   └── .gitkeep
├── instructions/          # AI指示書システム
│   ├── ai_instruction_kits/  # サブモジュール
│   ├── PROJECT.md         # プロジェクト固有の指示
│   └── PROJECT.en.md
├── scripts/               # 各種スクリプト
│   ├── checkpoint.sh      # チェックポイント管理
│   ├── commit.sh          # 安全なコミット
│   ├── worktree-manager.sh # worktree管理
│   └── project-manager.sh # プロジェクト管理
├── CLAUDE.md              # Claude Code用設定 → instructions/PROJECT.md
├── CURSOR.md              # Cursor用設定 → instructions/PROJECT.md
└── GEMINI.md              # Gemini用設定 → instructions/PROJECT.md
```

## セットアップ

### 1. このテンプレートをクローン

```bash
git clone <this-template-url> MyDevWrapper
cd MyDevWrapper
git submodule update --init --recursive
```

### 2. 開発対象プロジェクトを追加

```bash
# projects/配下にプロジェクトをクローン
git clone <target-project-url> projects/my-project

# プロジェクトディレクトリに移動
cd projects/my-project
```

### 3. AI指示書システムの初期化

```bash
# ラッパープロジェクトのルートで実行
cd ../../

# チェックポイント確認
bash scripts/checkpoint.sh pending

# 新規タスクの開始
bash scripts/checkpoint.sh start "機能開発" 5
```

## 使い方

### プロジェクト管理

```bash
# プロジェクト一覧表示
bash scripts/project-manager.sh list

# 新規プロジェクト追加
bash scripts/project-manager.sh add <repository-url> [project-name]

# プロジェクト削除
bash scripts/project-manager.sh remove <project-name>

# プロジェクトの状態確認
bash scripts/project-manager.sh status <project-name>
```

### AI開発支援の利用

1. **タスク開始**
```bash
bash scripts/checkpoint.sh start "認証機能の実装" 3
# → タスクID: TASK-123456-abc が生成されます
```

2. **AI指示書の選択**
   - Claude Code等のAIツールを起動
   - AIが自動的に `instructions/PROJECT.md` を読み込み
   - タスクに応じた指示書が選択されます

3. **開発実施**
   - `projects/my-project` 配下で開発作業
   - AIの支援を受けながら実装

4. **コミット**
```bash
# AI署名なしの安全なコミット
bash scripts/commit.sh "feat: ログイン機能を実装"

# 対象プロジェクトのディレクトリで通常のgit commit も使用可能
cd projects/my-project
git commit -m "fix: バリデーションエラーを修正"
```

5. **タスク完了**
```bash
bash scripts/checkpoint.sh complete TASK-123456-abc "認証機能実装完了"
```

### Worktreeの活用

複雑なタスクや複数ファイルの変更時は、専用のworktreeで作業：

```bash
# worktree作成
bash scripts/worktree-manager.sh create TASK-123456-abc "feature-auth"
cd .gitworktrees/ai-TASK-123456-abc-feature-auth/projects/my-project

# 作業実施...

# 完了後
bash scripts/worktree-manager.sh complete TASK-123456-abc
```

## プロジェクト固有の設定

`instructions/PROJECT.md` を編集して、プロジェクト固有の指示をAIに伝えることができます：

```markdown
## プロジェクト固有の追加指示

### コーディング規約
- インデント: スペース2個
- 命名規則: camelCase

### テストフレームワーク
- Jest を使用

### ビルドコマンド
- `npm run build`

### リントコマンド
- `npm run lint`
```

## 複数プロジェクトの管理

`projects/` 配下に複数のプロジェクトを配置可能：

```
projects/
├── backend-api/       # バックエンドAPI
├── frontend-web/      # フロントエンドWeb
└── mobile-app/        # モバイルアプリ
```

それぞれのプロジェクトは独立して管理され、タスクごとに適切な指示書を使用できます。

## チェックポイントとログ

- **チェックポイントログ**: `checkpoint.log` にタスクの進捗が記録されます
- **履歴確認**: `bash scripts/checkpoint.sh log` で履歴を確認

## トラブルシューティング

### AI署名付きコミットが拒否される

このプロジェクトでは、AI署名を含むコミットは自動的に拒否されます。
`scripts/commit.sh` を使用するか、手動でコミットメッセージからAI署名を削除してください。

### サブモジュールが初期化されていない

```bash
git submodule update --init --recursive
```

### チェックポイントが記録されない

`scripts/checkpoint.sh` に実行権限があるか確認：

```bash
chmod +x scripts/*.sh
```

## ライセンス

このテンプレートプロジェクト自体は自由に使用・改変できます。
ただし、各プロジェクトおよびAI指示書システムは独自のライセンスに従います。

## 関連リンク

- AI指示書システム: `instructions/ai_instruction_kits/`
- Claude Code: https://claude.com/claude-code

---

**作成日**: 2025-10-19
