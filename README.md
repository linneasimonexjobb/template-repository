# CI/CD Template

This is a template repo on how you may set up a working project within greenhouse. There are guides within the files how to set up the files but no code is provided. 

## Getting started
In the .github folder you will find the folder workflows and the files ISSUE_TEMPLATE and PULL_REQUEST_TEMPLATE

### TEMPLATES
The both templates generates a markdown file when a... issue or pull request is created. The files needs to be specified within the folder and with the characteristcs. If needed, you may alter the templates in your own repo.


### Workflows
The workflows specify how the CI/CD will run when changes to the code has been pushed. There are four yml files as a starter but may need to alter, remove or add another to fit your project. More info in the docs.

## MkDocs
MkDocs is a knowledge sharing repository that acts like a wiki, here you can store more significant information about your project. We have created a template on how it could be set up and provided more information about the CI/CD.
### How to run MkDocs
What things you need to run MkDocs
- Python 3.x

To install mkdocs you need to run the command
```pip install mkdocs-material```

To run Mkdocs you need to first cd in to the project
```cd docs```
Then to run MkDocs locally, you may run the command
```mkdocs serve```
This will enable mkdocs to run locally on port 8000

## Pre-commit
Pre-commit is a tool to easily install pre-commit hooks to git (see https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
Likewise Mkdocs you need:
- Python 3.x
to run the installment. More information in the mkdocs exactly how it works
## Dockerfile
Boilerplate dockerfile that contains no code


## Version
0.0.1

## Authors
The original template was provided by
Simon Jakobsson and
Linnéa Ivansson 