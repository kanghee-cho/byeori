# Byeori Version Diff Tool (PowerShell)
# Usage: .\version-diff.ps1 <project> <version1> <version2> [options]

param(
    [Parameter(Position=0)]
    [string]$Project,
    
    [Parameter(Position=1)]
    [string]$Version1,
    
    [Parameter(Position=2)]
    [string]$Version2,
    
    [string]$Lang = "ko-KR",
    [string]$Doc,
    [string]$Output,
    [switch]$Summary
)

$ErrorActionPreference = "Stop"

# Configuration
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir

function Write-Header {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Blue
}

function Show-Usage {
    Write-Header
    Write-Host "Byeori Version Diff" -ForegroundColor Cyan
    Write-Header
    Write-Host ""
    Write-Host "Usage: .\version-diff.ps1 <project> <version1> <version2> [options]"
    Write-Host ""
    Write-Host "Arguments:"
    Write-Host "  project       Project name"
    Write-Host "  version1      First version (e.g., v0.1)"
    Write-Host "  version2      Second version (e.g., v0.2)"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Lang LANG    Language to compare (ko-KR or en-US, default: ko-KR)"
    Write-Host "  -Doc DOC      Specific document to compare (e.g., prd.md)"
    Write-Host "  -Output FILE  Save diff to file"
    Write-Host "  -Summary      Show summary only (no detailed diff)"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\version-diff.ps1 my-project v0.1 v0.2"
    Write-Host "  .\version-diff.ps1 my-project v0.1 v0.2 -Lang en-US"
    Write-Host "  .\version-diff.ps1 my-project v0.1 v0.2 -Doc prd.md"
    Write-Host "  .\version-diff.ps1 my-project v0.1 v0.2 -Summary"
    Write-Host ""
    exit
}

# Validation
if (-not $Project -or -not $Version1 -or -not $Version2) {
    Write-Host "[ERROR] Missing required arguments" -ForegroundColor Red
    Show-Usage
}

$ProjectDir = Join-Path $RepoRoot "projects\$Project"
if (-not (Test-Path $ProjectDir)) {
    Write-Host "[ERROR] Project not found: $Project" -ForegroundColor Red
    exit 1
}

$V1Dir = Join-Path $ProjectDir "40_versions\$Version1\$Lang"
$V2Dir = Join-Path $ProjectDir "40_versions\$Version2\$Lang"

if (-not (Test-Path $V1Dir)) {
    Write-Host "[ERROR] Version not found: $Version1/$Lang" -ForegroundColor Red
    Write-Host "Available versions:"
    Get-ChildItem (Join-Path $ProjectDir "40_versions") -Directory | ForEach-Object { Write-Host "  $($_.Name)" }
    exit 1
}

if (-not (Test-Path $V2Dir)) {
    Write-Host "[ERROR] Version not found: $Version2/$Lang" -ForegroundColor Red
    Write-Host "Available versions:"
    Get-ChildItem (Join-Path $ProjectDir "40_versions") -Directory | ForEach-Object { Write-Host "  $($_.Name)" }
    exit 1
}

