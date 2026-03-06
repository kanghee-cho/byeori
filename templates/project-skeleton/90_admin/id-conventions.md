# Byeori ID Conventions

## Overview

This document defines the standard ID conventions used across all Byeori documentation artifacts. All agents MUST follow these conventions when generating or referencing IDs.

---

## ID Format

```
{PREFIX}-{NUMBER}
```

- **PREFIX**: 2-5 uppercase letters (meaningful abbreviation)
- **NUMBER**: 3 digits (001-999), except TASK which uses 4 digits
- **Separator**: Hyphen (-)

---

## ID Registry

### PRD Layer

| ID Pattern | Name | Description | Example |
|------------|------|-------------|---------|
| REQ-### | Requirement | Functional requirement | REQ-001 |
| NFR-### | Non-Functional Requirement | Performance, security, etc. | NFR-001 |

### Architecture Layer

| ID Pattern | Name | Description | Example |
|------------|------|-------------|---------|
| COMP-### | Component | System component | COMP-001 |
| ADR-### | Architecture Decision Record | Design decision with rationale | ADR-001 |

### Design Layer

| ID Pattern | Name | Description | Example |
|------------|------|-------------|---------|
| MOD-### | Module | Software module | MOD-001 |
| FLOW-### | Flow | Sequence, state, or data flow | FLOW-001 |

### API Layer

| ID Pattern | Name | Description | Example |
|------------|------|-------------|---------|
| API-### | API Endpoint | REST/GraphQL endpoint | API-001 |
| ERR-### | Error Code | Application error code | ERR-001 |

### Data Layer

| ID Pattern | Name | Description | Example |
|------------|------|-------------|---------|
| ENT-### | Entity | Database entity/table | ENT-001 |

> **Note**: Indexes are managed within entity definitions, not as separate IDs.

### Task Layer

| ID Pattern | Name | Description | Example |
|------------|------|-------------|---------|
| EPIC-### | Epic | Large initiative | EPIC-001 |
| FEAT-### | Feature | Feature group | FEAT-001 |
| STORY-### | User Story | User story | STORY-001 |
| TASK-#### | Task | Atomic work unit (4 digits) | TASK-0001 |

---

## Numbering Rules

1. **Sequential Assignment**: Numbers are assigned sequentially within each prefix (001, 002, 003...)
2. **No Gaps**: Do not skip numbers; use Deprecated/Retired status instead of deletion
3. **No Reuse**: Once assigned, an ID is never reused even if deprecated
4. **Scope**: IDs are unique within a single project

---

## Traceability Requirements

Each ID SHOULD reference its parent document IDs where applicable:

```
REQ-001 (PRD)
  └── COMP-001 (Architecture) — implements REQ-001
        └── MOD-001 (Design) — belongs to COMP-001
              ├── API-001 (API) — exposes MOD-001
              └── ENT-001 (DB) — persists MOD-001 data
                    └── TASK-0001 — implements ENT-001
```

### Traceability Table Format

Each document type should include a traceability section:

```markdown
## Traceability

| This ID | References | Relationship |
|---------|------------|--------------|
| COMP-001 | REQ-001, REQ-002 | implements |
| COMP-001 | NFR-001 | addresses |
```

---

## Status Values

IDs can have the following statuses:

| Status | Meaning | Editable |
|--------|---------|----------|
| Draft | In progress | ✅ Yes |
| Active | In use | ❌ No |
| Deprecated | Discouraged for new use | ❌ No |
| Retired | Completely obsolete | ❌ No |

---

## Examples

### Good Examples
```
REQ-001    ✓ Correct format
COMP-012   ✓ Correct format
TASK-0001  ✓ Correct format (4 digits for TASK)
ADR-003    ✓ Correct format
```

### Bad Examples
```
REQ-1      ✗ Missing leading zeros
req-001    ✗ Lowercase prefix
COMP_001   ✗ Underscore instead of hyphen
TASK-001   ✗ TASK requires 4 digits
R-001      ✗ Prefix too short (use REQ)
```

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-03-06 | Byeori System | Initial version |
