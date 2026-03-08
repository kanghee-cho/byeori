# Version Manifest Template

버전 스냅샷 생성 시 각 버전 폴더에 포함되는 메타데이터 파일입니다.

---

## 파일 위치

`40_versions/vX.Y/manifest.md`

---

## 템플릿

```markdown
# Version Manifest

## 버전 정보

| 항목 | 값 |
|------|-----|
| 버전 | v{X.Y} |
| 생성 일시 | {YYYY-MM-DD HH:MM} |
| 생성자 | Orchestrator Agent |
| 승인 기록 | [approval-v{X.Y}-{YYYYMMDD}.md](../../30_approvals/approval-v{X.Y}-{YYYYMMDD}.md) |

---

## 포함 문서

### ko-KR (원본)

| 문서 | 파일 | 상태 |
|------|------|------|
| PRD | ko-KR/prd.md | ✅ |
| Architecture | ko-KR/architecture.md | ✅ |
| Design | ko-KR/design.md | ✅ |
| API Spec | ko-KR/api-spec.md | ✅ |
| DB Schema | ko-KR/db-schema.md | ✅ |
| Tasks | ko-KR/tasks/ | {N}개 |

### en-US (번역)

| 문서 | 파일 | 번역 상태 |
|------|------|-----------|
| PRD | en-US/prd.md | ✅ 완료 / ⏳ 진행 중 / ❌ 미완료 |
| Architecture | en-US/architecture.md | |
| Design | en-US/design.md | |
| API Spec | en-US/api-spec.md | |
| DB Schema | en-US/db-schema.md | |
| Tasks | en-US/tasks/ | |

---

## 버전 변경 사항

(v1.0 이후 버전에서 작성)

### 이전 버전
v{X.Y-1}

### 주요 변경 사항

| 유형 | 설명 |
|------|------|
| 추가 | {새로 추가된 기능/문서} |
| 수정 | {변경된 내용} |
| 삭제 | {제거된 내용} |

### 영향 분석
[v{X.Y-1}-to-v{X.Y}-impact.md](../../20_reviews/impact-analysis/v{X.Y-1}-to-v{X.Y}-impact.md)

---

## 품질 게이트 통과 현황

| 게이트 | 상태 | 일시 |
|--------|------|------|
| Spec Review | ✅ PASS | {YYYY-MM-DD} |
| Task Review | ✅ PASS | {YYYY-MM-DD} |
| Human Approval | ✅ PASS | {YYYY-MM-DD} |
| Translation | ✅ 완료 / ⏳ 진행 중 | {YYYY-MM-DD} |
| Translation Review | ✅ PASS / ⏳ 대기 | {YYYY-MM-DD} |

---

## 릴리스 상태

| 항목 | 상태 |
|------|------|
| 릴리스 가능 | ✅ Yes / ❌ No |
| 릴리스 버전 | [50_release/v{X.Y}/](../../50_release/v{X.Y}/) |
| 릴리스 일시 | {YYYY-MM-DD} 또는 "미릴리스" |

---

## 체크섬 (선택)

파일 무결성 검증용

| 파일 | SHA-256 |
|------|---------|
| ko-KR/prd.md | {hash} |
| ... | ... |
```
