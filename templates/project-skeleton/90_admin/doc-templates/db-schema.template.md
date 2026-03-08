# 데이터베이스 스키마 문서

> **문서 정보**
> - 프로젝트: {프로젝트명}
> - 버전: Draft
> - 작성일: {YYYY-MM-DD}
> - 작성자: Data Schema Agent
> - 참조: [PRD](../prd.md), [Design](../design.md)

---

## 1. 개요

### 1.1 목적
{데이터베이스 설계의 목적과 범위}

### 1.2 데이터베이스 정보

| 항목 | 값 |
|------|-----|
| DBMS | {PostgreSQL / MySQL / ...} |
| 버전 | {버전} |
| 문자셋 | UTF-8 |
| Collation | {collation} |

### 1.3 명명 규칙

| 대상 | 규칙 | 예시 |
|------|------|------|
| 테이블 | snake_case, 복수형 | `users`, `order_items` |
| 컬럼 | snake_case | `created_at`, `user_id` |
| PK | `id` | `id` |
| FK | `{테이블_단수}_id` | `user_id` |
| 인덱스 | `idx_{테이블}_{컬럼}` | `idx_users_email` |
| Unique | `uq_{테이블}_{컬럼}` | `uq_users_email` |

---

## 2. ERD (Entity Relationship Diagram)

```
┌─────────────┐       ┌─────────────┐
│   users     │       │   orders    │
├─────────────┤       ├─────────────┤
│ id (PK)     │──┐    │ id (PK)     │
│ email       │  │    │ user_id(FK) │←─┐
│ name        │  │    │ status      │  │
│ created_at  │  └───→│ created_at  │  │
└─────────────┘       └─────────────┘  │
                                       │
                      ┌─────────────┐  │
                      │ order_items │  │
                      ├─────────────┤  │
                      │ id (PK)     │  │
                      │ order_id(FK)│──┘
                      │ product_id  │
                      │ quantity    │
                      └─────────────┘
```

---

## 3. 테이블 정의

### 3.1 users

**설명**: 사용자 정보를 저장합니다.

**엔티티 ID**: ENT-001

| 컬럼명 | 데이터 타입 | NULL | 기본값 | 설명 |
|--------|-------------|------|--------|------|
| id | VARCHAR(26) | NO | - | PK, ULID |
| email | VARCHAR(255) | NO | - | 이메일 (Unique) |
| password_hash | VARCHAR(255) | NO | - | 해시된 비밀번호 |
| name | VARCHAR(100) | NO | - | 이름 |
| phone | VARCHAR(20) | YES | NULL | 전화번호 |
| status | VARCHAR(20) | NO | 'ACTIVE' | 상태 |
| created_at | TIMESTAMP | NO | CURRENT_TIMESTAMP | 생성일시 |
| updated_at | TIMESTAMP | NO | CURRENT_TIMESTAMP | 수정일시 |
| deleted_at | TIMESTAMP | YES | NULL | 삭제일시 (Soft Delete) |

**제약조건**:
| 이름 | 유형 | 대상 컬럼 |
|------|------|-----------|
| pk_users | PRIMARY KEY | id |
| uq_users_email | UNIQUE | email |
| chk_users_status | CHECK | status IN ('ACTIVE', 'SUSPENDED', 'DELETED') |

**인덱스**:
| 이름 | 컬럼 | 유형 | 용도 |
|------|------|------|------|
| idx_users_email | email | BTREE | 이메일 조회 |
| idx_users_status | status | BTREE | 상태 필터 |
| idx_users_created_at | created_at | BTREE | 정렬 |

**DDL**:
```sql
CREATE TABLE users (
    id VARCHAR(26) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT chk_users_status CHECK (status IN ('ACTIVE', 'SUSPENDED', 'DELETED'))
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_status ON users(status);
CREATE INDEX idx_users_created_at ON users(created_at);
```

---

### 3.2 {테이블명}

(동일한 형식으로 계속)

---

## 4. 관계 정의

### 4.1 관계 목록

| 부모 테이블 | 자식 테이블 | 관계 | FK 컬럼 | ON DELETE | ON UPDATE |
|-------------|-------------|------|---------|-----------|-----------|
| users | orders | 1:N | user_id | SET NULL | CASCADE |
| orders | order_items | 1:N | order_id | CASCADE | CASCADE |

