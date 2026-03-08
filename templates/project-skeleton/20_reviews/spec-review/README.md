# Spec Review (20_reviews/spec-review)

이 폴더는 **Spec Reviewer Agent**의 리뷰 결과를 저장합니다.

## 리뷰 대상

- PRD (`prd.md`)
- Architecture (`architecture.md`)
- Design (`design.md`)
- API Spec (`api-spec.md`)
- DB Schema (`db-schema.md`)

## 리뷰 관점

Spec Reviewer는 다음을 검증합니다:

1. **문서 간 일관성** — 용어, 범위, 정의 충돌 여부
2. **누락된 요구사항** — 범위 불명확, 미정의 기능
3. **NFR 커버리지** — 보안, 성능, 확장성, 관찰 가능성
4. **Byeori 원칙 준수** — Design First, Zero-Code

## 출력 형식

| 파일명 | 리뷰 대상 |
|--------|-----------|
| `prd-review.md` | PRD |
| `architecture-review.md` | Architecture |
| `design-review.md` | Design |
| `api-spec-review.md` | API Spec |
| `db-schema-review.md` | DB Schema |

## 리뷰 결과 구조

```markdown
# [문서명] 리뷰

## 요약
- 상태: PASS / NEEDS_REVISION / FAIL
- 리뷰 일시: YYYY-MM-DD
- 리뷰어: Spec Reviewer Agent

## 이슈 목록

### [CRITICAL] 이슈 제목
- 위치: 섹션/라인
- 설명: 문제 상세
- 권장 조치: 수정 방안

### [WARNING] 이슈 제목
...

## 권장 사항
...
```

## 상태

이 폴더의 문서는 **읽기 전용**입니다.
리뷰 결과 수정이 필요하면 `10_drafts/` 원본을 수정 후 재리뷰합니다.
