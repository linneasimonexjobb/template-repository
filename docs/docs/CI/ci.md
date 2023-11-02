# why continious integration
To validate that the code is following certain standards, builds and tests correctly. A CI template has been created that the developers may use.

The CI runs on GitHub actions and has a few steps the devs need to assert.


## CI configuration

The CI runs with the steps:

| Steps     | Description                     |
| -----------     | ------------------------------------ |
| Lint      | Linting is used to verify that the code is properly structured, GitHub super-lint is used but can be changed to whatever the devs find appropriate  |
| Build  | The project should be built, here you may use cmake, npm build etc |
| Test         | Atleast basic unit test should be used in the project |
| Test coverage         | Test coverage should be included, but only warn a developer if it is below a certain threshhold |

It is possible to add or remove certain steps if the project allows it. 

## Adding more test suites
Unit test should always be included in the CI build. Based on what project you are working on, other kind of testing could be applied. 

An important note is that the more expensive the test suites are the more mintues it will take from GitHub. We recommend therefore to use
testing techniques such as e2e only when using PR.



## CI pipeline
The CI pipeline(s) are always defined in `.github/workflows`, a general build may look like this


```yaml

---
name: template-example

on:
  push:
    branches-ignore:
      - main        # Use branches instead of pushing directly to main
    paths-ignore:
      - 'wiki/**'

permissions:
  contents: read # The workflow is read only

# Ensures that only one workflow per branch/environment will be run
concurrency:
  group: ${{ github.head_ref || github.ref_name }} 
  cancel-in-progress: true

jobs:      
  run_project:
    runs-on: ubuntu-22.04   # Change to linux, macos or windows. To run multiple os:es, see https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs
    timeout-minutes: 30 #job times out after 30 mins

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Setup x
        run: echo "set up project here" # Define what language, versions etc here. Sometimes you may not need it

    # Cache dependencies for faster workflow
      - name: Cache dependencies
        uses: actions/cache@v3


      - name: Install dependencies
        run: echo "install dependencies"

      - name: Linting
        run: echo "run lint" # Define how the lint will be run
  
      - name: Build
        run: echo "build project" # Change this to your build command

      - name: Run Tests
        run: echo "run tests" # change this to your test command, you may need to run multiple tests here, such as unit, e2e, integration etc.

      - name: Retrieve unit test coverage
        run: |
          echo "generate test files" # most tests frameworks can generate a json or txt file which data such as total lines/functions/etc covererd.
          COVERAGE_VAR=$(jq -r '.your.json.file.format' < testfile.json) # If json file, change your.json.file to the correct query and testfile to correct file
          if [[ $COVERAGE_VAR -lt 80 ]]; then  # Adjust threshold as needed
            echo "::warning::Coverage below threshold (${COVERAGE_VAR}). \
            Please improve test coverage." >> $GITHUB_STEP_SUMMARY 
          else
            echo "$COVERAGE_VAR % line coverage"
          fi
```
You need to change the steps to accomodate what language and framework the project is using. 


