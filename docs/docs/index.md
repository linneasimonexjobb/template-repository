# Home
Welcome to this example wiki. In here there are guides on how to set up a project using MkDocs, git-prehooks, CI/CD, Docker, issue tracking and other means to make the greenhouse process a bit more streamlined.

Everything done here is just an example and one may use the template, or alter things if you deem neccecary.

This first version is made by the master students Simon and Linnéa at Linköping University.


## Navigation
Write where the different navigations take you in the wiki.

In this wiki, we have configured the different tools of DevOps in each NavBar

We recommend having a documentation tidy and easy to maintain. An example would be:

```yaml
project_root/
│
├── wiki/
│   ├── index.md
│   ├── Project
│   │    ├── description.md
│   │    │   
│   └── ... (other top-level pages)
│
├── mkdocs.yml
│
└── site/ (auto-generated)
```
MkDocs only support two layers of nesting, so making use of md headers within each folder is crucial.
## Purpose of project
Write down a few sentences what you are trying to achieve with the project. This helps with setting a goal and help others understand what the purpose is.


## Requirments
If you have any technical or non-technical requirements, it could declared here with the help of tables, for example:


| Requirement     | Description                     |
| -----------     | ------------------------------------ |
| Login user      | One may only authorize once  |
| Delete message  | A user should be able to delete messages |
| Logout          | a User should be able to logout from the site |