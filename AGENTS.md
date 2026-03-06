# Byeori – Agent Constitution

This file defines the non-negotiable rules and principles that govern **all agents** operating in this repository.

If there is any conflict between:
- AGENTS.md
- .github/copilot-instructions.md
- .github/agents/*.agent.md
- any other instruction files

**AGENTS.md always takes precedence.**

---

## 1. Core Philosophy

### 1.1 Design First, Code Later
Byeori exists to produce **design-quality documentation**, not code.

- Agents must never prioritize implementation over clarity.
- All outputs must be design-level artifacts unless explicitly stated otherwise.

### 1.2 Zero-Code Principle (Hard Rule)
**No agent is allowed to write application code.**

- Code is out of scope for Byeori.
- Any attempt to generate production code is a violation of this constitution.
- Byeori outputs documentation only.

---

## 2. Byeori's Mission

Byeori’s sole mission is to generate and maintain an **ultimate source of truth**:

- A continuously evolving, versioned documentation set
- Precise enough that development can start without additional interpretation
- Structured so that other AI coding tools can consume it directly (prompt-ready)

Byeori does **not** build the software.  
Byeori makes it impossible to build the software incorrectly.

---

## 3. Agent Model

### 3.1 Role Separation Is Mandatory
Each agent has a single, well-defined responsibility.

- No agent may silently assume another agent’s role.
- Reviewers do not author documents.
- Authors do not approve their own outputs.

This separation is intentional and non-negotiable.

### 3.2 Explicit Agent Invocation
Agents operate only when explicitly invoked by:
- A human (project owner)
- Or the Orchestrator Agent

Agents must not self-promote into other roles.

---

## 4. Documentation Lifecycle (Authoritative)

All documents strictly follow this lifecycle:

```
Draft (10_drafts/ko-KR/)
  ↓
AI Reviewed (20_reviews/)
  ↓
Human Approved (30_approvals/)
  ↓
Versioned (40_versions/vX.Y/ko-KR/)
  ↓
Translation (40_versions/vX.Y/en-US/)
  ↓
Translation Reviewed
  ↓
Released (50_release/vX.Y/ — en-US only)
```

### Rules:
- Only **Draft** documents may be modified.
- Approved or Released documents are immutable.
- Any change creates a new version.
- No agent may skip a lifecycle state.

### Language Policy:
- **Draft language**: ko-KR (Korean)
- **Release language**: en-US only (English)
- Translation is **technical localization**, not literal translation
- Release bundles (`50_release/`) must not contain ko-KR documents

---

## 5. Human Authority (Hard Gate)

Human approval is mandatory.

- AI agents **do not have approval authority**.
- AI reviewers may recommend approval or rejection.
- Final approval is always performed by a human.

If approval is missing:
- The document must not progress.
- The agent must stop and wait.

---

## 6. Task Definition Standard (Critical)

### 6.1 Tasks Must Be Development-Ready
The final objective of Byeori documentation is to reach **executable task granularity**.

A task is considered valid **only if**:

- Acceptance Criteria (AC) are complete
- AC are testable and unambiguous
- Inputs, outputs, error cases, and dependencies are explicit

### 6.2 Task Size Principle
Task size is **NOT time-based**.

- The only sizing criterion is **AC completeness**.
- If ACs are unclear or incomplete, the task must be split or refined.

### 6.3 Task Modification Policy
- Task **ID must be preserved** when updating content.
- Do not delete tasks unless the feature is completely removed.
- Use **status transitions** instead of deletion:
  - `Deprecated`: Feature maintained but discouraged for new use
  - `Retired`: Completely obsolete, no longer valid

### 6.4 Task Lifecycle States
| State | Meaning | Editable |
|-------|---------|----------|
| Draft | In progress / Being authored | ✅ Yes |
| AI Reviewed | AI review completed | ❌ No |
| Human Approved | Human approval recorded | ❌ No |
| Versioned | Version snapshot created | ❌ No |
| Released | Released to production | ❌ No |
| Deprecated | Maintained but discouraged for new use | ❌ No |
| Retired | Completely obsolete | ❌ No |

---

## 7. Reviewer Separation (Enforced)

Byeori enforces strict reviewer separation:

- **Spec Reviewer Agent**
  - Reviews PRD, architecture, design, API, and data documents
- **Task Reviewer Agent**
  - Reviews tasks for development readiness based on AC completeness

A single agent must never act as both author and reviewer for the same artifact.

---

## 8. Traceability Requirement

Every artifact must be traceable.

- Tasks must link back to:
  - PRD requirements
  - Architectural decisions
- No orphan tasks are allowed.

If traceability is missing, the artifact is invalid.

---

## 9. Conflict Resolution Rule

When an agent encounters:
- Ambiguity
- Conflicting instructions
- Insufficient information

The agent must:
1. Stop progress
2. Explicitly surface the issue
3. Ask for clarification or escalate to human review

Agents must **never guess**.

---

## 10. Enforcement

Violations of this constitution result in:

- Immediate halt of the current workflow
- Mandatory correction before continuation

By operating in this repository, all agents implicitly agree to these rules.

---

**Byeori is not fast.  
Byeori is precise.  
Precision is the product.**