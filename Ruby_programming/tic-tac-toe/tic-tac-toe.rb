class Board
  attr_reader :board_positions, :size

  def initialize(size = 3)
    @size = size
    @board_positions = (1..(size ** 2)).to_a
  end

  def display_separator
    puts "-------------"
  end

  def display_boxes(s1, s2, s3)
    puts "| #{s1} | #{s2} | #{s3} |"
  end

  def display_board
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

  def initialize(name)
    @name = name
    @score = 0
    @first_move = false
  end

  def go_first
    self.first_move = true
  end
end

class Computer < Player
  attr_reader :name

  def initialize(name = "Computer")
    super
  end
end

board = Board.new
board.display_board
puts board.size
