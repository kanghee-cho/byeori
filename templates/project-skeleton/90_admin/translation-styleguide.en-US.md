# Translation Style Guide (en-US) — Technical Localization (Single Glossary)

## Purpose
This guide defines how to convert ko-KR drafts into **en-US release documents** using **technical localization**:
- Not literal translation
- Spec-first tone
- AI/developer readability
- Meaning and constraints preserved

**Release policy:** `50_release/vX.Y/` is **en-US only**.

---

## 0) Inputs (Must Read)
Before localizing any document, always read:

1) **Single glossary (KR+EN unified)**
- `projects/<project>/90_admin/glossary.md`

2) (Optional but recommended) Project-specific conventions
- `projects/<project>/90_admin/translation-styleguide.en-US.md` (this file)
- Any project-specific templates under `projects/<project>/90_admin/doc-templates/`

If the glossary is missing or incomplete:
- Do not guess terminology.
- Propose glossary additions and escalate for human approval.

---

## 1) Non-Negotiable Rules (Hard Gates)
1) Do NOT add new requirements or features.
2) Do NOT remove requirements.
3) Do NOT weaken requirement strength (MUST/SHOULD/MAY).
4) Preserve constraints exactly (numbers, thresholds, limits, formats).
5) If the ko-KR source is ambiguous, STOP and escalate. Never guess.
6) Zero-Code: Do not generate application or infrastructure code.

---

## 2) Glossary Enforcement (Single Source of Truth)
### 2.1 Canonical Term Rule
- For every concept, use the **EN canonical** value from `glossary.md`.
- Do not invent synonyms for canonical terms.
- Preserve capitalization and spelling exactly as defined.

### 2.2 Term-ID Usage (Recommended)
- Prefer referencing stable identifiers in documents when possible:
  - Use `term-id` to reduce ambiguity and improve traceability.
- If a document introduces a new term:
  - Add it to `glossary.md` (both KO canonical + EN canonical)
  - Mark as requiring human approval before release

### 2.3 Glossary Suggestions Workflow
If a term is missing:
- Add it to a "Glossary Suggestions" note (per document or consolidated report)
- Include:
  - proposed `term-id`
  - KO canonical source phrase
  - EN canonical recommendation
  - short definition
  - usage notes / avoid list

---

## 3) Spec-First Tone & Writing Style
- Prefer structured headings and bullets over narrative paragraphs.
- Replace vague phrases with explicit conditions.
  - Avoid: "appropriately", "as needed", "sufficient", "etc."
  - Use: explicit rules, constraints, or open questions if unknown
- Use concise, deterministic language.

### Normative keywords
- MUST = hard requirement
- MUST NOT = hard prohibition
- SHOULD = recommendation
- MAY = optional

Preserve strength from ko-KR source:
- “해야 한다/필수” → MUST
- “권장/바람직” → SHOULD
- “가능/할 수 있다” → MAY

---

## 4) Document Structure Standards

### 4.1 PRD (prd.md)
Required sections:
- Context
- Goals
- Non-Goals
- Users / Scenarios
- Requirements (Functional / Non-Functional)
- Success Criteria
- Assumptions / Constraints
- Open Questions (only if allowed by project policy)

Style:
- Convert marketing-like phrasing into testable requirements.
- Make scope boundaries explicit and verifiable where possible.

### 4.2 Architecture (architecture.md)
Required sections:
- Overview
- Components and Responsibilities
- Key Flows
- Trust Boundaries / Security Notes (conceptual, no implementation)
- NFR Mapping
- Decisions / Trade-offs
- Assumptions / Constraints

Style:
- Prefer “decisions + rationale” over implicit descriptions.
- Remove culturally local phrasing; use standard technical definitions.

### 4.3 Software Design (design.md)
Required sections:
- Module Responsibilities
- Sequences / Flows
- Error Handling Policy
- Key Decisions (with rationale)
- Assumptions / Constraints

Style:
- Avoid implementation details (no code).
- Maintain alignment with architecture and API terms.

### 4.4 API Spec (api-spec.md)
Required sections:
- Endpoints / Interfaces (as applicable)
- Request/Response Schema
- Error Model
- Versioning Rules
- Validation Rules (explicit)

Style:
- Normalize field descriptions.
- Ensure error semantics are explicit and consistent.

### 4.5 DB Schema (db-schema.md)
Required sections:
- Entities / Tables
- Relationships
- Constraints / Invariants
- Indexing Intent
- Migration Notes (conceptual)

Style:
- Preserve constraints exactly.
- Clarify invariants and data lifecycle where applicable.

### 4.6 Tasks (tasks/*.md)
Required sections:
- Context (links to PRD/Architecture)
- Scope / Non-Goals
- Inputs / Outputs / Error Cases
- Acceptance Criteria (Given/When/Then)
- Dependencies
- Definition of Done

Task sizing policy:
- Task "small enough" = **AC completeness first** (not time-based)

---

## 5) Numbers, Units, and Constraints
- Preserve all numeric values exactly.
- Normalize units only if it does not change meaning (e.g., 200ms vs 0.2s).
- If ko-KR implies a constraint but does not specify a value:
  - Do not invent a value.
  - Raise an open question.

---

## 6) Acceptance Criteria (AC) Rules — Critical
- AC MUST be testable and unambiguous.
- Prefer Given/When/Then.
- Include at least:
  - 1 happy-path AC
  - 1 negative/error AC
- Do not include internal implementation details.
- If AC reveals hidden complexity:
  - Recommend refining/splitting (while preserving Task IDs per project policy)

---

## 7) Localization Notes (Per Document)
At the end of each localized en-US document, add a small section:

### Localization Notes
- Glossary Suggestions: (if any)
- Open Questions / Ambiguities requiring human decision: (if any)
- Risks / Dependencies surfaced during localization: (if any)

---

## 8) Release Readiness Rules (en-US Only)
For `50_release/vX.Y/`:
- Include **en-US documents only**
- Ensure all required doc types exist (PRD/Architecture/Design/API/DB/Tasks + release notes if required)
- Do not include draft-only brainstorming notes
- Any open questions must be resolved or explicitly handled according to project policy

---

## 9) Stop & Escalate Conditions
Escalate to human approval if:
- The ko-KR source is ambiguous and cannot be clarified without guessing
- Documents conflict with each other
- Glossary gaps could change meaning
- Any Hard Gate is at risk of violation

Escalation must include:
- file path + section
- what is ambiguous/conflicting
- 2–3 clarification questions
- suggested options (without choosing)