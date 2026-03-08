# Translation Style Guide (en-US)

This document defines the **translation standards** for converting Korean (ko-KR) documents to English (en-US).

---

## Core Principles

### 1. Technical Localization, Not Literal Translation
- Preserve **meaning**, not word-for-word structure
- Rewrite for clarity when necessary
- Maintain spec-first tone

### 2. Glossary Compliance
- **Always** use terms defined in `glossary.md`
- Do not invent new translations for established terms
- Flag any missing glossary terms

### 3. Readability for AI and Developers
- Clear, unambiguous language
- Short sentences preferred
- Avoid idioms and colloquialisms

---

## Style Guidelines

### Tone
- **Professional**: Formal but accessible
- **Direct**: State facts, avoid hedging
- **Precise**: Use exact terminology

### Voice
- **Active voice** preferred
- Passive voice acceptable for emphasis

| Avoid | Prefer |
|-------|--------|
| "It is recommended that..." | "We recommend..." |
| "There should be a validation..." | "Validate the input..." |
| "The system will be responsible for..." | "The system handles..." |

### Tense
- **Present tense** for specifications
- **Future tense** only for planned features marked as such

| Avoid | Prefer |
|-------|--------|
| "The API will return..." | "The API returns..." |
| "Users will be able to..." | "Users can..." |

---

## Structural Rules

### Headings
- Translate headings accurately
- Maintain heading hierarchy (H1, H2, H3...)

### Lists
- Preserve bullet/number structure
- Keep parallel structure in list items

### Tables
- Translate all cell content
- Keep column headers consistent with glossary

### Code Blocks
- **Do not translate** code, variable names, or technical identifiers
- Translate comments only if they are documentation

```
// 사용자 인증 → // User authentication
const userId = ... → const userId = ... (unchanged)
```

---

## ID and Reference Preservation

### Requirement IDs
- **Never** translate IDs: `REQ-F-001` stays `REQ-F-001`

### Task IDs
- **Never** translate IDs: `T-0001` stays `T-0001`

### Cross-References
- Update link text to English
- Keep target paths unchanged

| Korean | English |
|--------|---------|
| `[PRD 참조](../prd.md#section-2)` | `[See PRD](../prd.md#section-2)` |

---

## Common Translation Patterns

| Korean (ko-KR) | English (en-US) |
|----------------|-----------------|
| ~해야 한다 | must / shall |
| ~할 수 있다 | can / may |
| ~하는 것이 좋다 | should |
| ~인 경우 | when / if |
| ~를 통해 | via / through |
| 예를 들어 | for example |
| 즉 | i.e. |
| 참고 | Note: |

---

## Quality Checklist

Before submitting translation:

- [ ] All glossary terms used correctly
- [ ] No untranslated Korean text (except code)
- [ ] IDs and references preserved
- [ ] Headings match source structure
- [ ] Tables fully translated
- [ ] Active voice used where possible
- [ ] Present tense for specifications
- [ ] No literal translations that sound unnatural
