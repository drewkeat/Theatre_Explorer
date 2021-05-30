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
        year_label = Time.now.year.to_s if year_label == ""
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
        if details["summary"]
            puts ""
            puts "Summary: \t #{details["summary"]}\n"
            puts ""
        else
            puts ""
            puts "Summary: Not available for this production\n"
            puts ""
        end

        details.each do |k,v|
            puts "#{k} \t #{v}" unless k == "summary" || k == "Show type"
        end

    end
end