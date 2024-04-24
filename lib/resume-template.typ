#import "./resume/layout.typ": *
#import "./resume/education.typ": *
#import "./resume/experiences.typ": *
#import "./resume/skills.typ": *
#import "./resume/projects.typ": *
#import "./resume/header.typ": *
#import "./resume/certification.typ": *


#let default-config = yaml("/data/default-config.yml")
#let config = default-config + yaml(sys.inputs.at("config", default: "/data/default-config.yml"))

#let profile-picture = image("/data/" + config.at("avatar", default: "avatar.jpg"), fit: "cover", width: 2cm, height: 2cm)
#let basic_info = yaml("/data/basic.yml")

#show: ResumeLayout.with(
  basic_info: basic_info,
  date: datetime.today().display(),
  language: config.lang,
)

#let HeaderSection = [
  #ResumeHeader(
    basic_info: basic_info,
    profile-picture: profile-picture,
    positions: config.positions, 
  )
]


#let SectionMap = (:)


#SectionMap.insert(
  "about",
  [
    = About me 

    #pad(
      text(
        size: 10pt, 
        cmarker.render(config.about),
      )
    )
  ]
)

#SectionMap.insert(
  "certifications",
  ResumeCertificationSection(
    pull_entries(
      yaml("/data/certification.yml"), 
      only: config.certifications,
    ),
    column_count: 1
  )
)


#SectionMap.insert(
  "educations",
  ResumeEducationSection(
    pull_entries(
      yaml("/data/education.yml"), 
      only: config.educations,
    ),
    column_count: 1
  )
)


#SectionMap.insert(
  "languages",
  ResumeSkillsSection(
    basic_info.languages,
    column_count: basic_info.languages.len(),
    title: "Languages"
  )
)

#SectionMap.insert(
  "experiences", 
  ResumeExperienceSection(
    pull_entries(
      yaml("/data/experience.yml"), 
      only: config.experiences,
    )
  )
)

#SectionMap.insert(
  "projects", 
  ResumeProjectsSection(
    pull_entries(
      yaml("/data/projects.yml"), 
      only: config.projects, 
    )
  )
)

#SectionMap.insert(
  "tech-skills" , 
  ResumeSkillsSection(
    pull_entries(
      yaml("/data/tech-skill.yml"), 
      only: config.tech_skills,
    )
  )
)

#SectionMap.insert(
  "soft-skills" , 
  ResumeSkillsSection(
    pull_entries(
      yaml("/data/soft-skills.yml"), 
      only: config.soft_skills,
    ),
    title: "Soft Skills",
    column_count: 2,
  )
)

#SectionMap.insert(
  "interests",
  ResumeSkillsSection(
    pull_entries(
      yaml("/data/interest.yml"), 
      only: config.interests
    ),
    title: "Interests & Hobbies",
    column_count: 2,
  )
)


#let DisplayedSections = (HeaderSection,)
#for sec_name in config.sections {
  if sec_name in SectionMap {
    DisplayedSections.push(SectionMap.at(sec_name))
  }
}

#stack(
  dir: ttb,
  spacing: config.layout.at("section_spacing", default: 30) * 1pt,
  ..DisplayedSections
)


