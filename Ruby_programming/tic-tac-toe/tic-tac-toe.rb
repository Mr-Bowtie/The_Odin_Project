require "pry"

class Board
  WINNING_POSITIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  attr_reader :board_positions, :size, :valid_positions

  def initialize(size = 3)
    @size = size
    @board_positions = (1..(size ** 2)).to_a.map { |el| el }
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
end

class Player
  attr_reader :name
  attr_accessor :board, :symbol, :first_move, :winner

  def initialize(name, board)
    @name = name
    @score = 0
    @first_move = false
    @board = board
    @symbol = "X"
    @winner = false
  end

  def go_first
    self.first_move = true
    self.symbol = "X"
  end

  def turn_action
    puts "Choose an open position on the board #{self.board.calc_valid_positions}" #todo: validate input and update available position
    choice = gets.chomp.to_i
    position = self.board.board_positions.index(choice)
    self.board.board_positions[position] = self.symbol
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

  def board_full?
    self.board.calc_valid_positions.empty?
  end
end

class Computer < Player
  attr_reader :name
  attr_accessor :board

  def initialize(name, board)
    super
    @symbol = "O"
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
      if self.player1.winner? || self.player1.board_full?
        break
      end
      self.player2.turn_action
      if self.player2.winner? || self.player2.board_full?
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
end

board = Board.new
human = Player.new("Ian", board)
computer = Computer.new("Computer", board)
game = Game.new(board, human, computer)

game.play_round
game.display_round_outcome
