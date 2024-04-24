#import "/lib/util.typ": *
#import "./components.typ": *
#let ResumeCertification(certification, date) = {
  justified-header(certification, date)
}

#let ResumeCertificationSection(certifications, column_count: 1) = [
  #stick_together(
    threshold: 40pt,
    [= Certifications],
    grid(
      columns: equal_columns(column_count: column_count),
      rows: (auto),
      row-gutter: 24pt,

      ..certifications.map(cert => { 
        ResumeCertification(cert.name, cert.date)
      })
    )
  )
]
