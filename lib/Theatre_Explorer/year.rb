
class Year
    attr_accessor :label, :productions
    @@all = []
    extend Shared::Findable

    def initialize(label, productions = [])
        unless Year.find(label)
            @label = label
            @productions = productions
            @@all << self
        end
    end

    def self.all
        @@all
    end

    def display_productions
        system("clear")
        puts "Broadway productions from #{@label}"
        puts "-------------------------------------------------"
            productions.each.with_index(1) do |production, i|
                puts "#{i}) \t#{production.label}"
            end
        puts "-------------------------------------------------"
        puts "**Select a production by # to see more details**"
    end
end