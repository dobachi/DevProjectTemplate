# DevProjectTemplate

A wrapper project template for AI-assisted development

## Overview

This project is a wrapper project template designed to support development of other projects with AI assistance.
You can clone target projects into the `projects/` directory and develop them while leveraging the AI instruction system.

## Features

- **AI Instruction System Integration**: Select and use specialized instructions based on tasks
- **Project Isolation**: Manage multiple projects in parallel under `projects/`
- **Checkpoint Management**: Track and record task progress
- **Worktree Support**: Work on complex tasks in dedicated branches
- **Safe Commits**: Commit script that automatically removes AI signatures

## Directory Structure

```
DevProjectTemplate/
├── projects/              # Place development target projects (git clone destination)
│   └── .gitkeep
├── instructions/          # AI instruction system
│   ├── ai_instruction_kits/  # Submodule
│   ├── PROJECT.md         # Project-specific instructions
│   └── PROJECT.en.md
├── scripts/               # Various scripts
│   ├── checkpoint.sh      # Checkpoint management
│   ├── commit.sh          # Safe commit
│   ├── worktree-manager.sh # Worktree management
│   └── project-manager.sh # Project management
├── CLAUDE.md              # Claude Code config → instructions/PROJECT.md
├── CURSOR.md              # Cursor config → instructions/PROJECT.md
└── GEMINI.md              # Gemini config → instructions/PROJECT.md
```

## Setup

### 1. Clone This Template

```bash
git clone <this-template-url> MyDevWrapper
cd MyDevWrapper
git submodule update --init --recursive
```

### 2. Add Target Project

```bash
# Clone project under projects/
git clone <target-project-url> projects/my-project

# Move to project directory
cd projects/my-project
```

### 3. Initialize AI Instruction System

```bash
# Execute at wrapper project root
cd ../../

# Check checkpoint
bash scripts/checkpoint.sh pending

# Start new task
bash scripts/checkpoint.sh start "Feature Development" 5
```

## Usage

### Project Management

```bash
# List projects
bash scripts/project-manager.sh list

# Add new project
bash scripts/project-manager.sh add <repository-url> [project-name]

# Remove project
bash scripts/project-manager.sh remove <project-name>

# Check project status
bash scripts/project-manager.sh status <project-name>
```

### AI Development Support

1. **Start Task**
```bash
bash scripts/checkpoint.sh start "Implement Authentication" 3
# → Task ID: TASK-123456-abc will be generated
```

2. **Select AI Instruction**
   - Launch AI tool like Claude Code
   - AI automatically loads `instructions/PROJECT.md`
   - Appropriate instruction will be selected based on task

3. **Development**
   - Work under `projects/my-project`
   - Implement with AI assistance

4. **Commit**
```bash
# Safe commit without AI signature
bash scripts/commit.sh "feat: implement login functionality"

# Normal git commit is also available in target project directory
cd projects/my-project
git commit -m "fix: validation error"
```

5. **Complete Task**
```bash
bash scripts/checkpoint.sh complete TASK-123456-abc "Authentication feature completed"
```

### Utilizing Worktree

For complex tasks or multi-file changes, work in a dedicated worktree:

```bash
# Create worktree
bash scripts/worktree-manager.sh create TASK-123456-abc "feature-auth"
cd .gitworktrees/ai-TASK-123456-abc-feature-auth/projects/my-project

# Work...

# After completion
bash scripts/worktree-manager.sh complete TASK-123456-abc
```

## Project-Specific Configuration

Edit `instructions/PROJECT.md` to provide project-specific instructions to AI:

```markdown
## Project-Specific Additional Instructions

### Coding Standards
- Indent: 2 spaces
- Naming: camelCase

### Test Framework
- Use Jest

### Build Command
- `npm run build`

### Lint Command
- `npm run lint`
```

## Managing Multiple Projects

You can place multiple projects under `projects/`:

```
projects/
├── backend-api/       # Backend API
├── frontend-web/      # Frontend Web
└── mobile-app/        # Mobile App
```

Each project is managed independently and can use appropriate instructions per task.

## Checkpoints and Logs

- **Checkpoint Log**: Task progress is recorded in `checkpoint.log`
- **View History**: Check history with `bash scripts/checkpoint.sh log`

## Troubleshooting

### AI Signature Commits Are Rejected

This project automatically rejects commits containing AI signatures.
Use `scripts/commit.sh` or manually remove AI signatures from commit messages.

### Submodule Not Initialized

```bash
git submodule update --init --recursive
```

### Checkpoints Not Recorded

Check if `scripts/checkpoint.sh` has execute permission:

```bash
chmod +x scripts/*.sh
```

## License

This template project itself can be freely used and modified.
However, each project and the AI instruction system follow their own licenses.

## Related Links

- AI Instruction System: `instructions/ai_instruction_kits/`
- Claude Code: https://claude.com/claude-code

---

**Created**: 2025-10-19
