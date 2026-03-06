# Glossary (ko-KR + en-US) — Canonical Terminology

## Purpose
This glossary defines canonical terms in **Korean (drafting)** and **English (release)** for this project.
- Draft documents are written in **ko-KR**.
- Release bundles are **en-US only**.
- English entries are **technical localization**, not literal translation.

## Governance Rules
1) Use **one canonical term per concept** (avoid synonyms unless explicitly listed).
2) Every term MUST have:
   - term-id
   - ko-KR canonical
   - en-US canonical (for release)
   - definition (can be bilingual or EN-only if preferred)
3) If a term is missing, propose an entry and flag it for human approval.
4) Do not invent new meanings during localization. Preserve intent.

---

## Terms (Canonical)

> Columns:
> - term-id: stable identifier used in docs, tasks, traceability
> - KO canonical: default Korean term used in drafts
> - EN canonical: default English term used in releases
> - Definition: what it means (spec-first)
> - Usage / Notes: how to use it consistently
> - Avoid: discouraged synonyms / ambiguous phrases
> - Status: Active / Deprecated / Retired

| term-id | KO canonical | EN canonical | Definition | Usage / Notes | Avoid | Status |
|---|---|---|---|---|---|---|
| byeori | 벼리 | Byeori | (Fill) Top-down multi-agent system producing versioned documentation as the ultimate source of truth. | Proper noun. Capitalize as "Byeori". | byeori (lowercase) | Active |
| ultimate-source-of-truth | 최종 기준 문서 세트 | Ultimate Source of Truth | (Fill) Versioned, released documentation set precise enough to guide implementation without interpretation. | Treat as a defined term. Consider consistent capitalization. | final docs, best docs | Active |
| acceptance-criteria | 수용 기준 | Acceptance Criteria (AC) | (Fill) Testable, unambiguous conditions for task completion and correctness. | Prefer Given/When/Then in tasks. | “적절히”, “충분히” | Active |
| non-functional-requirements | 비기능 요구사항 | Non-Functional Requirements (NFR) | (Fill) Requirements about performance, security, reliability, etc. | Keep measurable where possible. If missing metrics, flag as open question. | vague adjectives | Active |

---

## Abbreviations

| Abbrev | Meaning (EN) | Meaning (KO) | Notes |
|---|---|---|---|
| PRD | Product Requirements Document | 제품 요구사항 문서 | Use PRD consistently. |
| AC | Acceptance Criteria | 수용 기준 | Use GWT where possible. |
| NFR | Non-Functional Requirements | 비기능 요구사항 | Define measurable targets or flag questions. |

---

## Term Change Log

| Date | term-id | Change Type | Summary | Approved By |
|---|---|---|---|---|
| YYYY-MM-DD | (term-id) | Added / Updated / Deprecated / Retired | (Fill) | (Fill) |

---

## Review Checklist (Quick)

- [ ] All terms used in Draft (ko-KR) appear here
- [ ] All release documents (en-US) use **EN canonical** values exactly
- [ ] No conflicting synonyms across documents
- [ ] Deprecated/Retired terms are not used in new drafts
