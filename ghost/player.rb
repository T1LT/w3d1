class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end

    def guess
        print "#{@name}, enter a character: "
        gets.chomp
    end
end