class Scraper

    def year(year_label)
        final = {}
        page = Mechanize.new.get("https://www.broadwayworld.com/browseshows.cfm?showtype=BR&open_yr=#{year_label}")
        list = page.search("p+ ul li")
        list.each do |item|
            label = item.text
            link = item.children.attribute("href").value
            final[label] = link
        end
        final
    end

    def production(url)
        page = Mechanize.new.get(url)
    end
end