This template should be the first page a user reaches when entering the wiki. Here should project definements, technical- and non-technical requirements be shown. A breif introduction how the wiki is structured and how to find things. We have provided a template on what could be shown but please remove, add or alter how you want the front page to be shown.

## Summary of project

## Purpose of project
Write down a few sentences what you are trying to achieve with the project. This helps with setting a goal and help others understand what the purpose is.


## Requirments
If you have any technical or non-technical requirements, it could declared here with the help of tables, for example:


| Requirement     | Description                     |
| -----------     | ------------------------------------ |
| Login user      | One may only authorize once  |
| Delete message  | A user should be able to delete messages |
| Logout          | a User should be able to logout from the site |

## Layout
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


## Contact
Contact to manager and/or developers

## Status of project
Is the project ongoing, stale or nearly done?