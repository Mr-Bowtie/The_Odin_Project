require "pry"

class Board
  WINNING_POSITIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  attr_reader :size, :valid_positions
  attr_accessor :board_positions

  def initialize(size = 3)
    @size = size
    @board_positions = (1..(size ** 2)).to_a
  end

  def calc_valid_positions #* looks through current board and returns a new array of all the numbers that are left, disregarding strings
    self.board_positions.select { |el| (1..(size ** 2)).include?(el) }
  end

  def display_separator
    puts "-------------"
  end

  def display_boxes(s1, s2, s3)
    puts "| #{s1} | #{s2} | #{s3} |"
  end

  def display_board #todo: make the position numbers a different color / opacity than the players symbol
    puts ""
    display_separator()
    display_boxes(@board_positions[0], @board_positions[1], @board_positions[2])
    display_separator()
    display_boxes(@board_positions[3], @board_positions[4], @board_positions[5])
    display_separator()
    display_boxes(@board_positions[6], @board_positions[7], @board_positions[8])
    display_separator()
    puts ""
  end

  def board_full?
    self.calc_valid_positions.empty?
  end

  def reset_board
    self.board_positions = (1..(size ** 2)).to_a
  end
end

class Player
  attr_accessor :board, :symbol, :first_move, :winner, :name, :score

  def initialize(board)
    @name = ""
    @score = 0
    @first_move = false
    @board = board
    @symbol = "X"
    @winner = false
  end

  def get_name
    puts "What is your name?"
    choice = gets.chomp
    self.name = choice
  end

  def go_first
    self.first_move = true
    self.symbol = "X"
  end

  def turn_action
    puts "Choose an open position on the board #{self.board.calc_valid_positions}" #todo: validate input and update available position
    loop do
      choice = gets.chomp.to_i
      position = self.board.board_positions.index(choice)
      if valid_action?(choice)
        self.board.board_positions[position] = self.symbol
        break
      else
        puts "Invalid input: Choose a valid position #{self.board.calc_valid_positions}"
      end
    end
  end

  def valid_action?(move)
    self.board.calc_valid_positions.include?(move)
  end

  def winner?
    positions = self.board.board_positions
    Board::WINNING_POSITIONS.each do |group|
      if group.all? { |i| positions[i - 1] == self.symbol }
        return self.winner = true
      end
    end
    false #* returns false if there is no winner or tie
  end

  def reset_player
    self.winner = false
    self.score = 0
    self.first_move = false
  end
end

class Computer < Player
  attr_accessor :board, :name

  def initialize(board)
    super
    @symbol = "O"
    @name = "Computer "
  end

  def turn_action
    choice = self.board.calc_valid_positions.sample
    self.board.board_positions[choice - 1] = self.symbol
  end
end

class Game
  attr_accessor :board, :player1, :player2

  def initialize(board, player1, player2)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def welcome
    puts "Welcome to Tic-Tac-Toe, lets play!"
  end

  # def calc_play_order(player, computer)
  #   order = []
  #   puts "Would you like to go first, second, or flip a coin?"
  #   choice = gets.chomp
  #   case choice
  #   when "first"
  #     order << player << computer
  #     player.go_first
  #   when "second"
  #     order << computer << player
  #   when "flip a coin"
  #     players = [player, computer]
  #     first = players.sample.pop
  #     second = players.pop
  #     first.go_first
  #     orde << first << second
  #   end
  #   order
  # end

  def play_round
    loop do
      self.board.display_board
      self.player1.turn_action
      if self.player1.winner? || self.board.board_full?
        break
      end
      self.player2.turn_action
      if self.player2.winner? || self.board.board_full?
        break
      end
    end
    self.board.display_board
  end

  def display_round_outcome
    if self.player1.winner
      puts "#{self.player1.name} Wins!"
    elsif self.player2.winner
      puts "#{self.player2.name} Wins!"
    else
      puts "Cat Scratch"
    end
  end

  def play_again?
    puts "Would you like to play again? ( yes | no )"
    loop do
      choice = gets.chomp.downcase
      if valid_choice?(choice)
        if choice == "yes" || choice == "y"
          return true
        elsif choice == "no" || choice == "n"
          return false
        end
      end
      puts "Invalid input. Valid options: yes, y, no, n"
    end
  end

  def valid_choice?(choice)
    %w(yes y no n).include?(choice)
  end

  def display_game_over
    puts "Thanks for playing Tic-Tac-Toe, Goodbye #{self.player1.name}!"
  end
end

board = Board.new
human = Player.new(board)
computer = Computer.new(board)
game = Game.new(board, human, computer)

game.welcome
human.get_name

loop do
  game.play_round
  game.display_round_outcome

  unless game.play_again?
    break
  else
    human.reset_player
    computer.reset_player
    board.reset_board
  end
end

game.display_game_over
