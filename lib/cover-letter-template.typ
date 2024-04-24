#import "@preview/fontawesome:0.1.0": *
#import "@preview/linguify:0.4.0": *
#import "./common.typ": *

/// ---- Coverletter ----

/// Cover letter template that is inspired by the Awesome CV Latex template by posquit0. This template can loosely be considered a port of the original Latex template. 
/// This coverletter template is designed to be used with the resume template.
/// - author (content): Structure that takes in all the author's information
/// - profile-picture (image): The profile picture of the author. This will be cropped to a circle and should be square in nature.
/// - date (date): The date the cover letter was created
/// - accent-color (color): The accent color of the cover letter
/// - body (content): The body of the cover letter
#let CoverLetterTemplate(
  author: (:),
  profile-picture: image,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  language: "en",
  body,
) = {
  if type(accent-color) == "string" {
    accent-color = rgb(accent-color)
  }
  
  // language data
  let lang_data = toml("lang.toml")
  
  set document(
    author: author.first_name + " " + author.last_name,
    title: "cover-letter",
  )
  
  set text(
    font: (text-font),
    lang: language,
    size: 11pt,
    fill: color-darkgray,
    fallback: true,
  )
  
  set page(
    paper: "a4",
    margin: (left: 15mm, right: 15mm, top: 10mm, bottom: 10mm),
    footer: [
      #set text(
        fill: gray,
        size: 8pt,
      )
      #__justify_align_3[
        #smallcaps[#date]
      ][
        #smallcaps[
          #author.first_name
          #author.last_name
          #sym.dot.c
          #linguify("cover-letter", from: lang_data)
        ]
      ][
        #counter(page).display()
      ]
    ],
    footer-descent: 0pt,
  )
  
  // set paragraph spacing
  show par: set block(
    above: 0.75em,
    below: 0.75em,
  )
  set par(justify: true)
  
  set heading(
    numbering: none,
    outlined: false,
  )
  
  show heading: it => [
    #set block(
      above: 1em,
      below: 1em,
    )
    #set text(
      size: 16pt,
      weight: "regular",
    )
    
    #align(left)[
      #text[#strong[#text(accent-color)[#it.body.text]]]
      #box(width: 1fr, line(length: 100%))
    ]
  ]
  
  let name = {
    align(right)[
      #pad(bottom: 5pt)[
        #block[
          #set text(
            size: 32pt,
            style: "normal",
            font: (display-font),
          )
          #text(accent-color, weight: "thin")[#author.first_name]
          #text(weight: "bold")[#author.last_name]
        ]
      ]
    ]
  }
  
  let positions = {
    set text(
      accent-color,
      size: 9pt,
      weight: "regular",
    )
    align(right)[
      #smallcaps[
        #author.positions.join(
          text[#"  "#sym.dot.c#"  "],
        )
      ]
    ]
  }
  
  let address = {
    set text(
      size: 9pt,
      weight: "bold",
      fill: color-gray,
    )
    align(right)[
      #author.address
    ]
  }
  
  let contacts = {
    set box(height: 9pt)
    
    let separator = [#box(sym.bar.v)]
    
    align(right)[
      #set text(
        size: 8pt,
        weight: "light",
        style: "normal",
      )
      #block[
        #align(horizon)[
          #stack(
            dir: ltr,
            spacing: 0.5em,
            if author.phone != none [
              #ICONS.phone
              #box[#text(author.phone)]
              #separator
            ],
            if author.email != none [
              #ICONS.email
              #box[#link("mailto:" + author.email)[#author.email]]
            ],
            if author.github != none [
              #separator
              #ICONS.github
              #box[#link("https://github.com/" + author.github)[#author.github]]
            ],
            if author.linkedin != none [
              #separator
              #ICONS.linkedin
              #box[
                #link("https://www.linkedin.com/in/" + author.linkedin)[#author.first_name #author.last_name]
              ]
            ],
          )
        ]
      ]
    ]
  }
  
  let letter-heading = {
    grid(
      columns: (1fr, 2fr),
      rows: (100pt),
      align(left + horizon)[
        #block(
          clip: true,
          stroke: 0pt,
          radius: 2cm,
          width: 4cm,
          height: 4cm,
          profile-picture,
        )
      ],
      [
        #name
        #positions
        #address
        #contacts
      ],
    )
  }
  
  let letter-conclusion = {
    align(bottom)[
      #pad(bottom: 2em)[
        #text(weight: "light")[Sincerely,] \
        #text(weight: "bold")[#author.first_name #author.last_name] \ \
        #text(weight: "light", style: "italic")[ #linguify(
            "attached",
            from: lang_data,
          )#sym.colon #linguify("curriculum-vitae", from: lang_data)]
      ]
    ]
  }
  
  // actual content
  letter-heading
  body
  linebreak()
  letter-conclusion
}

/// Cover letter heading that takes in the information for the hiring company and formats it properly.
/// - entity-info (content): The information of the hiring entity including the company name, the target (who's attention to), street address, and city
/// - date (date): The date the letter was written (defaults to the current date)
#let hiring-entity-info(
  entity-info: (:),
  date: datetime.today().display("[month repr:long] [day], [year]"),
) = {
  set par(leading: 1em)
  pad(top: 1.5em, bottom: 1.5em)[
    #__justify_align[
      #text(weight: "bold", size: 12pt)[#entity-info.target]
    ][
      #text(weight: "light", style: "italic", size: 9pt)[#date]
    ]
    
    #pad(top: 0.65em, bottom: 0.65em)[
      #text(weight: "regular", fill: color-gray, size: 9pt)[
        #smallcaps[#entity-info.name] \
        #entity-info.street-address \
        #entity-info.city \
      ]
    ]
  ]
}

/// Letter heading for a given job position and addressee.
/// - job-position (string): The job position you are applying for
/// - addressee (string): The person you are addressing the letter to
#let letter-heading(job-position: "", addressee: "") = {
  let lang_data = toml("lang.toml")
  
  // TODO: Make this adaptable to content
  underline(evade: false, stroke: 0.5pt, offset: 0.3em)[
    #text(weight: "bold", size: 12pt)[Job Application for #job-position]
  ]
  pad(top: 1em, bottom: 1em)[
    #text(weight: "light", fill: color-gray)[
      #linguify("dear", from: lang_data) #addressee,
    ]
  ]
}

/// Cover letter content paragraph. This is the main content of the cover letter.
/// - content (content): The content of the cover letter
#let coverletter-content(content) = {
  pad(top: 1em, bottom: 1em)[
    #set par(first-line-indent: 3em)
    #set text(weight: "light")
    #content
  ]
}

/// ---- End of Coverletter ----
