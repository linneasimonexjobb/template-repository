
Issues in GitHub repositories are a crucial aspect of collaborative software development.
They serve as a way for users to report problems, request features, and provide general feedback on a project. 

It is crucial to use issues, even if it is a one man project because it is a way to retain information if one would leave the project.

## Creating an issue
When creating a issue a template will be shown how to write the issue. This is a markdown file created in `.github/ISSUE_TEMPLATE.md`.
This can be changed to specify the projects needs.

A workflow will also run to validate that the issue has been tagged with a label.

## Closing an issue
To close a issue you need to create a PR. In the PR another template (`.github/PULL_REQUEST_TEMPLATE.md`) will be shown where you need to specify what you have done and that all the stages are correctly. Likewise the issue template, you may alter it to fit the projects needs. To close the issue, mark the issue with the tag `closes #ISSUE_NUMBER`. For example:

`closes #1`

When the pull request is merged, the issue will automatiaclly be closed.