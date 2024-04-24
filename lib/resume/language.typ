
#let ResumeLanguageSection(languages) = { 
  stick_together(
    threshold: 60pt,
    [= Languages],
    stack(
      dir: ltr,
      spacing: 24pt,
      ..languages.map(project => { 
          ResumeEntry(
            title: project.name,
            title-r: project.description,
            subtitle: project.date,
            subtitle-r: project.at("keywords", default: ()).join(", "),
          )

          ResumeItem( 
            cmarker.render(project.summary)
          )
      })
    )
  )
 }