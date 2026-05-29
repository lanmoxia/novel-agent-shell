# Repository Guidelines

## New Session Startup

At the start of each new session, read these four files in order:

1. `docs/AI-CONTEXT/README.md`
2. `docs/AI-CONTEXT/CURRENT-STATE.md`
3. `docs/AI-CONTEXT/BACKLOG.md`
4. `docs/AI-CONTEXT/LAST-TASK.md`

Do not read `docs/AI-CONTEXT/archive/` by default. Archive files are historical evidence and should be read only when a task explicitly depends on a specific archived report.

If the task touches architecture, workflow behavior, phase gates, or Skill contracts, also read `docs/GENRE-SKILL-CONTRACT.md` and `workflow/ORCHESTRATION.md` before proposing or editing changes.

At the end of a task, if project status, pause points, next steps, or backlog status changed, update `docs/AI-CONTEXT/CURRENT-STATE.md` and `docs/AI-CONTEXT/BACKLOG.md`.

Do not make broad changes to `workflow/`, `scripts/`, or `projects/_template/` without explicit user confirmation.

## Project Structure & Module Organization

This repository is a Codex-maintained shell for novel and script production workflows. Core workflow assets live in `workflow/`: `skills/` contains reusable workflow skills, `agents/` contains review and feedback agents, `hooks/` contains phase-gate scripts, and `feedback/` stores evolution notes. Project documentation and validation reports live in `docs/`. Pluggable genre rules belong in `genre-skills/<skill-name>/`; each genre skill must include `SKILL.md` and may include `templates/`, `examples/`, and rule files. Generated or active story projects belong in `projects/<project-name>/`; start from `projects/_template/`, not from sample projects such as `test-xianshi-demo/`.

## Build, Test, and Development Commands

There is no package manager build step in this repository. Use direct file and hook checks:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
powershell -ExecutionPolicy Bypass -File scripts/new-project.ps1 huanghe-minsu-horror-002
```

```bash
bash scripts/validate-shell.sh
bash scripts/validate-workflow-assets.sh
bash scripts/validate-genre-skills.sh
bash scripts/validate-projects.sh
bash scripts/new-project.sh huanghe-minsu-horror-002
```

These commands check repository structure, workflow asset metadata, hook syntax, project templates, active project folders, and genre Skill contracts. `new-project.*` creates a project from `projects/_template/` and refuses reserved sample/template names. Review `docs/SHELL-SPEC.md` and `docs/GENRE-SKILL-CONTRACT.md` before changing workflow contracts.

## Coding Style & Naming Conventions

Most content is Markdown, JSON, or shell. Keep Markdown headings descriptive and concise. Use lowercase kebab-case for skill and project directories, for example `genre-skills/huanghe-minsu-suspense-skill/`. Keep workflow files with established uppercase names such as `PROJECT.md`, `STORY-SPEC.md`, `OUTLINE.md`, and `FINAL-SCRIPT.md`. Preserve UTF-8 encoding for all Chinese and mixed-language files; in PowerShell, read and write with `-Encoding UTF8`.

## Testing Guidelines

Testing is document- and workflow-oriented. For genre skills, verify required files against `docs/GENRE-SKILL-CONTRACT.md` and include examples under `examples/` when behavior changes. For project workflow changes, run the relevant validation scripts and record findings in `docs/reports/` using the existing `*-REPORT.md` or `*-VALIDATION-RECORD.md` style. Do not treat generated story content as reusable test fixtures unless it is explicitly marked as a template or example.

## Change Guidelines

For local changes, record the workflow impact in the relevant document or report. Call out changes to hooks, phase gates, genre contracts, or project templates explicitly. When modifying generated story projects, keep the change scoped to the active project directory.

## Security & Configuration Tips

Do not recreate Claude Code runtime directories or files such as `.claude/`, `workflow/settings.json`, or `workflow/settings.local.json` unless explicitly needed for a temporary compatibility test. Hook scripts should remain offline and non-destructive: no network calls and no deletion of project outputs without explicit user confirmation.
