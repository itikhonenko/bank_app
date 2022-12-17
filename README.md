# Bank App

## Quick start

1. Install Docker & Docker Compose

2. Install Yarn or NPM

3. Run `docker-compose build`

## Tests
```sh
docker-compose run backend rspec
```

## Generate API docs
```sh
docker-compose up backend -d
docker-compose exec backend rake docs:generate
```
then -> `http://localhost:3000/api/docs`

## Test users
Test users can be found in the `seed.rb` file.
```ruby
backend/db/seeds.rb
```

## Links

|Name|Link|
|---|---|
|API|http://localhost:3000|
|Client|http://localhost:8080|
|API docs|http://localhost:3000/api/docs|

## Commands (docker-compose)

|Command|Alias|Description|
|---|---|---|
|`docker-compose up`|`dcup`| starts dev environment (all services)
|`docker-compose stop`|`dcstop`| stops dev environment (all services)
|`docker-compose up backend`|`dcup backend`| starts backend (API) only
|`docker-compose up backend client`|`dcup backend client`| starts both backend & client
|`docker-compose ps`|`dcps`| shows status of running containers
|`docker-compose exec backend bash`|`dce backend bash`| opens terminal inside container
|`docker-compose exec backend rails c`|`dce backend rails c`| opens rails console inside container
|`docker-compose exec backend rubocop`|`dce backend rubocop`| runs rubocop in backend container (you can use `-a` option to fix issues automatically)
|`docker-compose exec backend {command}`|`dce backend {command}`| to run any command inside a particular container
|`docker-compose run backend {command}`|`dcr backend {command}`| to run any command inside a particular container and to start container automatically

* to use aliases `nano ~/.zshrc` and add `plugins=(docker-compose ...)`
