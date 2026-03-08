# 벼리 (Byeori)

> **"벼리는 그물의 위쪽 코를 꿰어 놓은 줄로, 그물 전체를 유지하고 이끄는 핵심 줄입니다. 이름처럼, 벼리는 궁극의 진실의 원천(Source of Truth)을 만드는 데 집중하는 탑다운 멀티 에이전트 AI 시스템입니다. 코드를 급하게 작성하는 대신, 포괄적이고 완벽한 문서와 아키텍처를 협업하여 생성합니다. 개발자와 AI 에이전트가 따를 수 있는 절대적인 표준을 보장합니다."**

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

[English](README.md) | **한국어**

## 철학: 설계 우선, 코드는 나중에

많은 AI 코딩 어시스턴트는 모호한 프롬프트를 기반으로 바로 코드를 작성하려 해서 실패합니다. **벼리는 코드를 한 줄도 작성하지 않습니다.** 대신, 최고의 소프트웨어 아키텍트이자 프로덕트 매니저로서 역할합니다. 아이디어를 제공하면, 벼리의 멀티 에이전트 시스템이 탑다운 방식으로 명확하고 개발 준비가 완료된 문서를 생성합니다. 벼리가 청사진을 제공하면, 모든 개발자나 AI 코딩 도구가 소프트웨어를 완벽하게 구축할 수 있습니다.

## 주요 기능

- **탑다운 아키텍처 설계**: 핵심 목표에서 시작하여 실행 가능한 컴포넌트로 분해합니다.
- **멀티 에이전트 협업**: 전문화된 에이전트(예: 프로덕트 매니저, 시스템 아키텍트, 컨설턴트)가 사양을 토론하고 정제합니다.
- **제로 코드 문서 생성**: 완벽한 PRD(제품 요구사항 문서), 시스템 아키텍처, 소프트웨어 설계, API 사양, 데이터베이스 스키마를 마크다운 형식으로 생성합니다.
- **프롬프트 준비 완료**: 출력 문서가 코딩 AI(Claude, Cursor, Copilot 등)에 바로 입력할 수 있도록 완벽하게 구조화됩니다.
- **버전 관리 및 불변성**: 승인된 문서는 불변의 버전으로 스냅샷되어, 신뢰할 수 있는 진실의 원천을 보장합니다.
- **이중 언어 워크플로우**: 한국어(ko-KR)로 초안을 작성하고, 영어(en-US)로 기술 번역하여 릴리스합니다.

---

## 저장소 구조

```
byeori/
├── AGENTS.md                    # 헌법 (모든 에이전트의 최상위 규칙)
├── README.md                    # 영문 README
├── README_KO.md                 # 한글 README (현재 파일)
├── Projects/                    # 모든 관리 프로젝트
│   └── <project-name>/
│       ├── 00_context/          # 입력 자료, 배경
│       ├── 10_drafts/ko-KR/     # 작업 초안 (한국어)
│       ├── 20_reviews/          # AI 리뷰 결과
│       │   ├── spec-review/
│       │   ├── task-review/
│       │   └── impact-analysis/
│       ├── 30_approvals/        # 인간 승인 기록
│       ├── 40_versions/vX.Y/    # 불변 버전 스냅샷
│       │   ├── ko-KR/           # 승인된 한국어 스냅샷
│       │   └── en-US/           # 번역된 영어 버전
│       ├── 50_release/vX.Y/     # 릴리스 번들 (en-US만)
│       └── 90_admin/            # 프로젝트 관리 (용어집, 템플릿)
├── templates/
│   └── project-skeleton/        # 새 프로젝트용 템플릿
└── .github/
    ├── agents/                  # 에이전트 정의 (*.agent.md)
    ├── skills/                  # 재사용 가능한 스킬 패키지
    └── copilot-instructions.md  # 전역 Copilot 지침
```

---

## 문서 라이프사이클

모든 문서는 폴더-상태 매핑이 있는 엄격한 라이프사이클을 따릅니다:

```
Draft (10_drafts/ko-KR/)
  ↓  Spec Reviewer / Task Reviewer
AI Reviewed (20_reviews/)
  ↓  인간의 결정 필요
Human Approved (30_approvals/)
  ↓  스냅샷 생성
Versioned (40_versions/vX.Y/ko-KR/)
  ↓  Translation Agent
Translation (40_versions/vX.Y/en-US/)
  ↓  Translation Reviewer
Translation Reviewed
  ↓  Release Gatekeeper
Released (50_release/vX.Y/ — en-US만)
```

### 상태 전환 규칙

