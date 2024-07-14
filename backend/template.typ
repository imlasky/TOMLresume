// #let resume(body) = {
//   set list(indent: 1em)
//   show list: set text(size: 0.92em)
//   show link: underline
//   show link: set underline(offset: 3pt)

//   set page(
//     paper: "us-letter",
//     margin: (x: 0.5in, y: 0.5in)
//   )

//   set text(
//     size: 11pt,
//       font: "New Computer Modern",
//   )

//   body
// }

// #let name_header(name) = {
//   set text(size: 2.25em)
//   [*#name*]
// }

// #let header(
//   name: "John Doe",
//   phone: "123-456-7890",
//   email: "john@doe.com",
//   linkedin: "linkedin.com/in/jdoe",
//   github: "github.com/jdoe",
//   website: "jdoe.com",
// ) = {
//   align(center,
//     block[
//       #name_header(name) \
//       #box[#if phone != "" [#phone |]]
//       #box[#if email != "" [#link("mailto:" + email)[#email] |]]
//       #box[#if linkedin != "" [#link("https://" + linkedin)[#linkedin] |]]
//       #box[#if website != "" [#link("https://" + website)[#website] |]]
//       #box[#if github != "" [#link("https://" + github)[#github]]]
//     ]
//   )
//   v(5pt)
// }

// #let resume_heading(txt) = {
//   show heading: set text(size: 0.92em, weight: "regular")

//   block[
//     = #smallcaps(txt)
//     #v(-4pt)
//     #line(length: 100%, stroke: 1pt + black)
//   ]
// }

// #let edu_item(
//   name: "Default", 
//   degree: "Default", 
//   date: "Default"
// ) = {
//   set block(above: 0.7em, below: 1em)
//   pad(left: 1em, right: 0.5em, grid(
//     columns: (3fr, 1fr),
//     align(left)[
//       *#name* \
//       _#degree _
//     ],
//     align(right)[

//       #date
//     ]
//   ))
// }

// #let exp_item(
//   name: "Default",
//   role: "Default",
//   date: "Default",
//   location: "Default",
//   highlights: []
// ) = {
//     set block(above: 0.7em, below: 1em)
//     pad(left: 1em, right: 0.5em, box[
//       #grid(
//         columns: (3fr, 1fr),
//         align(left)[
//           *#role* \
//           _#name _
//         ],
//         align(right)[
//           #date \
//           _#location _
//         ]
//       )
//       #for hl in highlights [
//         - #hl.highlight
//       ]
//     ])
// }

// #let project_item(
//   name: "",
//   skills: "",
//   date: "",
//   highlights: []
// ) = {
//   set block(above: 0.7em, below: 1em)
//   pad(left: 1em, right: 0.5em, box[
//     *#name*  #h(1fr) #date
//     #for hl in highlights [
//         - #hl.highlight
//     ]
//   ])
// }

// #let skill_item(
//   category: "Default",
//   skills: "Default",
// ) = {
//   set block(above: 0.7em)
//   set text(size: 0.91em)
//   pad(left: 1em, right: 0.5em, block[*#category*: #skills])
// }

#let resume(body) = {
  set list(indent: 1em)
  show list: set text(size: 0.92em)
  show link: underline
  show link: set underline(offset: 3pt)

  set page(
    paper: "us-letter",
    margin: (x: 0.5in, y: 0.5in)
  )

  set text(
    size: 11pt,
    font: "New Computer Modern",
  )

  body
}

#let name_header(name) = {
  set text(size: 2.25em)
  [*#name*]
}

// #let header(
//   name: "John Doe",
//   label: "",
//   image: "",
//   phone: "",
//   email: "",
//   url: "",
//   summary: "",
//   profiles: [],
//   location: (),
// ) = {
//   align(left + horizon)[
//       #name_header(name)
//       #if label != "" [#label \]
//       #box[#if phone != "" [#phone |]]
//       #box[#if email != "" [#link("mailto:" + email)[#email] |]]
//       #box[#if url != "" [#link(url)[#url] |]]
//       #for profile in profiles [
//         #box[#link(profile.url)[#profile.network] |]
//       ]
//       #if location != () [
//         #location.address, #location.city, #location.region #location.postalCode, #location.countryCode
//       ]
//     ]
  
