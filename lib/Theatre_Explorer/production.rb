class Production
    attr_accessor :label, :year, :show, :details
    @@all = []
    extend Shared::Findable

    def initialize(label, year = nil, show = nil, details = nil)
        @label = label
        @@all << self
    end

    def self.all
        @@all
    end

    def join_year(year)
        year.productions << self
    end

    def join_show(show)
        show.productions << self
    end
end