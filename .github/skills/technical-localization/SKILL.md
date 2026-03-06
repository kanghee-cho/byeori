
---
name: technical-localization
description: >-
  Convert Byeori project documents from ko-KR to en-US in a "technical localization" style.
  This is not literal translation. It rewrites for clarity, spec tone, and AI/developer readability
  while preserving meaning and governance constraints. Use at release time (vX.Y) only.
---

# Technical Localization Skill (ko-KR → en-US)

## 0) Purpose

This skill performs **technical localization**, not literal translation.

- Input: Approved snapshot documents in `40_versions/vX.Y/ko-KR/**`
- Output: Localized documents in `40_versions/vX.Y/en-US/**`
- Release rule: `50_release/vX.Y/**` must include **en-US only** (no ko-KR) per project policy.

## 1) Non-Negotiable Rules (Constitution Alignment)

1. **Do not change requirements.**
   - No new features, no scope changes, no policy reinterpretation.
2. **Preserve meaning exactly.**
   - Improve clarity and structure, but keep intent and constraints identical.
3. **Do not write code.**
   - Byeori is zero-code. Provide documentation/specs only.
4. **If ambiguity exists, stop and escalate.**
   - Never guess; raise questions to the human approver or orchestrator.

## 2) When to Use This Skill

Use this skill only when:
- ko-KR drafts have completed reviews and human approval,
- a version snapshot exists (e.g., `40_versions/v1.0/ko-KR/**`),
- the project is preparing a release bundle (`50_release/v1.0/`).

Do NOT use this skill for early drafts unless explicitly asked.

## 3) Inputs You Must Load (Repository Artifacts)

Always read the following before writing output:
- `projects/<project>/90_admin/glossary.md` (or project glossary)
- `projects/<project>/90_admin/translation-styleguide.en-US.md` (if present)
- `projects/<project>/40_versions/vX.Y/ko-KR/**` documents to localize

If any of these are missing:
- Proceed with localization but explicitly note the missing reference and recommend adding it.

## 4) Output Requirements

### 4.1 File Mapping Rules
- Maintain the same relative file structure:
  - `ko-KR/prd.md` → `en-US/prd.md`
  - `ko-KR/architecture.md` → `en-US/architecture.md`
  - `ko-KR/tasks/TASK-0001.md` → `en-US/tasks/TASK-0001.md`

### 4.2 Document Tone and Format
- Use **spec-first tone**:
  - Prefer bullets, tables (where appropriate), structured headings
  - Avoid narrative, marketing language, or vague adjectives
- Use consistent headings across doc types:
  - Context / Goals / Non-Goals
  - Requirements (Functional / Non-Functional)
  - Interfaces / Data / Constraints
  - Decisions / Assumptions / Risks
- Eliminate ambiguity:
  - Replace “적절히”, “상황에 따라” with explicit conditions or mark as open questions.

### 4.3 Traceability Preservation
- Preserve identifiers:
  - Requirement IDs
  - Decision IDs (ADR-style if used)
  - Task IDs (TASK-####)
- Preserve cross-links and update them to point to en-US paths if needed.

## 5) Localization Procedure (Step-by-step)

### Step 1 — Preflight
1. Identify the document type (PRD / Architecture / Design / API / DB / Task).
2. Extract and list:
   - Key terms requiring glossary mapping
   - Normative statements (“must/shall/should”)
   - Any numeric constraints, thresholds, limits
3. Flag ambiguity immediately.

### Step 2 — Glossary Enforcement
1. Replace key Korean domain terms with approved English terms.
2. Ensure consistent usage across all documents.
3. If a term is missing:
   - Propose a glossary entry (append to a "Glossary Suggestions" section in the output or separate notes file).

### Step 3 — Structural Rewrite
Rewrite to improve:
- Readability for AI + developers
- Explicitness of rules and scope
- Consistent section layout

Important:
- Reordering sections is allowed if meaning stays identical.
- Collapsing or expanding bullets is allowed if it clarifies (no new requirements).

### Step 4 — Normalization (Spec Language)
- Use normative language consistently:
  - MUST = hard requirement
  - SHOULD = recommendation
  - MAY = optional behavior
- Keep the strength of the original statement:
  - “해야 한다” → MUST
  - “권장한다/바람직” → SHOULD
  - “가능하다/할 수 있다” → MAY

### Step 5 — Task-Specific AC Reinforcement (Critical)
For `tasks/*.md`:
- Ensure Acceptance Criteria are **testable** and **unambiguous**.
- Prefer "Given / When / Then" patterns.
- Ensure inputs/outputs/errors/dependencies are explicit.
- If AC reveals hidden complexity:
  - Recommend splitting or adding sub-tasks (but do not create new IDs unless project policy allows; prefer updating content under same Task ID).

### Step 6 — Localization QA Pass (Self-check)
Before finalizing each file, verify:
- Meaning equivalence with ko-KR source
- No loss of constraints, edge cases, or NFRs
- Glossary consistency
- Link correctness
- No added features or assumptions

Output a short QA note at the end of each localized document:
- “Localization Notes:”
  - Glossary additions suggested (if any)
  - Ambiguities requiring human decision (if any)

## 6) Document-Type Playbooks

### 6.1 PRD (prd.md)
- Preserve:
  - Problem statement, goals, scope/non-goals, user personas/scenarios
  - Success metrics
- Improve:
  - Convert narrative paragraphs into crisp requirements and acceptance signals
  - Make scope boundaries explicit and testable where possible

### 6.2 Architecture (architecture.md)
- Preserve:
  - Component boundaries, responsibilities, trust boundaries
  - Key flows and NFR mapping
- Improve:
  - Replace broad statements with explicit decisions + rationale
  - Add "Assumptions" and "Constraints" sections if missing

### 6.3 Software Design (design.md)
- Preserve:
  - Module responsibilities, error handling policies, sequencing
- Improve:
  - Document decision trade-offs explicitly
  - Ensure consistent terminology with architecture and API

### 6.4 API Spec (api-spec.md)
- Preserve:
  - Contracts, schemas, error model, versioning rules
- Improve:
  - Normalize field descriptions and error semantics
  - Remove culturally local phrasing; use precise technical definitions

### 6.5 DB Schema (db-schema.md)
- Preserve:
  - Entities, relations, constraints, indexing intent
- Improve:
  - Clarify invariants and migration implications

### 6.6 Tasks (tasks/*.md)
- Preserve:
  - Task ID, intent, scope, dependencies
- Improve:
  - AC completeness (Given/When/Then)
  - Clear DoD, impacts, and traceability links

## 7) Stop Conditions (Escalation)

Stop and escalate if:
- A requirement is ambiguous in the source (ko-KR) and cannot be made explicit without guessing
- A glossary term is missing and changing wording might alter meaning
- Conflicts exist between documents
- The source seems inconsistent with project constitution

When escalating, provide:
- File path + section
- The ambiguity/conflict
- Two or three clarification questions
- Suggested resolution options (without choosing)

## 8) Deliverables Summary

For each version vX.Y:
- Produce a complete en-US set under `40_versions/vX.Y/en-US/**`
- Ensure release bundle `50_release/vX.Y/` can be created using en-US only
- Provide a consolidated `LOCALIZATION_REPORT.md` (optional but recommended) summarizing:
  - Glossary additions
  - Open questions
  - Files localized
  - Known risks