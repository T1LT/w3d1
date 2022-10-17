require 'set'
require_relative 'player.rb'

class Game
    def initialize(*names)
        # names = ["Mark", "Eric", "Larry"]
        # players = [<Player @name: Mark>, <Player @name: Eric>, <Player @name: Larry>]
        @players = names.map { |name| Player.new(name) }
        @fragment = ""
        @dictionary = Set.new IO.readlines("dictionary.txt").map { |word| word.chomp }
        @current = @players[0]
        @previous = @players[-1]
        @losses = {}
        @players.each { |player| @losses[player] = 0 }
    end

    def dictionary
        @dictionary ||= Set.new IO.readlines("dictionary.txt").map { |word| word.chomp }
    end

    def next_player!
        @current = @players.rotate![0]
        @previous = @players[-1]
    end

    def valid_play?(str)
        alphabet = ("a".."z").to_a
        if !alphabet.include?(str)
            return false
        end
        @dictionary.any? { |word| word.include?(@fragment + str) }
    end

    def take_turn(player)
        str = @current.guess
        until valid_play?(str)
            puts "invalid input!"
            str = @current.guess
        end
        @fragment += str
    end

    def play_round
        while true
            self.take_turn(@current)
            if @dictionary.include? @fragment
                puts "#{@current.name} loses the round!"
                @losses[@current] += 1
                if @losses[@current] == 5
                    @losses.delete(@current)
                    @players.shift
                end
                self.next_player!
                break
            else
                self.next_player!
            end
        end
    end

    def record(player)
        "GHOST"[0...@losses[player]]
    end

    def display_standings
        @players.each { |player| puts "#{player.name}: #{self.record(player)}" }
        puts ""
    end

    def run
        while !(@players.count {|player| @losses[player] == 5 } == @players.length - 1)
            self.display_standings
            self.play_round
            @fragment = ""
        end
        puts "#{@players[0].name} wins!"
    end
end