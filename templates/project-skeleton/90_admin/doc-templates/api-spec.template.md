# API 명세서

> **문서 정보**
> - 프로젝트: {프로젝트명}
> - 버전: Draft
> - 작성일: {YYYY-MM-DD}
> - 작성자: API Spec Agent
> - 참조: [PRD](../prd.md), [Design](../design.md)

---

## 1. 개요

### 1.1 소개
{API의 목적과 대상 클라이언트}

### 1.2 기본 정보

| 항목 | 값 |
|------|-----|
| Base URL | `https://api.{domain}.com` |
| API 버전 | v1 |
| 프로토콜 | HTTPS |
| 데이터 형식 | JSON |
| 인코딩 | UTF-8 |

### 1.3 버전 관리
{API 버전 관리 정책: URL 경로, 헤더 등}

---

## 2. 인증 및 인가

### 2.1 인증 방식

| 방식 | 용도 | 헤더 |
|------|------|------|
| Bearer Token | 일반 API 접근 | `Authorization: Bearer {token}` |
| API Key | 서버 간 통신 | `X-API-Key: {key}` |

### 2.2 토큰 획득

```http
POST /auth/token
Content-Type: application/json

{
  "grant_type": "password",
  "username": "user@example.com",
  "password": "password123"
}
```

**응답**:
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "dGhpcyBpcyBhIHJlZnJl..."
}
```

### 2.3 권한 (Scopes)

| Scope | 설명 |
|-------|------|
| `read:users` | 사용자 정보 조회 |
| `write:users` | 사용자 정보 수정 |

---

## 3. 공통 규격

### 3.1 요청 헤더

| 헤더 | 필수 | 설명 |
|------|------|------|
| `Authorization` | ✅ | 인증 토큰 |
| `Content-Type` | ✅ | `application/json` |
| `Accept-Language` | ❌ | 응답 언어 (기본: ko-KR) |
| `X-Request-ID` | ❌ | 요청 추적 ID |

### 3.2 응답 형식

#### 성공 응답

```json
{
  "data": { ... },
  "meta": {
    "timestamp": "2026-03-07T10:00:00Z",
    "requestId": "req-abc-123"
  }
}
```

#### 목록 응답 (페이지네이션)

```json
{
  "data": [ ... ],
  "pagination": {
    "page": 1,
    "pageSize": 20,
    "totalItems": 150,
    "totalPages": 8
  },
  "meta": { ... }
}
```

#### 에러 응답

```json
{
  "error": {
    "code": "ERR-1001",
    "message": "이메일 형식이 올바르지 않습니다",
    "details": { ... }
  },
  "meta": { ... }
}
```

### 3.3 HTTP 상태 코드

| 코드 | 의미 | 사용 상황 |
|------|------|-----------|
| 200 | OK | 성공 (조회, 수정) |
| 201 | Created | 리소스 생성 성공 |
| 204 | No Content | 삭제 성공 |
| 400 | Bad Request | 잘못된 요청 |
| 401 | Unauthorized | 인증 실패 |
| 403 | Forbidden | 권한 없음 |
| 404 | Not Found | 리소스 없음 |
| 422 | Unprocessable Entity | 비즈니스 규칙 위반 |
| 429 | Too Many Requests | Rate Limit 초과 |
| 500 | Internal Server Error | 서버 오류 |

### 3.4 Rate Limiting

| 구분 | 제한 | 윈도우 |
|------|------|--------|
| 일반 API | 1000 req | 1분 |
| 인증 API | 10 req | 1분 |

**Rate Limit 헤더**:
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1709805600
```

---

## 4. 엔드포인트

### 4.1 사용자 (Users)

---

#### API-P-001: 사용자 생성

**POST** `/v1/users`

**설명**: 새 사용자를 등록합니다.

**요청**:
| 필드 | 타입 | 필수 | 설명 | 제약 |
|------|------|------|------|------|
| email | string | ✅ | 이메일 주소 | 이메일 형식, 최대 255자 |
| password | string | ✅ | 비밀번호 | 최소 8자, 특수문자 포함 |
| name | string | ✅ | 이름 | 최대 100자 |
| phone | string | ❌ | 전화번호 | E.164 형식 |

```json
{
  "email": "user@example.com",
  "password": "Password123!",
  "name": "홍길동",
  "phone": "+821012345678"
}
```

