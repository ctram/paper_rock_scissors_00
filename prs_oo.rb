# prs_oo.ruby

class Player
  attr_accessor :name, :hand

  def initialize name
    @name = name
    @hand = Hand.new
  end

end

class Hand
  attr_accessor :shape

  def initialize
  end

  def choose_random_shape
    shape = %w( Rock Paper Scissors)
    @shape = shape.sample
  end

  def choose_shape shape
    @shape = shape
  end

end

class Game
  def find_winner player1, player2
    r, p, s = "Rock", "Paper", "Scissors"

    if player1.hand.shape == player2.hand.shape
      return nil
    elsif player1.hand.shape == r
      return player2.hand.shape == p ? player2 : player1
    elsif player1.hand.shape == p
      return player2.hand.shape == s ? player2 : player1
    elsif player1.hand.shape == s
      return player2.hand.shape == r ? player2 : player1
    end
  end

  def run
    puts "Welcome to Paper Rocks Scissors!"
    puts "What's your name?"
    print ">> "
    name = gets.chomp.capitalize

    user = Player.new name
    comp = Player.new "Computer"

    continue_game = true

    begin

      acceptable_input = %w(r p s)
      shape = ""

      # User inputs shape choice
      while !acceptable_input.include?(shape)
        system 'clear'
        puts "Choose your shape: Rock (r), Paper (p), Scissors (s)"
        print ">>"
        shape = gets.chomp.downcase
      end

      if shape == "r"
        shape = "Rock"
      elsif shape == "p"
        shape = "Paper"
      elsif shape == "s"
        shape = "Scissors"
      end

      # Set shape choices
      user.hand.choose_shape(shape)
      comp.hand.choose_random_shape

      winner = find_winner user, comp
      loser = (winner == user) ? comp : user

      puts "#{user.name} chose #{user.hand.shape}"
      puts "#{comp.name} chose #{comp.hand.shape}"
      if winner == nil
        puts "It's a tie!"
      else
        puts "#{winner.name} beats #{loser.name}"
      end

      acceptable_input = ["q", ""]
      input = nil

      while !acceptable_input.include?(input)
        puts "Press enter to play again or press \"q\" to quit"
        print ">>"
        input = gets.chomp.downcase
      end

      input == "q" ? continue_game = false : nil

    end until continue_game == false
  end
end

game = Game.new
game.run
