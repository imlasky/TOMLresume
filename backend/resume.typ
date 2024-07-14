// #import "template.typ": resume, header, resume_heading, edu_item, exp_item, project_item, skill_item

// #show: resume

// #let data = json.decode(sys.inputs.data)


// #header(
//   name: data.basics.name,
//   email: data.basics.email,
//   url: data.basics.url,
//   phone: data.basics.phone,
//   profiles: data.basics.profiles,
//   location: data.basics.location
// )

// // #if data.work.len() > 0 {
  
// //   resume_heading[Experience]
// //   for work in data.work {
    
// //     exp_item(
// //       role: work.position,
// //       name: work.name,
// //       location: work.city + if work.country != "" {"," + work.country},
// //       date: work.startDate + " --- " + if work.present [Present] else [#work.endDate],
// //       highlights: work.work_highlights
// //     )
// //   }
// // }

// // #if data.education.len() > 0 {

// //   resume_heading[Education]
// //   for edu in data.education {
    
// //     edu_item(
// //       name: edu.institution,
// //       degree: edu.studyType + " in " + edu.area,
// //       // location: "Georgetown, TX",
// //       date: edu.startDate + " --- " + edu.endDate
// //     )
// //   }
// // }

// // #if data.projects.len() > 0 {

// //   resume_heading("Projects")
// //   for project in data.projects {
    
// //     project_item(
// //       name: project.name,
// //       highlights: project.projects_highlights
// //     )
// //   }
// // }

// // #if data.skills.len() > 0 {

// //   resume_heading("Skills")
// //   for skill in data.skills {
    
// //     skill_item(
// //       category: skill.name,
// //       skills: skill.keywords
// //     )
// //   }
// // }

#import "template.typ": resume, resume_heading, edu_item, exp_item, project_item, skill_item, volunteer_item, award_item, certificate_item, publication_item, language_item, interest_item, reference_item

#show: resume

#let data = json.decode(sys.inputs.data)

// #header(
//   name: data.basics.name,
//   label: data.basics.label,
//   image: data.basics.image,
//   email: data.basics.email,
//   url: data.basics.url,
//   phone: data.basics.phone,
//   summary: data.basics.summary,
//   profiles: data.basics.profiles,
//   location: data.basics.location
// )

#if data.work.len() > 0 {
  resume_heading[Experience]
  for work in data.work {
    exp_item(
      position: work.position,
      name: work.name,
      url: work.url,
      date: work.startDate + " --- " + if work.endDate == none [Present] else [#work.endDate],
      summary: work.summary,
      highlights: work.highlights
    )
  }
}

#if data.education.len() > 0 {
  resume_heading[Education]
  for edu in data.education {
    edu_item(
      institution: edu.institution,
      url: edu.url,
      area: edu.area,
      studyType: edu.studyType,
      date: edu.startDate + " --- " + edu.endDate,
      score: edu.score,
      courses: edu.courses
    )
  }
}

#if data.volunteer.len() > 0 {
  resume_heading[Volunteer Experience]
  for vol in data.volunteer {
    volunteer_item(
      organization: vol.organization,
      position: vol.position,
      url: vol.url,
      date: vol.startDate + " --- " + if vol.endDate == none [Present] else [#vol.endDate],
      summary: vol.summary,
      highlights: vol.highlights
    )
  }
}

#if data.awards.len() > 0 {
  resume_heading[Awards]
  for award in data.awards {
    award_item(
      title: award.title,
      date: award.date,
      awarder: award.awarder,
      summary: award.summary
    )
  }
}

#if data.certificates.len() > 0 {
  resume_heading[Certificates]
  for cert in data.certificates {
    certificate_item(
      name: cert.name,
      date: cert.date,
      issuer: cert.issuer,
      url: cert.url
    )
  }
}

#if data.publications.len() > 0 {
  resume_heading[Publications]
  for pub in data.publications {
    publication_item(
      name: pub.name,
      publisher: pub.publisher,
      releaseDate: pub.releaseDate,
      url: pub.url,
      summary: pub.summary
    )
  }
}

#if data.skills.len() > 0 {
  resume_heading[Skills]
  for skill in data.skills {
    skill_item(
      name: skill.name,
      level: skill.level,
      keywords: skill.keywords
    )
  }
}

#if data.languages.len() > 0 {
  resume_heading[Languages]
  for lang in data.languages {
    language_item(
      language: lang.language,
      fluency: lang.fluency
    )
  }
}

#if data.interests.len() > 0 {
  resume_heading[Interests]
  for interest in data.interests {
    interest_item(
      name: interest.name,
      keywords: interest.keywords
    )
  }
}

#if data.references.len() > 0 {
  resume_heading[References]
  for ref in data.references {
    reference_item(
      name: ref.name,
      reference: ref.reference
    )
  }
}

#if data.projects.len() > 0 {
  resume_heading[Projects]
  for project in data.projects {
    project_item(
      name: project.name,
      description: project.description,
      highlights: project.highlights,
      startDate: project.startDate,
      endDate: project.endDate,
      url: project.url
    )
  }
}
