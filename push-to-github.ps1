param(
  [string]$RepoName = 'ea-stories',
  [switch]$Private
)

Write-Host "Preparing repository in: $(Get-Location)"

if (-not (Test-Path .git)) {
  git init
  git branch -M main
  git config user.email "you@example.com"
  git config user.name "EA Stories Bot"
  Write-Host "Initialized local git repository."
} else { Write-Host ".git already exists" }

git add .
try{ git commit -m "Initial commit: site improvements, animations, Supabase integration" -q; Write-Host "Committed changes." } catch { Write-Host "No changes to commit or commit failed." }

if (Get-Command gh -ErrorAction SilentlyContinue) {
  $visibility = if($Private) { '--private' } else { '--public' }
  Write-Host "Creating GitHub repo '$RepoName' (this uses your gh auth)..."
  gh repo create $RepoName $visibility --source=. --remote=origin --push --confirm
  if ($LASTEXITCODE -eq 0) { Write-Host "Repository created and pushed. Remote origin set." } else { Write-Host "gh repo create failed. Check gh auth status and try manually." }
} else {
  Write-Host "GitHub CLI (gh) not found. To push manually, run the commands below in PowerShell:";
  Write-Host "1) Create a remote repository on GitHub (via website) named: $RepoName";
  Write-Host "2) Then in this folder run:";
  Write-Host "   git remote add origin https://github.com/<your-username>/$RepoName.git";
  Write-Host "   git push -u origin main";
}

Write-Host "Done. If you want me to create the repo for you, install and authenticate the GitHub CLI (https://cli.github.com/) and re-run this script with: .\push-to-github.ps1 -RepoName 'ea-stories'"
