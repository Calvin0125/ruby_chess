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

class Bishop
    attr_accessor :space, :color
    attr_reader :possible_moves, :display
    def initialize(space, color)
        @space = space
        @color = color
        if color == "white"
            @display = WHITE_BISHOP
        elsif
            color == "red"
            @display = RED_BISHOP
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

        #get positive diagonal moves to the right
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

        #get negative diagonal moves to the right
        x = x_and_y[0].to_i
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
        return possible_moves
    end

    def update_possible_moves(space)
        @possible_moves = get_possible_moves(space)
    end
end

class Knight
    attr_accessor :space, :color
    attr_reader :possible_moves, :display
    def initialize(space, color)
        @space = space
        @color = color
        if color == "white"
            @display = WHITE_KNIGHT
        elsif color == "red"
            @display = RED_KNIGHT
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
        first_move = "#{x + 2}#{y + 1}"
        possible_moves << first_move if $board.spaces.has_key?(:"#{first_move}")
        second_move = "#{x + 1}#{y + 2}"
        possible_moves << second_move if $board.spaces.has_key?(:"#{second_move}")
        third_move = "#{x - 1}#{y + 2}"
        possible_moves << third_move if $board.spaces.has_key?(:"#{third_move}")
        fourth_move = "#{x - 2}#{y + 1}"
        possible_moves << fourth_move if $board.spaces.has_key?(:"#{fourth_move}")
        fifth_move = "#{x - 2}#{y - 1}"
        possible_moves << fifth_move if $board.spaces.has_key?(:"#{fifth_move}")
        sixth_move = "#{x - 1}#{y - 2}"
        possible_moves << sixth_move if $board.spaces.has_key?(:"#{sixth_move}")
        seventh_move = "#{x + 1}#{y - 2}"
        possible_moves << seventh_move if $board.spaces.has_key?(:"#{seventh_move}")
        eighth_move = "#{x + 2}#{y - 1}"
        possible_moves << eighth_move if $board.spaces.has_key?(:"#{eighth_move}")
        possible_moves.delete_if{|space| $board.spaces[:"#{space}"].occupied == @color}
        return possible_moves
    end
    def update_possible_moves(space)
        @possible_moves = get_possible_moves(space)
    end
end

class Rook
    attr_accessor :space, :color
    attr_reader :possible_moves, :display
    def initialize(space, color)
        @space = space
        @color = color
        if color == "white"
            @display = WHITE_ROOK
        elsif
            color == "red"
            @display = RED_ROOK
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

        #get negative vertical moves
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

        #get horizontal moves to the right
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

class Pawn
    attr_accessor :space, :color
    attr_reader :possible_moves, :display, :name
    def initialize(name, space, color)
        #name attribute is necessary for pawn_promotion method
        @name = name
        @space = space
        @color = color
        if color == "white"
            @display = WHITE_PAWN
        elsif
            color == "red"
            @display = RED_PAWN
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

        if @color == "white"
            if $board.spaces[:"#{x}#{y + 1}"].occupied == nil
                possible_moves << "#{x}#{y + 1}"
                if y == 1 && $board.spaces[:"#{x}#{y + 2}"].occupied == nil
                possible_moves << "#{x}#{y + 2}"
                end
            end

            capture_move_right = "#{x + 1}#{y + 1}"
            unless $board.spaces[:"#{capture_move_right}"] == nil  
                if $board.spaces[:"#{capture_move_right}"].occupied == "red"
                    possible_moves << "#{x + 1}#{y + 1}"
                end
            end

            capture_move_left = "#{x - 1}#{y + 1}"
            unless $board.spaces[:"#{capture_move_left}"] == nil
                if $board.spaces[:"#{capture_move_left}"].occupied == "red"
                    possible_moves << "#{x - 1}#{y + 1}"
                end
            end
        elsif @color == "red"
            if $board.spaces[:"#{x}#{y - 1}"].occupied == nil
                possible_moves << "#{x}#{y - 1}"
                if y == 6 && $board.spaces[:"#{x}#{y - 2}"].occupied == nil
                possible_moves << "#{x}#{y - 2}"
                end
            end

            capture_move_right = "#{x + 1}#{y - 1}"
            unless $board.spaces[:"#{capture_move_right}"] == nil  
                if $board.spaces[:"#{capture_move_right}"].occupied == "white"
                    possible_moves << "#{x + 1}#{y - 1}"
                end
            end

            capture_move_left = "#{x - 1}#{y - 1}"
            unless $board.spaces[:"#{capture_move_left}"] == nil
                if $board.spaces[:"#{capture_move_left}"].occupied == "white"
                    possible_moves << "#{x - 1}#{y - 1}"
                end
            end
        end
        return possible_moves
    end

    def update_possible_moves(space)
        @possible_moves = get_possible_moves(space)
    end
