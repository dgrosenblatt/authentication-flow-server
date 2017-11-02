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
tom_hanks = Repo.insert!(%Actor{name: "Tom Hanks"})
tim_allen = Repo.insert!(%Actor{name: "Tim Allen"})
julia_louis = Repo.insert!(%Actor{name: "Julia Louis-Dreyfus"})
dave_foley = Repo.insert!(%Actor{name: "Dave Foley"})
john_goodman = Repo.insert!(%Actor{name: "John Goodman"})
billy_crystal = Repo.insert!(%Actor{name: "Billy Crystal"})
steve_buscemi = Repo.insert!(%Actor{name: "Steve Buscemi"})
james_coburn = Repo.insert!(%Actor{name: "James Coburn"})
jennifer_tilly = Repo.insert!(%Actor{name: "Jennifer Tilly"})
albert_brooks = Repo.insert!(%Actor{name: "Albert Brooks"})
ellen_degeneres = Repo.insert!(%Actor{name: "Ellen Degeneres"})
craig_t = Repo.insert!(%Actor{name: "Craig T. Nelson"})
holly_hunter = Repo.insert!(%Actor{name: "Holly Hunter"})
sarah_vowell = Repo.insert!(%Actor{name: "Sarah Vowell"})
samuel_l = Repo.insert!(%Actor{name: "Samuel L. Jackson"})
owen_wilson = Repo.insert!(%Actor{name: "Owen Wilson"})
paul_newman = Repo.insert!(%Actor{name: "Paul Newman"})
bonnie_hunt = Repo.insert!(%Actor{name: "Bonnie Hunt"})
larry = Repo.insert!(%Actor{name: "Larry the Cable Guy"})
patton_oswalt = Repo.insert!(%Actor{name: "Patton Oswalt"})
kathy_najimy = Repo.insert!(%Actor{name: "Kathy Najimy"})
jeff_garlin = Repo.insert!(%Actor{name: "Jeff Garlin"})
fred_willard = Repo.insert!(%Actor{name: "Fred Willard"})
ed_asner = Repo.insert!(%Actor{name: "Ed Asner"})
christopher_plummer = Repo.insert!(%Actor{name: "Christopher Plummer"})

# Directors
john_lasseter = Repo.insert!(%Director{name: "John Lasseter"})
pete_docter = Repo.insert!(%Director{name: "Pete Docter"})
andrew_stanton = Repo.insert!(%Director{name: "Andrew Stanton"})
brad_bird = Repo.insert!(%Director{name: "Brad Bird"})

# Movies
toy_story = Repo.insert!(
  %Movie{
    name: "Toy Story",
    director_id: john_lasseter.id,
    release_date: ~D[1995-11-22]
  }
)

a_bugs_life = Repo.insert!(
  %Movie{
    name: "A Bug's Life",
    director_id: john_lasseter.id,
    release_date: ~D[1998-11-25]
  }
)

toy_story_2 = Repo.insert!(
  %Movie{
    name: "Toy Story",
    director_id: john_lasseter.id,
    release_date: ~D[1999-11-24]
  }
)

monsters_inc = Repo.insert!(
  %Movie{
    name: "Monsters, Inc.",
    director_id: pete_docter.id,
    release_date: ~D[2001-11-02]
  }
)

finding_nemo = Repo.insert!(
  %Movie{
    name: "Finding Nemo",
    director_id: andrew_stanton.id,
    release_date: ~D[2003-05-30]
  }
)

the_incredibles = Repo.insert!(
  %Movie{
    name: "The Incredibles",
    director_id: brad_bird.id,
    release_date: ~D[2004-11-05]
  }
)

cars = Repo.insert!(
  %Movie{
    name: "Cars",
    director_id: john_lasseter.id,
    release_date: ~D[2006-06-09]
  }
)

ratatouille = Repo.insert!(
  %Movie{
    name: "Ratatouille",
    director_id: brad_bird.id,
    release_date: ~D[2007-06-29]
  }
)

wall_e = Repo.insert!(
  %Movie{
    name: "WALL-E",
    director_id: andrew_stanton.id,
    release_date: ~D[2008-06-27]
  }
)

up = Repo.insert!(
  %Movie{
    name: "Up",
    director_id: pete_docter.id,
    release_date: ~D[2009-05-29]
  }
)

# Roles
Repo.insert!(%Role{actor_id: tom_hanks.id, movie_id: toy_story.id})
Repo.insert!(%Role{actor_id: tim_allen.id, movie_id: toy_story.id})

Repo.insert!(%Role{actor_id: julia_louis.id, movie_id: a_bugs_life.id})
Repo.insert!(%Role{actor_id: dave_foley.id, movie_id: a_bugs_life.id})

Repo.insert!(%Role{actor_id: tom_hanks.id, movie_id: toy_story_2.id})
Repo.insert!(%Role{actor_id: tim_allen.id, movie_id: toy_story_2.id})

Repo.insert!(%Role{actor_id: john_goodman.id, movie_id: monsters_inc.id})
Repo.insert!(%Role{actor_id: billy_crystal.id, movie_id: monsters_inc.id})
Repo.insert!(%Role{actor_id: steve_buscemi.id, movie_id: monsters_inc.id})
Repo.insert!(%Role{actor_id: james_coburn.id, movie_id: monsters_inc.id})
Repo.insert!(%Role{actor_id: jennifer_tilly.id, movie_id: monsters_inc.id})

Repo.insert!(%Role{actor_id: albert_brooks.id, movie_id: finding_nemo.id})
Repo.insert!(%Role{actor_id: ellen_degeneres.id, movie_id: finding_nemo.id})

Repo.insert!(%Role{actor_id: craig_t.id, movie_id: the_incredibles.id})
Repo.insert!(%Role{actor_id: holly_hunter.id, movie_id: the_incredibles.id})
Repo.insert!(%Role{actor_id: sarah_vowell.id, movie_id: the_incredibles.id})
Repo.insert!(%Role{actor_id: samuel_l.id, movie_id: the_incredibles.id})

Repo.insert!(%Role{actor_id: owen_wilson.id, movie_id: cars.id})
Repo.insert!(%Role{actor_id: paul_newman.id, movie_id: cars.id})
Repo.insert!(%Role{actor_id: bonnie_hunt.id, movie_id: cars.id})
Repo.insert!(%Role{actor_id: larry.id, movie_id: cars.id})

Repo.insert!(%Role{actor_id: patton_oswalt.id, movie_id: ratatouille.id})

Repo.insert!(%Role{actor_id: kathy_najimy.id, movie_id: wall_e.id})
Repo.insert!(%Role{actor_id: jeff_garlin.id, movie_id: wall_e.id})
Repo.insert!(%Role{actor_id: fred_willard.id, movie_id: wall_e.id})

Repo.insert!(%Role{actor_id: ed_asner.id, movie_id: up.id})
Repo.insert!(%Role{actor_id: christopher_plummer.id, movie_id: up.id})
