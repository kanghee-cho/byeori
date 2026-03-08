#!/bin/bash
# Byeori Version Diff Tool
# Usage: ./version-diff.sh <project> <version1> <version2> [options]

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_info() { echo -e "${YELLOW}[INFO]${NC} $1"; }
print_header() { echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; }

usage() {
    print_header
    echo -e "${CYAN}Byeori Version Diff${NC}"
    print_header
    echo ""
    echo "Usage: $0 <project> <version1> <version2> [options]"
    echo ""
    echo "Arguments:"
    echo "  project       Project name"
    echo "  version1      First version (e.g., v0.1)"
    echo "  version2      Second version (e.g., v0.2)"
    echo ""
    echo "Options:"
    echo "  --lang=LANG   Language to compare (ko-KR or en-US, default: ko-KR)"
    echo "  --doc=DOC     Specific document to compare (e.g., prd.md)"
    echo "  --output=FILE Save diff to file"
    echo "  --summary     Show summary only (no detailed diff)"
    echo ""
    echo "Examples:"
    echo "  $0 my-project v0.1 v0.2"
    echo "  $0 my-project v0.1 v0.2 --lang=en-US"
    echo "  $0 my-project v0.1 v0.2 --doc=prd.md"
    echo "  $0 my-project v0.1 v0.2 --summary"
    echo ""
    exit 0
}

# Parse arguments
PROJECT=""
VERSION1=""
VERSION2=""
LANG="ko-KR"
DOC=""
OUTPUT=""
SUMMARY_ONLY=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --lang=*)
            LANG="${1#*=}"
            shift
            ;;
        --doc=*)
            DOC="${1#*=}"
            shift
            ;;
        --output=*)
            OUTPUT="${1#*=}"
            shift
            ;;
        --summary)
            SUMMARY_ONLY=true
            shift
            ;;
        --help|-h)
            usage
            ;;
        -*)
            print_error "Unknown option: $1"
            usage
            ;;
        *)
            if [ -z "$PROJECT" ]; then
                PROJECT="$1"
            elif [ -z "$VERSION1" ]; then
                VERSION1="$1"
            elif [ -z "$VERSION2" ]; then
                VERSION2="$1"
            fi
            shift
            ;;
    esac
done

# Validation
if [ -z "$PROJECT" ] || [ -z "$VERSION1" ] || [ -z "$VERSION2" ]; then
    print_error "Missing required arguments"
    usage
fi

PROJECT_DIR="$REPO_ROOT/projects/$PROJECT"
if [ ! -d "$PROJECT_DIR" ]; then
    print_error "Project not found: $PROJECT"
    exit 1
fi

V1_DIR="$PROJECT_DIR/40_versions/$VERSION1/$LANG"
V2_DIR="$PROJECT_DIR/40_versions/$VERSION2/$LANG"

if [ ! -d "$V1_DIR" ]; then
    print_error "Version not found: $VERSION1/$LANG"
    echo "Available versions:"
    ls -1 "$PROJECT_DIR/40_versions/" 2>/dev/null || echo "  (none)"
    exit 1
fi

if [ ! -d "$V2_DIR" ]; then
    print_error "Version not found: $VERSION2/$LANG"
    echo "Available versions:"
    ls -1 "$PROJECT_DIR/40_versions/" 2>/dev/null || echo "  (none)"
    exit 1
fi

