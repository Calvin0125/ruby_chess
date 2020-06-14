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
    attr_accessor :occupied, :piece, :display
    def initialize(occupied = nil, piece = nil, display = "  ")
        @occupied = occupied
        @piece = piece
        @display = display
    end

    def set_space(occupied, piece, display)
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
            @spaces[:"#{x}#{y}"] = Space.new
            if y < 7
                y += 1
            elsif y >= 7
                y = 0
                x += 1
            end
        end
        @display = "  +---+---+---+---+---+---+---+---+\n7 |#{@spaces[:"07"].display} |#{@spaces[:"17"].display} |"\
                "#{@spaces[:"27"].display} |#{@spaces[:"37"].display} |#{@spaces[:"47"].display} |"\
                "#{@spaces[:"57"].display} |#{@spaces[:"67"].display} |#{@spaces[:"77"].display} |\n"\
                "  +---+---+---+---+---+---+---+---+\n6 |#{@spaces[:"06"].display} |#{@spaces[:"16"].display} |"\
                "#{@spaces[:"26"].display} |#{@spaces[:"36"].display} |#{@spaces[:"46"].display} |"\
                "#{@spaces[:"56"].display} |#{@spaces[:"66"].display} |#{@spaces[:"76"].display} |\n"\
                "  +---+---+---+---+---+---+---+---+\n5 |#{@spaces[:"05"].display} |#{@spaces[:"15"].display} |"\
                "#{@spaces[:"25"].display} |#{@spaces[:"35"].display} |#{@spaces[:"45"].display} |"\
                "#{@spaces[:"55"].display} |#{@spaces[:"65"].display} |#{@spaces[:"75"].display} |\n"\
                "  +---+---+---+---+---+---+---+---+\n4 |#{@spaces[:"04"].display} |#{@spaces[:"14"].display} |"\
                "#{@spaces[:"24"].display} |#{@spaces[:"34"].display} |#{@spaces[:"44"].display} |"\
                "#{@spaces[:"54"].display} |#{@spaces[:"64"].display} |#{@spaces[:"74"].display} |\n"\
                "  +---+---+---+---+---+---+---+---+\n3 |#{@spaces[:"03"].display} |#{@spaces[:"13"].display} |"\
                "#{@spaces[:"23"].display} |#{@spaces[:"33"].display} |#{@spaces[:"43"].display} |"\
                "#{@spaces[:"53"].display} |#{@spaces[:"63"].display} |#{@spaces[:"73"].display} |\n"\
                "  +---+---+---+---+---+---+---+---+\n2 |#{@spaces[:"02"].display} |#{@spaces[:"12"].display} |"\
                "#{@spaces[:"22"].display} |#{@spaces[:"32"].display} |#{@spaces[:"42"].display} |"\
                "#{@spaces[:"52"].display} |#{@spaces[:"62"].display} |#{@spaces[:"72"].display} |\n"\
                "  +---+---+---+---+---+---+---+---+\n1 |#{@spaces[:"01"].display} |#{@spaces[:"11"].display} |"\
                "#{@spaces[:"21"].display} |#{@spaces[:"31"].display} |#{@spaces[:"41"].display} |"\
                "#{@spaces[:"51"].display} |#{@spaces[:"61"].display} |#{@spaces[:"71"].display} |\n"\
                "  +---+---+---+---+---+---+---+---+\n0 |#{@spaces[:"00"].display} |#{@spaces[:"10"].display} |"\
                "#{@spaces[:"20"].display} |#{@spaces[:"30"].display} |#{@spaces[:"40"].display} |"\
                "#{@spaces[:"50"].display} |#{@spaces[:"60"].display} |#{@spaces[:"70"].display} |\n"\
                "  +---+---+---+---+---+---+---+---+\n    0   1   2   3   4   5   6   7"
    end

    def update_display
        @display = "  +---+---+---+---+---+---+---+---+\n7 |#{@spaces[:"07"].display} |#{@spaces[:"17"].display} |"\
        "#{@spaces[:"27"].display} |#{@spaces[:"37"].display} |#{@spaces[:"47"].display} |"\
        "#{@spaces[:"57"].display} |#{@spaces[:"67"].display} |#{@spaces[:"77"].display} |\n"\
        "  +---+---+---+---+---+---+---+---+\n6 |#{@spaces[:"06"].display} |#{@spaces[:"16"].display} |"\
        "#{@spaces[:"26"].display} |#{@spaces[:"36"].display} |#{@spaces[:"46"].display} |"\
        "#{@spaces[:"56"].display} |#{@spaces[:"66"].display} |#{@spaces[:"76"].display} |\n"\
        "  +---+---+---+---+---+---+---+---+\n5 |#{@spaces[:"05"].display} |#{@spaces[:"15"].display} |"\
        "#{@spaces[:"25"].display} |#{@spaces[:"35"].display} |#{@spaces[:"45"].display} |"\
        "#{@spaces[:"55"].display} |#{@spaces[:"65"].display} |#{@spaces[:"75"].display} |\n"\
        "  +---+---+---+---+---+---+---+---+\n4 |#{@spaces[:"04"].display} |#{@spaces[:"14"].display} |"\
        "#{@spaces[:"24"].display} |#{@spaces[:"34"].display} |#{@spaces[:"44"].display} |"\
        "#{@spaces[:"54"].display} |#{@spaces[:"64"].display} |#{@spaces[:"74"].display} |\n"\
        "  +---+---+---+---+---+---+---+---+\n3 |#{@spaces[:"03"].display} |#{@spaces[:"13"].display} |"\
        "#{@spaces[:"23"].display} |#{@spaces[:"33"].display} |#{@spaces[:"43"].display} |"\
        "#{@spaces[:"53"].display} |#{@spaces[:"63"].display} |#{@spaces[:"73"].display} |\n"\
        "  +---+---+---+---+---+---+---+---+\n2 |#{@spaces[:"02"].display} |#{@spaces[:"12"].display} |"\
        "#{@spaces[:"22"].display} |#{@spaces[:"32"].display} |#{@spaces[:"42"].display} |"\
        "#{@spaces[:"52"].display} |#{@spaces[:"62"].display} |#{@spaces[:"72"].display} |\n"\
        "  +---+---+---+---+---+---+---+---+\n1 |#{@spaces[:"01"].display} |#{@spaces[:"11"].display} |"\
        "#{@spaces[:"21"].display} |#{@spaces[:"31"].display} |#{@spaces[:"41"].display} |"\
        "#{@spaces[:"51"].display} |#{@spaces[:"61"].display} |#{@spaces[:"71"].display} |\n"\
        "  +---+---+---+---+---+---+---+---+\n0 |#{@spaces[:"00"].display} |#{@spaces[:"10"].display} |"\
        "#{@spaces[:"20"].display} |#{@spaces[:"30"].display} |#{@spaces[:"40"].display} |"\
        "#{@spaces[:"50"].display} |#{@spaces[:"60"].display} |#{@spaces[:"70"].display} |\n"\
        "  +---+---+---+---+---+---+---+---+\n    0   1   2   3   4   5   6   7"
    end

end

$board = Board.new
