# Byeori CLI - Agent Invocation and Workflow Management (PowerShell)
# Usage: .\byeori.ps1 <command> [options]

param(
    [Parameter(Position=0)]
    [string]$Command = "help",
    
    [Parameter(Position=1)]
    [string]$Arg1,
    
    [Parameter(Position=2)]
    [string]$Arg2,
    
    [Parameter(Position=3)]
    [string]$Arg3
)

$ErrorActionPreference = "Stop"

# Configuration
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir
$AgentsDir = Join-Path $RepoRoot ".github\agents"

# Agents
$Agents = @{
    "prd"              = "product-prd"
    "architect"        = "system-architect"
    "design"           = "software-design"
    "api"              = "api-spec"
    "db"               = "data-schema"
    "tasks"            = "task-decomposition"
    "spec-review"      = "spec-reviewer"
    "task-review"      = "task-reviewer"
    "translate"        = "translation"
    "translate-review" = "translation-reviewer"
    "impact"           = "impact-analyzer"
    "release"          = "release-gatekeeper"
    "orchestrator"     = "orchestrator"
}

$AgentDesc = @{
    "prd"              = "Generate PRD from idea/requirements"
    "architect"        = "Generate System Architecture from PRD"
    "design"           = "Generate Software Design from PRD+Architecture"
    "api"              = "Generate API Specification from Design"
    "db"               = "Generate Database Schema from Design"
    "tasks"            = "Decompose specs into executable Tasks"
    "spec-review"      = "Review specification documents"
    "task-review"      = "Review Task documents for AC quality"
    "translate"        = "Translate ko-KR to en-US"
    "translate-review" = "Review translation quality"
    "impact"           = "Analyze change impact across documents"
    "release"          = "Validate release readiness"
    "orchestrator"     = "Control workflow and coordinate agents"
}

function Write-Header {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
}

function Show-Usage {
    Write-Header
    Write-Host "Byeori CLI" -ForegroundColor Cyan -NoNewline
    Write-Host " - Multi-Agent Documentation System"
    Write-Header
    Write-Host ""
    Write-Host "Usage: .\byeori.ps1 <command> [options]"
    Write-Host ""
    Write-Host "Commands:"
    Write-Host "  agent <name> [project]    Invoke an agent (opens VS Code Chat)"
    Write-Host "  list                      List all available agents"
    Write-Host "  status <project>          Show project workflow status"
    Write-Host "  diff <project> <v1> <v2>  Compare two versions"
    Write-Host "  create <project-name>     Create a new project"
    Write-Host "  help                      Show this help message"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\byeori.ps1 agent prd my-project"
    Write-Host "  .\byeori.ps1 list"
    Write-Host "  .\byeori.ps1 status obsidian-sync-service"
    Write-Host "  .\byeori.ps1 diff my-project v0.1 v0.2"
    Write-Host ""
}

function Show-Agents {
    Write-Header
    Write-Host "Available Byeori Agents" -ForegroundColor Cyan
    Write-Header
    Write-Host ""
    Write-Host ("{0,-18} {1,-25} {2}" -f "SHORTCUT", "AGENT NAME", "DESCRIPTION")
    Write-Host ("─" * 75)
    
    $order = @("prd", "architect", "design", "api", "db", "tasks", "spec-review", "task-review", "translate", "translate-review", "impact", "release", "orchestrator")
    foreach ($key in $order) {
        Write-Host ("{0,-18} {1,-25} {2}" -f $key, $Agents[$key], $AgentDesc[$key])
    }
    
    Write-Host ""
    Write-Host "Usage: .\byeori.ps1 agent <shortcut> [project-name]"
    Write-Host ""
}

