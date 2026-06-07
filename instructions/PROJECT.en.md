# AI Development Support Configuration (Wrapper Project)

This project is a **wrapper project template**.
Clone target development projects into the `projects/` directory and develop them using the AI instruction system.

## Project Structure
This template operates with the following structure:
```
DevProjectTemplate/        # This wrapper project (AI support environment)
├── projects/              # Place development target projects
│   ├── my-project-1/      # git cloned project 1
│   ├── my-project-2/      # git cloned project 2
│   └── ...
├── instructions/          # AI instruction system
└── scripts/               # Management scripts
```

## Using the AI Instruction System
Please load `instructions/ai_instruction_kits/instructions/en/system/ROOT_INSTRUCTION.md` when starting a task.

ROOT_INSTRUCTION.md acts as a skill orchestrator. Check installed skills in `.claude/skills/` and use them according to the task at hand.

Additional skills are available from the [AI Instruction Kits Marketplace](https://github.com/dobachi/AI_Instruction_Kits).

## Project Settings
- Language: English (en)
- Project Type: Wrapper Project (supporting multiple project development)
- Use your AI tool's native features for task management, progress tracking, worktrees, and builds.

## Important Paths
- **Development Target Projects**: Under `projects/`
- AI Instruction System: `instructions/ai_instruction_kits/`
- Project Management Script: `scripts/project-manager.sh`
- Project-Specific Configuration: This file (`instructions/PROJECT.en.md`)

## Project Management Commands

### Add Project
```bash
bash scripts/project-manager.sh add <repository-url> [project-name]
```

### List Projects
```bash
bash scripts/project-manager.sh list
```

### Check Project Status
```bash
bash scripts/project-manager.sh status <project-name>
```

### Update Project
```bash
bash scripts/project-manager.sh update <project-name>
```

### Remove Project
```bash
bash scripts/project-manager.sh remove <project-name>
```

## Development Workflow

### 1. Add New Project
```bash
# Clone project
bash scripts/project-manager.sh add https://github.com/user/repo.git my-project
```

### 2. Development Work
- Develop under `projects/<project-name>`
- Accomplish tasks using the AI instruction system
- Use your AI tool's native features for task management, progress tracking, and worktrees.

### 3. Commit
```bash
# Changes in wrapper project (configurations, etc.)
bash scripts/commit.sh "message"

# Changes in development target project
cd projects/my-project
git commit -m "message"
```

## Commit Rules
- **Wrapper Project**: `bash scripts/commit.sh "message"` recommended
- **Development Target Project**: Follow each project's rules
- **Prohibited**: AI-signed commits (auto-detected and rejected)

## Handling Multiple Projects
- Each project is managed independently
- Select appropriate instructions per task
- Recommended to record which project you are working on using your AI tool's task management feature

## Project-Specific Instructions
<!-- Add instructions according to development target project characteristics -->

### Examples:
- Main Project: `projects/backend-api` - Python FastAPI
- Sub Project: `projects/frontend` - React TypeScript
- Coding Standards: Follow each project's standards
- Test Framework: Comply with each project
- Other Constraints: projects/ is excluded in .gitignore 