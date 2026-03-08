# Task Review (20_reviews/task-review)

이 폴더는 **Task Reviewer Agent**의 리뷰 결과를 저장합니다.

## 리뷰 대상

- `10_drafts/ko-KR/tasks/` 내 모든 Task 문서

## 리뷰 관점

Task Reviewer는 **개발 준비도**를 검증합니다:

1. **AC 완전성** — Acceptance Criteria가 테스트 가능하고 명확한가
2. **입력/출력 명시** — 입력 데이터, 출력 결과가 정의되었는가
3. **에러 케이스** — 실패 시나리오가 문서화되었는가
4. **의존성** — 선행 Task, 외부 시스템 의존성이 명시되었는가
5. **트레이서빌리티** — PRD/Architecture 링크가 존재하는가

## 출력 형식

```
task-review/
├── T-0001-review.md
├── T-0002-review.md
└── batch-review-summary.md  # 전체 Task 요약
```

## 리뷰 결과 구조

```markdown
# Task [T-XXX] 리뷰

## 판정
- 상태: READY / NEEDS_SPLIT / NEEDS_REVISION
- 리뷰 일시: YYYY-MM-DD

## AC 검증

| AC# | 테스트 가능 | 명확성 | 판정 |
|-----|-------------|--------|------|
| AC1 | ✅ | ✅ | PASS |
| AC2 | ❌ | ✅ | FAIL - 측정 기준 없음 |

## 분할 권고
(NEEDS_SPLIT인 경우)
- 권고 하위 Task 1: ...
- 권고 하위 Task 2: ...

## 수정 필요 사항
...
```

## 상태

이 폴더의 문서는 **읽기 전용**입니다.
