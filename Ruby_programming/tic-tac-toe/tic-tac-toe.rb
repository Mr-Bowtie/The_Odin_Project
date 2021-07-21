require "pry"

class Board
  WINNING_POSITIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 9], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  attr_reader :board_positions, :size, :valid_positions

  def initialize(size = 3)
    @size = size
    @board_positions = (1..(size ** 2)).to_a.map { |el| el }
  end

  def calc_valid_positions
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

  def game_over?
    return true if self.calc_valid_positions == []
    positions = self.board_positions
    p positions
    WINNING_POSITIONS.each do |group|
      # binding.pry
      if group.all? { |i| positions[i - 1] == "X" } || group.all? { |i| positions[i - 1] == "O" }
        return true
      end
    end
    false
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
    @symbol = "O"
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

  def initialize(name = "Computer")
    super
  end
end

def play_round(player, board)
  loop do
    board.display_board
    player.take_turn
    # binding.pry
    break if board.game_over?
  end
end

board = Board.new
ian = Player.new("Ian", board)
play_round(ian, board)
