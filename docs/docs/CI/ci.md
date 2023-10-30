# why continious integration
To validate that the code is following certain standards, builds and tests correctly. A CI template has been created that the developers may use.

The CI runs on GitHub actions and has a few steps the devs need to assert.


## CI configuration

The CI runs with the steps:

| Steps     | Description                     |
| -----------     | ------------------------------------ |
| Lint      | Linting is used to verify that the code is properly structured, GitHub super-lint is used but can be changed to whatever the devs find appropriate  |
| Build  | The project should be built, here you may use cmake, npm build etc |
| test         | Atleast basic unit test should be used in the project |



## CI pipeline
The CI pipeline(s) are always defined in `.github/workflows`, a general build may look like this


```yaml

name: vue-3-ci

on:
  push:
    branches:
      - "dev/**" # Push can only be done to develepment branches
  pull_request:
    types:
      - closed

permissions:
  actions: read # The workflow is read only

# Ensures that only one workflow per branch/environment will be run
concurrency:
  group: ${{ github.head_ref || github.ref_name }} 
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-22.04
    timeout-minutes: 30 #job times out after 30 mins

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: 18 # Change this to the desired Node.js version

    # Cache dependencies for faster workflow
    - name: Cache dependencies
      uses: actions/cache@v3
      with:
          path: ~/.npm # Can potentially create cache of /node_modules folder but could create conflicts
          key: ${{ runner.OS }}-node-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.OS }}-node-

    - name: Install dependencies
      run: npm ci

    - name: Run Tests
      run: npm run test:unit && npm run test:coverage # Change this to your test command

    - name: Lint code
      run: npm run lint # Change this to your linting command

    - name: Build
      run: npm run build # Change this to your build command

    - name: Archive artifacts
      uses: actions/upload-artifact@v3
      with:
        name: dist
        path: dist

  if_merged:
    needs: build
    if: github.event.pull_request.merged == true
    runs-on: ubuntu-22.04
    timeout-minutes: 30 #job times out after 30 mins
    steps:
    - name: Deploy
      run: |
        echo The PR was merged
```