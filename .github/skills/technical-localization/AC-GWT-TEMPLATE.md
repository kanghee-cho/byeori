
# Acceptance Criteria Template (Given / When / Then)

Use this template to rewrite and reinforce Acceptance Criteria (AC) so they are:
- testable
- unambiguous
- implementation-agnostic (no code)
- consistent with Byeori's zero-code principle

---

## 1. Basic Pattern

### AC-1
**Given** <precondition/state>  
**When** <action/event/request>  
**Then** <observable outcome>

### AC-2 (Error / Negative)
**Given** <invalid input or forbidden state>  
**When** <action/event/request>  
**Then** <error outcome with explicit error type + message + status (if applicable)>

---

## 2. Required AC Coverage Checklist (per Task)

Every Task should have AC that covers:
- Happy path (at least 1)
- Validation failure (at least 1)
- Authorization/permission failure (if relevant)
- Dependency failure (if relevant)
- Edge case(s) that could break the main behavior

---

## 3. IO & Error Specification Helpers (No Code)

### Inputs
- Input fields:
  - name:
  - type/format:
  - required: yes/no
  - constraints: (range, length, pattern)
- Source:
  - user / system / external API / stored data
- Validation rules:
  - explicit rules only (no “appropriate”, “as needed”)

### Outputs
- Output fields:
  - name:
  - type/format:
- Success conditions:
  - what must be observable after completion
- Side effects (if any):
  - data created/updated
  - event emitted
  - audit log written

### Error Cases
List errors explicitly using a consistent structure:
- Error ID:
- Trigger condition:
- Expected response/outcome:
- Recovery/handling expectation (if any):

---

## 4. Examples (Fill-in-the-blank)

### Example A — Normal flow
**Given** the user is authenticated and has role `<role>`  
**When** the user requests `<operation>` with `<valid input>`  
**Then** the system returns `<expected result>` and records `<audit/log>`.

### Example B — Validation failure
**Given** the request contains `<invalid field/value>`  
**When** the system validates the request  
**Then** it returns error `<error id>` with message `<message>` and no side effects occur.

### Example C — Authorization failure
**Given** the user is authenticated but lacks permission `<permission>`  
**When** the user requests `<operation>`  
**Then** the system denies the request with error `<error id>` and logs the access attempt.

---

## 5. Non-Goals Reminder

Acceptance Criteria must NOT:
- describe internal implementation (algorithms, classes, code structure)
- introduce new requirements not present in ko-KR source
- change requirement strength (MUST/SHOULD/MAY) unless the source imp
