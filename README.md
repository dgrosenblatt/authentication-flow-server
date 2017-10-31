# Authentication Server

Trello board: https://trello.com/b/r2Of9CM2/authentication-flow-server

Currently running at: https://authentication-flow-server.herokuapp.com/

## Deploying the codebase to a new heroku instance:

#### From the command line via the Heroku CLI:

https://hexdocs.pm/phoenix/heroku.html

(Most or all of the "Making our Project ready for Heroku" section will already be done)

#### From the heroku dashboard

Create and Configure a new heroku app

* Create a new app - New => Create New app
* Resources Tab => Add-ons => Add Heroku Postgres (hobby/free should be sufficient)
* Settings Tab => Config Variables => Reveal Config Vars, add the following:
  * (DATABASE_URL should already be populated from the postgres add-on)
  * HOST_URL - read from the Domains and certificates section, under "Your app can be found at", will most likely be https://{name you chose when creating the app}.herokuapp.com
  * POOL_SIZE - 18
  * SECRET_KEY_BASE - a random string of ~50 characters (use a tool to generate this; it may yell at you for not being "random" enough)
* Settings Tab => Buildpacks => Add buildpack => Enter Buildpack URL => https://github.com/HashNuke/heroku-buildpack-elixir.git

Deploy from github via heroku integration

* Deploy Tab => Deployment Method => Select GitHub
  * Connect to GitHub => Select IntrepidPursuits, repo-name enter authentication_flow_server, Search, click Connect
  * Manual deploy => master should be selected by default, click Deploy Branch

Done!

## Running server locally on MacOS:

#### Install dependencies
  * Erlang and Elixir
    * Install `asdf` - language version manager - https://github.com/asdf-vm/asdf
    * Install erlang
      * `$ asdf plugin-add erlang`
      * `$ asdf install erlang 19.3`
    * Install elixir
      * `$ asdf plugin-add elixir`
      * `$ asdf install elixir 1.4.5`

  * Postgres
    * Install Postgres.app for mac: https://postgresapp.com/

#### Clone & Run
  * `$ git clone git@github.com:IntrepidPursuits/authentication_flow_server.git`
  * `$ cd authentication_flow_server`
  * Install dependencies with `$ mix deps.get`
  * Create and migrate your database with `$ mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `$ mix phx.server`