| 시작 상태 | 종료 상태 | 게이트 조건 |
|----------|----------|------------|
| Draft | AI Reviewed | 필수 문서 존재, Spec/Task 리뷰 완료 |
| AI Reviewed | Human Approved | 피드백 반영, 인간 승인 기록됨 |
| Human Approved | Versioned | ko-KR 스냅샷 생성 (불변) |
| Versioned | Translation | Translation Agent 호출 |
| Translation | Translation Reviewed | en-US 생성, Translation Reviewer 완료 |
| Translation Reviewed | Released | QA 통과, Release Gatekeeper 승인 |

### 불변성 규칙

- **편집 가능**: `10_drafts/` 문서만
- **불변**: `40_versions/` 및 `50_release/` — 변경 시 새 버전 필요

---

## 언어 정책

| 단계 | 언어 | 위치 |
|------|------|------|
| 초안 작성 | ko-KR (한국어) | `10_drafts/ko-KR/` |
| 버전 스냅샷 | ko-KR | `40_versions/vX.Y/ko-KR/` |
| 기술 번역 | en-US (영어) | `40_versions/vX.Y/en-US/` |
| 릴리스 번들 | **en-US만** | `50_release/vX.Y/` |

- 번역은 **기술 번역**이며, 직역이 아닙니다
- 사양 우선 톤, AI/개발자 가독성, 의미 보존
- 용어집 기반 용어 일관성

## 에이전트 모델

벼리는 실행 준비가 완료된 문서 세트를 생성하고 지속적으로 개선하는 3가지 카테고리의 에이전트로 구성됩니다 (코드는 작성하지 않음).

### 주요 결정 사항

| 결정 | 선택 | 근거 |
|------|------|------|
| 리뷰어 분리 | **활성화** | Spec Reviewer와 Task Reviewer가 별도 에이전트 |
| 태스크 크기 | **AC 완전성 우선** | AC가 완전히 테스트 가능할 때 "충분히 작음" |
| 언어 정책 | **ko-KR 초안 / en-US 릴리스** | 기술 번역, 직역 아님 |
| 인간 권한 | **필수** | AI 에이전트는 승인 불가능; 인간 승인 필수 |

---

### 1) Generate (초안 작성 / 저작)

탑다운 청사진 문서를 생성하고 실행 준비가 완료된 태스크로 분해하는 에이전트들.

- **Product / PRD Agent**
  - PRD 생성: 문제, 목표, 범위, 비범위, 사용자 시나리오, 성공 기준
- **System Architect Agent**
  - 시스템 아키텍처 생성: 컴포넌트, 경계, 주요 흐름, NFR 매핑
- **Software Design Agent**
  - 소프트웨어 설계 생성: 모듈 책임, 시퀀스/흐름, 오류 정책, 설계 결정
- **Interface / API Spec Agent**
  - API/계약 사양 생성: 엔드포인트, 스키마, 오류 모델, 버전 계약
- **Data / Schema Agent**
  - 데이터 모델 및 DB 스키마 생성: 엔터티, 관계, 제약조건, 인덱스, 데이터 사전
- **Task Decomposition Agent**
  - PRD/아키텍처/사양을 Epic → Feature → Story → **Task**로 분해
  - 각 Task가 **AC 완전성** 기반으로 실행 가능하도록 보장 (테스트 가능하고 명확한 인수 기준)
- **Translation Agent**
  - 릴리스 시점에 기술 번역 수행 (ko-KR → en-US)
  - 의미를 정확히 보존하면서 명확성과 사양 톤으로 재작성

---

### 2) Review (품질 / 일관성)

모호함, 불일치, 누락, 준비 상태 격차를 탐지하는 에이전트들 — 최종 승인 권한 없음.

- **Spec Reviewer Agent (AI)**
  - PRD/아키텍처/설계/API/DB 문서 리뷰:
    - 문서 간 일관성
    - 누락된 요구사항 / 불분명한 범위
    - NFR 커버리지 (보안, 성능, 관찰 가능성 등)
    - 벼리 원칙 위반 (설계 우선, 코드는 나중에)
- **Task Quality Reviewer Agent (AI)**
  - "개발 준비 완료" 품질 리뷰:
    - 인수 기준이 완전히 테스트 가능하고 완전함
    - 입력/출력/오류가 명시적임
    - 의존성과 영향이 문서화됨
    - AC가 숨겨진 복잡성을 드러낼 때 태스크 분할 제안
- **Change Impact Analyzer Agent**
  - 버전 간 차이를 분석하고 파급 효과 보고:
    - 영향받는 문서/태스크
    - 회귀 위험 및 필요한 후속 작업
    - 추적성과 릴리스 준비를 위한 업데이트 제안
