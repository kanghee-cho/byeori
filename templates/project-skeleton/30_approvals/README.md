# Approvals (30_approvals)

이 폴더는 **Human Approval 기록**을 저장합니다.

## 핵심 원칙

> **AI Agent는 승인 권한이 없습니다.**
> 모든 승인은 인간이 수행합니다.

## 승인 대상

- `10_drafts/`의 모든 문서
- AI Review가 완료된 후 승인 요청

## 승인 워크플로우

```
Draft (10_drafts/)
    ↓
AI Review (20_reviews/)
    ↓
Human Review (피드백 확인)
    ↓
[선택] 수정 필요 → 10_drafts/ 수정 → 재리뷰
    ↓
[선택] 승인 → 30_approvals/에 기록
    ↓
Versioned (40_versions/)
```

## 승인 기록 형식

파일명: `approval-{version}-{YYYYMMDD}.md`

예시: `approval-v1.0-20260307.md`

템플릿은 `90_admin/approval-record.template.md` 참조

## 승인 기록 예시

```markdown
# Approval Record

## 버전 정보
- 버전: v1.0
- 승인 일시: 2026-03-07
- 승인자: [이름]

## 승인 범위

| 문서 | 상태 | 비고 |
|------|------|------|
| prd.md | ✅ 승인 | - |
| architecture.md | ✅ 승인 | - |
| design.md | ✅ 승인 | 섹션 4.2 조건부 승인 |
| api-spec.md | ✅ 승인 | - |
| db-schema.md | ✅ 승인 | - |
| tasks/*.md | ✅ 승인 | 32개 Task |

## 조건부 승인 사항
- design.md 섹션 4.2: v1.1에서 에러 핸들링 보완 필요

## 서명
승인자: _______________
일시: _______________
```

## 상태

이 폴더의 문서는 **읽기 전용**입니다.
승인 기록은 수정할 수 없습니다.
