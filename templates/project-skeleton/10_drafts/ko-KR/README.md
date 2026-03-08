# Drafts (10_drafts/ko-KR)

이 폴더는 **작업 중인 문서 초안**을 저장합니다.

## 상태

- **Draft** — 수정 가능한 유일한 상태
- 이 폴더의 문서만 편집할 수 있음

## 언어

- **ko-KR (한국어)** — 모든 초안은 한국어로 작성

## 문서 종류

| 파일명 | 생성 Agent | 설명 |
|--------|-----------|------|
| `prd.md` | PRD Agent | 제품 요구사항 문서 |
| `architecture.md` | System Architect Agent | 시스템 아키텍처 |
| `design.md` | Software Design Agent | 소프트웨어 설계 |
| `api-spec.md` | API Spec Agent | API 명세 |
| `db-schema.md` | Data Schema Agent | 데이터베이스 스키마 |

## 생성 순서

```
PRD Agent
    ↓
System Architect Agent
    ↓
Software Design Agent
    ↓
API Spec Agent + Data Schema Agent
    ↓
Task Decomposition Agent → tasks/
```

## 파일 명명 규칙

- 소문자, 하이픈 구분: `api-spec.md`
- 확장자: `.md`

## 다음 단계

Draft 완료 후:
1. **Spec Reviewer Agent** 호출
2. 리뷰 결과 → `20_reviews/spec-review/`
3. 피드백 반영 후 Human Approval 요청