- **Translation Reviewer Agent**
  - 번역된 (en-US) 문서 리뷰:
    - ko-KR 소스와의 의미 동등성
    - 용어집 일관성 및 사양 톤 준수
    - 추적성 보존

---

### 3) Governance (흐름 / 상태 / 릴리스)

라이프사이클 상태, 인간 승인 게이트, 버전 관리, 릴리스 패키징을 오케스트레이션하는 에이전트들.

- **Orchestrator Agent**
  - 엔드투엔드 워크플로우 및 상태 전환 제어
  - 각 단계에서 올바른 에이전트로 작업 라우팅
  - 라이프사이클 규칙 및 인간 승인 게이트 강제
  - 자체적으로 콘텐츠를 저작, 리뷰, 승인하지 않음
  - 모호함이나 충돌 감지 시 중지하고 에스컬레이션
- **Release Gatekeeper Agent**
  - 릴리스 준비 완료 문서 번들 검증:
    - 필수 문서 존재
    - 리뷰 게이트 통과
    - 인간 승인 기록됨
    - en-US만 패키징 확인

---

## 태스크 정책

태스크는 벼리의 최종 결과물입니다 — 개발 준비가 완료된 실행 가능한 사양.

### 태스크 유효성

태스크가 유효한 조건:
- 인수 기준(AC)이 완전하고, 테스트 가능하며, 명확함
- 입력, 출력, 오류 케이스, 의존성이 명시적임
- PRD 요구사항 및 아키텍처 결정에 대한 추적성 링크 존재

### 태스크 크기 결정

태스크 크기는 **시간 기반이 아닙니다**. 유일한 기준은 **AC 완전성**입니다.
- AC가 불분명하면 → 태스크 분할 또는 정제
- 숨겨진 복잡성이 드러나면 → 하위 태스크 권장

### 태스크 수정 정책

| 액션 | 규칙 |
|------|------|
| 업데이트 | 태스크 ID 유지, 내용 업데이트 |
| 폐기 | 상태를 `Deprecated`로 표시 (기능 유지되지만 새 사용 비권장) |
| 퇴역 | 상태를 `Retired`로 표시 (완전히 구식) |
| 삭제 | 기능이 완전히 제거될 때만 (가능하면 피함) |

### 태스크 라이프사이클 상태

| 상태 | 편집 가능 |
|------|----------|
| Draft | ✅ 예 |
| AI Reviewed | ❌ 아니오 |
| Human Approved | ❌ 아니오 |
| Versioned | ❌ 아니오 |
| Released | ❌ 아니오 |
| Deprecated | ❌ 아니오 |
| Retired | ❌ 아니오 |

---

## 작동 방식

### 1단계: 입력 및 컨텍스트 (인간)
- 대략적인 아이디어, 문제 진술, 초기 요구사항 제공
- 배경 자료를 `00_context/`에 배치

### 2단계: 청사진 생성 (AI 에이전트)
Orchestrator가 Generate 에이전트를 순서대로 라우팅:

1. **PRD Agent** → 제품 요구사항 문서
2. **System Architect Agent** → 아키텍처 문서
3. **Software Design Agent** → 설계 문서
4. **API Spec Agent** → API 사양
5. **Data Schema Agent** → 데이터베이스 스키마
6. **Task Decomposition Agent** → Epic → Feature → Story → Task 분해

모든 초안은 `10_drafts/ko-KR/`에 생성됩니다.

### 3단계: 리뷰 (AI 에이전트)
- **Spec Reviewer**가 일관성, 완전성, NFR 커버리지 확인
- **Task Reviewer**가 AC 완전성 및 개발 준비 상태 검증
- 리뷰 결과는 `20_reviews/`에 저장

### 4단계: 인간 승인 (인간 게이트)
- 인간이 AI 피드백을 검토하고 최종 결정
- 승인은 `30_approvals/`에 기록
- **AI 에이전트는 문서를 승인할 수 없음**

### 5단계: 버전 관리 및 번역 (AI 에이전트)
- 승인된 ko-KR 문서가 `40_versions/vX.Y/ko-KR/`로 스냅샷 (불변)
- **Translation Agent**가 `40_versions/vX.Y/en-US/`로 기술 번역 수행
- **Translation Reviewer**가 의미 동등성 및 용어집 준수 검증

### 6단계: 릴리스 (AI + 인간)
- **Release Gatekeeper**가 번들 검증
- 최종 en-US 패키지가 `50_release/vX.Y/`에 생성
- 출력은 코딩 AI를 위해 **프롬프트 준비 완료**

