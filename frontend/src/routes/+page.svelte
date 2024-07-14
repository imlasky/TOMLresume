<script>
    import { applyAction, enhance } from '$app/forms';
    import { text } from '@sveltejs/kit';
    import { onMount } from 'svelte';
    import { parse, stringify } from 'smol-toml'
    
    let textContent = ``

    let initialContent = 
`[basics]
name = "Emily Chen"
label = "Full Stack Developer"
email = "emily.chen@email.com"
phone = "(415) 555-7890"
url = "https://emilychen.dev"
summary = "Passionate full stack developer with 5+ years of experience in building scalable web applications. Specialized in React, Node.js, and cloud technologies."

[basics.location]
address = "1234 Tech Avenue"
postalCode = "CA 94107"
city = "San Francisco"
countryCode = "US"
region = "California"

[[basics.profiles]]
network = "LinkedIn"
username = "emilychen"
url = "https://www.linkedin.com/in/emilychen"

[[basics.profiles]]
network = "GitHub"
username = "emily-chen"
url = "https://github.com/emily-chen"

[[work]]
name = "TechNova Solutions"
position = "Senior Full Stack Developer"
url = "https://technovasolutions.com"
startDate = "2019-03-15"
endDate = "2023-07-31"
summary = "Led development of the company's flagship SaaS product, improving performance and scalability."
highlights = [
    "Architected and implemented microservices architecture, reducing system latency by 40%",
    "Mentored junior developers and conducted code reviews",
    "Implemented CI/CD pipeline, reducing deployment time by 60%"
]

[[work]]
name = "StartUp Innovations"
position = "Full Stack Developer"
url = "https://startupinnovations.com"
startDate = "2017-06-01"
endDate = "2019-03-01"
summary = "Worked on various client projects, focusing on responsive web applications."
highlights = [
    "Developed and maintained 10+ client websites using React and Node.js",
    "Integrated third-party APIs and payment gateways",
    "Optimized database queries, improving application response time by 25%"
]

[[volunteer]]
organization = "Code for San Francisco"
position = "Tech Volunteer"
url = "https://codeforsanfrancisco.org/"
startDate = "2018-09-01"
endDate = "2023-12-31"
summary = "Contributed to open-source projects aimed at improving civic services in San Francisco."
highlights = [
    "Developed a mobile app for reporting and tracking local infrastructure issues",
    "Participated in hackathons focused on solving community challenges"
]

[[education]]
institution = "University of California, Berkeley"
url = "https://www.berkeley.edu/"
area = "Computer Science"
studyType = "Bachelor of Science"
startDate = "2013-08-15"
endDate = "2017-05-20"
score = "3.8"
courses = [
    "Data Structures and Algorithms",
    "Database Management Systems",
    "Web Development",
    "Machine Learning"
]

[[awards]]
title = "Best Tech Innovation Award"
date = "2022-11-15"
awarder = "SF Tech Conference"
summary = "Awarded for developing an AI-powered accessibility tool for visually impaired users."

[[certificates]]
name = "AWS Certified Solutions Architect - Associate"
date = "2021-06-30"
issuer = "Amazon Web Services"
url = "https://www.aws.amazon.com/certification/"

[[publications]]
name = "Optimizing React Applications for Performance"
publisher = "Medium"
releaseDate = "2022-03-10"
url = "https://medium.com/@emily.chen/optimizing-react-applications-for-performance"
summary = "A comprehensive guide on improving React application performance through code splitting, memoization, and efficient state management."

[[skills]]
name = "Frontend Development"
level = "Expert"
keywords = ["React", "Vue.js", "JavaScript", "HTML5", "CSS3", "Webpack"]

[[skills]]
name = "Backend Development"
level = "Advanced"
keywords = ["Node.js", "Express", "Python", "Django", "RESTful APIs", "GraphQL"]

[[skills]]
name = "Database Management"
level = "Intermediate"
keywords = ["MongoDB", "PostgreSQL", "MySQL", "Redis"]

[[skills]]
name = "DevOps"
level = "Intermediate"
keywords = ["Docker", "Kubernetes", "AWS", "CI/CD", "Jenkins"]

[[languages]]
language = "English"
fluency = "Native"

[[languages]]
language = "Mandarin Chinese"
fluency = "Fluent"

[[interests]]
name = "Tech Meetups"
keywords = ["Web Development", "AI/ML", "Blockchain"]

[[interests]]
name = "Outdoor Activities"
keywords = ["Hiking", "Rock Climbing", "Photography"]

[[references]]
name = "Alex Johnson"
reference = "Emily is an exceptional developer with a keen eye for detail. Her ability to tackle complex problems and deliver high-quality solutions is impressive. She's a valuable asset to any team."

[[projects]]
name = "EcoTrack"
startDate = "2021-04-01"
endDate = "2022-02-28"
description = "A mobile app for tracking personal carbon footprint and suggesting eco-friendly alternatives."
highlights = [
    "Implemented machine learning algorithm for personalized recommendations",
    "Integrated with IoT devices for automatic data collection",
    "Featured in TechCrunch as one of the top 10 eco-friendly apps of 2022"
]
url = "https://ecotrack-app.com/"`

const storageKey = 'content';

// Function to save to local storage
function saveToLocalStorage(content) {
    localStorage.setItem(storageKey, content);
}

// Function to load from local storage
function loadFromLocalStorage() {
    return localStorage.getItem(storageKey) || initialContent;
}

// Handle textarea input
function handleInput(event) {
    textContent = event.target.value;
    saveToLocalStorage(textContent);
}

onMount(() => {
    // Load content from local storage when component mounts
    textContent = loadFromLocalStorage();
});


</script>

<h1>TOML resume</h1>
<p>Turn <a href="https://toml.io">TOML</a> into a nicely formatted resume. <a href="https://github.com/imlasky/TOMLresume">Source</a></p>


<form method="post" use:enhance={() => {
    
    return async ({ result }) => {
        if (result.data) {

            textContent = result.data.textContent
        }
        
        let pdfBase64 = ''
        if (result.data.pdfBase64) {
            pdfBase64 = result.data.pdfBase64;
            const a = document.createElement('a');
            a.href = `data:application/pdf;base64,${pdfBase64}`;
            a.download = `Resume.pdf`;
            document.body.appendChild(a);
            a.click();            
            document.body.removeChild(a);
        } else {
            console.error('Failed to fetch PDF');
        }
        await applyAction(result);
    };
}}>
    <textarea bind:value={textContent} on:input={handleInput} name="content" rows="30" ></textarea>
    <button>Create resume</button>
</form>


Made by <a href="https://lasky.io">Ian</a>. Need a tailored resume? Check out <a href="https://resgen.app">Resgen</a>
  
<style>
    textarea {
        width: 100%;
        resize: vertical;
    }
</style>