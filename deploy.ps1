# deploy.ps1 — petits outils pour tests locaux et options de déploiement
# Usage:
# 1) Lancer un serveur local
#    python -m http.server 8000; Start-Process "http://localhost:8000"
# 2) Déployer manuellement sur gh-pages (optionnel, nécessite git+remote configuré):
#    git checkout --orphan gh-pages
#    git --work-tree=./ -m "Deploy" add --all
#    git commit -m "Deploy" || exit
#    git push origin gh-pages --force
#    git checkout -
# 3) Option: utiliser gh cli to create repo & push (voir documentation gh)

Write-Host "Usage: run the script commands as described in comments, or open README.md for guidance." -ForegroundColor Green