---

## 시작하기

### 사전 요구사항

- Copilot Chat 확장이 설치된 **VS Code**
- 버전 관리를 위한 **Git**

### 설치

```bash
# 저장소 복제
git clone https://github.com/kanghee-cho/byeori.git
cd byeori
```

### 빠른 시작: 첫 프로젝트 만들기

#### 1. 쉘 스크립트로 새 프로젝트 생성

```bash
# Unix/macOS/Linux
./scripts/create-project.sh my-app-name

# Windows PowerShell
.\scripts\create-project.ps1 my-app-name
```

`projects/my-app-name/`에 프로젝트 구조가 생성됩니다.

#### 2. 초기 컨텍스트 추가

아이디어, 요구사항 또는 배경 자료를 다음 위치에 배치:
```
projects/my-app-name/00_context/initial-idea.md
```

#### 3. VS Code Chat으로 에이전트 호출

VS Code를 열고 Chat 패널에서 벼리 에이전트를 호출:

```
@product-prd 00_context/initial-idea.md를 기반으로 PRD 생성해줘
```

에이전트가 `projects/my-app-name/10_drafts/ko-KR/prd.md`를 생성합니다.

#### 4. 문서 체인 계속하기

```
@system-architect PRD에서 아키텍처 생성해줘
@software-design PRD와 아키텍처에서 설계 생성해줘
@api-spec 설계에서 API 사양 생성해줘
@data-schema 설계에서 데이터베이스 스키마 생성해줘
@task-decomposition 실행 가능한 태스크로 분해해줘
```

#### 5. 리뷰 및 승인

```
@spec-reviewer PRD 문서 리뷰해줘
@task-reviewer AC 완전성 리뷰해줘
```

리뷰 결과는 `20_reviews/`에 나타납니다. 진행 전 인간 승인이 필요합니다.

#### 6. 버전 관리 및 번역

승인 후, 버전 스냅샷을 생성하고 번역:
```bash
# 버전 스냅샷 생성
cp -r projects/my-app-name/10_drafts/ko-KR/* projects/my-app-name/40_versions/v1.0/ko-KR/
```

```
@translation 모든 문서를 en-US로 번역해줘
@translation-reviewer 번역 리뷰해줘
```

#### 7. 릴리스 준비 상태 확인

```
@release-gatekeeper v1.0이 릴리스 준비되었는지 확인해줘
```

모든 게이트를 통과하면, `50_release/v1.0/` (en-US만)에 릴리스 번들이 생성됩니다.

---

## 명령줄 인터페이스 (CLI)

벼리는 일반적인 작업을 위한 CLI 래퍼를 제공합니다.

### 메인 CLI: `byeori.sh` / `byeori.ps1`

```bash
# Unix/macOS/Linux
./scripts/byeori.sh <command> [options]

# Windows PowerShell
.\scripts\byeori.ps1 <command> [options]
```

#### 명령어

| 명령어 | 설명 | 예시 |
|-------|------|------|
| `agent <name> <project>` | 프로젝트에 에이전트 호출 | `./scripts/byeori.sh agent prd my-app` |
| `list` | 사용 가능한 에이전트 목록 | `./scripts/byeori.sh list` |
| `status <project>` | 프로젝트 문서 상태 표시 | `./scripts/byeori.sh status my-app` |
| `diff <project> <v1> <v2>` | 두 버전 비교 | `./scripts/byeori.sh diff my-app v1.0 v1.1` |
| `create <project>` | 새 프로젝트 생성 | `./scripts/byeori.sh create my-app` |
| `help` | 도움말 표시 | `./scripts/byeori.sh help` |

#### 에이전트 단축키

| 단축키 | 전체 에이전트 이름 |
|-------|-------------------|
| `prd` | product-prd |
| `architect` | system-architect |
| `design` | software-design |
| `api` | api-spec |
| `db` | data-schema |
| `tasks` | task-decomposition |
| `spec-review` | spec-reviewer |
| `task-review` | task-reviewer |
| `translate` | translation |
| `translate-review` | translation-reviewer |
| `impact` | impact-analyzer |
| `release` | release-gatekeeper |
| `orchestrator` | orchestrator |

#### CLI를 통한 예시 워크플로우

