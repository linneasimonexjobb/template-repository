Welcome to this example wiki. In here there are guides on how to set up a project using MkDocs, git-prehooks, CI/CD, Docker, issue tracking and other means to make the greenhouse process a bit more streamlined. The integration of documentation follows a light version of [docs-as-code](https://www.writethedocs.org/guide/docs-as-code/), such as version control, markdown, code reviews and automated tests are followed. We advice reading through just the first page to get comfortable with the philosphy.

Everything done here is just an example and one may use the template, or alter things if you deem neccecary.

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
