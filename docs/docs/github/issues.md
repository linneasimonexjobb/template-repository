Both Issues and Project Boards are tightly integrated with repositories, and can work together through automated workflows to enhance project management and collaboration on GitHub.

Documentation about issues and projects, and their automatic workflow can be found [here.](https://docs.github.com/issues)

## Issues
Issues in GitHub repositories are a crucial aspect of collaborative software development.
They serve as a way for users and developers to report problems, request features, and provide general feedback on a project. 

It is crucial to use issues, even if it is a one man project because it is a way to retain information and allow traceback to previous issues if one would leave the project.

### Creating an issue
When creating an issue a template will be shown how to write the issue. This is a markdown file created in `.github/ISSUE_TEMPLATE.md`.
This can be changed to specify the projects needs.

Important when working with issues is adding a fitting label and assigning it to a developer. Upon creating the issue, it will be added in form of a card to the linked project board. The card will contain all the information that the issue contains such as description, label and assignee. 
A workflow (`.github/workflows/project-management.yml`) will also run to validate that the issue has been tagged with a label.

### Closing an issue
To close a issue you need to create a pull request. In the PR another template (`.github/PULL_REQUEST_TEMPLATE.md`) will be shown where you need to specify what you have done and that all the stages are correctly. Likewise the issue template, you may alter it to fit the projects needs. To close the issue, mark the issue with the tag `closes #ISSUE_NUMBER`. For example:

`closes #1`

When the pull request is merged, the issue will automatiaclly be closed, and the board will be updated.

## Project boards
GitHub Project Boards are a powerful project management feature that helps teams organize, prioritize, and track their work directly within GitHub in the form of a Kanban board. These boards provide a visual way to manage GitHub issues and pull requests, making it easier for teams to collaborate and stay organized. 

### Project board beta
As of writing this (02/11/23), GitHub as revamped project board to exclude Github Actions workflows, today they are working with templates which is in beta. So this guide can be changed in the future.

### Project board template
In the repos project board, there is a  template named `project template`. This template can be applied to any project to follow the [kanban](https://en.wikipedia.org/wiki/Kanban_(development)) board methodology. The template consists of two tabs, "Status board" to view a Kanban board of the issues and pull requests and "Tasks" to view the issues and pull requests in a list. The Kanban board has 5 columns, which can be configured, and cards created can be draged between boards. Upon changing which column the card belongs to, an update will be sent to the issue and pull request in their respective locations. 

The board can of course be re-configured by admins by for example changing columns in "Status Board" or "Tasks", or adding fields to tasks (such as Priority and Workload) to give more information about the task. 

### Adding tasks
A card/task can be created in either tab by clicking the "+" at the bottom of the column/list. When creating a card, either an existsing issue can be chosen or a new issue can be created and just like when creating an issue, the card can be assigned a label and an assignee. Upon creating a card, an issues will also automatically be created containing the same information as the card. The card can then on be edited to add a value to workload (5 for high and 1 for low) and priority (5 for high and 1 for low) to help organise and prioritise tasks. 

### Link project template to a project
To link a project board to a specific project, you need to access the settings by clicking on the three dots icon at the righthand corner. Then in the settings, you need to connect the template to the existing repo and name it. Then the issues, pull requests and project board linked to the specified repository is connected and will dynamically change whenever one or the other is altered.

## Automatic workflow
Issues and Project boards ahve built-in automatic workflows outside of GitHub Actions workflows that controlles how issues, pull requests and board work together and update each other. 

### Workflow settings
To change or update the workflow one can (in either the template borad or specific repository linked board) click on the three dots in the righthand corner when viewing the board and click on "Workflows". Here there exists 8 default workflows but one can add more to fit their project needs. Each workflow can be separatly changed between on/off. 

The impostant thing to do here is to go into the "Auto-add to project" and change so it tracks a specific repository. This is so the board can find repository specific issues and pull requests and add them to the board automatically upon creation. 