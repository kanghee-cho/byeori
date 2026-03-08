# ID 규칙 (ID Conventions)

이 문서는 프로젝트 전체에서 사용되는 **식별자(ID) 체계**를 정의합니다.

---

## 문서 ID

### 형식
문서에는 별도 ID를 부여하지 않음. 파일명이 식별자 역할.

| 문서 | 파일명 |
|------|--------|
| PRD | `prd.md` |
| Architecture | `architecture.md` |
| Design | `design.md` |
| API Spec | `api-spec.md` |
| DB Schema | `db-schema.md` |

---

## 요구사항 ID

### 형식
`REQ-{카테고리}-{번호}`

### 카테고리
| 코드 | 의미 |
|------|------|
| F | Functional (기능) |
| NF | Non-Functional (비기능) |
| C | Constraint (제약) |

### 예시
- `REQ-F-001`: 첫 번째 기능 요구사항
- `REQ-NF-003`: 세 번째 비기능 요구사항
- `REQ-C-002`: 두 번째 제약사항

---

## Task 계층 ID

### 형식
`{타입}-{번호}`

### 타입 접두사
| 접두사 | 의미 | 계층 | 자릿수 | 범위 |
|--------|------|------|--------|--------|
| E | Epic | 1 | 3자리 | 001-999 |
| F | Feature | 2 | 3자리 | 001-999 |
| S | Story | 3 | 3자리 | 001-999 |
| T | Task | 4 | 4자리 | 0001-9999 |

### ID 예시
```
E-001        # Epic
F-001        # Feature
S-001        # Story
T-0001       # Task
```

### 계층 관계
상위 계층 관계는 **파일명이 아닌 메타데이터**로 표현:
```markdown
> - ID: T-0001
> - 상위 Story: S-005
> - 상위 Feature: F-002  
> - 상위 Epic: E-001
```

### 파일명 규칙
`{ID}-{slug}.md`

예시:
- `E-001-user-management.md`
- `F-003-email-auth.md`
- `S-012-validate-input.md`
- `T-0001-validate-email-format.md`

---

## API ID

### 엔드포인트 ID
`API-{메서드}-{번호}`

| 메서드 | 코드 |
|--------|------|
| GET | G |
| POST | P |
| PUT | U |
| PATCH | A |
| DELETE | D |

예시:
- `API-G-001`: 첫 번째 GET 엔드포인트
- `API-P-003`: 세 번째 POST 엔드포인트

---

## 데이터 ID

### 엔티티 ID
`ENT-{번호}`

예시: `ENT-001`, `ENT-002`

### 테이블 ID
테이블명이 ID 역할 (snake_case)

예시: `users`, `order_items`

---

## 버전 ID

### 형식
`v{Major}.{Minor}`

예시: `v1.0`, `v1.1`, `v2.0`

### 증가 규칙
- Major: 호환성 없는 변경
- Minor: 호환 가능한 변경, 추가

---

## ID 생성 규칙

1. **순차 증가**: 번호는 001(Task는 0001)부터 순차 증가
2. **삭제 시 재사용 금지**: 삭제된 ID는 재사용하지 않음
3. **변경 시 보존**: 내용 변경 시 ID 유지
4. **트레이서빌리티**: 메타데이터에 상위 계층 관계 명시