**응답**: `201 Created`
```json
{
  "data": {
    "id": "usr_abc123",
    "email": "user@example.com",
    "name": "홍길동",
    "createdAt": "2026-03-07T10:00:00Z"
  }
}
```

**에러**:
| 코드 | 상황 |
|------|------|
| ERR-1001 | 이메일 형식 오류 |
| ERR-1002 | 비밀번호 규칙 미충족 |
| ERR-5001 | 이미 등록된 이메일 |

---

#### API-G-001: 사용자 조회

**GET** `/v1/users/{userId}`

**설명**: 사용자 정보를 조회합니다.

**Path Parameters**:
| 파라미터 | 타입 | 설명 |
|----------|------|------|
| userId | string | 사용자 ID |

**응답**: `200 OK`
```json
{
  "data": {
    "id": "usr_abc123",
    "email": "user@example.com",
    "name": "홍길동",
    "phone": "+821012345678",
    "status": "ACTIVE",
    "createdAt": "2026-03-07T10:00:00Z",
    "updatedAt": "2026-03-07T10:00:00Z"
  }
}
```

**에러**:
| 코드 | 상황 |
|------|------|
| ERR-4001 | 사용자를 찾을 수 없음 |

---

#### API-G-002: 사용자 목록 조회

**GET** `/v1/users`

**Query Parameters**:
| 파라미터 | 타입 | 필수 | 기본값 | 설명 |
|----------|------|------|--------|------|
| page | integer | ❌ | 1 | 페이지 번호 |
| pageSize | integer | ❌ | 20 | 페이지 크기 (최대 100) |
| status | string | ❌ | - | 상태 필터 |
| sort | string | ❌ | createdAt:desc | 정렬 |

**응답**: `200 OK`
```json
{
  "data": [
    { "id": "usr_abc123", ... },
    { "id": "usr_def456", ... }
  ],
  "pagination": {
    "page": 1,
    "pageSize": 20,
    "totalItems": 150,
    "totalPages": 8
  }
}
```

---

#### API-U-001: 사용자 수정

**PUT** `/v1/users/{userId}`

...

---

#### API-D-001: 사용자 삭제

**DELETE** `/v1/users/{userId}`

**응답**: `204 No Content`

---

### 4.2 {리소스명}

(동일한 형식으로 계속)

---

## 5. 스키마 정의

### 5.1 User

```json
{
  "type": "object",
  "properties": {
    "id": { "type": "string", "format": "prefixed-id", "example": "usr_abc123" },
    "email": { "type": "string", "format": "email" },
    "name": { "type": "string", "maxLength": 100 },
    "phone": { "type": "string", "pattern": "^\\+[1-9]\\d{1,14}$" },
    "status": { "type": "string", "enum": ["ACTIVE", "SUSPENDED", "DELETED"] },
    "createdAt": { "type": "string", "format": "date-time" },
    "updatedAt": { "type": "string", "format": "date-time" }
  },
  "required": ["id", "email", "name", "status", "createdAt"]
}
```

### 5.2 Error

```json
{
  "type": "object",
  "properties": {
    "code": { "type": "string" },
    "message": { "type": "string" },
    "details": { "type": "object" }
  },
  "required": ["code", "message"]
}
```

---

## 6. 에러 코드 목록

| 코드 | HTTP | 메시지 | 설명 |
|------|------|--------|------|
| ERR-1001 | 400 | 이메일 형식이 올바르지 않습니다 | 이메일 검증 실패 |
| ERR-1002 | 400 | 비밀번호 규칙을 충족하지 않습니다 | 비밀번호 검증 실패 |
| ERR-2001 | 401 | 인증이 필요합니다 | 토큰 없음 |
| ERR-2002 | 401 | 토큰이 만료되었습니다 | 토큰 만료 |
| ERR-3001 | 403 | 이 작업에 대한 권한이 없습니다 | 권한 부족 |
| ERR-4001 | 404 | 사용자를 찾을 수 없습니다 | 사용자 없음 |
| ERR-5001 | 422 | 이미 등록된 이메일입니다 | 이메일 중복 |
| ERR-9001 | 500 | 서버 오류가 발생했습니다 | 시스템 오류 |

---

## 7. 변경 이력

| 버전 | 일시 | 변경 내용 | 작성자 |
|------|------|-----------|--------|
| Draft | {YYYY-MM-DD} | 최초 작성 | API Spec Agent |
