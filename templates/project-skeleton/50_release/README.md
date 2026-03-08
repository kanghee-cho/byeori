# Release (50_release)

이 폴더는 **최종 릴리스 번들**을 저장합니다.

## 핵심 원칙

> **릴리스는 영어(en-US)만 포함합니다.**
> 한국어 문서는 릴리스 번들에 포함되지 않습니다.

## 목적

이 폴더의 문서는 **Prompt-Ready** 상태로:
- AI 코딩 도구 (Claude, Cursor, Copilot 등)에 직접 입력 가능
- 개발자가 즉시 개발 착수 가능
- 추가 해석 없이 구현 가능한 수준의 명세

## 폴더 구조

```
50_release/
├── v1.0/
│   ├── prd.md
│   ├── architecture.md
│   ├── design.md
│   ├── api-spec.md
│   ├── db-schema.md
│   ├── tasks/
│   │   ├── T-0001.md
│   │   └── ...
│   └── release-notes.md
├── v1.1/
│   └── ...
└── README.md
```

## 릴리스 조건

Release Gatekeeper가 검증하는 조건:

1. ✅ 모든 필수 문서 존재
2. ✅ Spec Review 통과
3. ✅ Task Review 통과 (모든 Task READY)
4. ✅ Human Approval 기록 존재
5. ✅ Translation Review 통과
6. ✅ en-US 문서만 포함

## release-notes.md 예시

```markdown
# Release Notes - v1.0

## 릴리스 정보
- 버전: v1.0
- 릴리스 일시: 2026-03-07
- 승인자: [이름]

## 포함 내용
- PRD: 제품 요구사항
- Architecture: 시스템 아키텍처
- Design: 소프트웨어 설계
- API Spec: 12개 엔드포인트
- DB Schema: 8개 테이블
- Tasks: 32개 실행 가능 Task

## 개발 시작 방법
1. 이 폴더의 문서를 AI 코딩 도구에 입력
2. Task 순서대로 구현
3. 각 Task의 AC 기준으로 검증

## 알려진 제한사항
- ...
```

## 상태

이 폴더의 모든 문서는 **읽기 전용**입니다.
