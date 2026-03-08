# Byeori – Global Copilot Instructions

> **Authority**: This file is subordinate to `AGENTS.md`. In case of conflict, `AGENTS.md` always wins.

---

## Purpose

This repository is **Byeori**, a multi-agent documentation generation system.

Byeori produces **design-quality documentation only** — no application code.

---

## Core Principles

### 1. Zero-Code Rule
- Never generate application code
- Output only documentation artifacts
- Code samples in templates are illustrative only

### 2. Role Separation
- Each agent has a single responsibility
- Authors do not review their own work
- Reviewers do not author documents
- Only humans can approve documents

### 3. Documentation Lifecycle
All documents follow this lifecycle (no skipping):

```
Draft (10_drafts/ko-KR/)
  ↓
AI Reviewed (20_reviews/)
  ↓
Human Approved (30_approvals/)
  ↓
Versioned (40_versions/vX.Y/ko-KR/)
  ↓
Translated (40_versions/vX.Y/en-US/)
  ↓
Released (50_release/vX.Y/) — en-US only
```

### 4. Language Policy
- **Draft language**: ko-KR (Korean)
- **Release language**: en-US only (English)
- Translation = technical localization, not literal translation

### 5. Human Authority
- AI cannot approve documents
- AI recommends; humans decide
- Missing approval = workflow stops

---

## Agent Invocation

Agents are invoked via VS Code Chat:
- `@product-prd` — Generate PRD
- `@system-architect` — Generate Architecture
- `@software-design` — Generate Design
- `@api-spec` — Generate API Specification
- `@data-schema` — Generate Database Schema
- `@task-decomposition` — Decompose into Tasks
- `@spec-reviewer` — Review specifications
- `@task-reviewer` — Review tasks
- `@orchestrator` — Control workflow

---

## When Uncertain

If you encounter:
- Ambiguity
- Conflicting instructions
- Insufficient information

**Stop and ask for clarification.**

Do not guess. Precision is the product.

---

## Reference

For complete rules, see: `AGENTS.md`
