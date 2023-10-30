# Pre-hooks
Git pre-hooks are scripts that you can use to enforce certain criteria or perform checks before a Git operation is executed. They are useful for ensuring code quality, running tests, or preventing commits that do not meet specific standards.

The pre-hook scripts can be written in any scripting language such as Bash, Python, or Ruby, depending on your requirements and preferences. The main pre-hooks that Git supports are:

pre-commit: This hook is invoked before a commit is created. It can be used to inspect the snapshot that is about to be committed.

pre-rebase: This hook is invoked before a branch is rebased. It can be used to ensure that the branch being rebased is in a suitable state.

pre-receive: This hook is invoked on the remote repository once it has received a push but before it updates any refs. It can be used to check the pushed commits for consistency and quality.

pre-push: This hook is invoked before a push to a remote repository is executed. It can be used to ensure that the pushed changes meet certain criteria.


## Pre-commit
Git pre-commit hooks are scripts that run before the commit is created. They can be used to inspect the snapshot that is about to be committed and to ensure that it passes certain criteria.
If the script exits with a non-zero status, the commit is aborted. Pre-commit hooks are useful for tasks such as checking for trailing whitespace, ensuring commit messages follow a certain
pattern, or running tests before allowing a commit.

To set up a Git pre-commit hook, follow these steps:

Navigate to the .git directory of your project.

Go to the hooks subdirectory. If it doesn't exist, you can create it.

Create a new file named pre-commit (without any file extension) in the hooks directory.

### Commit message
With pre-commit, a set of specified tags can be enforced using git. For example you may need to tag the commit with dev, test, bug etc to know what the commit did. A decription may also be added that requires specific characteristics to be passed.
This can ofcourse be turned of if the developer may find it too enforcing. However, we recommed having some kind of pre-commit message requirement so valuable commit messages are only let through.

### Prettier
You may also use code styling enforcers before commiting your code. For example, prettier can change the code corretly directly.