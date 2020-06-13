require './lib/chess_board.rb'

class King
    attr_accessor :space, :color
    #display should never be changed, and possible_moves should only be updated based on current space
    attr_reader :display, :possible_moves
    def initialize(space, color)
        @space = space
        @color = color
        if color == "white"
            @display = WHITE_KING
        elsif color == "red"
            @display = RED_KING
        end
        @possible_moves = get_possible_moves(@space)
    end

    def get_possible_moves(space)
        if space == nil
            return nil
        end
        possible_moves = []
        x_and_y = space.split("")
        x = x_and_y[0].to_i
        y = x_and_y[1].to_i
        first_move = "#{x - 1}#{y - 1}"
        possible_moves << first_move if $board.spaces.has_key?(:"#{first_move}")
        second_move = "#{x - 1}#{y}"
        possible_moves << second_move if $board.spaces.has_key?(:"#{second_move}")
        third_move = "#{x - 1}#{y + 1}"
        possible_moves << third_move if $board.spaces.has_key?(:"#{third_move}")
        fourth_move = "#{x}#{y + 1}"
        possible_moves << fourth_move if $board.spaces.has_key?(:"#{fourth_move}")
        fifth_move = "#{x + 1}#{y + 1}"
        possible_moves << fifth_move if $board.spaces.has_key?(:"#{fifth_move}")
        sixth_move = "#{x + 1}#{y}"
        possible_moves << sixth_move if $board.spaces.has_key?(:"#{sixth_move}")
        seventh_move = "#{x + 1}#{y - 1}"
        possible_moves << seventh_move if $board.spaces.has_key?(:"#{seventh_move}")
        eighth_move = "#{x}#{y - 1}"
        possible_moves << eighth_move if $board.spaces.has_key?(:"#{eighth_move}")
        possible_moves.delete_if{|space| $board.spaces[:"#{space}"].occupied == @color}
        return possible_moves
    end

    def update_possible_moves(space)
        @possible_moves = get_possible_moves(space)
    end
end

class Queen
    attr_accessor :space, :color
    attr_reader :display, :possible_moves
    def initialize(space, color)
        @space = space
        @color = color
        if color == "white"
            @display = WHITE_QUEEN
        elsif color == "red"
            @display = RED_QUEEN
        end
        @possible_moves = get_possible_moves(space)
    end

    def get_possible_moves(space)
        if space == nil
            return nil
        end
        possible_moves = []
        x_and_y = space.split("")
        x = x_and_y[0].to_i
        y = x_and_y[1].to_i
        
        #get positive vertical moves
        while y < 7
            y += 1
            next_move = "#{x}#{y}"
            if $board.spaces[:"#{next_move}"].occupied == "#{@color}"
                break
            elsif $board.spaces[:"#{next_move}"].occupied == nil
                possible_moves << next_move
            else
                possible_moves << next_move
                break
            end
        end

        #get positive diagonal moves to the right
        y = x_and_y[1].to_i
        while y < 7 && x < 7
            y += 1
            x += 1
            next_move = "#{x}#{y}"
            if $board.spaces[:"#{next_move}"].occupied == "#{@color}"
                break
            elsif $board.spaces[:"#{next_move}"].occupied == nil
                possible_moves << next_move
            else
                possible_moves << next_move
                break
            end
        end

        #get positive diagonal moves to the left
        x = x_and_y[0].to_i
        y = x_and_y[1].to_i
        while y < 7 && x > 0
            y += 1
            x -= 1
            next_move = "#{x}#{y}"
            if $board.spaces[:"#{next_move}"].occupied == "#{@color}"
                break
            elsif $board.spaces[:"#{next_move}"].occupied == nil
                possible_moves << next_move
            else
                possible_moves << next_move
                break
            end
        end
        
        #get negative vertical moves
        x = x_and_y[0].to_i
        y = x_and_y[1].to_i
        while y > 0
            y -= 1
            next_move = "#{x}#{y}"
            if $board.spaces[:"#{next_move}"].occupied == "#{@color}"
                break
            elsif $board.spaces[:"#{next_move}"].occupied == nil
                possible_moves << next_move
            else
                possible_moves << next_move
                break
            end
        end

        #get negative diagonal moves to the right
        y = x_and_y[1].to_i
        while x < 7 && y > 0
            x += 1
            y -= 1
            next_move = "#{x}#{y}"
            if $board.spaces[:"#{next_move}"].occupied == "#{@color}"
                break
            elsif $board.spaces[:"#{next_move}"].occupied == nil
                possible_moves << next_move
            else
                possible_moves << next_move
                break
            end
        end

        #get negative diagonal moves to the left
        x = x_and_y[0].to_i
        y = x_and_y[1].to_i
        while x > 0 && y > 0
            x -= 1
            y -= 1
            next_move = "#{x}#{y}"
            if $board.spaces[:"#{next_move}"].occupied == "#{@color}"
                break
            elsif $board.spaces[:"#{next_move}"].occupied == nil
                possible_moves << next_move
            else
                possible_moves << next_move
                break
            end
        end

        #get horizontal moves to the right
        x = x_and_y[0].to_i
        y = x_and_y[1].to_i
        while x < 7
            x += 1
            next_move = "#{x}#{y}"
            if $board.spaces[:"#{next_move}"].occupied == "#{@color}"
                break
            elsif $board.spaces[:"#{next_move}"].occupied == nil
                possible_moves << next_move
            else
                possible_moves << next_move
                break
            end
        end

        #get horizontal moves to the left
        x = x_and_y[0].to_i
        while x > 0
            x -= 1
            next_move = "#{x}#{y}"
            if $board.spaces[:"#{next_move}"].occupied == "#{@color}"
                break
            elsif $board.spaces[:"#{next_move}"].occupied == nil
                possible_moves << next_move
            else
                possible_moves << next_move
                break
            end
        end
        return possible_moves
    end

    def update_possible_moves(space)
        @possible_moves = get_possible_moves(space)
    end
end

class Team
    attr_accessor :king, :queen, :possible_moves
    def initialize(color)
        @king = King.new("30", color)
        $board.spaces[:"#{@king.space}"].set_space(color, @king, @king.display)
        @queen = Queen.new("40", color)
        $board.spaces[:"#{@queen.space}"].set_space(color, @queen, @queen.display)
        $board.update_display
        @possible_moves = update_possible_moves
    end

    def update_possible_moves
        @king.update_possible_moves(@king.space)
        @queen.update_possible_moves(@queen.space)
        possible_moves = (@king.possible_moves + @queen.possible_moves).uniq!
    end

    def take_turn(start, destination)
        moving_piece = $board.spaces[:"#{start}"].piece
        unless moving_piece.possible_moves.include?(destination)
            return nil
        end
        $board.spaces[:"#{start}"].set_space(nil, nil, "  ")
        moving_piece.space = destination
        moving_piece.update_possible_moves(destination)
        $board.spaces[:"#{destination}"].set_space(moving_piece.color, moving_piece, moving_piece.display)
        update_possible_moves
        $board.update_display
    end
end
        
white = Team.new("white")
puts $board.display
p white.queen.possible_moves
p white.king.possible_moves
white.take_turn("40", "31")
puts $board.display
p white.queen.possible_moves
p white.king.possible_moves

