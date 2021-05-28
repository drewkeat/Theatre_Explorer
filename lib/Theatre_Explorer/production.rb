class Production
    attr_accessor :label, :year, :show, :details
    @@all = []
    extend Shared::Findable

    def initialize(label, year = nil, show = nil, details = nil)
        unless Production.find(label)
            @label = label
            join_year(year) if year
            join_show(show) if show
            @details = details
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
end