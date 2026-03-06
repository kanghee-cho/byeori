# Database Schema Document

## Document Info
- **Project**: (Project name)
- **Version**: v0.1-draft
- **Status**: Draft
- **Last Updated**: YYYY-MM-DD
- **Author**: (Author)

---

## 1. Overview
(Purpose and scope of the data model)

## 2. Database Information

| Item | Value |
|------|-------|
| Database Type | |
| Naming Convention | |
| Charset/Collation | |

## 3. Entities

### 3.1 [Entity Name]

**Description**: (Entity description)

**Fields**
| Field | Type | Nullable | Default | Constraints | Description |
|-------|------|----------|---------|-------------|-------------|
| id | | NO | | PK | |
| | | | | | |
| created_at | | NO | | | |
| updated_at | | NO | | | |

**Indexes**
| Index Name | Fields | Type | Purpose |
|------------|--------|------|---------|
| | | UNIQUE / INDEX | |

**Invariants**
- (Conditions this entity must always satisfy)

---

## 4. Relationships

### 4.1 Entity Relationship Diagram
```
[Entity A] 1--* [Entity B]
[Entity B] *--1 [Entity C]
```

### 4.2 Relationship Details
| From | To | Cardinality | Description |
|------|----|-------------|-------------|
| | | 1:1 / 1:N / N:M | |

## 5. Constraints & Invariants

### 5.1 Business Rules
| Rule ID | Description | Enforcement |
|---------|-------------|-------------|
| | | DB / Application |

### 5.2 Referential Integrity
| FK | References | On Delete | On Update |
|----|------------|-----------|-----------|
| | | CASCADE / RESTRICT / SET NULL | |

## 6. Data Lifecycle

### 6.1 Data Retention
| Entity | Retention Period | Archive Strategy |
|--------|------------------|------------------|
| | | |

### 6.2 Soft Delete vs Hard Delete
| Entity | Strategy | Notes |
|--------|----------|-------|
| | | |

## 7. Migration Notes
(Considerations for schema changes — conceptual level without code)

### 7.1 Migration Considerations
- (Backward compatibility)
- (Data migration strategy)
- (Rollback strategy)

## 8. Performance Considerations

### 8.1 Expected Data Volume
| Entity | Expected Rows (1yr) | Growth Rate |
|--------|---------------------|-------------|
| | | |

### 8.2 Query Patterns
| Pattern | Frequency | Index Support |
|---------|-----------|---------------|
| | | |

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
