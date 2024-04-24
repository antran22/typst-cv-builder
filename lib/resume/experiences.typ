#import "@preview/cmarker:0.1.0"
#import "./components.typ": *
#import "../util.typ": *

#let ResumeExperienceSection(experiences) = [
  #stick_together(
    threshold: 60pt,
    [= Experience],
      grid(
        columns: (1fr),
        rows: (auto),
        row-gutter: 24pt,

        ..experiences.map(exp => { 
          ResumeEntry(
            title: if "url" in exp {
              link(exp.url)[#exp.company]
            } else {
              exp.company
            },
            title-r: exp.position,
            subtitle: exp.date,
            subtitle-r: exp.location,
          )
          ResumeItem(
            cmarker.render(exp.summary)
          )
        })
      )
  )
]