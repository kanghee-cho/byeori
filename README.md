# Byeori (벼리)

> **"In Korean, *Byeori* refers to the strong core rope that guides and holds a net together. True to its name, Byeori is a top-down multi-agent AI system that focuses entirely on crafting the ultimate source of truth. Instead of rushing to write code, it collaborates to generate comprehensive, flawless documentation and architectures—ensuring developers and AI agents have an absolute standard to follow."**

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

**English** | [한국어](README_KO.md)

## The Philosophy: Design First, Code Later

Many AI coding assistants fail because they jump straight into writing code based on vague prompts. **Byeori does not write a single line of code.** Instead, it acts as your ultimate software architect and product manager. You provide an idea, and Byeori's multi-agent system works top-down to generate crystal-clear, developer-ready documents. Once Byeori gives you the blueprint, any developer or AI coding tool can build the software flawlessly.

## Key Features (Planned)

- **Top-Down Architecture Planning**: Starts from the core objective and breaks it down into actionable components.
- **Multi-Agent Collaboration**: Specialized agents (e.g., Product Manager, System Architect, Consultant) debate and refine the specifications.
- **Zero-Code Documentation Generation**: Generates perfect Product Requirements Documents (PRD), System Architectures, Software Designs, API Specs, and Database Schemas in Markdown format.
- **Prompt-Ready**: The output documents are perfectly structured to be fed into coding AIs (like Claude, Cursor, or Copilot) for frictionless development.
- **Versioned & Immutable**: Approved documents are snapshotted as immutable versions, ensuring a reliable source of truth.
- **Bilingual Workflow**: Draft in Korean (ko-KR), release in English (en-US) via technical localization.

---

## Repository Structure

```
byeori/
├── AGENTS.md                    # Constitution (supreme rules for all agents)
├── README.md                    # This file
├── Projects/                    # All managed projects
│   └── <project-name>/
│       ├── 00_context/          # Input materials, background
│       ├── 10_drafts/ko-KR/     # Working drafts (Korean)
│       ├── 20_reviews/          # AI review results
│       │   ├── spec-review/
│       │   ├── task-review/
│       │   └── impact-analysis/
│       ├── 30_approvals/        # Human approval records
│       ├── 40_versions/vX.Y/    # Immutable version snapshots
│       │   ├── ko-KR/           # Approved Korean snapshot
│       │   └── en-US/           # Localized English version
│       ├── 50_release/vX.Y/     # Release bundle (en-US only)
│       └── 90_admin/            # Project admin (glossary, templates)
├── templates/
│   └── project-skeleton/        # Template for new projects
└── .github/
    ├── agents/                  # Agent definitions (*.agent.md)
    ├── skills/                  # Reusable skill packages
    └── copilot-instructions.md  # Global Copilot instructions
```

---

## Documentation Lifecycle

All documents follow a strict lifecycle with folder-to-state mapping:

```
Draft (10_drafts/ko-KR/)
  ↓  Spec Reviewer / Task Reviewer
AI Reviewed (20_reviews/)
  ↓  Human decision required
Human Approved (30_approvals/)
  ↓  Snapshot created
Versioned (40_versions/vX.Y/ko-KR/)
  ↓  Translation Agent
Translation (40_versions/vX.Y/en-US/)
  ↓  Translation Reviewer
Translation Reviewed
  ↓  Release Gatekeeper
Released (50_release/vX.Y/ — en-US only)
```

### State Transition Rules

| From | To | Gate Condition |
|------|----|----|
| Draft | AI Reviewed | All required docs exist, Spec/Task Review completed |
| AI Reviewed | Human Approved | Feedback addressed, Human approval recorded |
| Human Approved | Versioned | ko-KR snapshot created (immutable) |
| Versioned | Translation | Translation Agent invoked |
| Translation | Translation Reviewed | en-US created, Translation Reviewer completed |
| Translation Reviewed | Released | QA passed, Release Gatekeeper approved |

### Immutability Rules

- **Editable**: Only `10_drafts/` documents
- **Immutable**: `40_versions/` and `50_release/` — any change requires a new version

---

## Language Policy

| Phase | Language | Location |
|-------|----------|----------|
| Drafting | ko-KR (Korean) | `10_drafts/ko-KR/` |
| Version Snapshot | ko-KR | `40_versions/vX.Y/ko-KR/` |
| Technical Localization | en-US (English) | `40_versions/vX.Y/en-US/` |
| Release Bundle | **en-US only** | `50_release/vX.Y/` |

