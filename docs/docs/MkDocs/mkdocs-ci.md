# MkDocs CI

To keep the documentation updated. A CI is used to validate the changes made to the wiki page. For now, GitHub Actions is used to run a CI/CD and deploy to GitHub pages. This might change in the future but the file is situated in `.github/workflows/mkdocs.yml`.
The CI runs MkDocs when a change is merged into the main branch, this updates the gh-deploy branch with the update and is deployed to gh-pages. Cool.




```yaml
name: mkdocs-ci

on:
  push:
    branches:
      - main

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: 3.x

      - name: Install dependencies
        run: |
          pip install mkdocs-material pillow cairosvg

      - name: Build and Deploy MkDocs
        run: |
          cd wiki
          mkdocs build
          mkdocs gh-deploy --force
```