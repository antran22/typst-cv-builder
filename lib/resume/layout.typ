#import "../common.typ": *
#import "./components.typ": *
#import "@preview/fontawesome:0.1.0": *
#import "@preview/linguify:0.4.0": *
#import "@preview/cmarker:0.1.0"

#let ResumeLayout(
  basic_info: (:),
  date: datetime.today().display("[month repr:long] [day], [year]"),
  language: "en",
  body,
) = {
  let lang_data = toml("../lang.toml")
  
  set document(
    author: basic_info.first_name + " " + basic_info.last_name,
    title: "resume",
  )
  
  set text(
    font: (text-font),
    lang: language,
    size: 11pt,
    fill: color-darkgray,
    fallback: true,
    kerning: true,
    slashed-zero: true,
    hyphenate: true,
  )
  
  set page(
    paper: "a4",
    margin: (left: 10mm, right: 10mm, top: 8mm, bottom: 16mm),
    footer: [
      #set text(
        fill: gray,
        size: 8pt,
      )
        #__justify_align_3[
          #smallcaps[#date]
        ][
          #smallcaps[
            #basic_info.first_name
            #basic_info.last_name
            #sym.dot.c
            #linguify("resume", from: lang_data)
          ]
        ][
          #counter(page).display()
        ]
    ],
    footer-descent: 50%,
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
  
  show heading.where(level: 1): it => [
    #set block(
      above: 1em,
      below: 1em,
    )
    #set text(
      size: 16pt,
      weight: "regular",
    )
    
    #pad(
      bottom: 4pt,
      align(left)[
        #text[#strong[#text(accent-color)[#it.body.text]]]
        #h(4pt)
        #box(width: 1fr, line(length: 100%))
      ]
    )
  ]
  
  show heading.where(level: 2): it => {
    set text(
      color-darkgray,
      size: 12pt,
      style: "normal",
      weight: "bold",
    )
    it.body
  }
  
  show heading.where(level: 3): it => {
    set text(
      size: 10pt,
      weight: "regular",
    )
    smallcaps[#it.body]
  }

  body
}