- Translation is **technical localization**, not literal translation
- Spec-first tone, AI/developer readability, meaning preserved
- Glossary-enforced terminology consistency

## Agent Model

Byeori is organized into 3 categories of agents to produce and continuously improve an execution-ready documentation set (without writing any code).

### Key Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Reviewer Separation | **Enabled** | Spec Reviewer and Task Reviewer are distinct agents |
| Task Sizing | **AC Completeness First** | A task is "small enough" when its AC are fully testable |
| Language Policy | **ko-KR Draft / en-US Release** | Technical localization, not literal translation |
| Human Authority | **Mandatory** | AI agents cannot approve; human approval is required |

---

### 1) Generate (Drafting / Authoring)

Agents responsible for producing the top-down blueprint documents and decomposing them into execution-ready tasks.

- **Product / PRD Agent**
  - Produces PRD: problem, goals, scope, non-goals, user scenarios, success criteria
- **System Architect Agent**
  - Produces system architecture: components, boundaries, major flows, NFR mapping
- **Software Design Agent**
  - Produces software design: module responsibilities, sequence/flows, error policies, design decisions
- **Interface / API Spec Agent**
  - Produces API/contract specs: endpoints, schemas, error models, versioning contracts
- **Data / Schema Agent**
  - Produces data model & DB schema: entities, relations, constraints, indexes, data dictionary
- **Task Decomposition Agent**
  - Breaks down PRD/Architecture/Specs into Epic → Feature → Story → **Task**
  - Ensures each Task is executable based on **AC completeness** (testable, unambiguous acceptance criteria)
- **Translation Agent**
  - Performs technical localization (ko-KR → en-US) at release time
  - Rewrites for clarity and spec tone while preserving meaning exactly

---

### 2) Review (Quality / Consistency)

Agents responsible for detecting ambiguity, inconsistency, omissions, and readiness gaps—without granting final approval.

- **Spec Reviewer Agent (AI)**
  - Reviews PRD/Architecture/Design/API/DB docs for:
    - consistency across documents
    - missing requirements / unclear scope
    - NFR coverage (security, performance, observability, etc.)
    - violations against Byeori's principles (Design First, Code Later)
- **Task Quality Reviewer Agent (AI)**
  - Reviews tasks for "development-ready" quality:
    - Acceptance Criteria are fully testable and complete
    - inputs/outputs/errors are explicit
    - dependencies and impacts are documented
    - task splitting suggestions when AC reveals hidden complexity
- **Change Impact Analyzer Agent**
  - Analyzes diffs between versions and reports ripple effects:
    - what documents/tasks are affected
    - regression risks and required follow-up work
    - update suggestions for traceability and release readiness
- **Translation Reviewer Agent**
  - Reviews localized (en-US) documents for:
    - meaning equivalence with ko-KR source
    - glossary consistency and spec tone compliance
    - traceability preservation

---

### 3) Governance (Flow / State / Release)

Agents responsible for orchestrating lifecycle states, human approval gates, versioning, and release packaging.

- **Orchestrator Agent**
  - Controls the end-to-end workflow and state transitions
  - Routes work to the correct agent at each phase
  - Enforces lifecycle rules and human approval gates
  - Never authors, reviews, or approves content itself
  - Stops and escalates when ambiguity or conflict is detected
- **Release Gatekeeper Agent**
  - Validates release-ready documentation bundles:
    - All required docs exist
    - Review gates passed
    - Human approval recorded
    - en-US only packaging confirmed

---

## Task Policy

Tasks are the final deliverable of Byeori — executable specifications ready for development.

### Task Validity

A task is valid **only if**:
- Acceptance Criteria (AC) are complete, testable, and unambiguous
- Inputs, outputs, error cases, and dependencies are explicit
- Traceability links to PRD requirements and architecture decisions exist

### Task Sizing

Task size is **NOT time-based**. The only criterion is **AC completeness**.
- If ACs are unclear → split or refine the task
- If hidden complexity is revealed → recommend sub-tasks

### Task Modification Policy

| Action | Rule |
|--------|------|
| Update | Preserve Task ID, update content |
| Deprecate | Mark status as `Deprecated` (feature maintained but discouraged) |
| Retire | Mark status as `Retired` (completely obsolete) |
| Delete | Only when feature is completely removed (avoid if possible) |

### Task Lifecycle States

| State | Editable |
|-------|----------|
| Draft | ✅ Yes |
| AI Reviewed | ❌ No |
| Human Approved | ❌ No |
| Versioned | ❌ No |
| Released | ❌ No |
| Deprecated | ❌ No |
| Retired | ❌ No |
   