# Generate diff
generate_diff() {
    local output_content=""
    
    output_content+="# Version Diff Report\n\n"
    output_content+="- **Project**: $PROJECT\n"
    output_content+="- **Comparison**: $VERSION1 → $VERSION2\n"
    output_content+="- **Language**: $LANG\n"
    output_content+="- **Generated**: $(date '+%Y-%m-%d %H:%M:%S')\n\n"
    output_content+="---\n\n"
    
    # Get all files from both versions
    local all_files=()
    
    if [ -n "$DOC" ]; then
        all_files=("$DOC")
    else
        # Collect all .md files (excluding README)
        while IFS= read -r -d '' file; do
            local rel_path="${file#$V1_DIR/}"
            if [[ "$rel_path" != "README.md" ]] && [[ "$rel_path" != *"/README.md" ]]; then
                all_files+=("$rel_path")
            fi
        done < <(find "$V1_DIR" -name "*.md" -type f -print0 2>/dev/null)
        
        while IFS= read -r -d '' file; do
            local rel_path="${file#$V2_DIR/}"
            if [[ "$rel_path" != "README.md" ]] && [[ "$rel_path" != *"/README.md" ]]; then
                if [[ ! " ${all_files[*]} " =~ " ${rel_path} " ]]; then
                    all_files+=("$rel_path")
                fi
            fi
        done < <(find "$V2_DIR" -name "*.md" -type f -print0 2>/dev/null)
    fi
    
    # Sort files
    IFS=$'\n' sorted_files=($(sort <<<"${all_files[*]}")); unset IFS
    
    # Summary statistics
    local added=0
    local modified=0
    local deleted=0
    local unchanged=0
    
    output_content+="## Summary\n\n"
    output_content+="| Status | File |\n"
    output_content+="|--------|------|\n"
    
    for file in "${sorted_files[@]}"; do
        local v1_file="$V1_DIR/$file"
        local v2_file="$V2_DIR/$file"
        
        if [ ! -f "$v1_file" ] && [ -f "$v2_file" ]; then
            output_content+="| 🆕 Added | \`$file\` |\n"
            ((added++))
        elif [ -f "$v1_file" ] && [ ! -f "$v2_file" ]; then
            output_content+="| 🗑️ Deleted | \`$file\` |\n"
            ((deleted++))
        elif [ -f "$v1_file" ] && [ -f "$v2_file" ]; then
            if diff -q "$v1_file" "$v2_file" > /dev/null 2>&1; then
                output_content+="| ✅ Unchanged | \`$file\` |\n"
                ((unchanged++))
            else
                output_content+="| ✏️ Modified | \`$file\` |\n"
                ((modified++))
            fi
        fi
    done
    
    output_content+="\n"
    output_content+="### Statistics\n\n"
    output_content+="- **Added**: $added\n"
    output_content+="- **Modified**: $modified\n"
    output_content+="- **Deleted**: $deleted\n"
    output_content+="- **Unchanged**: $unchanged\n"
    output_content+="- **Total**: ${#sorted_files[@]}\n\n"
    
    if [ "$SUMMARY_ONLY" = false ]; then
        output_content+="---\n\n"
        output_content+="## Detailed Changes\n\n"
        
        for file in "${sorted_files[@]}"; do
            local v1_file="$V1_DIR/$file"
            local v2_file="$V2_DIR/$file"
            
            if [ ! -f "$v1_file" ] && [ -f "$v2_file" ]; then
                output_content+="### 🆕 Added: \`$file\`\n\n"
                output_content+="\`\`\`markdown\n"
                output_content+="$(head -50 "$v2_file")\n"
                if [ $(wc -l < "$v2_file") -gt 50 ]; then
                    output_content+="... (truncated, $(wc -l < "$v2_file") lines total)\n"
                fi
                output_content+="\`\`\`\n\n"
            elif [ -f "$v1_file" ] && [ ! -f "$v2_file" ]; then
                output_content+="### 🗑️ Deleted: \`$file\`\n\n"
                output_content+="File was present in $VERSION1 but removed in $VERSION2.\n\n"
            elif [ -f "$v1_file" ] && [ -f "$v2_file" ]; then
                if ! diff -q "$v1_file" "$v2_file" > /dev/null 2>&1; then
                    output_content+="### ✏️ Modified: \`$file\`\n\n"
                    output_content+="\`\`\`diff\n"
                    output_content+="$(diff -u "$v1_file" "$v2_file" 2>/dev/null | head -100)\n"
                    local diff_lines=$(diff -u "$v1_file" "$v2_file" 2>/dev/null | wc -l)
                    if [ "$diff_lines" -gt 100 ]; then
                        output_content+="... (truncated, $diff_lines diff lines total)\n"
                    fi
                    output_content+="\`\`\`\n\n"
                fi
            fi
        done
    fi
    
    echo -e "$output_content"
}

# Main execution
print_header
echo -e "${CYAN}Byeori Version Diff${NC}"
print_header
echo ""
print_info "Project: $PROJECT"
print_info "Comparing: $VERSION1 → $VERSION2"
print_info "Language: $LANG"
if [ -n "$DOC" ]; then
    print_info "Document: $DOC"
fi
echo ""

diff_result=$(generate_diff)

if [ -n "$OUTPUT" ]; then
    echo -e "$diff_result" > "$OUTPUT"
    print_success "Diff saved to: $OUTPUT"
else
    echo -e "$diff_result"
fi
