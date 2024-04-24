#import "@preview/cmarker:0.1.0"
#import "./components.typ": *
#import "../util.typ": *

#let ResumeProjectsSection(projects) = { 
  stick_together(
    threshold: 60pt,
    [= Projects],
    grid(
      columns: (1fr),
      rows: (auto),
      row-gutter: 24pt,

      ..projects.map(project => { 
          ResumeEntry(
            title: project.name,
            title-r: project.description,
            subtitle: project.date,
            subtitle-r: project.keywords.join(", "),
          )

          ResumeItem( 
            cmarker.render(project.summary)
          )
      })
    )
  )
 }