function Get-AllMdFiles {
    param([string]$Dir)
    
    $files = @()
    Get-ChildItem $Dir -Filter "*.md" -Recurse | Where-Object { $_.Name -ne "README.md" } | ForEach-Object {
        $relPath = $_.FullName.Substring($Dir.Length + 1).Replace("\", "/")
        $files += $relPath
    }
    return $files
}

function Compare-Files {
    param([string]$File1, [string]$File2)
    
    $content1 = Get-Content $File1 -Raw -ErrorAction SilentlyContinue
    $content2 = Get-Content $File2 -Raw -ErrorAction SilentlyContinue
    
    return $content1 -eq $content2
}

function Generate-Diff {
    $output = @()
    
    $output += "# Version Diff Report"
    $output += ""
    $output += "- **Project**: $Project"
    $output += "- **Comparison**: $Version1 → $Version2"
    $output += "- **Language**: $Lang"
    $output += "- **Generated**: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    $output += ""
    $output += "---"
    $output += ""
    
    # Get all files
    $allFiles = @()
    
    if ($Doc) {
        $allFiles = @($Doc)
    } else {
        $v1Files = Get-AllMdFiles -Dir $V1Dir
        $v2Files = Get-AllMdFiles -Dir $V2Dir
        $allFiles = ($v1Files + $v2Files) | Sort-Object -Unique
    }
    
    # Statistics
    $added = 0
    $modified = 0
    $deleted = 0
    $unchanged = 0
    
    $output += "## Summary"
    $output += ""
    $output += "| Status | File |"
    $output += "|--------|------|"
    
    $details = @()
    
    foreach ($file in $allFiles) {
        $v1File = Join-Path $V1Dir $file.Replace("/", "\")
        $v2File = Join-Path $V2Dir $file.Replace("/", "\")
        
        $v1Exists = Test-Path $v1File
        $v2Exists = Test-Path $v2File
        
        if (-not $v1Exists -and $v2Exists) {
            $output += "| 🆕 Added | ``$file`` |"
            $added++
            
            if (-not $Summary) {
                $details += "### 🆕 Added: ``$file``"
                $details += ""
                $details += "``````markdown"
                $content = Get-Content $v2File -TotalCount 50
                $details += $content
                $totalLines = (Get-Content $v2File).Count
                if ($totalLines -gt 50) {
                    $details += "... (truncated, $totalLines lines total)"
                }
                $details += "``````"
                $details += ""
            }
        }
        elseif ($v1Exists -and -not $v2Exists) {
            $output += "| 🗑️ Deleted | ``$file`` |"
            $deleted++
            
            if (-not $Summary) {
                $details += "### 🗑️ Deleted: ``$file``"
                $details += ""
                $details += "File was present in $Version1 but removed in $Version2."
                $details += ""
            }
        }
        elseif ($v1Exists -and $v2Exists) {
            if (Compare-Files -File1 $v1File -File2 $v2File) {
                $output += "| ✅ Unchanged | ``$file`` |"
                $unchanged++
            } else {
                $output += "| ✏️ Modified | ``$file`` |"
                $modified++
                
                if (-not $Summary) {
                    $details += "### ✏️ Modified: ``$file``"
                    $details += ""
                    
                    # Simple line-by-line diff
                    $v1Content = Get-Content $v1File
                    $v2Content = Get-Content $v2File
                    
                    $details += "**Lines changed**: $($v1Content.Count) → $($v2Content.Count)"
                    $details += ""
                    
                    # Show first 20 differences
                    $details += "``````diff"
                    $diffCount = 0
                    $maxDiff = 20
                    
                    $maxLines = [Math]::Max($v1Content.Count, $v2Content.Count)
                    for ($i = 0; $i -lt $maxLines -and $diffCount -lt $maxDiff; $i++) {
                        $line1 = if ($i -lt $v1Content.Count) { $v1Content[$i] } else { $null }
                        $line2 = if ($i -lt $v2Content.Count) { $v2Content[$i] } else { $null }
                        
                        if ($line1 -ne $line2) {
                            if ($null -ne $line1) { $details += "- $line1" }
                            if ($null -ne $line2) { $details += "+ $line2" }
                            $diffCount++
                        }
                    }
                    
                    if ($diffCount -ge $maxDiff) {
                        $details += "... (showing first $maxDiff differences)"
                    }
                    
                    $details += "``````"
                    $details += ""
                }
            }
        }
    }
    
    $output += ""
    $output += "### Statistics"
    $output += ""
    $output += "- **Added**: $added"
    $output += "- **Modified**: $modified"
    $output += "- **Deleted**: $deleted"
    $output += "- **Unchanged**: $unchanged"
    $output += "- **Total**: $($allFiles.Count)"
    $output += ""
    
    if (-not $Summary -and $details.Count -gt 0) {
        $output += "---"
        $output += ""
        $output += "## Detailed Changes"
        $output += ""
        $output += $details
    }
    
    return $output -join "`n"
}

# Main
Write-Header
Write-Host "Byeori Version Diff" -ForegroundColor Cyan
Write-Header
Write-Host ""
Write-Host "[INFO] Project: $Project" -ForegroundColor Yellow
Write-Host "[INFO] Comparing: $Version1 → $Version2" -ForegroundColor Yellow
Write-Host "[INFO] Language: $Lang" -ForegroundColor Yellow
if ($Doc) {
    Write-Host "[INFO] Document: $Doc" -ForegroundColor Yellow
}
Write-Host ""

$diffResult = Generate-Diff

if ($Output) {
    $diffResult | Out-File -FilePath $Output -Encoding UTF8
    Write-Host "[SUCCESS] Diff saved to: $Output" -ForegroundColor Green
} else {
    Write-Host $diffResult
}
