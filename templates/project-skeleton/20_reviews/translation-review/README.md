# Translation Review (20_reviews/translation-review)

이 폴더는 **Translation Reviewer Agent**의 리뷰 결과를 저장합니다.

## 리뷰 대상

- `40_versions/vX.Y/en-US/` 내 번역된 문서
- 원본: `40_versions/vX.Y/ko-KR/`

## 리뷰 관점

Translation Reviewer는 다음을 검증합니다:

1. **의미 동등성** — 한국어 원본과 영어 번역의 의미가 일치하는가
2. **용어집 준수** — `glossary.md` 정의 용어가 일관되게 번역되었는가
3. **Spec 톤** — 기술 문서로서 명확하고 간결한 어조인가
4. **트레이서빌리티 보존** — ID, 링크가 정확히 유지되었는가

## 출력 형식

```
translation-review/
├── v1.0-prd-translation-review.md
├── v1.0-architecture-translation-review.md
└── ...
```

## 리뷰 결과 구조

```markdown
# [문서명] 번역 리뷰

## 요약
- 상태: PASS / NEEDS_REVISION
- 원본: 40_versions/v1.0/ko-KR/prd.md
- 번역: 40_versions/v1.0/en-US/prd.md
- 리뷰 일시: YYYY-MM-DD

## 용어 검증

| 원어 (ko-KR) | 번역 (en-US) | 용어집 | 판정 |
|--------------|--------------|--------|------|
| 사용자 | User | User | ✅ |
| 결제 | Payment | Purchase | ❌ 불일치 |

## 의미 이슈

### 섹션 2.3
- 원본: "..."
- 번역: "..."
- 문제: 의미 누락/왜곡
- 권장: "..."

## 스타일 이슈
...
```

## 상태

이 폴더의 문서는 **읽기 전용**입니다.
