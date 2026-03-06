# Software Design Document

## Document Info
- **Project**: (Project name)
- **Version**: v0.1-draft
- **Status**: Draft
- **Last Updated**: YYYY-MM-DD
- **Author**: (Author)

---

## 1. Overview
(Scope and purpose of this design document)

## 2. Module Responsibilities

| Module | Responsibility | Inputs | Outputs |
|--------|---------------|--------|---------|
| | | | |

### 2.1 Module Interactions
```
[Module A] --request--> [Module B]
[Module B] --response--> [Module A]
```

## 3. Sequences & Flows

### Flow 1: (Flow name)
```
Actor -> Module A: request
Module A -> Module B: process
Module B --> Module A: result
Module A --> Actor: response
```

### Flow 2: (Error flow)
```
Actor -> Module A: invalid request
Module A --> Actor: error response
```

## 4. Error Handling Policy

### 4.1 Error Categories
| Category | Description | Handling Strategy |
|----------|-------------|-------------------|
| Validation | Input validation failure | |
| Authorization | Permission denied | |
| System | System error | |

### 4.2 Error Response Format
(Error response structure definition — without code)

## 5. State Management
(If applicable, state transition definitions)

| State | Transitions To | Trigger |
|-------|----------------|---------|
| | | |

## 6. Key Decisions

### Decision 1: (Decision title)
- **Context**: (Background)
- **Options Considered**:
  - Option A: (Pros/Cons)
  - Option B: (Pros/Cons)
- **Decision**: (Selection)
- **Rationale**: (Reasoning)

## 7. Dependencies

### 7.1 Internal Dependencies
| Dependency | Purpose | Version/Contract |
|------------|---------|------------------|
| | | |

### 7.2 External Dependencies
| Dependency | Purpose | Notes |
|------------|---------|-------|
| | | |

## 8. Assumptions & Constraints
### Assumptions
- (Design preconditions)

### Constraints
- (Design constraints)

## 9. Open Questions
| ID | Question | Owner | Due Date |
|----|----------|-------|----------|
| | | | |

---

## Approval
| Role | Name | Date | Status |
|------|------|------|--------|
| Author | | | |
| Reviewer | | | |
| Approver | | | |