end
        
class Team
    attr_accessor :king, :queen, :bishop1, :bishop2, :knight1, :knight2, :rook1, :rook2
    attr_accessor :pawn1, :pawn2, :pawn3, :pawn4, :pawn5, :pawn6, :pawn7, :pawn8, :piece_array
    attr_reader :possible_moves
    def initialize(color)
        @color = color
        if color == "white"
            @king = King.new("40", color)
            $board.spaces[:"#{@king.space}"].set_space(color, @king, @king.display)
            @queen = Queen.new("30", color)
            $board.spaces[:"#{@queen.space}"].set_space(color, @queen, @queen.display)
            @bishop1 = Bishop.new("20", color)
            $board.spaces[:"#{@bishop1.space}"].set_space(color, @bishop1, @bishop1.display)
            @bishop2 = Bishop.new("50", color)
            $board.spaces[:"#{@bishop2.space}"].set_space(color, @bishop2, @bishop2.display)
            @knight1 = Knight.new("10", color)
            $board.spaces[:"#{@knight1.space}"].set_space(color, @knight1, @knight1.display)
            @knight2 = Knight.new("60", color)
            $board.spaces[:"#{@knight2.space}"].set_space(color, @knight2, @knight2.display)
            @rook1 = Rook.new("00", color)
            $board.spaces[:"#{@rook1.space}"].set_space(color, @rook1, @rook1.display)
            @rook2 = Rook.new("70", color)
            $board.spaces[:"#{@rook2.space}"].set_space(color, @rook2, @rook2.display)
            @pawn1 = Pawn.new("pawn1", "01", color)
            $board.spaces[:"#{@pawn1.space}"].set_space(color, @pawn1, @pawn1.display)
            @pawn2 = Pawn.new("pawn2", "11", color)
            $board.spaces[:"#{@pawn2.space}"].set_space(color, @pawn2, @pawn2.display)
            @pawn3 = Pawn.new("pawn3", "21", color)
            $board.spaces[:"#{@pawn3.space}"].set_space(color, @pawn3, @pawn3.display)
            @pawn4 = Pawn.new("pawn4", "31", color)
            $board.spaces[:"#{@pawn4.space}"].set_space(color, @pawn4, @pawn4.display)
            @pawn5 = Pawn.new("pawn5", "41", color)
            $board.spaces[:"#{@pawn5.space}"].set_space(color, @pawn5, @pawn5.display)
            @pawn6 = Pawn.new("pawn6", "51", color)
            $board.spaces[:"#{@pawn6.space}"].set_space(color, @pawn6, @pawn6.display)
            @pawn7 = Pawn.new("pawn7", "61", color)
            $board.spaces[:"#{@pawn7.space}"].set_space(color, @pawn7, @pawn7.display)
            @pawn8 = Pawn.new("pawn8", "71", color)
            $board.spaces[:"#{@pawn8.space}"].set_space(color, @pawn8, @pawn8.display)
        elsif color == "red"
            @king = King.new("47", color)
            $board.spaces[:"#{@king.space}"].set_space(color, @king, @king.display)
            @queen = Queen.new("37", color)
            $board.spaces[:"#{@queen.space}"].set_space(color, @queen, @queen.display)
            @bishop1 = Bishop.new("27", color)
            $board.spaces[:"#{@bishop1.space}"].set_space(color, @bishop1, @bishop1.display)
            @bishop2 = Bishop.new("57", color)
            $board.spaces[:"#{@bishop2.space}"].set_space(color, @bishop2, @bishop2.display)
            @knight1 = Knight.new("17", color)
            $board.spaces[:"#{@knight1.space}"].set_space(color, @knight1, @knight1.display)
            @knight2 = Knight.new("67", color)
            $board.spaces[:"#{@knight2.space}"].set_space(color, @knight2, @knight2.display)
            @rook1 = Rook.new("07", color)
            $board.spaces[:"#{@rook1.space}"].set_space(color, @rook1, @rook1.display)
            @rook2 = Rook.new("77", color)
            $board.spaces[:"#{@rook2.space}"].set_space(color, @rook2, @rook2.display)
            @pawn1 = Pawn.new("pawn1", "06", color)
            $board.spaces[:"#{@pawn1.space}"].set_space(color, @pawn1, @pawn1.display)
            @pawn2 = Pawn.new("pawn2", "16", color)
            $board.spaces[:"#{@pawn2.space}"].set_space(color, @pawn2, @pawn2.display)
            @pawn3 = Pawn.new("pawn3", "26", color)
            $board.spaces[:"#{@pawn3.space}"].set_space(color, @pawn3, @pawn3.display)
            @pawn4 = Pawn.new("pawn4", "36", color)
            $board.spaces[:"#{@pawn4.space}"].set_space(color, @pawn4, @pawn4.display)
            @pawn5 = Pawn.new("pawn5", "46", color)
            $board.spaces[:"#{@pawn5.space}"].set_space(color, @pawn5, @pawn5.display)
            @pawn6 = Pawn.new("pawn6", "56", color)
            $board.spaces[:"#{@pawn6.space}"].set_space(color, @pawn6, @pawn6.display)
            @pawn7 = Pawn.new("pawn7", "66", color)
            $board.spaces[:"#{@pawn7.space}"].set_space(color, @pawn7, @pawn7.display)
            @pawn8 = Pawn.new("pawn8", "76", color)
            $board.spaces[:"#{@pawn8.space}"].set_space(color, @pawn8, @pawn8.display)
        end
        @piece_array = [@king, @queen, @bishop1, @bishop2, @knight1, @knight2, @rook1, @rook2]
        @piece_array += [@pawn1, @pawn2, @pawn3, @pawn4, @pawn5, @pawn6, @pawn7, @pawn8]
        $board.update_display
        @possible_moves = update_possible_moves
    end

    def update_possible_moves
        #use piece array so that as pieces are added through pawn transformation the possible moves will stay up to date
        possible_moves = []
        @piece_array.each do |piece|
            piece.update_possible_moves(piece.space)
            unless piece.possible_moves == nil
                possible_moves += piece.possible_moves
            end
        end
        @possible_moves = possible_moves.uniq!
    end

    def take_turn(start, destination)
        moving_piece = $board.spaces[:"#{start}"].piece
        if moving_piece == nil
            return nil
        end
        unless moving_piece.possible_moves.include?(destination)
            return nil
        end
        $board.spaces[:"#{start}"].set_space(nil, nil, "  ")
        moving_piece.space = destination
        last_row = ["07", "17", "27", "37", "47", "57", "67", "77"]
        if last_row.include?(destination) && moving_piece.class == Pawn
            #get piece from user input
            new_piece = pawn_promotion(moving_piece.name, "knight", destination)
            moving_piece.space = nil
            $board.spaces[:"#{destination}"].set_space(new_piece.color, new_piece, new_piece.display)
        else
            $board.spaces[:"#{destination}"].set_space(moving_piece.color, moving_piece, moving_piece.display)
        end
        update_possible_moves
        $board.update_display
    end

    def pawn_promotion(pawn, piece, space)
        case piece
        when "knight"
            new_piece = instance_variable_set("@#{pawn}_to_#{piece}", Knight.new("#{space}", @color))
            self.class.send(:attr_accessor, "#{pawn}_to_#{piece}")
        when "rook"
            new_piece = instance_variable_set("@#{pawn}_to_#{piece}", Rook.new("#{space}", @color))
            self.class.send(:attr_accessor, "#{pawn}_to_#{piece}")
        when "bishop"
            new_piece = instance_variable_set("@#{pawn}_to_#{piece}", Bishop.new("#{space}", @color))
            self.class.send(:attr_accessor, "#{pawn}_to_#{piece}")
        when "queen"
            new_piece = instance_variable_set("@#{pawn}_to_#{piece}", Queen.new("#{space}", @color))
            self.class.send(:attr_accessor, "#{pawn}_to_#{piece}")
        end
        @piece_array << new_piece
        return new_piece
    end
end
        
white = Team.new("white")
red = Team.new("red")
puts $board.display
