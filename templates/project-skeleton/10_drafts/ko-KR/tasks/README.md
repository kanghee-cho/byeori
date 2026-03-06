# Tasks

This folder stores individual Task documents.

## Lifecycle State
- **Status**: Draft
- **Editable**: ✅ Yes

## File Structure
```
tasks/
├── hierarchy.md          # Epic/Feature/Story/Task structure
├── TASK-0001.md          # Individual task files
├── TASK-0002.md
└── ...
```

## Naming Convention
| Level | ID Format | Example |
|-------|-----------|---------|
| Epic | EPIC-### | EPIC-001 |
| Feature | FEAT-### | FEAT-001 |
| Story | STORY-### | STORY-001 |
| Task | TASK-#### | TASK-0001 |

## Rules
- Each Task MUST have a unique TASK-ID
- Each Task MUST reference its parent Story in Traceability section
- Each Task MUST have at least 2 Acceptance Criteria (Happy Path + Error)
- Task size is determined by AC completeness, NOT by time estimate
- Use `90_admin/task-template.md` as the template for new tasks

## Traceability Requirements
| Reference | Required |
|-----------|----------|
| PRD Requirement (REQ-###) | ✅ Mandatory |
| Parent Story (STORY-###) | ✅ Mandatory |
| Architecture Decision (ADR-###) | Recommended |
| Parent Feature (FEAT-###) | Recommended |

## Workflow
1. Task Decomposition Agent generates tasks from PRD/Architecture
2. Task Reviewer Agent validates AC completeness
3. Human approves tasks
4. Approved tasks are versioned to `40_versions/`
