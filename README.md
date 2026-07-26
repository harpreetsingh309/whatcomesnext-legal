# What Comes Next? — Legal site

Static Privacy Policy and Support pages for App Store Connect.

## Publish (GitHub Pages)

```bash
cd docs
# From repo root after creating the public repo:
gh repo create whatcomesnext-legal --public --source=. --remote=origin --push
gh api repos/harpreetsingh309/whatcomesnext-legal/pages -X POST -f build_type=legacy -f source[branch]=main -f source[path]=/
```

Or in GitHub: Settings → Pages → Deploy from branch `main` / root.

## Live URLs

- https://harpreetsingh309.github.io/whatcomesnext-legal/
- https://harpreetsingh309.github.io/whatcomesnext-legal/privacy.html
- https://harpreetsingh309.github.io/whatcomesnext-legal/support.html
