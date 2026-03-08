#!/bin/bash
# Byeori CLI - Agent Invocation and Workflow Management
# Usage: ./byeori.sh <command> [options]

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
AGENTS_DIR="$REPO_ROOT/.github/agents"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Functions
print_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_info() { echo -e "${YELLOW}[INFO]${NC} $1"; }
print_header() { echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; }

# Available Agents
declare -A AGENTS=(
    ["prd"]="product-prd"
    ["architect"]="system-architect"
    ["design"]="software-design"
    ["api"]="api-spec"
    ["db"]="data-schema"
    ["tasks"]="task-decomposition"
    ["spec-review"]="spec-reviewer"
    ["task-review"]="task-reviewer"
    ["translate"]="translation"
    ["translate-review"]="translation-reviewer"
    ["impact"]="impact-analyzer"
    ["release"]="release-gatekeeper"
    ["orchestrator"]="orchestrator"
)

# Agent Descriptions
declare -A AGENT_DESC=(
    ["prd"]="Generate PRD from idea/requirements"
    ["architect"]="Generate System Architecture from PRD"
    ["design"]="Generate Software Design from PRD+Architecture"
    ["api"]="Generate API Specification from Design"
    ["db"]="Generate Database Schema from Design"
    ["tasks"]="Decompose specs into executable Tasks"
    ["spec-review"]="Review specification documents"
    ["task-review"]="Review Task documents for AC quality"
    ["translate"]="Translate ko-KR to en-US"
    ["translate-review"]="Review translation quality"
    ["impact"]="Analyze change impact across documents"
    ["release"]="Validate release readiness"
    ["orchestrator"]="Control workflow and coordinate agents"
)

usage() {
    print_header
    echo -e "${CYAN}Byeori CLI${NC} - Multi-Agent Documentation System"
    print_header
    echo ""
    echo "Usage: $0 <command> [options]"
    echo ""
    echo "Commands:"
    echo "  agent <name> [project]    Invoke an agent (opens VS Code Chat)"
    echo "  list                      List all available agents"
    echo "  status <project>          Show project workflow status"
    echo "  diff <project> <v1> <v2>  Compare two versions"
    echo "  create <project-name>     Create a new project"
    echo "  help                      Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 agent prd my-project"
    echo "  $0 list"
    echo "  $0 status obsidian-sync-service"
    echo "  $0 diff my-project v0.1 v0.2"
    echo ""
    exit 0
}

list_agents() {
    print_header
    echo -e "${CYAN}Available Byeori Agents${NC}"
    print_header
    echo ""
    printf "%-18s %-25s %s\n" "SHORTCUT" "AGENT NAME" "DESCRIPTION"
    echo "─────────────────────────────────────────────────────────────────────────────"
    
    for key in prd architect design api db tasks spec-review task-review translate translate-review impact release orchestrator; do
        printf "%-18s %-25s %s\n" "$key" "${AGENTS[$key]}" "${AGENT_DESC[$key]}"
    done
    
    echo ""
    echo "Usage: $0 agent <shortcut> [project-name]"
    echo ""
}

invoke_agent() {
    local agent_key="$1"
    local project="$2"
    
    if [ -z "$agent_key" ]; then
        print_error "Agent name required"
        echo "Usage: $0 agent <name> [project]"
        echo "Run '$0 list' to see available agents"
        exit 1
    fi
    
    local agent_name="${AGENTS[$agent_key]}"
    
    if [ -z "$agent_name" ]; then
        print_error "Unknown agent: $agent_key"
        echo "Run '$0 list' to see available agents"
        exit 1
    fi
    
    local agent_file="$AGENTS_DIR/$agent_name.agent.md"
    
    if [ ! -f "$agent_file" ]; then
        print_error "Agent file not found: $agent_file"
        exit 1
    fi
    
    print_info "Agent: @$agent_name"
    print_info "Description: ${AGENT_DESC[$agent_key]}"
    
    if [ -n "$project" ]; then
        local project_dir="$REPO_ROOT/projects/$project"
        if [ ! -d "$project_dir" ]; then
            print_error "Project not found: $project"
            exit 1
        fi
        print_info "Project: $project"
    fi
    
    echo ""
    print_header
    echo -e "${GREEN}VS Code Chat Command:${NC}"
    print_header
    echo ""
    echo -e "  ${CYAN}@$agent_name${NC}"
    echo ""
    
    if [ -n "$project" ]; then
        echo "Suggested prompt:"
        case "$agent_key" in
            prd)
                echo "  \"프로젝트 $project의 초기 아이디어를 기반으로 PRD를 생성해주세요.\""
                ;;
            architect)
                echo "  \"projects/$project/10_drafts/ko-KR/prd.md를 읽고 Architecture 문서를 생성해주세요.\""
                ;;
            design)
                echo "  \"projects/$project의 PRD와 Architecture를 읽고 Design 문서를 생성해주세요.\""
                ;;
            api)
                echo "  \"projects/$project의 Design 문서를 읽고 API Spec을 생성해주세요.\""
                ;;
            db)
                echo "  \"projects/$project의 Design 문서를 읽고 DB Schema를 생성해주세요.\""
                ;;
            tasks)
                echo "  \"projects/$project의 전체 스펙 문서를 읽고 Task로 분해해주세요.\""
                ;;
            spec-review)
                echo "  \"projects/$project/10_drafts/ko-KR/의 스펙 문서들을 리뷰해주세요.\""
                ;;
            task-review)
                echo "  \"projects/$project/10_drafts/ko-KR/tasks/의 Task들을 리뷰해주세요.\""
                ;;
            translate)
                echo "  \"projects/$project/40_versions/v0.1/ko-KR/의 문서들을 en-US로 번역해주세요.\""
                ;;
            translate-review)
                echo "  \"projects/$project/40_versions/v0.1/en-US/의 번역 품질을 리뷰해주세요.\""
                ;;
            impact)
                echo "  \"projects/$project에서 변경 사항의 영향 범위를 분석해주세요.\""
                ;;
            release)
                echo "  \"projects/$project의 릴리스 준비 상태를 검증해주세요.\""
                ;;
            orchestrator)
                echo "  \"projects/$project의 현재 상태를 평가하고 다음 단계를 안내해주세요.\""
                ;;
        esac
    fi
    
    echo ""
    
    # Try to open VS Code if available
    if command -v code &> /dev/null; then
        print_info "Opening VS Code..."
        if [ -n "$project" ]; then
            code "$REPO_ROOT/projects/$project"
        else
            code "$REPO_ROOT"
        fi
    fi
}

