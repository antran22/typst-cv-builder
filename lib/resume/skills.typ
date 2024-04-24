#import "@preview/cmarker:0.1.0"
#import "./components.typ": *
#import "../util.typ": *


#let ResumeSkillItem(name: "", description: content, keywords: ()) = {
  set block(below: 0.65em)
  
  stack(
    dir: ttb, 
    spacing: 10pt,
    [== #name],
    text(description, size: 10pt, weight: "light"),
    text(keywords.join(", "), size: 8pt, weight: "medium")
  )

}


#let ResumeSkillsSection(skills, title: "Technical Skills", column_count: 2) = [
  #let layout = range(column_count).map(_ => 1fr)

  #stick_together(
    threshold: 60pt,
    [= #title],
    [
      #grid(
        columns: layout,
        column-gutter: 24pt,
        rows: (auto),
        row-gutter: 18pt,

        ..skills.map(skill=> { 
          [ 
            #ResumeSkillItem(
              name: skill.name,
              description: cmarker.render(skill.at("description", default: "")),
              keywords: skill.at("keywords", default: ())
            )
          ]
        })
      )
    ]
  )
]