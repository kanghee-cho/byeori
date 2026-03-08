# Versions (40_versions)

이 폴더는 **불변 버전 스냅샷**을 저장합니다.

## 핵심 원칙

> **승인된 문서는 수정할 수 없습니다.**
> 변경이 필요하면 새 버전을 생성합니다.

## 버전 체계

**vX.Y** (major.minor)

- **Major (X)**: 대규모 변경, 호환성 없는 변경
- **Minor (Y)**: 기능 추가, 버그 수정, 호환 가능한 변경

예시: `v1.0`, `v1.1`, `v2.0`

## 폴더 구조

```
40_versions/
├── v1.0/
│   ├── ko-KR/           # 승인된 한국어 원본 (불변)
│   │   ├── prd.md
│   │   ├── architecture.md
│   │   ├── design.md
│   │   ├── api-spec.md
│   │   ├── db-schema.md
│   │   └── tasks/
│   ├── en-US/           # 번역된 영어 버전 (불변)
│   │   ├── prd.md
│   │   └── ...
│   └── manifest.md      # 버전 메타데이터
├── v1.1/
│   └── ...
└── README.md
```

## 버전 생성 과정

```
Human Approved (30_approvals/)
    ↓
[Orchestrator] 스냅샷 생성
    ↓
10_drafts/ko-KR/ → 40_versions/vX.Y/ko-KR/ (복사)
    ↓
[Translation Agent] 번역
    ↓
40_versions/vX.Y/en-US/ (생성)
    ↓
[Translation Reviewer] 검증
```

## manifest.md 내용

각 버전 폴더에는 `manifest.md` 포함:

```markdown
# Version Manifest

## 버전 정보
- 버전: v1.0
- 생성 일시: 2026-03-07
- 승인 기록: ../30_approvals/approval-v1.0-20260307.md

## 포함 문서
| 문서 | ko-KR | en-US |
|------|-------|-------|
| PRD | ✅ | ✅ |
| Architecture | ✅ | ✅ |
| Design | ✅ | ✅ |
| API Spec | ✅ | ✅ |
| DB Schema | ✅ | ✅ |
| Tasks | 32개 | 32개 |

## 이전 버전과 차이
(v1.1 이상인 경우)
- 변경 사항 요약
```

## 상태

이 폴더의 모든 문서는 **읽기 전용**입니다.
