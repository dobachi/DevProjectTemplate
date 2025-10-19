# AI開発支援設定（ラッパープロジェクト）

このプロジェクトは**ラッパープロジェクトテンプレート**です。
`projects/` ディレクトリ配下に開発対象プロジェクトをgit cloneして、AI指示書システムを活用しながら開発を進めます。

## プロジェクト構造
このテンプレートは以下の構造で動作します：
```
DevProjectTemplate/        # このラッパープロジェクト（AI支援環境）
├── projects/              # 開発対象プロジェクトを配置
│   ├── my-project-1/      # git clone したプロジェクト1
│   ├── my-project-2/      # git clone したプロジェクト2
│   └── ...
├── instructions/          # AI指示書システム
└── scripts/               # 管理スクリプト
```

## AI指示書システムの使用
タスク開始時は`instructions/ai_instruction_kits/instructions/ja/system/ROOT_INSTRUCTION.md`を読み込んでください。

## プロジェクト設定
- 言語: 日本語 (ja)
- プロジェクトタイプ: ラッパープロジェクト（複数プロジェクトの開発支援）
- チェックポイント管理: 有効
- チェックポイントスクリプト: scripts/checkpoint.sh
- ログファイル: checkpoint.log

## 重要なパス
- **開発対象プロジェクト**: `projects/` 配下
- AI指示書システム: `instructions/ai_instruction_kits/`
- チェックポイントスクリプト: `scripts/checkpoint.sh`
- プロジェクト管理スクリプト: `scripts/project-manager.sh`
- プロジェクト固有の設定: このファイル（`instructions/PROJECT.md`）

## プロジェクト管理コマンド

### プロジェクト追加
```bash
bash scripts/project-manager.sh add <repository-url> [project-name]
```

### プロジェクト一覧
```bash
bash scripts/project-manager.sh list
```

### プロジェクト状態確認
```bash
bash scripts/project-manager.sh status <project-name>
```

### プロジェクト更新
```bash
bash scripts/project-manager.sh update <project-name>
```

### プロジェクト削除
```bash
bash scripts/project-manager.sh remove <project-name>
```

## 開発ワークフロー

### 1. 新規プロジェクトの追加
```bash
# プロジェクトをclone
bash scripts/project-manager.sh add https://github.com/user/repo.git my-project

# タスク開始
bash scripts/checkpoint.sh start "機能開発" 3
```

### 2. 開発作業
- `projects/<project-name>` 配下で開発
- AI指示書システムを活用してタスクを遂行
- 必要に応じてworktreeを作成

### 3. コミット
```bash
# ラッパープロジェクトでの変更（設定等）
bash scripts/commit.sh "メッセージ"

# 開発対象プロジェクトでの変更
cd projects/my-project
git commit -m "メッセージ"
```

### 4. タスク完了
```bash
bash scripts/checkpoint.sh complete <task-id> "完了メッセージ"
```

## コミットルール
- **ラッパープロジェクト**: `bash scripts/commit.sh "メッセージ"` 推奨
- **開発対象プロジェクト**: 各プロジェクトのルールに従う
- **禁止**: AI署名付きコミット（自動検出・拒否されます）

## 複数プロジェクトの扱い
- 各プロジェクトは独立して管理
- タスクごとに適切な指示書を選択
- チェックポイントでどのプロジェクトの作業か記録推奨

## プロジェクト固有の追加指示
<!-- 開発対象プロジェクトの特性に応じて追加してください -->

### 例：
- メインプロジェクト: `projects/backend-api` - Python FastAPI
- サブプロジェクト: `projects/frontend` - React TypeScript
- コーディング規約: 各プロジェクトの規約に従う
- テストフレームワーク: 各プロジェクトに準拠
- その他の制約事項: projects/配下は.gitignoreで除外されています 