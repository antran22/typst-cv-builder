# Typst based CV Builder

## Use case
- You have a lot of experiences, projects that can be showcased in CVs.
- However, you can only include some of those in one CV to be sent to an employer.
- You need a way to centrally manage all your informations, but also quickly pick out some entries to construct into a CV.
- You don't really care that much about aesthetic. After all, a minimal looking CV is still a good CV.

## Dependencies

- [Typst](https://github.com/typst/typst?tab=readme-ov-file#installation)
- [Go Task](https://taskfile.dev/installation/)

## Workflow

- You add experience, project, skills entries into `data`
  - Each entry must have an ID.
  - Some entry type have a `description` or `summary` that is going to be rendered as Markdown.
  - Each entry can inherit from another entry of the same type. Use this feature how you can (personally, I can have `project1` as the base information, then `project1-frontend` that showcase my frontend skill better)

- To create a new CV, copy 'data/default-config.yml' into a new file in `resumes/`. Name it accordingly, for example 'Google-SRE' or 'Netflix-DevOps'.
- Configure your new CV. 
  - Select entries ID that you want to keep in each section. For example: 
```yaml
experiences:
- exp-1
- exp-2
```
or keep the field as `experiences: all` to include every entries.
  - Reorder your sections the way you see fit.


To develop your CV live: run `task watch-resume Name=$(YAML_FILE_NAME_WITHOUT_EXTENSION)`. The file will be produced in `/output`
To build a final CV: run `task build-resume Name=$(YAML_FILE_NAME_WITHOUT_EXTENSION)`. The file will also be produced in /output

For example:

```bash
git clone https://github.com/antran22/typst-cv-builder.git
cd typst-cv-builder
cp data/default-config.yml resumes/Google-SRE.yml

task watch-resume Name=Google-SRE # watch changes in the CV file and rebuild PDF.

vim resumes/Google-SRE.yml # edit your CV
# while editing the yml file, open output/Google-SRE-DEV.pdf to see the live change

task build-resume Name=Google-SRE # build CV file into output/Google-SRE-$(CURRENT_DATE).pdf. You can send it to your employer now, or keep it somewhere else.
```