## How It Works

### Phase 1: Input & Context (Human)
- Provide a rough idea, problem statement, or initial requirements
- Place background materials in `00_context/`

### Phase 2: Blueprint Generation (AI Agents)
The Orchestrator routes work through Generate agents in order:

1. **PRD Agent** → Product Requirements Document
2. **System Architect Agent** → Architecture Document
3. **Software Design Agent** → Design Document
4. **API Spec Agent** → API Specification
5. **Data Schema Agent** → Database Schema
6. **Task Decomposition Agent** → Epic → Feature → Story → Task breakdown

All drafts are created in `10_drafts/ko-KR/`.

### Phase 3: Review (AI Agents)
- **Spec Reviewer** checks consistency, completeness, NFR coverage
- **Task Reviewer** validates AC completeness and development readiness
- Review results are stored in `20_reviews/`

### Phase 4: Human Approval (Human Gate)
- Human reviews AI feedback and makes final decision
- Approval is recorded in `30_approvals/`
- **No AI agent can approve documents**

### Phase 5: Versioning & Translation (AI Agents)
- Approved ko-KR docs are snapshotted to `40_versions/vX.Y/ko-KR/` (immutable)
- **Translation Agent** performs technical localization to `40_versions/vX.Y/en-US/`
- **Translation Reviewer** validates meaning equivalence and glossary compliance

### Phase 6: Release (AI + Human)
- **Release Gatekeeper** validates the bundle
- Final en-US package is created in `50_release/vX.Y/`
- Output is **prompt-ready** for coding AIs

## Getting Started

### Prerequisites

- **VS Code** with Copilot Chat extension
- **Git** for version control

### Installation

```bash
# Clone the repository
git clone https://github.com/kanghee-cho/byeori.git
cd byeori
```

### Quick Start: Create Your First Project

#### 1. Create a new project using the shell script

```bash
# Unix/macOS/Linux
./scripts/create-project.sh my-app-name

# Windows PowerShell
.\scripts\create-project.ps1 my-app-name
```

This creates a project structure in `projects/my-app-name/`.

#### 2. Add your initial context

Place your idea, requirements, or background materials in:
```
projects/my-app-name/00_context/initial-idea.md
```

#### 3. Invoke agents via VS Code Chat

Open VS Code and use the Chat panel to invoke Byeori agents:

```
@product-prd Generate a PRD for my app based on 00_context/initial-idea.md
```

The agent will create `projects/my-app-name/10_drafts/ko-KR/prd.md`.

#### 4. Continue the documentation chain

```
@system-architect Generate architecture from the PRD
@software-design Generate design from PRD and Architecture
@api-spec Generate API specification from Design
@data-schema Generate database schema from Design
@task-decomposition Break down into executable tasks
```

#### 5. Review and approve

```
@spec-reviewer Review the PRD document
@task-reviewer Review the tasks for AC completeness
```

Review results appear in `20_reviews/`. Human approval is required before proceeding.

#### 6. Version and translate

After approval, create a version snapshot and translate:
```bash
# Create version snapshot
cp -r projects/my-app-name/10_drafts/ko-KR/* projects/my-app-name/40_versions/v1.0/ko-KR/
```

```
@translation Translate all documents to en-US
@translation-reviewer Review translations
```

#### 7. Check release readiness

```
@release-gatekeeper Check if v1.0 is ready for release
```

If all gates pass, the release bundle is created in `50_release/v1.0/` (en-US only).

---

## Command-Line Interface (CLI)

Byeori provides a CLI wrapper for common operations.

### Main CLI: `byeori.sh` / `byeori.ps1`

```bash
# Unix/macOS/Linux
./scripts/byeori.sh <command> [options]

# Windows PowerShell
.\scripts\byeori.ps1 <command> [options]
```

#### Commands

| Command | Description | Example |
|---------|-------------|---------|
| `agent <name> <project>` | Invoke an agent for a project | `./scripts/byeori.sh agent prd my-app` |
| `list` | List all available agents | `./scripts/byeori.sh list` |
| `status <project>` | Show project documentation status | `./scripts/byeori.sh status my-app` |
| `diff <project> <v1> <v2>` | Compare two versions | `./scripts/byeori.sh diff my-app v1.0 v1.1` |
| `create <project>` | Create a new project | `./scripts/byeori.sh create my-app` |
| `help` | Show help message | `./scripts/byeori.sh help` |

#### Agent Shortcuts

