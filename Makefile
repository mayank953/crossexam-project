.PHONY: setup check up demo down reset
setup:  ## create .env from the template (never overwrites an existing one)
	@test -f .env && echo ".env already exists" || (cp .env.example .env && echo "Created .env: put your Gemini key in it")
check:  ## prove Docker, the papers and (if set) the key work
	./run.sh check.py

# --- step 4: a shared database, an API and a screen ------------------------------------------------
up:  ## build and start Postgres + the API/screen for step 4
	docker compose up --build -d
	@echo "Screen + API  http://localhost:8010   (Swagger at /docs)   Postgres on 5433"
demo:  ## load the 9 demo papers (PO-40002, PO-40010) straight into the database
	docker compose run --rm api python ladder/step4/seed_demo.py
down:  ## stop step 4's Postgres + API
	docker compose down
reset:  ## stop step 4's Postgres + API and delete the database
	docker compose down -v



# postgresql://crossexam:crossexam@localhost:5433/crossexam  user:crossexam pass:crossexam  db:crossexam  port:5433
