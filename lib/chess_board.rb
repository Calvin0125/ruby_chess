require 'colorize'
WHITE_KING = "\u2654 "
WHITE_QUEEN = "\u2655 "
WHITE_ROOK = "\u2656 "
WHITE_BISHOP = "\u2657 "
WHITE_KNIGHT = "\u2658 "
WHITE_PAWN = "\u2659 "
RED_KING = "\u2654 ".red
RED_QUEEN = "\u2655 ".red
RED_ROOK = "\u2656 ".red
RED_BISHOP = "\u2657 ".red
RED_KNIGHT = "\u2658 ".red
RED_PAWN = "\u2659 ".red
class Space
    attr_accessor :occupied, :piece, :name, :display
    def initialize(name, occupied = nil, piece = nil, display = "  ")
        @name = name
        @occupied = occupied
        @piece = piece
        @display = display
    end
end

class Board
    attr_accessor :spaces, :display
    def initialize
        @spaces = {}
        x = 0
        y = 0
        64.times do
            @spaces[:"space#{x}#{y}"] = Space.new("space#{x}#{y}")
            if y < 7
                y += 1
            elsif y >= 7
                y = 0
                x += 1
            end
        end
        @display = "+---+---+---+---+---+---+---+---+\n|#{@spaces[:space07].display} |#{@spaces[:space17].display} |"\
                "#{@spaces[:space27].display} |#{@spaces[:space37].display} |#{@spaces[:space47].display} |"\
                "#{@spaces[:space57].display} |#{@spaces[:space67].display} |#{@spaces[:space77].display} |\n"\
                "+---+---+---+---+---+---+---+---+\n|#{@spaces[:space06].display} |#{@spaces[:space16].display} |"\
                "#{@spaces[:space26].display} |#{@spaces[:space36].display} |#{@spaces[:space46].display} |"\
                "#{@spaces[:space56].display} |#{@spaces[:space66].display} |#{@spaces[:space76].display} |\n"\
                "+---+---+---+---+---+---+---+---+\n|#{@spaces[:space05].display} |#{@spaces[:space15].display} |"\
                "#{@spaces[:space25].display} |#{@spaces[:space35].display} |#{@spaces[:space45].display} |"\
                "#{@spaces[:space55].display} |#{@spaces[:space65].display} |#{@spaces[:space75].display} |\n"\
                "+---+---+---+---+---+---+---+---+\n|#{@spaces[:space04].display} |#{@spaces[:space14].display} |"\
                "#{@spaces[:space24].display} |#{@spaces[:space34].display} |#{@spaces[:space44].display} |"\
                "#{@spaces[:space54].display} |#{@spaces[:space64].display} |#{@spaces[:space74].display} |\n"\
                "+---+---+---+---+---+---+---+---+\n|#{@spaces[:space03].display} |#{@spaces[:space13].display} |"\
                "#{@spaces[:space23].display} |#{@spaces[:space33].display} |#{@spaces[:space43].display} |"\
                "#{@spaces[:space53].display} |#{@spaces[:space63].display} |#{@spaces[:space73].display} |\n"\
                "+---+---+---+---+---+---+---+---+\n|#{@spaces[:space02].display} |#{@spaces[:space12].display} |"\
                "#{@spaces[:space22].display} |#{@spaces[:space32].display} |#{@spaces[:space42].display} |"\
                "#{@spaces[:space52].display} |#{@spaces[:space62].display} |#{@spaces[:space72].display} |\n"\
                "+---+---+---+---+---+---+---+---+\n|#{@spaces[:space01].display} |#{@spaces[:space11].display} |"\
                "#{@spaces[:space21].display} |#{@spaces[:space31].display} |#{@spaces[:space41].display} |"\
                "#{@spaces[:space51].display} |#{@spaces[:space61].display} |#{@spaces[:space71].display} |\n"\
                "+---+---+---+---+---+---+---+---+\n|#{@spaces[:space00].display} |#{@spaces[:space10].display} |"\
                "#{@spaces[:space20].display} |#{@spaces[:space30].display} |#{@spaces[:space40].display} |"\
                "#{@spaces[:space50].display} |#{@spaces[:space60].display} |#{@spaces[:space70].display} |\n"\
                "+---+---+---+---+---+---+---+---+"
    end
end

board = Board.new