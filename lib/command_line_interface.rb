def welcome
  puts "Welcome, nerd."
end

def get_character_from_user
  puts "please enter a character name or type 'quit' to exit"
  input = gets.chomp()
  input.downcase
  # use gets to capture the user's input. This method should return that input, downcased.
end
