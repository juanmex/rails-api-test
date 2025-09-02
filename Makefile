build:
		docker compose build
start:
		docker compose up -d
stop:
		docker compose down
bash:
		docker compose exec api bash
console:
		docker compose exec api bash -c "bin/rails console"
bundle:
		docker compose exec api bash -c "bundle install"
rspec:
		docker compose exec api bash -c "bundle exec rspec"
