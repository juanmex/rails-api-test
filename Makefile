build:
		docker compose build
start:
		docker compose up
stop:
		docker compose down
bash:
		docker compose run --rm api bash
console:
		docker compose exec api bash -c "bin/rails console"
bundle:
		docker compose run --rm api bundle install
rspec:
		docker compose run --rm -e RAILS_ENV=test api bundle exec rspec
rubocop:
		docker compose run --rm api bundle exec rubocop
