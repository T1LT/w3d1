require 'set'
class Game
    def initialize(name1, name2)
        @player1 = Player.new(name1)
        @player2 = Player.new(name2)
        @fragment = ""
        @dictionary = Set.new IO.readlines("dictionary.txt").map { |word| word.chomp }
        @current = @player1 
        @previous = @player2
    end

    def next_player!
        @current = @current == @player1 ? @player2 : @player1
        @previous = @current == @player1 ? @player1 : @player2
    end

    def valid_play?(str)
        alphabet = ("a".."z").to_a
        
    end

    def take_turn(player)
        
    end

    def play_round
        
    end
end