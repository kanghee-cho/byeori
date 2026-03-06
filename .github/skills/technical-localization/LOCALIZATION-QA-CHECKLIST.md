# Technical Localization QA Checklist (ko-KR → en-US)

This checklist is used to validate that the en-US output is:
- meaning-equivalent
- clearer and more spec-oriented
- consistent with glossary and Byeori governance
- release-ready (en-US only)

Use this checklist per file, and also once per release bundle.

---

## A. Meaning Preservation (Hard Gate)

- [ ] No requirements were added.
- [ ] No requirements were removed.
- [ ] Scope boundaries (In/Out of Scope) match the ko-KR source.
- [ ] Numerical constraints (limits, thresholds, timeouts, sizes) are identical.
- [ ] Requirement strength is preserved:
  - "must/shall" ↔ "해야 한다"
  - "should" ↔ "권장"
  - "may" ↔ "가능"

If any item fails → STOP and escalate.

---

## B. Glossary & Terminology (Hard Gate)

- [ ] All key domain terms follow `glossary.md`.
- [ ] Terminology is consistent across PRD/Architecture/Design/API/DB/Tasks.
- [ ] Acronyms are defined on first use (unless globally obvious).
- [ ] If a term was missing from glossary:
  - [ ] a suggestion was recorded (do not silently invent terms)

---

## C. Spec Tone & Structure (Quality Gate)

- [ ] The document uses spec-first structure (headings + bullets).
- [ ] Vague phrases were removed or converted into explicit conditions.
- [ ] Assumptions and constraints are clearly stated.
- [ ] Decisions are captured as decisions (not implied).
- [ ] Cross-links are updated to en-US paths where applicable.

---

## D. Task Readiness (AC Completeness First)

For `tasks/*.md` only:

- [ ] Acceptance Criteria are testable and unambiguous.
- [ ] At least one happy-path AC exists.
- [ ] At least one negative/error AC exists.
- [ ] Inputs/Outputs/Error cases are explicit.
- [ ] Dependencies are explicit.
- [ ] No implementation details leaked into AC.
- [ ] If AC reveals hidden complexity:
  - [ ] the task was refined or splitting was recommended (ID preserved unless policy allows otherwise)

---

## E. Traceability (Hard Gate)

- [ ] Every task links to a PRD requirement and/or architecture decision.
- [ ] No “orphan task” exists.
- [ ] Requirement/Task IDs are preserved.
- [ ] If IDs appear in ko-KR, they appear in en-US unchanged.

---

## F. Release Bundle Checks (en-US Only)

For `50_release/vX.Y/`:

- [ ] Only en-US documents are included.
- [ ] All required doc types exist:
  - PRD
  - Architecture
  - Design
  - API Spec
  - DB Schema
  - Tasks
  - Release Notes / Changelog / Traceability (if required by project policy)
- [ ] No draft-only notes are included (e.g., unresolved brainstorming).
- [ ] Any open questions are explicitly listed in a single place (if allowed), otherwise resolved.

---

## G. Escalation Rules (Stop Conditions)

Escalate to human approval if:
- ko-KR source is ambiguous and cannot be clarified without guessing
- there is inconsistency across documents
- glossary gaps could change meaning
- any Hard Gate item fails

When escalating, include:
- file + section
- the ambiguity/conflict
- 2–3 clarifying questions
- suggested options (without choosing