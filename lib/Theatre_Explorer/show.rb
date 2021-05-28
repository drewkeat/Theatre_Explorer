class Show
    attr_accessor :label, :type, :productions
    @@all = []
    extend Shared::Findable

    def initialize(label, type = "Unknown", productions = [])
        @label = label
        @type = type
        @productions = productions
        @@all << self
    end

    def self.all
        @@all
    end
end