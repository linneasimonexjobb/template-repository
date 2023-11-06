# Pre-hooks
Pre-hooks, in the context of version control systems like Git, refer to scripts that are run before the execution of Git commands, typically before the staging of files or the creation of a commit. They are a part of the pre-commit framework that allows you to set up hooks to enforce certain guidelines or checks before allowing a commit to proceed.

In the case of the pre-commit Python package, it provides a framework for managing and maintaining multi-language pre-commit hooks. These hooks can be used to automatically check your code for issues before you commit it. This can include tasks like checking for trailing whitespace, running tests, or enforcing specific code formatting guidelines.

By integrating pre-commit into your workflow, you can ensure that certain checks and tests are performed automatically before your changes are committed, helping maintain code quality and consistency across your project. This can be especially useful in collaborative environments to enforce consistent standards and reduce the likelihood of introducing errors or inconsistencies into the codebase.

## Why python pre-commit and not change the .git folder?
Implementing a third-party plugin to make alterations is a best practice that creates a streamlined collaborative enviroment.
While this approach may restrict the use to specific plugins and customizable hooks, the wide array of available plugins and the ease of implementation more than compensate for any limitations.

## Getting started
What you need:
- Python 3.x

To download pre-commit use `pip install pre-commit`.

After installment, a `.pre-commit-config.yaml` is needed to install pre-hooks to the project. A template with naitive and 3rd party plugins has been created.
For larger project we recommend using all of them, specially commitzen to create valuable commit message. But it is up to each project to bring valuable plugins. Please look at the [pre-hook](https://github.com/pre-commit/pre-commit-hooks) to find some out-of-the-box pre-hooks that is avaiable.

## Install pre-hooks
After choosing pre-hooks, to install use:

`pre-hooks install` to install general pre-hooks.

To install specific hook types, you need to install using the `--hook-type` flag:

For example:

`pre-commit install --hook-type commit-msg`

Please look at [pre-commit](https://pre-commit.com/) for more information