//   if summary != "" [
//     #v(5pt)
//     #summary
//   ]
//   v(5pt)
// }

#let resume_heading(txt) = {
  show heading: set text(size: 0.92em, weight: "regular")

  block[
    = #smallcaps(txt)
    #v(-4pt)
    #line(length: 100%, stroke: 1pt + black)
  ]
}

#let edu_item(
  institution: "",
  url: "",
  area: "",
  studyType: "",
  date: "",
  score: "",
  courses: []
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, grid(
    columns: (3fr, 1fr),
    align(left)[
      *#institution* \
      _#studyType in #area _
      _#if url != "" [#link(url)[#url]] _ \ 
      #if courses.len() > 0 [
          *Courses:* #courses.join(", ")
      ]
    ],
    align(right)[
      #date \
      #if score != "" [Score: #score]
    ]
  ))
}

#let exp_item(
  name: "",
  position: "",
  date: "",
  url: "",
  summary: "",
  highlights: []
) = {
    set block(above: 0.7em, below: 1em)
    pad(left: 1em, right: 0.5em, box[
      #grid(
        columns: (3fr, 1fr),
        align(left)[
          *#position* \
          _#name _ _#if url != "" [#link(url)[#url]] _
        ],
        align(right)[
          #date
        ]
      )
      #if summary != "" [#summary]
      #for hl in highlights [
        - #hl
      ]
    ])
}

#let project_item(
  name: "",
  description: "",
  highlights: [],
  startDate: "",
  endDate: "",
  url: ""
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, box[
    #grid(
      columns: (3fr, 1fr),
      align(left)[
        *#name* \
        _#if url != "" [#link(url)[#url]]_
      ],
      align(right)[
        #startDate --- #if endDate != none [#endDate] else ["Present"]
      ]
    )
    #if description != "" [#description]
    #for hl in highlights [
      - #hl
    ]
  ])
}

#let skill_item(
  name: "",
  level: "",
  keywords: []
) = {
  set block(above: 0.7em)
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[
    *#name* (#level): #keywords.join(", ")
  ])
}

#let volunteer_item(
  organization: "",
  position: "",
  url: "",
  date: "",
  summary: "",
  highlights: []
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, box[
    #grid(
      columns: (3fr, 1fr),
      align(left)[
        *#position* \
        _#organization _
        _#if url != "" [#link(url)[#url]] _
      ],
      align(right)[
        #date
      ]
    )
    #if summary != "" [#summary]
    #for hl in highlights [
      - #hl
    ]
  ])
}

#let award_item(
  title: "",
  date: "",
  awarder: "",
  summary: ""
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, box[
    #grid(
      columns: (3fr, 0.5fr),
      align(left)[
        *#title* by #awarder\
        _#if summary != "" [#summary] _
      ],
      align(right)[
        #date
    ]
    )
    
  ])
}

#let certificate_item(
  name: "",
  date: "",
  issuer: "",
  url: ""
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, box[
    *#name* - #issuer #h(1fr) #date
    #if url != "" [#link(url)[#url]]
  ])
}

#let publication_item(
  name: "",
  publisher: "",
  releaseDate: "",
  url: "",
  summary: ""
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, box[
    *#name* - #publisher #h(1fr) #releaseDate
    #if url != "" [#link(url)[#url]]
    #if summary != "" [#summary]
  ])
}

#let language_item(
  language: "",
  fluency: ""
) = {
  set block(above: 0.7em)
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[
    *#language*: #fluency
  ])
}

#let interest_item(
  name: "",
  keywords: []
) = {
  set block(above: 0.7em)
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[
    *#name*: #keywords.join(", ")
  ])
}

#let reference_item(
  name: "",
  reference: ""
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, box[
    *#name*
    "#reference"
  ])
}
