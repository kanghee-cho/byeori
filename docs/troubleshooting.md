# Byeori 트러블슈팅 가이드

이 문서는 Byeori 사용 중 발생할 수 있는 일반적인 문제와 해결 방법을 안내합니다.

---

## 목차

1. [Agent 호출 문제](#1-agent-호출-문제)
2. [문서 생성 문제](#2-문서-생성-문제)
3. [리뷰 관련 문제](#3-리뷰-관련-문제)
4. [버전/릴리스 문제](#4-버전릴리스-문제)
5. [번역 관련 문제](#5-번역-관련-문제)
6. [CLI 스크립트 문제](#6-cli-스크립트-문제)
7. [일반적인 오류](#7-일반적인-오류)

---

## 1. Agent 호출 문제

### 1.1 Agent가 인식되지 않음

**증상**: VS Code Chat에서 `@agent-name`을 입력해도 Agent가 나타나지 않음

**원인 및 해결**:

| 원인 | 해결 방법 |
|------|-----------|
| VS Code가 `.github/agents/` 폴더를 인식하지 못함 | VS Code 재시작 |
| Agent 파일명이 잘못됨 | `*.agent.md` 형식 확인 |
| YAML frontmatter 오류 | Agent 파일 첫 번째 `---` 블록 문법 확인 |
| GitHub Copilot 확장 비활성화 | Extensions에서 Copilot 활성화 확인 |

**확인 명령**:
```bash
# Agent 파일 목록 확인
ls -la .github/agents/*.agent.md

# YAML frontmatter 검증
head -10 .github/agents/product-prd.agent.md
```

### 1.2 Agent가 다른 Agent와 혼동됨

**증상**: 특정 Agent를 호출했는데 다른 Agent처럼 동작

**해결**:
1. Agent 이름을 정확히 입력 (대소문자 구분)
2. 프롬프트에서 역할을 명확히 지시
3. 필요시 `AGENTS.md` 참조 요청

**예시**:
```
@spec-reviewer

역할: Spec Reviewer Agent입니다.
이 프로젝트의 PRD를 리뷰해주세요: projects/my-project/10_drafts/ko-KR/prd.md
```

### 1.3 Agent가 무한 루프 또는 중단됨

**증상**: Agent가 응답 중 멈추거나 같은 내용을 반복

**해결**:
1. Chat 세션 종료 후 새 세션 시작
2. 더 작은 단위로 작업 분할 요청
3. 명확한 종료 조건 제시

---

## 2. 문서 생성 문제

### 2.1 문서가 잘못된 위치에 생성됨

**증상**: 문서가 `10_drafts/ko-KR/` 대신 다른 곳에 생성

**해결**:
1. 프로젝트 경로 명시: `projects/<project-name>/10_drafts/ko-KR/`
2. 작업 디렉토리 확인

**예시 프롬프트**:
```
@product-prd

프로젝트 경로: projects/obsidian-sync-service/
출력 위치: 10_drafts/ko-KR/prd.md

위 경로에 PRD를 생성해주세요.
```

### 2.2 템플릿이 적용되지 않음

**증상**: 생성된 문서가 템플릿 형식을 따르지 않음

**해결**:
1. 템플릿 파일 존재 확인: `90_admin/doc-templates/`
2. Agent 프롬프트에서 템플릿 경로 명시

**확인**:
```bash
# 템플릿 파일 확인
ls projects/<project>/90_admin/doc-templates/
```

### 2.3 누락된 섹션이 있음

**증상**: 생성된 문서에 필수 섹션이 빠져있음

**해결**:
1. 템플릿 대비 누락 섹션 확인
2. Agent에게 특정 섹션 추가 요청
3. 입력 문서가 충분한지 확인 (PRD 없이 Architecture 생성 시도 등)

---

## 3. 리뷰 관련 문제

### 3.1 리뷰 결과가 생성되지 않음

**증상**: Review Agent 호출 후 출력 파일이 없음

**해결**:
1. 올바른 출력 경로 확인: `20_reviews/spec-review/` 또는 `20_reviews/task-review/`
2. 리뷰 대상 문서가 존재하는지 확인
3. 리뷰 Agent에 명확한 출력 경로 지시

### 3.2 모든 항목이 PASS로 나옴

**증상**: 문제가 있어 보이는데 리뷰 결과가 전부 통과

**원인**: 리뷰 Agent가 문서를 충분히 읽지 않았을 수 있음

**해결**:
1. 문서 전체를 읽은 후 리뷰하도록 명시
2. 특정 섹션에 대한 심층 리뷰 요청
3. 체크리스트 기반 리뷰 요청

**예시**:
```
@spec-reviewer

1. 먼저 projects/my-project/10_drafts/ko-KR/prd.md 전체를 읽어주세요  
2. 90_admin/doc-templates/prd.template.md 템플릿과 비교해주세요
3. 누락된 섹션, 모호한 표현, 일관성 오류를 찾아주세요
4. 결과를 20_reviews/spec-review/prd-review.md에 저장해주세요
```

### 3.3 리뷰 결과가 너무 엄격함/관대함

**해결**:
- `AGENTS.md`와 Agent 정의에서 리뷰 기준 조정
- Critical/Major/Minor 기준 명확화
- 프롬프트에서 기대 수준 명시

---

## 4. 버전/릴리스 문제

### 4.1 버전 스냅샷 생성 실패

**증상**: `40_versions/vX.Y/` 폴더가 생성되지 않음

**해결**:
1. 수동 버전 생성:
```bash
# 버전 폴더 생성
mkdir -p projects/<project>/40_versions/v0.1/ko-KR

# Draft 복사
cp -r projects/<project>/10_drafts/ko-KR/* \
      projects/<project>/40_versions/v0.1/ko-KR/
```

2. 매니페스트 생성:
```bash
cp projects/<project>/90_admin/version-manifest.template.md \
   projects/<project>/40_versions/v0.1/manifest.md
```

### 4.2 릴리스 게이트 통과 실패

**증상**: Release Gatekeeper가 NOT READY 판정

**확인 단계**:

| Gate | 확인 방법 |
|------|-----------|
| Spec Review | `20_reviews/spec-review/` 존재 여부 |
| Task Review | `20_reviews/task-review/` 존재 여부 |
| Human Approval | `30_approvals/approval-*.md` 존재 여부 |
| Translation | `40_versions/vX.Y/en-US/` 모든 문서 존재 |
| Translation Review | `20_reviews/translation-review/` 존재 여부 |
| All Gates Pass | 모든 리뷰가 PASS 또는 CONDITIONAL(Human 승인) |

**해결**: 차단된 Gate 순서대로 완료

### 4.3 버전 비교(diff) 오류

**증상**: `version-diff.sh` 실행 시 오류

**해결**:
```bash
# 권한 확인
chmod +x scripts/version-diff.sh

# 버전 폴더 존재 확인
ls projects/<project>/40_versions/

# 언어 폴더 확인
ls projects/<project>/40_versions/v0.1/
```

---

## 5. 번역 관련 문제

### 5.1 번역이 너무 직역적임

**증상**: 영어 번역이 어색하거나 기술 용어가 잘못됨

**해결**:
1. `90_admin/glossary.md` 업데이트
2. `90_admin/translation-styleguide.en-US.md` 참조 요청
3. 번역 에이전트에 기술적 맥락 제공

**예시**:
```
@translation

번역 시 다음을 준수해주세요:
1. 90_admin/glossary.md의 용어 사용
2. 90_admin/translation-styleguide.en-US.md 스타일 준수
3. 기술 문서 톤 유지 (marketing 아님)
```

### 5.2 ID가 변경됨

**증상**: 번역 후 `REQ-F-001`, `T-0001` 같은 ID가 바뀜

**해결**:
- ID는 절대 번역하지 않도록 명시
- Translation Reviewer 리뷰 후 수정

**예시**:
```
주의: 다음 ID는 번역하지 마세요:
- REQ-F-###, REQ-NF-###
- E-###, F-###, S-###, T-####
- COMP-###, MOD-###
- API-###, ENT-###
```

### 5.3 번역 출력 위치 오류

**해결**:
- 입력: `40_versions/vX.Y/ko-KR/`
- 출력: `40_versions/vX.Y/en-US/`
- 파일명은 동일하게 유지

---

## 6. CLI 스크립트 문제

### 6.1 스크립트 실행 권한 오류 (macOS/Linux)

**증상**: `Permission denied`

**해결**:
```bash
chmod +x scripts/byeori.sh
chmod +x scripts/version-diff.sh
chmod +x scripts/create-project.sh
```

### 6.2 PowerShell 실행 정책 오류 (Windows)

**증상**: `cannot be loaded because running scripts is disabled`

**해결**:
```powershell
# 현재 사용자에게만 허용
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 6.3 경로 문제

**증상**: `Project not found` 또는 `File not found`

**해결**:
1. 스크립트를 `scripts/` 폴더에서 실행하는지 확인
2. 프로젝트 이름이 정확한지 확인 (대소문자 구분)
3. 상대 경로 대신 절대 경로 사용

```bash
# 올바른 사용법
cd /path/to/byeori
./scripts/byeori.sh status my-project
```

---

## 7. 일반적인 오류

### 7.1 "AGENTS.md와 충돌" 오류

**증상**: Agent가 AGENTS.md 규칙 위반 경고

**원인**: Agent나 Skills 정의가 헌법(AGENTS.md)과 충돌

**해결**:
1. AGENTS.md 읽고 규칙 확인
2. Agent/Skill 정의 수정
3. 충돌 시 AGENTS.md가 우선

### 7.2 Traceability 링크 끊김

**증상**: Task에서 참조하는 REQ-ID나 Story가 없음

**해결**:
1. PRD에서 REQ-ID 확인
2. hierarchy.md에서 Story 확인
3. 누락된 링크 추가

**확인 명령**:
```bash
# REQ-ID 존재 확인
grep -r "REQ-F-001" projects/<project>/10_drafts/ko-KR/

# Task 링크 확인
grep -r "상위 Story" projects/<project>/10_drafts/ko-KR/tasks/
```

### 7.3 중복 ID

**증상**: 같은 ID가 여러 곳에서 사용됨

**해결**:
1. ID 컨벤션 확인: `90_admin/id-conventions.md`
2. 기존 ID 검색:
```bash
grep -rn "T-0001" projects/<project>/
```
3. 충돌 ID 수정 (삭제된 ID 재사용 금지)

---

## 자주 묻는 질문 (FAQ)

### Q1: Agent를 어떤 순서로 호출해야 하나요?

**권장 순서**:
```
1. @product-prd        → PRD 생성
2. @system-architect   → Architecture 생성  
3. @software-design    → Design 생성
4. @api-spec          → API Spec 생성
5. @data-schema       → DB Schema 생성
6. @task-decomposition → Task 분해
7. @spec-reviewer     → 스펙 리뷰
8. @task-reviewer     → Task 리뷰
9. Human Approval     → 수동 승인 기록
10. @translation      → 번역
11. @translation-reviewer → 번역 리뷰
12. @release-gatekeeper → 릴리스 검증
```

또는 `@orchestrator`에게 다음 단계를 물어보세요.

### Q2: 문서를 수정한 후 어떻게 해야 하나요?

1. **Draft 상태**라면 직접 수정 가능
2. 수정 후 `@impact-analyzer`로 영향 범위 분석
3. 연관 문서 업데이트
4. 리뷰 재실행

### Q3: 한 번에 여러 Agent를 호출할 수 있나요?

아니요. Byeori는 한 번에 하나의 Agent만 호출합니다.  
의존성이 있으므로 순서대로 호출해야 합니다.  
`@orchestrator`가 순서를 안내합니다.

### Q4: 승인(Approval)은 어떻게 하나요?

1. `30_approvals/` 폴더에 승인 기록 생성
2. `90_admin/approval-record.template.md` 템플릿 사용
3. 파일명: `approval-v{VERSION}-{DATE}.md`
4. 승인자 정보, 범위, 조건 기록

---

## 도움 받기

문제가 지속되면:

1. **AGENTS.md** 재확인 — 모든 규칙의 근원
2. **Agent 정의 파일** 확인 — `.github/agents/*.agent.md`
3. **템플릿** 확인 — `90_admin/doc-templates/`, `90_admin/task-templates/`
4. **ID 규칙** 확인 — `90_admin/id-conventions.md`

---

*마지막 업데이트: 2026-03-08*