```bash
# 새 프로젝트 생성
./scripts/byeori.sh create my-app

# 문서 체인 생성
./scripts/byeori.sh agent prd my-app
./scripts/byeori.sh agent architect my-app
./scripts/byeori.sh agent design my-app
./scripts/byeori.sh agent api my-app
./scripts/byeori.sh agent db my-app
./scripts/byeori.sh agent tasks my-app

# 리뷰
./scripts/byeori.sh agent spec-review my-app
./scripts/byeori.sh agent task-review my-app

# 상태 확인
./scripts/byeori.sh status my-app
```

### 버전 Diff 도구: `version-diff.sh` / `version-diff.ps1`

프로젝트의 두 버전을 비교하여 변경 사항을 분석합니다.

```bash
# Unix/macOS/Linux
./scripts/version-diff.sh <project> <v1> <v2> [options]

# Windows PowerShell
.\scripts\version-diff.ps1 -Project <project> -V1 <v1> -V2 <v2> [options]
```

#### 옵션

| 옵션 | 설명 | 기본값 |
|------|------|-------|
| `--lang` / `-Lang` | 비교할 언어 (ko-KR, en-US) | ko-KR |
| `--doc` / `-Doc` | 비교할 특정 문서 | all |
| `--output` / `-Output` | 출력 파일 경로 | stdout |
| `--summary` / `-Summary` | 요약만 표시 | false |

#### 예시

```bash
# v1.0과 v1.1 사이의 모든 ko-KR 문서 비교
./scripts/version-diff.sh my-app v1.0 v1.1

# PRD 문서만 비교
./scripts/version-diff.sh my-app v1.0 v1.1 --doc prd.md

# en-US 번역 비교
./scripts/version-diff.sh my-app v1.0 v1.1 --lang en-US

# diff 보고서를 파일로 저장
./scripts/version-diff.sh my-app v1.0 v1.1 --output diff-report.md

# 빠른 요약만
./scripts/version-diff.sh my-app v1.0 v1.1 --summary
```

---

### 사용 가능한 에이전트

| 에이전트 | 명령어 | 목적 |
|---------|-------|------|
| PRD Agent | `@product-prd` | 제품 요구사항 문서 생성 |
| System Architect | `@system-architect` | 아키텍처 문서 생성 |
| Software Design | `@software-design` | 설계 문서 생성 |
| API Spec | `@api-spec` | API 사양 생성 |
| Data Schema | `@data-schema` | 데이터베이스 스키마 생성 |
| Task Decomposition | `@task-decomposition` | 태스크로 분해 |
| Spec Reviewer | `@spec-reviewer` | 사양 문서 리뷰 |
| Task Reviewer | `@task-reviewer` | AC 완전성 리뷰 |
| Translation | `@translation` | ko-KR → en-US 번역 |
| Translation Reviewer | `@translation-reviewer` | 번역 리뷰 |
| Impact Analyzer | `@impact-analyzer` | 변경 영향 분석 |
| Release Gatekeeper | `@release-gatekeeper` | 릴리스 준비 상태 검증 |
| Orchestrator | `@orchestrator` | 워크플로우 제어 (메타 에이전트) |

### 워크플로우 팁

1. **항상 PRD부터 시작** — 다른 모든 문서가 PRD에 의존
2. **승인 전에 리뷰** — AI 리뷰는 인간 승인 전에 필수
3. **한 번에 하나씩 변경** — 초안 수정 후 재리뷰
4. **Orchestrator에게 확인** — `@orchestrator 현재 상태가 어때?`
5. **인간 승인 필수** — AI 에이전트는 문서를 승인할 수 없음

---

## 문제 해결

일반적인 문제와 해결책은 [트러블슈팅 가이드](docs/troubleshooting.md)에 문서화되어 있습니다.

빠른 링크:
- [에이전트가 응답하지 않음](docs/troubleshooting.md#11-에이전트가-응답하지-않음)
- [문서 생성 실패](docs/troubleshooting.md#2-문서-생성-문제)
- [버전/릴리스 문제](docs/troubleshooting.md#4-버전릴리스-문제)
- [CLI 오류](docs/troubleshooting.md#6-cli-스크립트-문제)

---

## 기여하기

벼리는 오픈소스 프로젝트이며 모든 분의 기여를 환영합니다! 에이전트 프롬프트 개선, 새 문서 템플릿 추가, 오타 수정 등 어떤 도움이든 감사합니다.

1. 저장소 포크
2. 새 브랜치 생성 (`git checkout -b feature/amazing-feature`)
3. 변경사항 커밋 (`git commit -m 'Add some amazing feature'`)
4. 브랜치에 푸시 (`git push origin feature/amazing-feature`)
5. Pull Request 열기

## 라이선스

이 프로젝트는 MIT 라이선스로 제공됩니다 - 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.
