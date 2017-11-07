# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AuthenticationFlowServer.Repo.insert!(%AuthenticationFlowServer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias AuthenticationFlowServer.Repo
alias AuthenticationFlowServer.MovieReviews.{Actor, Director, Movie, Role}

# Actors
IO.puts "Seeding actors"
tom_hanks = Repo.Query.get_or_insert!(Actor, %{name: "Tom Hanks"})
tim_allen = Repo.Query.get_or_insert!(Actor, %{name: "Tim Allen"})
julia_louis = Repo.Query.get_or_insert!(Actor, %{name: "Julia Louis-Dreyfus"})
dave_foley = Repo.Query.get_or_insert!(Actor, %{name: "Dave Foley"})
john_goodman = Repo.Query.get_or_insert!(Actor, %{name: "John Goodman"})
billy_crystal = Repo.Query.get_or_insert!(Actor, %{name: "Billy Crystal"})
steve_buscemi = Repo.Query.get_or_insert!(Actor, %{name: "Steve Buscemi"})
james_coburn = Repo.Query.get_or_insert!(Actor, %{name: "James Coburn"})
jennifer_tilly = Repo.Query.get_or_insert!(Actor, %{name: "Jennifer Tilly"})
albert_brooks = Repo.Query.get_or_insert!(Actor, %{name: "Albert Brooks"})
ellen_degeneres = Repo.Query.get_or_insert!(Actor, %{name: "Ellen Degeneres"})
craig_t = Repo.Query.get_or_insert!(Actor, %{name: "Craig T. Nelson"})
holly_hunter = Repo.Query.get_or_insert!(Actor, %{name: "Holly Hunter"})
sarah_vowell = Repo.Query.get_or_insert!(Actor, %{name: "Sarah Vowell"})
samuel_l = Repo.Query.get_or_insert!(Actor, %{name: "Samuel L. Jackson"})
owen_wilson = Repo.Query.get_or_insert!(Actor, %{name: "Owen Wilson"})
paul_newman = Repo.Query.get_or_insert!(Actor, %{name: "Paul Newman"})
bonnie_hunt = Repo.Query.get_or_insert!(Actor, %{name: "Bonnie Hunt"})
larry = Repo.Query.get_or_insert!(Actor, %{name: "Larry the Cable Guy"})
patton_oswalt = Repo.Query.get_or_insert!(Actor, %{name: "Patton Oswalt"})
kathy_najimy = Repo.Query.get_or_insert!(Actor, %{name: "Kathy Najimy"})
jeff_garlin = Repo.Query.get_or_insert!(Actor, %{name: "Jeff Garlin"})
fred_willard = Repo.Query.get_or_insert!(Actor, %{name: "Fred Willard"})
ed_asner = Repo.Query.get_or_insert!(Actor, %{name: "Ed Asner"})
christopher_plummer = Repo.Query.get_or_insert!(Actor, %{name: "Christopher Plummer"})

# Directors
IO.puts "Seeding directors"
john_lasseter = Repo.Query.get_or_insert!(Director, %{name: "John Lasseter"})
pete_docter = Repo.Query.get_or_insert!(Director, %{name: "Pete Docter"})
andrew_stanton = Repo.Query.get_or_insert!(Director, %{name: "Andrew Stanton"})
brad_bird = Repo.Query.get_or_insert!(Director, %{name: "Brad Bird"})

# Movies
IO.puts "Seeding movies"
toy_story = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "Toy Story",
    director_id: john_lasseter.id,
    release_date: ~D[1995-11-22]
  }
)

a_bugs_life = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "A Bug's Life",
    director_id: john_lasseter.id,
    release_date: ~D[1998-11-25]
  }
)

toy_story_2 = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "Toy Story",
    director_id: john_lasseter.id,
    release_date: ~D[1999-11-24]
  }
)

monsters_inc = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "Monsters, Inc.",
    director_id: pete_docter.id,
    release_date: ~D[2001-11-02]
  }
)

finding_nemo = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "Finding Nemo",
    director_id: andrew_stanton.id,
    release_date: ~D[2003-05-30]
  }
)

