
A CI is used to validate the changes made to the wiki page and to keep the documentation updated. For now, GitHub Actions is used to run a CI/CD to lint the markdown files, check that links are not broken and deploy to gh-pages. This might change in the future but the file is situated in `.github/workflows/mkdocs.yml`.
The CI runs when any of the MkDocs files has been updated and the CD when a PR is merged. It will deploy to gh-pages

```yaml
---
name: mkdocs-ci

on:
  push:
    # need to name the mkdocs folder docs to make the CI/CD work
    paths:
      - 'docs/**'
  pull_request:
    paths:
      - 'docs/**'

permissions:
  contents: write

jobs:

  super-linter:
    name: Lint Markdown files
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Lint Markdown files
        uses: github/super-linter@v5
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          FILTER_REGEX_INCLUDE: ^docs\/.*\.md$ # only looks at docs/*.md files

  markdown-link-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: gaurav-nelson/github-action-markdown-link-check@v1
      with:
        use-quiet-mode: 'yes'
        use-verbose-mode: 'yes'
        config-file: 'mlc_config.json'
        folder-path: 'docs/'

  deploy:
    if: github.event.pull_request.merged == true
    needs: [super-linter, markdown-link-check] 
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v3
        with:
          python-version: 3.x

      - name: Install dependencies
        run: |
          pip install mkdocs-material pillow cairosvg
      
      # Creates a seperate branch for MkDocs to be deployed using gh-pages. You may need to change the settings in the github project to accomendate the MkDocs branch
      - name: Build and Deploy MkDocs
        run: |
          cd wiki
          mkdocs build
          mkdocs gh-deploy --force
```