| Shortcut | Full Agent Name |
|----------|-----------------|
| `prd` | product-prd |
| `architect` | system-architect |
| `design` | software-design |
| `api` | api-spec |
| `db` | data-schema |
| `tasks` | task-decomposition |
| `spec-review` | spec-reviewer |
| `task-review` | task-reviewer |
| `translate` | translation |
| `translate-review` | translation-reviewer |
| `impact` | impact-analyzer |
| `release` | release-gatekeeper |
| `orchestrator` | orchestrator |

#### Example Workflow via CLI

```bash
# Create a new project
./scripts/byeori.sh create my-app

# Generate documentation chain
./scripts/byeori.sh agent prd my-app
./scripts/byeori.sh agent architect my-app
./scripts/byeori.sh agent design my-app
./scripts/byeori.sh agent api my-app
./scripts/byeori.sh agent db my-app
./scripts/byeori.sh agent tasks my-app

# Review
./scripts/byeori.sh agent spec-review my-app
./scripts/byeori.sh agent task-review my-app

# Check status
./scripts/byeori.sh status my-app
```

### Version Diff Tool: `version-diff.sh` / `version-diff.ps1`

Compare two versions of a project to analyze changes.

```bash
# Unix/macOS/Linux
./scripts/version-diff.sh <project> <v1> <v2> [options]

# Windows PowerShell
.\scripts\version-diff.ps1 -Project <project> -V1 <v1> -V2 <v2> [options]
```

#### Options

| Option | Description | Default |
|--------|-------------|---------|
| `--lang` / `-Lang` | Language to compare (ko-KR, en-US) | ko-KR |
| `--doc` / `-Doc` | Specific document to compare | all |
| `--output` / `-Output` | Output file path | stdout |
| `--summary` / `-Summary` | Show summary only | false |

#### Examples

```bash
# Compare all ko-KR documents between v1.0 and v1.1
./scripts/version-diff.sh my-app v1.0 v1.1

# Compare only the PRD document
./scripts/version-diff.sh my-app v1.0 v1.1 --doc prd.md

# Compare en-US translations
./scripts/version-diff.sh my-app v1.0 v1.1 --lang en-US

# Save diff report to file
./scripts/version-diff.sh my-app v1.0 v1.1 --output diff-report.md

# Quick summary only
./scripts/version-diff.sh my-app v1.0 v1.1 --summary
```

---

### Available Agents

| Agent | Command | Purpose |
|-------|---------|---------|
| PRD Agent | `@product-prd` | Generate Product Requirements Document |
| System Architect | `@system-architect` | Generate Architecture Document |
| Software Design | `@software-design` | Generate Design Document |
| API Spec | `@api-spec` | Generate API Specification |
| Data Schema | `@data-schema` | Generate Database Schema |
| Task Decomposition | `@task-decomposition` | Break down into Tasks |
| Spec Reviewer | `@spec-reviewer` | Review specification documents |
| Task Reviewer | `@task-reviewer` | Review tasks for AC completeness |
| Translation | `@translation` | Translate ko-KR → en-US |
| Translation Reviewer | `@translation-reviewer` | Review translations |
| Impact Analyzer | `@impact-analyzer` | Analyze change impact |
| Release Gatekeeper | `@release-gatekeeper` | Validate release readiness |
| Orchestrator | `@orchestrator` | Control workflow (meta-agent) |

### Workflow Tips

1. **Always start from PRD** — All other documents depend on it
2. **Review before approval** — AI reviews are mandatory before Human approval
3. **One change at a time** — Modify Drafts, then re-review
4. **Check with Orchestrator** — `@orchestrator what's the current state?`
5. **Human approval is required** — No AI agent can approve documents

---

## Troubleshooting

Common issues and solutions are documented in the [Troubleshooting Guide](docs/troubleshooting.md).

Quick links:
- [Agent not responding](docs/troubleshooting.md#11-에이전트가-응답하지-않음)
- [Document generation failures](docs/troubleshooting.md#2-문서-생성-문제)
- [Version/Release issues](docs/troubleshooting.md#4-버전릴리스-문제)
- [CLI errors](docs/troubleshooting.md#6-cli-스크립트-문제)

---

## Contributing

Byeori is an open-source project and we welcome contributions from everyone! Whether you want to improve the agent prompts, add new document templates, or fix a typo, your help is appreciated.

Fork the repository.

Create a new branch (git checkout -b feature/amazing-feature).
Commit your changes (git commit -m 'Add some amazing feature').
Push to the branch (git push origin feature/amazing-feature).

Open a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.