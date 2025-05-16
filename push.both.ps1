# push.both.ps1

Write-Host "Switching to 'dev' branch..."
git checkout dev

Write-Host "Pushing to Gitea (origin/dev)..."
git push origin dev

Write-Host "Switching to 'main' branch..."
git checkout main

Write-Host "Merging 'dev' into 'main'..."
git merge dev

Write-Host "Pushing to GitHub (github/main)..."
git push github main

Write-Host "✅ Push to both remotes completed!"
