# Tasks (10_drafts/ko-KR/tasks)

이 폴더는 **실행 가능한 Task 문서**를 저장합니다.

## 생성 Agent

**Task Decomposition Agent**가 PRD/Architecture/Design을 분석하여 생성

## 계층 구조

```
Epic (E-###)
  └── Feature (F-###)
        └── Story (S-###)
              └── Task (T-####)
```

**ID는 독립적 순번** (3자리, Task는 4자리)
**상위 계층 관계는 문서 내 메타데이터에서 표현**

- `E-001` → Epic 001
- `F-001` → Feature 001 (상위 Epic은 메타데이터에 명시)
- `S-001` → Story 001
- `T-0001` → Task 0001

## 파일 명명 규칙

```
tasks/
├── E-001-user-management.md
├── F-001-user-registration.md
├── S-001-email-signup.md
├── T-0001-validate-email-format.md
├── T-0002-send-verification-email.md
└── ...
```

**형식:** `{TYPE}-{ID}-{slug}.md`

| 접두사 | 의미 | 자릿수 |
|--------|------|--------|
| E- | Epic | 3 |
| F- | Feature | 3 |
| S- | Story | 3 |
| T- | Task | 4 |

## Task 유효성 조건

Task는 다음 조건을 **모두** 만족해야 유효:

1. ✅ Acceptance Criteria (AC)가 완전하고 테스트 가능
2. ✅ 입력/출력/에러 케이스가 명시적
3. ✅ 의존성이 문서화됨
4. ✅ PRD/Architecture로 트레이서빌리티 링크 존재

## 다음 단계

Task 생성 후:
1. **Task Reviewer Agent** 호출
2. 리뷰 결과 → `20_reviews/task-review/`
3. AC 불완전 시 → Task 분할 또는 수정
