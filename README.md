# TOML Resume


Create a nice looking resume with just some [TOML](https://toml.io). 

## How to run yourself

1. Install [Typst](https://typst.app)
2. Open a new terminal window and `cd frontend && npm install`
3. Then `npm run dev`
4. Open a new terminal tab and `cd backend && python -m venv .env`
5. `source .env/bin/activate && pip install -r requirements.txt`
6. `uvicorn main:app --host 0.0.0.0 --port 80 --reload`