### 4.2 관계 상세

#### users → orders

- **관계 유형**: 1:N (한 사용자가 여러 주문 가능)
- **참여도**: 사용자는 0개 이상의 주문 가능
- **비즈니스 규칙**: 사용자 삭제 시 주문의 user_id는 NULL 처리

---

## 5. 열거형 및 상수

### 5.1 status 값

#### users.status

| 값 | 설명 | 전환 가능 상태 |
|----|------|----------------|
| ACTIVE | 활성 사용자 | SUSPENDED, DELETED |
| SUSPENDED | 정지된 사용자 | ACTIVE, DELETED |
| DELETED | 삭제된 사용자 | - |

#### orders.status

| 값 | 설명 | 전환 가능 상태 |
|----|------|----------------|
| PENDING | 결제 대기 | PAID, CANCELLED |
| PAID | 결제 완료 | SHIPPED, REFUNDED |
| SHIPPED | 배송 중 | DELIVERED |
| DELIVERED | 배송 완료 | - |
| CANCELLED | 취소됨 | - |
| REFUNDED | 환불됨 | - |

---

## 6. 데이터 사전

### 6.1 공통 컬럼

| 컬럼명 | 데이터 타입 | 설명 | 적용 테이블 |
|--------|-------------|------|-------------|
| id | VARCHAR(26) | ULID 형식 PK | 전체 |
| created_at | TIMESTAMP | 레코드 생성 일시 | 전체 |
| updated_at | TIMESTAMP | 레코드 수정 일시 | 전체 |
| deleted_at | TIMESTAMP | 소프트 삭제 일시 | 소프트 삭제 대상 |

### 6.2 도메인별 데이터 타입

| 도메인 | 데이터 타입 | 제약 | 예시 |
|--------|-------------|------|------|
| ID | VARCHAR(26) | ULID 형식 | 01ARZ3NDEKTSV4RRFFQ69G5FAV |
| Email | VARCHAR(255) | 이메일 형식 | user@example.com |
| Phone | VARCHAR(20) | E.164 형식 | +821012345678 |
| Money | DECIMAL(19,4) | 양수 | 10000.0000 |
| Percentage | DECIMAL(5,2) | 0-100 | 15.50 |

---

## 7. 마이그레이션 전략

### 7.1 버전 관리

| 마이그레이션 ID | 설명 | 적용 버전 |
|-----------------|------|-----------|
| 001_create_users | users 테이블 생성 | v1.0 |
| 002_create_orders | orders 테이블 생성 | v1.0 |

### 7.2 롤백 계획

| 마이그레이션 | 롤백 SQL |
|--------------|----------|
| 001_create_users | DROP TABLE users; |

---

## 8. 성능 고려사항

### 8.1 예상 데이터 볼륨

| 테이블 | 1년 후 예상 | 3년 후 예상 | 증가율 |
|--------|-------------|-------------|--------|
| users | 100,000 | 500,000 | 월 5% |
| orders | 500,000 | 3,000,000 | 월 10% |

### 8.2 쿼리 패턴

| 쿼리 패턴 | 빈도 | 대응 인덱스 |
|-----------|------|-------------|
| 이메일로 사용자 조회 | 높음 | idx_users_email |
| 사용자별 주문 목록 | 높음 | idx_orders_user_id |

### 8.3 파티셔닝 전략

| 테이블 | 파티션 키 | 전략 | 적용 시점 |
|--------|-----------|------|-----------|
| orders | created_at | RANGE (월별) | 100만 건 이후 |

---

## 9. 보안 고려사항

### 9.1 민감 데이터

| 테이블 | 컬럼 | 민감도 | 보호 방안 |
|--------|------|--------|-----------|
| users | password_hash | 높음 | bcrypt 해시 |
| users | email | 중간 | 접근 제어 |
| users | phone | 중간 | 암호화 (선택) |

### 9.2 접근 제어

| 역할 | 권한 | 대상 테이블 |
|------|------|-------------|
| app_read | SELECT | 전체 |
| app_write | SELECT, INSERT, UPDATE | 전체 |
| app_admin | ALL | 전체 |

---

## 10. 변경 이력

| 버전 | 일시 | 변경 내용 | 작성자 |
|------|------|-----------|--------|
| Draft | {YYYY-MM-DD} | 최초 작성 | Data Schema Agent |
