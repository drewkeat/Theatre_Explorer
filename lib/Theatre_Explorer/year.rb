
class Year
    attr_accessor :label, :productions, :scraped_list
    @@all = []
    extend Shared::Findable

    def initialize(label, productions = [])
        unless Year.find(label)
            @label = label
            @productions = productions
            @scraped_list = Scraper.new.year(self.label)
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
            scraped_list.keys.each.with_index(1) do |production, i|
                puts "#{i}) \t#{production}"
            end
        puts "-------------------------------------------------"
    end
end