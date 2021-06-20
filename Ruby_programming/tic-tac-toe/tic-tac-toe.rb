class GameBoard
    attr_accessor :board
   
    def initialize(board)
        @board = board 
    end

    
    def display_cells(c1, c2, c3)
        puts "     | #{c1} | #{c2} | #{c3} |"
    end 
    
    def display_row_divider
        puts "     -------------"
    end 

    def display_grid
        display_row_divider()
        display_cells(board[0], board[1], board[2])
        display_row_divider()
        display_cells(board[3], board[4], board[5])
        display_row_divider()
        display_cells(board[6], board[7], board[8])
        display_row_divider()
    end

    def record_action(player, cell)
        board[cell - 1] = player 
    end

    def winning_state?
        if board[0] == board[1] && board[1] == board[2]
            true        
        elsif board[3] == board[4] && board[4] == board[5]
            true
        elsif board[6] == board[7] && board[7] == board[8]
            true
        elsif board[0] == board[3] && board[3] == board[6]
            true
        elsif board[1] == board[4] && board[4] == board[7]
            true
        elsif board[2] == board[5] && board[5] == board[8]
            true
        elsif board[0] == board[4] && board[4] == board[8]
            true
        elsif board[2] == board[4] && board[4] == board[6]
            true
        else 
            false
        end
    end



end

class Player
    @@current = ''
    attr_accessor :name, :symbol, :choice

    def initialize(name, symbol)
        @symbol = symbol
        @name = name
    end

    def self.display_winning_message
        puts "#{@@current} has won!"
    end

    def play(board, options) 
        get_valid_input(options)
        board.record_action(symbol, self.choice)
        options.delete(choice)
        @@current = self.name
    end

    def valid_choice?(options, choice)
        options.include?(choice) ? true : false 
    end

    def get_valid_input(options)
        loop do 
            puts "#{self.name}: choose a number"
            self.choice = gets.chomp.to_i
            unless valid_choice?(options, self.choice)
                puts "Invalid input"
            else 
                break
            end
           
        end
    end 
end

replay = true

while replay do 
    puts "Player one, enter your name:"
    player1 = Player.new(gets.chomp, "X")
    puts "Player two, enter your name"
    player2 = Player.new(gets.chomp, "O")

    playable_options = [1,2,3,4,5,6,7,8,9]
    playing_field = GameBoard.new(playable_options) 
    playing_field.display_grid

    9.times do |i|
        if i % 2 == 0
            player1.play(playing_field, playable_options)
        else 
            player2.play(playing_field, playable_options)
        end 
        playing_field.display_grid
        if playing_field.winning_state?
            Player.display_winning_message
            break
        end 
    end 
    puts "Would you like to play again? (yes / no)"
    replay_answer = gets.chomp.downcase
    if replay_answer == "yes"
        next
    else
        puts "Thanks for playing!"
        replay = false
    end
end