
class Year
    attr_accessor :label, :productions
    @@all = []
    extend Shared::Findable

    def initialize(label)
        @label = label
        @@all << self
    end

    def self.all
        @@all
    end

    def display_productions
        puts "List of productions\n
        1) Title One\n
        2) Title Two\n
        3) Title Three\n
        "
    end
end