show_status() {
    local project="$1"
    
    if [ -z "$project" ]; then
        print_error "Project name required"
        echo "Usage: $0 status <project-name>"
        exit 1
    fi
    
    local project_dir="$REPO_ROOT/projects/$project"
    
    if [ ! -d "$project_dir" ]; then
        print_error "Project not found: $project"
        exit 1
    fi
    
    print_header
    echo -e "${CYAN}Project Status: $project${NC}"
    print_header
    echo ""
    
    # Check drafts
    echo -e "${YELLOW}📝 Drafts (10_drafts/ko-KR/)${NC}"
    local drafts_dir="$project_dir/10_drafts/ko-KR"
    if [ -d "$drafts_dir" ]; then
        for doc in prd.md architecture.md design.md api-spec.md db-schema.md; do
            if [ -f "$drafts_dir/$doc" ]; then
                echo -e "  ✅ $doc"
            else
                echo -e "  ❌ $doc (missing)"
            fi
        done
        
        # Tasks
        local task_count=$(find "$drafts_dir/tasks" -name "*.md" -type f 2>/dev/null | grep -v README | wc -l | tr -d ' ')
        echo -e "  📋 Tasks: $task_count files"
    else
        echo -e "  ❌ Drafts folder not found"
    fi
    
    echo ""
    
    # Check reviews
    echo -e "${YELLOW}🔍 Reviews (20_reviews/)${NC}"
    local reviews_dir="$project_dir/20_reviews"
    for review_type in spec-review task-review translation-review impact-analysis; do
        local review_count=$(find "$reviews_dir/$review_type" -name "*.md" -type f 2>/dev/null | grep -v README | wc -l | tr -d ' ')
        if [ "$review_count" -gt 0 ]; then
            echo -e "  ✅ $review_type: $review_count files"
        else
            echo -e "  ⏳ $review_type: pending"
        fi
    done
    
    # Release readiness
    if [ -f "$reviews_dir/release-readiness-"*".md" ] 2>/dev/null; then
        echo -e "  ✅ Release readiness check exists"
    fi
    
    echo ""
    
    # Check approvals
    echo -e "${YELLOW}✅ Approvals (30_approvals/)${NC}"
    local approvals_dir="$project_dir/30_approvals"
    local approval_count=$(find "$approvals_dir" -name "approval-*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    if [ "$approval_count" -gt 0 ]; then
        echo -e "  ✅ Approvals: $approval_count records"
        ls -1 "$approvals_dir"/approval-*.md 2>/dev/null | while read f; do
            echo -e "     - $(basename "$f")"
        done
    else
        echo -e "  ⏳ No approvals yet"
    fi
    
    echo ""
    
    # Check versions
    echo -e "${YELLOW}📦 Versions (40_versions/)${NC}"
    local versions_dir="$project_dir/40_versions"
    if [ -d "$versions_dir" ]; then
        for ver_dir in "$versions_dir"/v*/; do
            if [ -d "$ver_dir" ]; then
                local ver_name=$(basename "$ver_dir")
                echo -e "  📁 $ver_name"
                
                if [ -d "$ver_dir/ko-KR" ]; then
                    local ko_count=$(find "$ver_dir/ko-KR" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
                    echo -e "     - ko-KR: $ko_count files"
                fi
                
                if [ -d "$ver_dir/en-US" ]; then
                    local en_count=$(find "$ver_dir/en-US" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
                    echo -e "     - en-US: $en_count files"
                fi
            fi
        done
    fi
    
    echo ""
    
    # Check release
    echo -e "${YELLOW}🚀 Release (50_release/)${NC}"
    local release_dir="$project_dir/50_release"
    local release_count=$(find "$release_dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
    if [ "$release_count" -gt 0 ]; then
        echo -e "  ✅ Released versions: $release_count"
    else
        echo -e "  ⏳ No releases yet"
    fi
    
    echo ""
    print_header
}

# Main
case "${1:-help}" in
    agent)
        invoke_agent "$2" "$3"
        ;;
    list)
        list_agents
        ;;
    status)
        show_status "$2"
        ;;
    diff)
        # Delegate to diff script
        "$SCRIPT_DIR/version-diff.sh" "$2" "$3" "$4"
        ;;
    create)
        # Delegate to create script
        "$SCRIPT_DIR/create-project.sh" "$2" "$3"
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        print_error "Unknown command: $1"
        usage
        ;;
esac
