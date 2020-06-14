require './lib/chess_board.rb'
require 'yaml'

class King
    attr_accessor :space, :color, :not_moved
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
        @not_moved = true
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
        
        #check if castling is a possible move
        if self.color == "white"
            #have to check for nil or else get_possible_moves throws an error because variable referring to class is not available
            #while the class is initializing
            unless $white == nil
                unless $white.check?(self.color)
                    if ($white.king.not_moved == true && $white.rook1.not_moved == true) &&
                        ($board.spaces[:"10"].occupied == nil && $red.possible_moves.include?("10") == false) &&
                        ($board.spaces[:"20"].occupied == nil && $red.possible_moves.include?("20") == false) &&
                        ($board.spaces[:"30"].occupied == nil && $red.possible_moves.include?("30") == false) 
                        possible_moves << "20"
                    end
                    if ($white.king.not_moved == true && $white.rook2.not_moved == true) &&
                        ($board.spaces[:"50"].occupied == nil && $red.possible_moves.include?("50") == false) &&
                        ($board.spaces[:"60"].occupied == nil && $red.possible_moves.include?("60") == false)
                        possible_moves << "60"
                    end
                end
            end
        elsif self.color == "red"
            unless $red == nil
                unless $red.check?(self.color)
                    if ($red.king.not_moved == true && $red.rook1.not_moved == true) &&
                        ($board.spaces[:"17"].occupied == nil && $white.possible_moves.include?("17") == false) &&
                        ($board.spaces[:"27"].occupied == nil && $white.possible_moves.include?("27") == false) &&
                        ($board.spaces[:"37"].occupied == nil && $white.possible_moves.include?("37") == false) &&
                        possible_moves << "27"
                    end
                    if ($red.king.not_moved == true && $red.rook2.not_moved == true) &&
                        ($board.spaces[:"57"].occupied == nil && $white.possible_moves.include?("57") == false) &&
                        ($board.spaces[:"67"].occupied == nil && $white.possible_moves.include?("67") == false)
                        possible_moves << "67"
                    end
                end
            end
        end
           
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
    attr_accessor :space, :color, :not_moved
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
        @not_moved = true
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
    attr_accessor :space, :color, :en_passant
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
        @en_passant = false
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

            #see if en_passant move is possible
            unless $board.spaces[:"#{x + 1}#{y}"] == nil
                if $board.spaces[:"#{x + 1}#{y}"].occupied == "red"
                    if $board.spaces[:"#{x + 1}#{y}"].piece.class == Pawn
                        if $board.spaces[:"#{x + 1}#{y}"].piece.en_passant == true
                            possible_moves << "#{x + 1}#{y + 1}"
                        end
                    end
                end
            end
            unless $board.spaces[:"#{x - 1}#{y}"] == nil
                if $board.spaces[:"#{x - 1}#{y}"].occupied == "red"
                    if $board.spaces[:"#{x - 1}#{y}"].piece.class == Pawn
                        if $board.spaces[:"#{x - 1}#{y}"].piece.en_passant == true &&
                            possible_moves << "#{x - 1}#{y + 1}"
                        end
                    end
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

            #see if en_passant move is possible
            unless $board.spaces[:"#{x + 1}#{y}"] == nil
                if $board.spaces[:"#{x + 1}#{y}"].occupied == "white"
                    if $board.spaces[:"#{x + 1}#{y}"].piece.class == Pawn
                        if $board.spaces[:"#{x + 1}#{y}"].piece.en_passant == true
                            possible_moves << "#{x + 1}#{y - 1}"
                        end
                    end
                end
            end
            unless $board.spaces[:"#{x - 1}#{y}"] == nil
                if $board.spaces[:"#{x - 1}#{y}"].occupied == "white"
                    if $board.spaces[:"#{x - 1}#{y}"].piece.class == Pawn
                        if $board.spaces[:"#{x - 1}#{y}"].piece.en_passant == true
                            possible_moves << "#{x - 1}#{y - 1}"
                        end
                    end
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
    attr_accessor :king, :queen, :bishop1, :bishop2, :knight1, :knight2, :rook1, :rook2, :color
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
    
    def save_states
        red = YAML::dump($red)
        white = YAML::dump($white)
        board = YAML::dump($board)
        Dir.mkdir("saved_states") unless Dir.exists?("saved_states")
        red_file = "saved_states/red"
        File.open(red_file, "w") do |file|
            file.puts(red)
        end
        white_file = "saved_states/white"
        File.open(white_file, "w") do |file|
            file.puts(white)
        end
        board_file = "saved_states/board"
        File.open(board_file, "w") do |file|
            file.puts(board)
        end
    end

    def restore_states
        red_file = "saved_states/red"
        white_file = "saved_states/white"
        board_file = "saved_states/board"
        
        red = File.open(red_file, "r") do |file|
            YAML::load(file)
        end
        $red = red

        white = File.open(white_file, "r") do |file|
            YAML::load(file)
        end
        $white = white

        board = File.open(board_file, "r") do |file|
            YAML::load(file)
        end
        $board = board
    end
        


    def take_turn(start, destination)
        if $board.spaces[:"#{start}"] == nil
            return nil
        end
        unless $board.spaces[:"#{start}"].occupied == self.color
            return nil
        end
        moving_piece = $board.spaces[:"#{start}"].piece
        if moving_piece == nil
            return nil
        end
        unless moving_piece.possible_moves.include?(destination)
            return nil
        end
        
        save_states

        x_and_y = start.split("")
        x = x_and_y[0].to_i
        y = x_and_y[1].to_i

        $board.spaces[:"#{start}"].set_space(nil, nil, "  ")
        moving_piece.space = destination
        first_and_last_row = ["07", "17", "27", "37", "47", "57", "67", "77", "00", "10", "20", "30", "40", "50", "60", "70"]
        captured_piece = en_passant(start, destination, moving_piece)

        if captured_piece == nil
            if moving_piece.class == King && (destination == "#{x + 2}#{y}" || destination == "#{x - 2}#{y}")
                castle(start, destination, moving_piece)
            elsif first_and_last_row.include?(destination) && moving_piece.class == Pawn
                #get piece from user input
                new_piece = pawn_promotion(moving_piece.name, "knight", destination)
                moving_piece.space = nil
                $board.spaces[:"#{destination}"].set_space(new_piece.color, new_piece, new_piece.display)
            else
                if $board.spaces[:"#{destination}"].occupied != nil
                    captured_piece = capture_piece(destination)
                end
                $board.spaces[:"#{destination}"].set_space(moving_piece.color, moving_piece, moving_piece.display)
            end
        else
            $board.spaces[:"#{destination}"].set_space(moving_piece.color, moving_piece, moving_piece.display)
        end
        

        update_en_passant(start, destination)
        if moving_piece.class == Rook || moving_piece.class == King
            moving_piece.not_moved = false
        end
        $red.update_possible_moves
        $white.update_possible_moves
        $board.update_display
        
        if check?(self.color)
            restore_states
            return "check"
        end

        return captured_piece if captured_piece != nil
        return true
    end

    def check?(color)
        if color == "white"
            if $red.possible_moves.include?($white.king.space)
                return true
            end
        elsif color == "red"
            if $white.possible_moves.include?($red.king.space)
                return true
            end
        else
            return false
        end
    end

    def checkmate?
        unless check?(self.color) == true
            return false
        end
        @piece_array.each do |piece|
            piece.possible_moves.each do |move|
                result = take_turn(piece.space, move)
                restore_states
                update_possible_moves
                unless result == "check"
                    return false
                end
            end
        end
        return true
    end

    def castle(start, destination, king)
        $board.spaces[:"#{destination}"].set_space(king.color, king, king.display)
        $board.spaces[:"#{start}"].set_space(nil, nil, "  ")
        king.space = "#{destination}"
        case destination
        when "20"
            rook = $board.spaces[:"00"].piece
            $board.spaces[:"00"].set_space(nil, nil, "  ")
            $board.spaces[:"30"].set_space(rook.color, rook, rook.display)
            rook.space = "30"
            rook.not_moved = false
        when "60"
            rook = $board.spaces[:"70"].piece
            $board.spaces[:"70"].set_space(nil, nil, "  ")
            $board.spaces[:"50"].set_space(rook.color, rook, rook.display)
            rook.space = "50"
            rook.not_moved = false
        when "27"
            rook = $board.spaces[:"07"].piece
            $board.spaces[:"07"].set_space(nil, nil, "  ")
            $board.spaces[:"37"].set_space(rook.color, rook, rook.display)
            rook.space = "37"
            rook.not_moved = false
        when "67"
            rook = $board.spaces[:"77"].piece
            $board.spaces[:"77"].set_space(nil, nil, "  ")
            $board.spaces[:"57"].set_space(rook.color, rook, rook.display)
            rook.space = "57"
            rook.not_moved = false
        end
    end
            

    def en_passant(start, destination, piece)
        unless piece.class == Pawn
            return nil
        end
        x_and_y = start.split("")
        x = x_and_y[0].to_i
        y = x_and_y[1].to_i
        if piece.color == "white"
            if destination == "#{x + 1}#{y + 1}" && $board.spaces[:"#{destination}"].occupied == nil
                return captured_piece = capture_piece("#{x + 1}#{y}")
            elsif destination == "#{x - 1}#{y + 1}" && $board.spaces[:"#{destination}"].occupied == nil
                return captured_piece = capture_piece("#{x - 1}#{y}")
            else
                return nil
            end
        elsif piece.color == "red"
            if destination == "#{x + 1}#{y - 1}" && $board.spaces[:"#{destination}"].occupied == nil
                return captured_piece = capture_piece("#{x + 1}#{y}")
            elsif destination == "#{x - 1}#{y - 1}" && $board.spaces[:"#{destination}"].occupied == nil
                return captured_piece = capture_piece("#{x - 1}#{y}")
            else 
                return nil
            end
        end
    end

    def update_en_passant(start, destination)
        pawn_array = [$red.pawn1, $red.pawn2, $red.pawn3, $red.pawn4, $red.pawn5, $red.pawn6, $red.pawn7, $red.pawn8]
        pawn_array += [$white.pawn1, $white.pawn2, $white.pawn3, $white.pawn4, $white.pawn5, $white.pawn6, $white.pawn7, $white.pawn8]
        pawn_array.each do |pawn|
            pawn.en_passant = false
        end
        if $board.spaces[:"#{destination}"].piece.class == Pawn
            x_and_y = start.split("")
            x = x_and_y[0].to_i
            y = x_and_y[1].to_i
            if destination == "#{x}#{y + 2}" || destination == "#{x}#{y - 2}"
                $board.spaces[:"#{destination}"].piece.en_passant = true
            end
        end
    end

    def capture_piece(space)
        captured_piece = $board.spaces[:"#{space}"].piece
        captured_piece.space = nil
        $board.spaces[:"#{space}"].set_space(nil, nil, "  ")
        return captured_piece
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

#red and white must be global variables so both teams' possible moves can be updated at the end of each turn
$red = Team.new("red")
$white = Team.new("white")
puts $board.display
$white.take_turn("51", "52")
$red.take_turn("46", "44")
$white.take_turn("61", "63")
puts $board.display
$red.take_turn("37", "73")
puts $board.display
puts $white.checkmate?
