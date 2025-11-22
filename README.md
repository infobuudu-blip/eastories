# EA Stories — Optimisations pour déploiement

Ce dépôt contient une page statique `index.html`. Ce fichier contient déjà des améliorations d'accessibilité et d'UX. Voici des actions et fichiers ajoutés pour préparer un déploiement simple et robuste.

Fichiers ajoutés
- `robots.txt` — règles pour les robots
- `sitemap.xml` — plan du site (mettez à jour le domaine avant publication)
- `manifest.json` — manifeste PWA basique (mettez à jour les icônes si nécessaire)
- `netlify.toml` — configuration minimale pour Netlify
- `deploy.ps1` — petit script PowerShell pour tests locaux et options de déploiement

Rappels avant publication
- Remplacez `https://example.com/` par votre domaine réel dans `sitemap.xml` et `robots.txt`.
- Vérifiez que `manifest.json` référence une icône disponible (png/webp). Ajoutez des tailles 512x512 pour stores.
- Optimisez vos images (WebP / srcset) avant mise en production.

Déploiement rapide (options)

1) Déploiement statique simple (serveur local, vérification)

```powershell
# Commande PowerShell (Windows) : lancer un serveur simple pour vérifier localement
python -m http.server 8000; Start-Process "http://localhost:8000"
```

2) Déployer sur GitHub Pages
- Créez un repo GitHub et poussez votre projet.
- Dans `Settings > Pages`, sélectionnez la branche (`main` ou `gh-pages`) et le dossier `/`.
- Optionnel : utiliser `gh-pages` npm package ou `git subtree` pour publier.

3) Déployer sur Netlify
- Créez un site en connectant le repo GitHub ou en faisant un drag & drop du dossier `c:\Users\USER\Documents\EA  Stories`.
- `netlify.toml` inclus une configuration minimale.

Minification / build
- Si vous avez Node.js :
  - `npm i -g html-minifier-terser` puis :
    `html-minifier-terser --collapse-whitespace --remove-comments --remove-optional-tags --minify-css true --minify-js true -o index.min.html index.html`
- Vous pouvez intégrer cette commande dans un script `package.json` ou CI.

CI / pipeline (suggestion)
- GitHub Actions : workflow pour minifier `index.html` et déployer sur `gh-pages`.
- Netlify : build automatique si vous connectez le repo.

Besoin d'aide ?
- Je peux :
  - ajouter un workflow GitHub Actions de déploiement automatique,
  - ajouter un script de build qui minifie et génère `index.min.html`,
  - optimiser les images et générer des `srcset`/WebP.

Mettez-moi au courant quelle option vous voulez que j'implémente en priorité.

Supabase — intégration pour récupérer les participations
-----------------------------------------------------

Si vous choisissez l'option Supabase, voici les étapes rapides :

1. Créez un projet sur https://supabase.com et notez l'URL du projet (ex: `https://xyz.supabase.co`) et la `anon` key.
2. Dans Supabase SQL editor, exécutez le fichier `sql/create_submissions_table.sql` pour créer la table `submissions`.
3. Copiez `supabase-config.example.js` en `supabase-config.js` et remplissez `SUPABASE_URL` et `SUPABASE_ANON_KEY`.
4. Déployez le site (Netlify / GitHub Pages) et chargez `admin.html` pour consulter les enregistrements.

Notes de sécurité :
- La `anon` key permet des inserts depuis le client ; pour un contrôle fin, configurez Row Level Security (RLS) dans Supabase et des policies qui acceptent les inserts authentifiés seulement, ou utilisez des fonctions server-side.
- Ne mettez pas votre `service_role` key dans le client ; conservez-la uniquement côté serveur pour taches administratives.

Si vous voulez, je peux :
- vous guider pas-à-pas pour créer le projet Supabase et exécuter le SQL, ou
- automatiser la création de la table via l'API (nécessite `service_role`), ou
- implémenter des politiques RLS de base et une authentification pour l'admin.
