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
from datetime import date



app = FastAPI()

class Profile(BaseModel):
    network: str
    username: str
    url: str

class Location(BaseModel):
    address: str
    postalCode: str
    city: str
    countryCode: str
    region: str

class Basics(BaseModel):
    name: str
    label: str
    email: str
    phone: str
    url: str
    summary: str
    location: Location
    profiles: List[Profile]

class WorkEntry(BaseModel):
    name: str
    position: str
    url: str
    startDate: date
    endDate: Optional[date]
    summary: str
    highlights: List[str]

class VolunteerEntry(BaseModel):
    organization: str
    position: str
    url: str
    startDate: date
    endDate: Optional[date]
    summary: str
    highlights: List[str]

class EducationEntry(BaseModel):
    institution: str
    url: str
    area: str
    studyType: str
    startDate: date
    endDate: date
    score: str
    courses: List[str]

class AwardEntry(BaseModel):
    title: str
    date: date
    awarder: str
    summary: str

class CertificateEntry(BaseModel):
    name: str
    date: date
    issuer: str
    url: str

class PublicationEntry(BaseModel):
    name: str
    publisher: str
    releaseDate: date
    url: str
    summary: str

class SkillEntry(BaseModel):
    name: str
    level: str
    keywords: List[str]

class LanguageEntry(BaseModel):
    language: str
    fluency: str

class InterestEntry(BaseModel):
    name: str
    keywords: List[str]

class ReferenceEntry(BaseModel):
    name: str
    reference: str

class ProjectEntry(BaseModel):
    name: str
    startDate: date
    endDate: Optional[date]
    description: str
    highlights: List[str]
    url: str

class Resume(BaseModel):
    basics: Basics
    work: List[WorkEntry]
    volunteer: List[VolunteerEntry]
    education: List[EducationEntry]
    awards: List[AwardEntry]
    certificates: List[CertificateEntry]
    publications: List[PublicationEntry]
    skills: List[SkillEntry]
    languages: List[LanguageEntry]
    interests: List[InterestEntry]
    references: List[ReferenceEntry]
    projects: List[ProjectEntry]

@app.post("/")
async def submit_resume(resume: Resume):
    template_path = os.path.abspath("./resume.typ")
    name_str = "_".join(resume.basics.name.split(' '))
    fname = f'{name_str}_resume'

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
    return {"message": f"Resume for {resume.basics.name} received successfully"}

@app.get("/")
async def root():
    return {"message": "Welcome to the Resume API"}