require 'rest-client'
require 'json'
require 'pry'

def parse_response(url)
  response_string = RestClient.get(url)
  JSON.parse(response_string)
end


def get_character_movies_from_api(character_name)
  #make the web request
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  response_hash = parse_response('http://swapi.dev/api/people')
  character = response_hash["results"].find{|character| character["name"].downcase == character_name}
  if character == nil
    puts "Sorry, didn't find that one."
  else
    array_of_film_urls = character["films"]
    array_of_film_hashes = array_of_film_urls.map do |url|
      parse_response(url)
    end
    return array_of_film_hashes
  end
end

def print_movies(films)
  if !films.nil?
    films.map do |film_hash|
      puts "Episode #{film_hash["episode_id"]}: #{film_hash["title"]} -- Release Date: #{film_hash["release_date"]}"
      puts "*****************************************"
    end
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
