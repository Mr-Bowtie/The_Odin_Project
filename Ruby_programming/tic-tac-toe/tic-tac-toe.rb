require "pry"

class Board
  WINNING_POSITIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 9], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
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

  def round_outcome
    return "Tie" if self.calc_valid_positions == [] #* tie when there are no valid positions left
    positions = self.board_positions
    WINNING_POSITIONS.each do |group|
      if group.all? { |i| positions[i - 1] == "X" }
        return "Player"
      elsif group.all? { |i| positions[i - 1] == "O" }
        return "Computer"
      end
    end
    nil #* returns nil if there is no winner or tie
  end

  def round_over?
    !!round_outcome()
  end
end

class Player
  attr_reader :name
  attr_accessor :board, :symbol, :first_move

  def initialize(name, board)
    @name = name
    @score = 0
    @first_move = false
    @board = board
    @symbol = "X"
  end

  def go_first
    self.first_move = true
    self.symbol = "X"
  end

  def take_turn
    puts "Choose an open position on the board #{self.board.calc_valid_positions}" #todo: validate input and update available position
    choice = gets.chomp.to_i
    position = self.board.board_positions.index(choice)
    self.board.board_positions[position] = self.symbol
  end
end

class Computer < Player
  attr_reader :name
  attr_accessor :board

  def initialize(name, board)
    super
    @symbol = "O"
  end

  def take_turn
    choice = self.board.calc_valid_positions.sample
    self.board.board_positions[choice - 1] = self.symbol
  end
end

def calc_play_order(player, computer)
  order = []
  puts "Would you like to go first, second, or flip a coin?"
  choice = gets.chomp
  case choice
  when "first"
    order << player << computer
    player.go_first
  when "second"
    order << computer << player
  when "flip a coin"
    players = [player, computer]
    first = players.sample.pop
    second = players.pop
    first.go_first
    orde << first << second
  end
  order
end

def play_round(player, computer, board)
  loop do
    board.display_board
    player.take_turn
    break if board.round_over?
    computer.take_turn
    break if board.round_over?
  end
  board.display_board
end

def display_round_outcome(board)
  case board.round_outcome
  when "Player"
    puts "You win!"
  when "Computer"
    puts "The Computer wins."
  when "Tie"
    puts "Cat Scratch!"
  end
end

board = Board.new
user = Player.new("Ian", board)
computer = Computer.new("Computer", board)
# binding.pry
play_round(user, computer, board)
display_round_outcome(board)
