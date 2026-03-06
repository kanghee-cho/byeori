# Release

This folder stores deployable release bundles.

## Lifecycle State
- **Status**: Released
- **Editable**: ❌ No (Immutable)

## Folder Structure
```
50_release/
├── v1.0/
│   ├── prd.md           # en-US only
│   ├── architecture.md  # en-US only
│   ├── design.md        # en-US only
│   ├── api-spec.md      # en-US only
│   ├── db-schema.md     # en-US only
│   ├── tasks/           # en-US only
│   └── RELEASE-NOTES.md
└── v1.1/
    └── ...
```

## Rules
- **en-US only** (ko-KR must not be included)
- Created after Translation Review completion
- Release Gatekeeper Agent approval required
- Packaged in prompt-ready format
