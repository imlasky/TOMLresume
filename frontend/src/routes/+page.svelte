<script>
    import { applyAction, enhance } from '$app/forms';
    import { text } from '@sveltejs/kit';
    import { onMount } from 'svelte';
    import { parse, stringify } from 'smol-toml'
    
    let textContent = ``

    let initialContent = 
`[Basics]
Name = "John Doe"\n
Email = "john.doe@email.com"
Phone = "(123) 456-7890"

[Skills]
"Programming Languages" = ["Python", "JavaScript", "Haskell"]
Frameworks = ["Django", "React", "Express.js"]
Databases = ["PostgreSQL", "MongoDB", "Redis"]
Tools = ["Git", "Docker", "AWS"]

[[Experience]]
role = "Senior Developer at Tech Co. (2018-Present)"
achievements = [
    "Led a team of 5 developers",
    "Implemented new features that increased user engagement by 25%"
]

[[Experience]]
role = "Junior Developer at Startup Inc. (2015-2018)"
achievements = [
    "Developed and maintained the company's main web application",
    "Collaborated with the design team to improve UI/UX"
]

[Education]
degree = "Bachelor of Science in Computer Science (2011-2015)"
institution = "University of Technology"
GPA = 3.8
"GPA Scale" = 4.0
"Relevant coursework" = ["Data Structures", "Algorithms", "Database Systems"]`

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
<p>Turn <a href="https://toml.io">TOML</a> into a nicely formatted resume.</p>


<form method="post" use:enhance={({ formElement, formData, action, cancel }) => {
    
    return async ({ result }) => {
        textContent = result.data.textContent
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
    }
</style>