# prs_oo.ruby

class Player
  attr_accessor :name, :hand

  def initialize name
    self.name = name
    self.hand = Hand.new
  end

end

class Hand
  include Comparable
  # TODO: add comparable module to Hand class
  attr_accessor :shape

  def initialize
  end

  def <=> (other_hand)
    if self.shape == other_hand.shape
      return 0
    elsif self.shape == "Rock"
      return other_hand.shape == "Paper" ? -1 : 1
    elsif self.shape == "Paper"
      return other_hand.shape == "Scissors" ? -1 : 1
    elsif self.shape == "Scissors"
      return other_hand.shape == "Rock" ? -1 : 1
    end
  end


  def choose_random_shape
    shape = %w( Rock Paper Scissors)
    self.shape = shape.sample
  end
end

class Game
  def find_winner player1, player2
    # TODO: find winner
    comparable_int = player1.hand <=> player2.hand
    if comparable_int == 1
      return player1
    elsif comparable_int == -1
      return player2
    else
      return nil
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
      user.hand.shape = shape
      comp.hand.choose_random_shape

      winner = find_winner(user, comp)
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
