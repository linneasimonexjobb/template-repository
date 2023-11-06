# Why continuous integration
To validate that the code is following certain standards, and that the code builds and tests correctly independent of what is commited to the repository. A CI template has been created that the developers may use.

The CI runs on GitHub Actions and has a few steps the devs need to address.


## CI configuration

The CI runs with the steps:

| Steps     | Description                     |
| -----------     | ------------------------------------ |
| Lint      | Linting is used to verify that the code is properly structured, GitHub super-lint is used but can be changed to whatever the devs find appropriate  |
| Build  | The project should be built, here you may use cmake, npm build etc |
| Test         | Atleast basic unit test should be used in the project |
| Test coverage         | Test coverage should be included, but only warn a developer if it is below a certain threshhold |

It is possible to add, remove or change steps if the project allows it though having the above four steps is recommended.

## Adding more test suites
Unit tests should always be included in the CI build. Based on what project you are working on, other kind of testing could be applied such as integration testing or end-to-end testing. 

An important note is that the more expensive the test suites are the more mintues it will take from GitHub. We recommend therefore to use
testing techniques such as E2E only when using PR.

## Linting
Linting is the process of running a program that analyzes code for potential errors, bugs, stylistic inconsistencies, and suspicious constructs. The term originated from the Unix utility "lint," which was designed to flag suspicious and non-portable constructs in C language code. While linting was initially used for C, it has since been adapted for various programming languages and is now a common practice in software development.

Linting tools are available for different programming languages and can help developers identify issues early in the development process, reducing the likelihood of bugs and improving the overall quality of the code. These tools can catch a wide range of issues, including syntax errors, unused variables, misspelled function names, and adherence to coding style guidelines.

Some popular linting tools for specific programming languages include:

- [ESLint](https://eslint.org/) for JavaScript: It helps identify and fix problems in JavaScript code, ensuring adherence to coding standards and best practices.

- [Flake8](https://flake8.pycqa.org/en/latest/) for Python: It checks Python code for errors and helps enforce coding standards, improving code quality and maintainability.

- [StyleCop](https://github.com/DotNetAnalyzers/StyleCopAnalyzers) for C#: It enforces coding style and consistency in C# code, helping developers maintain a uniform code style across a project.

Many linters can also be run locally through plugins in VS Code. 

### Github super-linter
The GitHub Super Linter simplifies the process of setting up a comprehensive and consistent code quality checking system for your repositories. By using Super Linter, you can consolidate multiple linters into a single automated workflow, ensuring that your code meets quality standards as defined by the community or your organization.

Key features and benefits of GitHub Super Linter include:

- **Multi-language support**: Super Linter can analyze code written in various programming languages, including JavaScript, Python, Java, Ruby, Go, and more.

- **Consistent coding standards**: It enforces consistent coding styles and best practices across different programming languages.

- **Automated linting**: GitHub Super Linter can be set up as a GitHub Action, allowing you to automatically run code analysis whenever a pull request is opened or updated, providing immediate feedback to developers.

- **Customizability**: You can configure GitHub Super Linter to include or exclude specific linters, depending on your project's requirements.

- **Integration with GitHub workflows**: It seamlessly integrates with GitHub's continuous integration and continuous deployment (CI/CD) workflows, allowing for efficient code analysis as part of the development process.

***A note on GitHub super-linter:*** 
Super-linter cant be cached thus creates a lot of overhead when used. A normal linter would take 3 seconds when super-linter takes 2 minutes. Also, it is more customizable with a project specific linter.

We recommend only to use super-linter if it is a large project with multiple-languages or it is not possible to use a local linter.

### Function documentation linter
Function documentation linters are tools that help ensure that the documentation for functions and methods in code follows a specified format and provides sufficient information about the purpose, parameters, return values, and usage of the functions. These linters enforce standards for documenting code, which is crucial for improving code readability, maintainability, and understanding, especially in collaborative software development environments. Two common function documentation linters are JSDoc and Flake8, which are used for JavaScript and Python, respectively.

These does not often need to run seperatly, instead they are a part of the linter. Some configurations is needed to include them in the CI.

Example with JS/TS:

`.eslintrc.cjs`
```cjs
 "plugins": ["jsdoc"],
    'jsdoc/require-jsdoc': [
      'warn',
      {
        require: {
          FunctionDeclaration: true,
          MethodDefinition: true,
          ClassDeclaration: true,
        },
      },
    ],
    'valid-jsdoc': [
      'warn',
      {
        requireReturn: false,
        requireParamDescription: true,
        requireReturnDescription: true,
      },
    ],

```

Example python:

`pip install flake8-docstrings`

## Code reviews
The main branch should be protected from pushes and only merging through pull requests should be allowed. In projects with 3 > developer, 
code reviews should be used to validate and ensure code quality. A approval of minimum 2 developers should be in place to merge the change.

When creating a PR, a template is used to check that everything is correct before creating the PR. In setting -> branches, rules can be set up what requirements to PR should be done. We recommend checking in

* Require a pull request before merging
* Require approvals
* Require status checks to pass before merging
* Require branches to be up to date before merging
* Require conversation resolution before merging

To ensure a code quality and standard is followed.

## CI pipeline
The CI pipeline(s) are always defined in `.github/workflows`, a general build may look like this


```yaml

---
---
name: development-template

on:
  push:
    branches-ignore:
      - main        # Use branches instead of pushing directly to main
    paths-ignore:
      - 'docs/**'   # Docs is running its own workflow

permissions:
  contents: read # The workflow is read only

# Ensures that only one workflow per branch/environment will be run
concurrency:
  group: ${{ github.head_ref || github.ref_name }} 
  cancel-in-progress: true

jobs:      
  run_project:
    runs-on: ubuntu-22.04   # Change to linux, macos or windows. To run multiple os:es, see https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs
    timeout-minutes: 10 # job times out after 10 mins

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      # Define what language, versions etc here. Sometimes you may not need it
      - name: Setup x
        run: echo "set up project here" 

      # Cache dependencies for faster workflow, see https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows
      - name: Cache dependencies
        uses: actions/cache@v3

      - name: Install dependencies
        run: echo "install dependencies"

      # Define how the lint will be run
      - name: Linting
        run: echo "run lint" 

      # Change this to your build command
      - name: Build
        run: echo "build project" 

      # change this to your test command, you may need to run multiple tests here, such as unit, e2e, integration etc.
      - name: Run Tests
        run: echo "run tests" 

      # most tests frameworks can generate a json or txt file which data such as total lines/functions/etc covererd.
      - name: Retrieve unit test coverage
        run: |
          echo "generate test files" 
          COVERAGE_VAR=$(jq -r '.your.json.file.format' < testfile.json) # IF json file, change your.json.file to the correct query and testfile to correct file
          if [[ $COVERAGE_VAR -lt 80 ]]; then  # Adjust threshold as needed
            echo "::warning::Coverage below threshold (${COVERAGE_VAR}). \
            Please improve test coverage." >> $GITHUB_STEP_SUMMARY 
          else
            echo "$COVERAGE_VAR % line coverage"
          fi
```
You need to change the steps to accomodate what language and framework the project is using. 