the_incredibles = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "The Incredibles",
    director_id: brad_bird.id,
    release_date: ~D[2004-11-05]
  }
)

cars = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "Cars",
    director_id: john_lasseter.id,
    release_date: ~D[2006-06-09]
  }
)

ratatouille = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "Ratatouille",
    director_id: brad_bird.id,
    release_date: ~D[2007-06-29]
  }
)

wall_e = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "WALL-E",
    director_id: andrew_stanton.id,
    release_date: ~D[2008-06-27]
  }
)

up = Repo.Query.get_or_insert!(
  Movie,
  %{
    name: "Up",
    director_id: pete_docter.id,
    release_date: ~D[2009-05-29]
  }
)

# Roles
IO.puts "Seeding roles"
Repo.Query.get_or_insert!(Role, %{actor_id: tom_hanks.id, movie_id: toy_story.id})
Repo.Query.get_or_insert!(Role, %{actor_id: tim_allen.id, movie_id: toy_story.id})

Repo.Query.get_or_insert!(Role, %{actor_id: julia_louis.id, movie_id: a_bugs_life.id})
Repo.Query.get_or_insert!(Role, %{actor_id: dave_foley.id, movie_id: a_bugs_life.id})

Repo.Query.get_or_insert!(Role, %{actor_id: tom_hanks.id, movie_id: toy_story_2.id})
Repo.Query.get_or_insert!(Role, %{actor_id: tim_allen.id, movie_id: toy_story_2.id})

Repo.Query.get_or_insert!(Role, %{actor_id: john_goodman.id, movie_id: monsters_inc.id})
Repo.Query.get_or_insert!(Role, %{actor_id: billy_crystal.id, movie_id: monsters_inc.id})
Repo.Query.get_or_insert!(Role, %{actor_id: steve_buscemi.id, movie_id: monsters_inc.id})
Repo.Query.get_or_insert!(Role, %{actor_id: james_coburn.id, movie_id: monsters_inc.id})
Repo.Query.get_or_insert!(Role, %{actor_id: jennifer_tilly.id, movie_id: monsters_inc.id})

Repo.Query.get_or_insert!(Role, %{actor_id: albert_brooks.id, movie_id: finding_nemo.id})
Repo.Query.get_or_insert!(Role, %{actor_id: ellen_degeneres.id, movie_id: finding_nemo.id})

Repo.Query.get_or_insert!(Role, %{actor_id: craig_t.id, movie_id: the_incredibles.id})
Repo.Query.get_or_insert!(Role, %{actor_id: holly_hunter.id, movie_id: the_incredibles.id})
Repo.Query.get_or_insert!(Role, %{actor_id: sarah_vowell.id, movie_id: the_incredibles.id})
Repo.Query.get_or_insert!(Role, %{actor_id: samuel_l.id, movie_id: the_incredibles.id})

Repo.Query.get_or_insert!(Role, %{actor_id: owen_wilson.id, movie_id: cars.id})
Repo.Query.get_or_insert!(Role, %{actor_id: paul_newman.id, movie_id: cars.id})
Repo.Query.get_or_insert!(Role, %{actor_id: bonnie_hunt.id, movie_id: cars.id})
Repo.Query.get_or_insert!(Role, %{actor_id: larry.id, movie_id: cars.id})

Repo.Query.get_or_insert!(Role, %{actor_id: patton_oswalt.id, movie_id: ratatouille.id})

Repo.Query.get_or_insert!(Role, %{actor_id: kathy_najimy.id, movie_id: wall_e.id})
Repo.Query.get_or_insert!(Role, %{actor_id: jeff_garlin.id, movie_id: wall_e.id})
Repo.Query.get_or_insert!(Role, %{actor_id: fred_willard.id, movie_id: wall_e.id})

Repo.Query.get_or_insert!(Role, %{actor_id: ed_asner.id, movie_id: up.id})
Repo.Query.get_or_insert!(Role, %{actor_id: christopher_plummer.id, movie_id: up.id})
