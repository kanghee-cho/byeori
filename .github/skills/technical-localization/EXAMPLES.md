# Technical Localization Examples (ko-KR → en-US)

These examples demonstrate "technical localization" (not literal translation).
Goal: rewrite for clarity, spec tone, and AI/developer readability while preserving meaning.

---

## Example 1 — Vague phrase to explicit rule

### ko-KR (before)
- 오류는 적절히 처리한다.

### en-US (localized)
- The system MUST handle errors explicitly:
  - It MUST return a defined error identifier for each failure class.
  - It MUST NOT perform side effects when validation fails.
  - It SHOULD record an error event for observability.

> Note: The en-US version did not add new features. It clarified what "appropriately" means into testable statements.

---

## Example 2 — PRD scope boundary tightening

### ko-KR (before)
- 사용자는 문서를 쉽게 찾을 수 있어야 한다.
- 검색 성능은 충분해야 한다.

### en-US (localized)
- Users MUST be able to locate documents via:
  - keyword search, and
  - filtering by at least one primary attribute (e.g., type or owner).
- Performance:
  - The search response time MUST meet the success threshold defined in the NFR section.
  - If no threshold is provided in ko-KR, raise an explicit question instead of guessing.

---

## Example 3 — Architecture statements normalization

### ko-KR (before)
- 시스템은 확장 가능해야 한다.
- 컴포넌트는 역할에 따라 분리한다.

### en-US (localized)
- Scalability requirements:
  - The architecture MUST support horizontal scaling for read-heavy workloads.
  - Scaling assumptions and constraints MUST be documented (e.g., expected traffic patterns).
- Component boundaries:
  - Components MUST be separated by responsibility (single responsibility boundary).
  - Each component MUST declare its inputs/outputs and ownership.

---

## Example 4 — Task AC reinforcement (Given/When/Then)

### ko-KR (before)
- 사용자가 잘못된 입력을 보내면 에러를 반환한다.

### en-US (localized)
- Acceptance Criteria:
  - **Given** the request contains an invalid field value `<X>`  
    **When** the request is validated  
    **Then** the system returns error `<ERROR_ID>` and performs no side effects.
  - **Given** the request is valid  
    **When** the request is processed  
    **Then** the system returns a success response containing `<Y>`.

---

## Example 5 — Glossary enforcement example

### ko-KR (before)
- 벼리는 최종 문서 세트를 만든다.

### en-US (localized)
- Byeori produces a versioned documentation set that serves as the **Ultimate Source of Truth**.

Glossary note:
- 벼리 → Byeori
- 최종 문서 세트 → versioned documentation set
- “ultimate source of truth” is treated as a defined term (capitalize consistently if your styleguide says so)

---

## Example 6 — Escalation instead of guessing

### ko-KR (before)
- 하루에 100건 이상 요청이 들어올 수 있다.

### en-US (localized)
- Load assumption:
  - The system MAY receive more than 100 requests per day.
- Open Question (Escalation):
  - Is the design target "average daily requests" or "peak requests per minute/hour"?
  - Provide the intended peak load and latency SLO to avoid guessing performance requirements.

---

## Style Reminders (Do / Don't)

### Do
- Convert narrative into structured, testable requirements.
- Preserve requirement strength (MUST/SHOULD/MAY).
- Use consistent headings and bullets.
- Keep identifiers unchanged (TASK-####, requirement IDs).

### Don't
- Don't add features.
- Don't remove constraints.
- Don't write code.
- Don't invent numbers or thresholds.