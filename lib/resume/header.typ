#import "../common.typ": *
#import "./components.typ": *
#import "@preview/cmarker:0.1.0"


#let ResumeProfileEntry(title: "", type: "", url: "") = {
  stack(dir: ltr, spacing: 0pt)[
    #set text(size: 9pt)
    #ICONS.at(type)
    #box(width: 0pt)
    #if url != "" {
      link(url, title)
    } else {
      text(title)
    }
  ]
}

#let ResumeHeader(
  basic_info: (:),
  positions: (),
  profile-picture: image, 
  colored-headers: true,
  language: "en",
) = {
  let Name = {
    align(right)[
      #pad(bottom: 5pt)[
        #block[
          #set text(
            size: 24pt,
            style: "normal",
            font: (display-font),
          )
          #text(fill: accent-color, weight: "bold")[#basic_info.first_name]
          #text(weight: "bold")[#basic_info.last_name]
        ]
      ]
    ]
  }
  
  let Positions = {
    set text(
      accent-color,
      size: 9pt,
      weight: "regular",
    )
    align(right)[
      #smallcaps[
        #positions.join(
          text[#"  "#sym.dot.c#"  "],
        )
      ]
    ]
  }
  
  
  let Contacts = {
    let separator = box(width: 2pt)
    
    align(right)[ 
      #set text(
        size: 8pt,
        weight: "regular",
        style: "normal",
      )

      #block( 
        align(
          horizon,
          stack(
            dir: ltr,
            spacing: 2em,
            ResumeProfileEntry(
              type: "phone", 
              title: basic_info.phone,
              url: "tel:" + basic_info.phone
            ),

            ResumeProfileEntry(
              type: "email", 
              title: basic_info.email,
              url: "mailto:" + basic_info.email
            ),
            ResumeProfileEntry(
              type: "location", 
              title: basic_info.address,
            ),
          )
        )
      ),

      #v(8pt)
      
      #block( 
        align(
          horizon,
          stack(
            dir: ltr,
            spacing: 2em,
            ..basic_info.profiles.map(cont => {
              [
                #ResumeProfileEntry(
                  title: cont.username,
                  type: cont.icon,
                  url: cont.url.href,
                )
              ]
            })
          )
        )
      )
    ]
  }
  

  let Profiles = {
    align(right)[
      #set text(
        size: 8pt,
        weight: "regular",
        style: "normal",
      )
    ]
  }

  grid(
    columns: (2cm, 1fr),
    rows: (2cm),
    align(left + horizon)[
      #block(
        clip: true,
        stroke: 1pt,
        radius: 2cm,
        width: 2cm,
        height: 2cm,
        profile-picture
      )
    ],
    [
      #Name
      #Positions
      #pad(top: 5pt, [#Contacts])
      #pad(top: 5pt, [#Profiles])
    ],
  )

}