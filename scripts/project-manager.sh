#!/usr/bin/env bash
# プロジェクト管理スクリプト
# projects/配下のプロジェクトを管理

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
PROJECTS_DIR="${PROJECT_ROOT}/projects"

# ヘルプ表示
show_help() {
    cat <<EOF
Usage: $0 <command> [options]

プロジェクト管理コマンド

Commands:
    list                      プロジェクト一覧を表示
    add <url> [name]          新規プロジェクトを追加
    remove <name>             プロジェクトを削除
    status <name>             プロジェクトの状態を確認
    update <name>             プロジェクトを更新 (git pull)
    help                      このヘルプを表示

Examples:
    $0 list
    $0 add https://github.com/user/repo.git my-project
    $0 remove my-project
    $0 status my-project
    $0 update my-project

EOF
}

# プロジェクト一覧表示
list_projects() {
    echo "=== プロジェクト一覧 ==="
    echo

    if [ ! -d "${PROJECTS_DIR}" ]; then
        echo "projects/ディレクトリが存在しません"
        return 1
    fi

    local count=0
    for dir in "${PROJECTS_DIR}"/*; do
        [ -d "$dir" ] || continue
        [ "$(basename "$dir")" = ".gitkeep" ] && continue

        local name=$(basename "$dir")
        local is_git=""

        if [ -d "$dir/.git" ]; then
            is_git="[Git]"
            local remote=$(cd "$dir" && git remote get-url origin 2>/dev/null || echo "N/A")
            local branch=$(cd "$dir" && git branch --show-current 2>/dev/null || echo "N/A")
            echo "📁 $name $is_git"
            echo "   Remote: $remote"
            echo "   Branch: $branch"
        else
            echo "📁 $name"
        fi
        echo
        ((count++))
    done

    if [ $count -eq 0 ]; then
        echo "プロジェクトがありません"
        echo
        echo "プロジェクトを追加するには:"
        echo "  $0 add <repository-url> [project-name]"
    else
        echo "合計: $count プロジェクト"
    fi
}

# プロジェクト追加
add_project() {
    local url="$1"
    local name="${2:-}"

    if [ -z "$url" ]; then
        echo "エラー: リポジトリURLを指定してください"
        echo "使用例: $0 add https://github.com/user/repo.git [project-name]"
        return 1
    fi

    # プロジェクト名が指定されていない場合はURLから抽出
    if [ -z "$name" ]; then
        name=$(basename "$url" .git)
    fi

    local target_dir="${PROJECTS_DIR}/${name}"

    if [ -e "$target_dir" ]; then
        echo "エラー: ${name} は既に存在します"
        return 1
    fi

    echo "プロジェクトを追加しています..."
    echo "  URL: $url"
    echo "  ディレクトリ: projects/$name"
    echo

    mkdir -p "${PROJECTS_DIR}"

    if git clone "$url" "$target_dir"; then
        echo
        echo "✓ プロジェクトを追加しました: $name"
        echo
        echo "次のステップ:"
        echo "  cd projects/$name"
        echo "  # 開発作業を開始"
    else
        echo "✗ プロジェクトの追加に失敗しました"
        return 1
    fi
}

# プロジェクト削除
remove_project() {
    local name="$1"

    if [ -z "$name" ]; then
        echo "エラー: プロジェクト名を指定してください"
        echo "使用例: $0 remove <project-name>"
        return 1
    fi

    local target_dir="${PROJECTS_DIR}/${name}"

    if [ ! -e "$target_dir" ]; then
        echo "エラー: ${name} が見つかりません"
        return 1
    fi

    # 確認
    echo "プロジェクトを削除します: $name"
    echo "  パス: $target_dir"
    echo
    read -p "本当に削除しますか? (yes/no): " confirm

    if [ "$confirm" = "yes" ]; then
        rm -rf "$target_dir"
        echo "✓ プロジェクトを削除しました: $name"
    else
        echo "キャンセルしました"
    fi
}

# プロジェクト状態確認
status_project() {
    local name="$1"

    if [ -z "$name" ]; then
        echo "エラー: プロジェクト名を指定してください"
        echo "使用例: $0 status <project-name>"
        return 1
    fi

    local target_dir="${PROJECTS_DIR}/${name}"

    if [ ! -e "$target_dir" ]; then
        echo "エラー: ${name} が見つかりません"
        return 1
    fi

    echo "=== プロジェクト状態: $name ==="
    echo

    if [ -d "$target_dir/.git" ]; then
        echo "📁 パス: $target_dir"
        echo

        cd "$target_dir"

        echo "--- Git情報 ---"
        echo "Remote: $(git remote get-url origin 2>/dev/null || echo 'N/A')"
        echo "Branch: $(git branch --show-current 2>/dev/null || echo 'N/A')"
        echo

        echo "--- ステータス ---"
        git status
        echo

        echo "--- 最新コミット ---"
        git log -1 --oneline 2>/dev/null || echo "コミット履歴なし"
    else
        echo "Gitリポジトリではありません"
        ls -lh "$target_dir"
    fi
}

# プロジェクト更新
update_project() {
    local name="$1"

    if [ -z "$name" ]; then
        echo "エラー: プロジェクト名を指定してください"
        echo "使用例: $0 update <project-name>"
        return 1
    fi

    local target_dir="${PROJECTS_DIR}/${name}"

    if [ ! -e "$target_dir" ]; then
        echo "エラー: ${name} が見つかりません"
        return 1
    fi

    if [ ! -d "$target_dir/.git" ]; then
        echo "エラー: ${name} はGitリポジトリではありません"
        return 1
    fi

    echo "プロジェクトを更新しています: $name"
    echo

    cd "$target_dir"

    if git pull; then
        echo
        echo "✓ プロジェクトを更新しました: $name"
    else
        echo
        echo "✗ プロジェクトの更新に失敗しました"
        return 1
    fi
}

# メイン処理
main() {
    local command="${1:-help}"

    case "$command" in
        list|ls)
            list_projects
            ;;
        add)
            shift
            add_project "$@"
            ;;
        remove|rm)
            shift
            remove_project "$@"
            ;;
        status|st)
            shift
            status_project "$@"
            ;;
        update|up)
            shift
            update_project "$@"
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            echo "エラー: 不明なコマンド: $command"
            echo
            show_help
            return 1
            ;;
    esac
}

main "$@"
