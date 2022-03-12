# Rails Backend API
A Rails backend API to register tennis players, retrieve tennis players data and post matches.

## Prerequisites
Ruby, Rails, NodeJS, Postgres SQL database

## How to start the application
In the project directory run `bundle install` to install dependencies  
run `rails db:create` and `rails db:migrate` to create the database and tables  
`rails server` to run the application on [http://localhost:3000](http://localhost:3000)

## How to use
### Endpoints
* Register a player: POST request to http://localhost:3000/players with parameters: **name**, **nationality**, **birthday**, **points**(optional, default to 1200)
* Retrieve all players: GET request to http://localhost:3000/players, filter search by nationality and/or rank name with parameters: **nationality**, **rank_name***
* Register a match: POST request to http://localhost:3000/matches with parameters: **winner**(name of the winner player), **loser**(name of the loser player)

*available rank names: 'Unranked', 'Bronze', 'Silver', 'Gold', 'Supersonic Legend'

Example  
from terminal: `curl http://localhost:3000/players -v` to get all players in the database  
or use a tool like [Postman](https://www.postman.com/)

## Tests
run `rspec` in the project directory to run Rspec tests

## What I would do next
* add more unit tests
* set cors policy to allow client side data fetch
* research best practices on how to filter data from a GET request with parameters
