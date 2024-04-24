#import "../common.typ": *


/// The base item for resume entries. 
/// This formats the item for the resume entries. Typically your body would be a bullet list of items. Could be your responsibilities at a company or your academic achievements in an educational background section.
/// - body (content): The body of the resume entry
#let ResumeItem(body) = {
  set text(
    size: 10pt,
    style: "normal",
    weight: "light",
    fill: color-darknight,
  )
  show link:underline
  show link: set text(accent-color)
  set par(leading: 0.65em)
  body
}

/// The base item for resume entries. This formats the item for the resume entries. Typically your body would be a bullet list of items. Could be your responsibilities at a company or your academic achievements in an educational background section.
/// - title (string): The title of the resume entry
/// - location (string): The location of the resume entry
/// - date (string): The date of the resume entry, this can be a range (e.g. "Jan 2020 - Dec 2020")
/// - description (content): The body of the resume entry
#let ResumeEntry(
  title: none,
  title-r: "",
  subtitle: "",
  subtitle-r: "",
) = {
  pad(bottom: 8pt)[
    #justified-header(title, title-r)
    #secondary-justified-header(subtitle, subtitle-r)
  ]
}

/// Show cumulative GPA.
/// *Example:*
/// #example(`resume.resume-gpa("3.5", "4.0")`)
#let resume-gpa(numerator, denominator) = {
  set text(
    size: 12pt,
    style: "italic",
    weight: "light",
  )
  text[Cumulative GPA: #box[#strong[#numerator] / #denominator]]
}

