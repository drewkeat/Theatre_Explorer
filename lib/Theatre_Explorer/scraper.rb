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
        landing = Mechanize.new.get(url)
        @page = landing.link_with(:href => /backstage.php/).click
        attributes = pull_attrs
        Production.new(attributes) unless Production.find(attributes["label"])
        Production.find(attributes["label"])
    end

    def pull_attrs
        attributes = {}
        attributes["show"] = @page.at("h2").text.gsub(" Show Information","")
        attributes["year"] = @page.at("tr:nth-child(1) td+ td span").text.match(/\d{4}/).to_s
        attributes["label"] = "#{attributes["show"]} - #{attributes["year"]}"
        attributes["details"] = {}
        prod_information = @page.search(".production-table span")
            prod_information.each.with_index do |e,i|
                case e.text.strip
                when "Previews:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Opening:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Closing:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Theatres:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Production Type:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Run Type:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Market:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Running Time:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Intermissions:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Version:"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Official Website"
                    attributes["details"][e.text] = prod_information[i + 1].text
                when "Show type"
                    attributes["details"][e.text] = prod_information[i + 1].text
                end 
            end
        summary = @page.link_with(:href => /\d*.html/).click.at("style+ .col-12").text[/; (\w.*\.)\w/]
        attributes["details"]["summary"] = /; (\w.*\.)\w/.match(summary)[1].strip if summary
        attributes
    end
end