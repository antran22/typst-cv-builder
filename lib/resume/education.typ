#import "@preview/cmarker:0.1.0"
#import "./components.typ": *
#import "../util.typ": *

#let ResumeEducationSection(educations, column_count: 1) = [
  #stick_together(
    threshold: 30pt,
    [= Education],
      grid(
        columns: equal_columns(column_count: column_count),
        rows: (auto),
        row-gutter: 24pt,

        ..educations.map(ed => { 
          ResumeEntry(
            title: if "url" in ed {
              link(ed.url, text(ed.institution + " – " + ed.studyType))
            } else {
              text(ed.institution + " – " + ed.studyType)
            },
            title-r: ed.area,
            subtitle: ed.date,
            subtitle-r: ed.score,
          )
          ResumeItem(
            cmarker.render(ed.summary)
          )
        })
      )
  )
]