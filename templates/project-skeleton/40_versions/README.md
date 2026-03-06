# Versions

This folder stores approved version snapshots.

## Lifecycle State
- **Status**: Versioned
- **Editable**: ❌ No (Immutable)

## Folder Structure
```
40_versions/
├── v1.0/
│   ├── ko-KR/      # Approved Korean snapshot (immutable)
│   │   ├── prd.md
│   │   ├── architecture.md
│   │   ├── design.md
│   │   ├── api-spec.md
│   │   ├── db-schema.md
│   │   └── tasks/
│   └── en-US/      # Localized English version (created by Translation Agent)
│       ├── prd.md
│       ├── architecture.md
│       ├── design.md
│       ├── api-spec.md
│       ├── db-schema.md
│       └── tasks/
└── v1.1/
    └── ...
```

## Rules
- ko-KR: Copied from 10_drafts/ after Human Approval
- en-US: Created by Translation Agent based on ko-KR source
- Cannot be modified (any change requires a new version)