function Invoke-Agent {
    param([string]$AgentKey, [string]$Project)
    
    if (-not $AgentKey) {
        Write-Host "[ERROR] Agent name required" -ForegroundColor Red
        Write-Host "Usage: .\byeori.ps1 agent <name> [project]"
        Write-Host "Run '.\byeori.ps1 list' to see available agents"
        return
    }
    
    if (-not $Agents.ContainsKey($AgentKey)) {
        Write-Host "[ERROR] Unknown agent: $AgentKey" -ForegroundColor Red
        Write-Host "Run '.\byeori.ps1 list' to see available agents"
        return
    }
    
    $AgentName = $Agents[$AgentKey]
    $AgentFile = Join-Path $AgentsDir "$AgentName.agent.md"
    
    if (-not (Test-Path $AgentFile)) {
        Write-Host "[ERROR] Agent file not found: $AgentFile" -ForegroundColor Red
        return
    }
    
    Write-Host "[INFO] Agent: @$AgentName" -ForegroundColor Yellow
    Write-Host "[INFO] Description: $($AgentDesc[$AgentKey])" -ForegroundColor Yellow
    
    if ($Project) {
        $ProjectDir = Join-Path $RepoRoot "projects\$Project"
        if (-not (Test-Path $ProjectDir)) {
            Write-Host "[ERROR] Project not found: $Project" -ForegroundColor Red
            return
        }
        Write-Host "[INFO] Project: $Project" -ForegroundColor Yellow
    }
    
    Write-Host ""
    Write-Header
    Write-Host "VS Code Chat Command:" -ForegroundColor Green
    Write-Header
    Write-Host ""
    Write-Host "  @$AgentName" -ForegroundColor Cyan
    Write-Host ""
    
    if ($Project) {
        Write-Host "Suggested prompt:"
        switch ($AgentKey) {
            "prd"              { Write-Host "  `"프로젝트 $Project의 초기 아이디어를 기반으로 PRD를 생성해주세요.`"" }
            "architect"        { Write-Host "  `"projects/$Project/10_drafts/ko-KR/prd.md를 읽고 Architecture 문서를 생성해주세요.`"" }
            "design"           { Write-Host "  `"projects/$Project의 PRD와 Architecture를 읽고 Design 문서를 생성해주세요.`"" }
            "api"              { Write-Host "  `"projects/$Project의 Design 문서를 읽고 API Spec을 생성해주세요.`"" }
            "db"               { Write-Host "  `"projects/$Project의 Design 문서를 읽고 DB Schema를 생성해주세요.`"" }
            "tasks"            { Write-Host "  `"projects/$Project의 전체 스펙 문서를 읽고 Task로 분해해주세요.`"" }
            "spec-review"      { Write-Host "  `"projects/$Project/10_drafts/ko-KR/의 스펙 문서들을 리뷰해주세요.`"" }
            "task-review"      { Write-Host "  `"projects/$Project/10_drafts/ko-KR/tasks/의 Task들을 리뷰해주세요.`"" }
            "translate"        { Write-Host "  `"projects/$Project/40_versions/v0.1/ko-KR/의 문서들을 en-US로 번역해주세요.`"" }
            "translate-review" { Write-Host "  `"projects/$Project/40_versions/v0.1/en-US/의 번역 품질을 리뷰해주세요.`"" }
            "impact"           { Write-Host "  `"projects/$Project에서 변경 사항의 영향 범위를 분석해주세요.`"" }
            "release"          { Write-Host "  `"projects/$Project의 릴리스 준비 상태를 검증해주세요.`"" }
            "orchestrator"     { Write-Host "  `"projects/$Project의 현재 상태를 평가하고 다음 단계를 안내해주세요.`"" }
        }
    }
    
    Write-Host ""
    
    # Try to open VS Code
    if (Get-Command code -ErrorAction SilentlyContinue) {
        Write-Host "[INFO] Opening VS Code..." -ForegroundColor Yellow
        if ($Project) {
            code (Join-Path $RepoRoot "projects\$Project")
        } else {
            code $RepoRoot
        }
    }
}

function Show-Status {
    param([string]$Project)
    
    if (-not $Project) {
        Write-Host "[ERROR] Project name required" -ForegroundColor Red
        Write-Host "Usage: .\byeori.ps1 status <project-name>"
        return
    }
    
    $ProjectDir = Join-Path $RepoRoot "projects\$Project"
    
    if (-not (Test-Path $ProjectDir)) {
        Write-Host "[ERROR] Project not found: $Project" -ForegroundColor Red
        return
    }
    
    Write-Header
    Write-Host "Project Status: $Project" -ForegroundColor Cyan
    Write-Header
    Write-Host ""
    
    # Check drafts
    Write-Host "📝 Drafts (10_drafts/ko-KR/)" -ForegroundColor Yellow
    $DraftsDir = Join-Path $ProjectDir "10_drafts\ko-KR"
    if (Test-Path $DraftsDir) {
        foreach ($doc in @("prd.md", "architecture.md", "design.md", "api-spec.md", "db-schema.md")) {
            if (Test-Path (Join-Path $DraftsDir $doc)) {
                Write-Host "  ✅ $doc"
            } else {
                Write-Host "  ❌ $doc (missing)"
            }
        }
        
        $TasksDir = Join-Path $DraftsDir "tasks"
        if (Test-Path $TasksDir) {
            $TaskCount = (Get-ChildItem $TasksDir -Filter "*.md" | Where-Object { $_.Name -ne "README.md" }).Count
            Write-Host "  📋 Tasks: $TaskCount files"
        }
    }
    
    Write-Host ""
    
    # Check reviews
    Write-Host "🔍 Reviews (20_reviews/)" -ForegroundColor Yellow
    $ReviewsDir = Join-Path $ProjectDir "20_reviews"
    foreach ($ReviewType in @("spec-review", "task-review", "translation-review", "impact-analysis")) {
        $ReviewTypeDir = Join-Path $ReviewsDir $ReviewType
        if (Test-Path $ReviewTypeDir) {
            $ReviewCount = (Get-ChildItem $ReviewTypeDir -Filter "*.md" | Where-Object { $_.Name -ne "README.md" }).Count
            if ($ReviewCount -gt 0) {
                Write-Host "  ✅ ${ReviewType}: $ReviewCount files"
            } else {
                Write-Host "  ⏳ ${ReviewType}: pending"
            }
        }
    }
    
    Write-Host ""
    
    # Check approvals
    Write-Host "✅ Approvals (30_approvals/)" -ForegroundColor Yellow
    $ApprovalsDir = Join-Path $ProjectDir "30_approvals"
    if (Test-Path $ApprovalsDir) {
        $ApprovalFiles = Get-ChildItem $ApprovalsDir -Filter "approval-*.md"
        if ($ApprovalFiles.Count -gt 0) {
            Write-Host "  ✅ Approvals: $($ApprovalFiles.Count) records"
            foreach ($f in $ApprovalFiles) {
                Write-Host "     - $($f.Name)"
            }
        } else {
            Write-Host "  ⏳ No approvals yet"
        }
    }
    
    Write-Host ""
    
    # Check versions
    Write-Host "📦 Versions (40_versions/)" -ForegroundColor Yellow
    $VersionsDir = Join-Path $ProjectDir "40_versions"
    if (Test-Path $VersionsDir) {
        $VersionDirs = Get-ChildItem $VersionsDir -Directory | Where-Object { $_.Name -match "^v\d" }
        foreach ($VerDir in $VersionDirs) {
            Write-Host "  📁 $($VerDir.Name)"
            
            $KoDir = Join-Path $VerDir.FullName "ko-KR"
            if (Test-Path $KoDir) {
                $KoCount = (Get-ChildItem $KoDir -Filter "*.md" -Recurse).Count
                Write-Host "     - ko-KR: $KoCount files"
            }
            
            $EnDir = Join-Path $VerDir.FullName "en-US"
            if (Test-Path $EnDir) {
                $EnCount = (Get-ChildItem $EnDir -Filter "*.md" -Recurse).Count
                Write-Host "     - en-US: $EnCount files"
            }
        }
    }
    
    Write-Host ""
    
    # Check release
    Write-Host "🚀 Release (50_release/)" -ForegroundColor Yellow
    $ReleaseDir = Join-Path $ProjectDir "50_release"
    if (Test-Path $ReleaseDir) {
        $ReleaseDirs = Get-ChildItem $ReleaseDir -Directory | Where-Object { $_.Name -match "^v\d" }
        if ($ReleaseDirs.Count -gt 0) {
            Write-Host "  ✅ Released versions: $($ReleaseDirs.Count)"
        } else {
            Write-Host "  ⏳ No releases yet"
        }
    }
    
    Write-Host ""
    Write-Header
}

# Main
switch ($Command) {
    "agent" {
        Invoke-Agent -AgentKey $Arg1 -Project $Arg2
    }
    "list" {
        Show-Agents
    }
    "status" {
        Show-Status -Project $Arg1
    }
    "diff" {
        & "$ScriptDir\version-diff.ps1" $Arg1 $Arg2 $Arg3
    }
    "create" {
        & "$ScriptDir\create-project.ps1" $Arg1 $Arg2
    }
    { $_ -in "help", "--help", "-h" } {
        Show-Usage
    }
    default {
        Write-Host "[ERROR] Unknown command: $Command" -ForegroundColor Red
        Show-Usage
    }
}
