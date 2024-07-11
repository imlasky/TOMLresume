import json
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
from fastapi.responses import StreamingResponse
import subprocess
import re
import os
import io
import json
from fastapi.encoders import jsonable_encoder


app = FastAPI()

class TextArr(BaseModel):
    texts: List[str]

class WorkHighlight(BaseModel):
    highlight: str
    index: Optional[int]

class ProjectHighlight(BaseModel):
    highlight: str

class Work(BaseModel):
    url: Optional[str]
    city: Optional[str]
    name: Optional[str]
    country: Optional[str]
    startDate: Optional[datetime]
    endDate: Optional[datetime]
    present: Optional[bool]
    position: Optional[str]
    work_highlights: List[WorkHighlight]
    index: Optional[int]  

class Basics(BaseModel):
    name: Optional[str]
    email: Optional[str]
    phone: Optional[str]
    city: Optional[str]
    country: Optional[str]
    website: Optional[str]
    linkedin: Optional[str]
    github: Optional[str]

class Education(BaseModel):
    institution: Optional[str]
    degree: Optional[str]
    startDate: Optional[datetime]
    endDate: Optional[datetime]
    present: bool
    accolades: Optional[str]
    GPA: Optional[str]
    GPAScale: Optional[str]

class Skills(BaseModel):
    name: Optional[str]
    keywords: Optional[str]

class Project(BaseModel):
    name: Optional[str]
    startDate: Optional[datetime]
    endDate: Optional[datetime]
    projects_highlights: List[ProjectHighlight] 

class Resume(BaseModel):
    basics: Basics
    work: List[Work] 
    education: List[Education] 
    skills: List[Skills]
    projects: List[Project]


@app.post("/")
def create_resume(resume: Resume):
   
    for work in resume.work:
        if work.startDate:
            work.startDate = work.startDate.strftime("%b, %Y")
        if work.endDate:
            work.endDate = work.endDate.strftime("%b, %Y")

    for education in resume.education:
        if education.startDate:
            education.startDate = education.startDate.strftime("%b, %Y")
        if education.endDate:
            education.endDate = education.endDate.strftime("%b, %Y")


    # Path to your Typst template file
    template_path = os.path.abspath("./resume.typ")
    fname = f'{resume.basics.first_name}_{resume.basics.last_name}_resume'

    output_filename = f"{fname}.pdf"

    try:
        # Prepare the Typst command
        typst_command = ["typst", "compile", template_path, output_filename]
        typst_command.extend(["--input", f"data={json.dumps(jsonable_encoder(resume))}"])

        # Run Typst
        result = subprocess.run(typst_command, capture_output=True, check=True)
        
        # Read the output file into a buffer
        with open(output_filename, 'rb') as f:
            pdf_buffer = io.BytesIO(f.read())
            print(pdf_buffer.getbuffer().nbytes)
        
        print("PDF compiled successfully and stored in buffer.")
        
        return StreamingResponse(pdf_buffer, media_type="application/pdf")
        
    except subprocess.CalledProcessError as e:
        print(f"Error compiling Typst template: {e}")
        print(f"Typst error output: {e.stderr.decode()}")

    finally:
        # Clean up: remove the temporary output file
        os.unlink(output_filename)