class Production
    attr_accessor :label, :year, :show, :details
    @@all = []
    extend Shared::Findable

    def initialize(attributes)
        unless Production.find(attributes["label"])
            @label = label
            attributes.each {|k,v| self.send("#{k}=", v)}
            join_year(year) if year
            join_show(show) if show
            @@all << self
        end
    end

    def self.all
        @@all
    end

    def join_year(year_label)
        year = Year.find_or_create(year_label)
        self.year = year
        year.productions << self
    end

    def join_show(show_label)
        show = Show.find_or_create(show_label)
        self.show = show
        show.productions << self
    end

    def print
        puts "========================"
        puts "#{label}"
        puts "========================"
        puts "Show type: #{details["Show type"]}"
        puts ""
        puts "
        Summary:\n
        #{details["summary"]}\n
        "
    end
end