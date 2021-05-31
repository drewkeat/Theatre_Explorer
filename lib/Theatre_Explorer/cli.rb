class CLI
    #Initiates the CLI and prompts user for initial exploration preferences
    def call
        system("clear")
        puts "
        =====================================
        ||   Welcome to Theatre Explore!   ||
        =====================================
        "
        initial_prompt
    end

    #Prompts user for initial exploration preferences
    def initial_prompt
        puts "How would you like to explore?"
        puts "---------------------------------"
        puts ""
        puts "1) Search by Year"
        puts "2) Search by production title"
        puts "\n\t ** or type Exit **"
        input = gets.strip.downcase
        case input
        when "exit"
            goodbye
        when "1"
            year_search
        when "2"
            production_search
        else 
            unclear
        end
    end

    #Prompts user for year input.  Creates/finds year based on input, and displays scraped list of productions from that year (rather than creating production instances for all productions associated with that year).
    def year_search
        system("clear")
        puts "========================"
        puts "What year would you like to explore?"
        puts "I can pull records dating back to 1832."
        puts "========================"
        puts ""
        
            input = gets.strip.downcase
            current_year = Time.now.year

        if input == "exit"

            goodbye 

        elsif input.to_i.between?(1832, current_year - 1)

            #Scrapes production titles and urls for year
            year = Year.find_or_create(input)
            #Displays scraped production list
            year.display_productions
            puts "**Select a production by # to see more details**"
            input = gets.strip.to_i
            #Returns the url for the associated production
            selection = year.scraped_list[year.scraped_list.keys[input - 1]]
            system("clear")
            #Scrapes and instantiates a new production based on selection
            show = Scraper.new.production(selection)
            show.print
            continue_prompt

        else

            unclear

        end

    end

    #Prompts user to search for a production by title.  Scrapes query results based on input, and displays results for selection.  Instantiates new production based on selection
    def production_search
        system("clear")
        puts "===================================="
        puts "What show would you like to explore?"
        puts "===================================="
        puts ""
            input = gets.strip
        if input == "exit"
            goodbye 
        else
            #Creates hash with query results as keys and urls as values
            options = Scraper.new.show_search(input)
            if options.keys.size == 0
                begin
                    raise SearchError
                rescue SearchError => error
                    puts error.message
                end
            else
                #Displays query results
                options.keys.each.with_index(1) {|option, index| puts "#{index}) \t #{option}"}
                puts "Which result would you like to explore?"
                input = gets.strip.to_i
                if input.between?(1,options.keys.size)
                    selection = options[options.keys[input - 1]]
                    #Scrapes and instantiates production object based on selection.
                    show = Scraper.new.production("https://www.broadwayworld.com#{selection}")
                    show.print
                else
                    puts "Input error"
                    sleep(1)
                    production_search
                end
            end
            continue_prompt
        end
    end
    #Error to raise in case of empty search results
    class SearchError < StandardError
        def message
            "Search yielded no results."
        end
    end

    #Sequence for repeated searches
    def continue_prompt
        puts "\nWould you like to explore more?"
        puts "Yes/No"
        input = gets.strip.downcase
        if input == "n" || input == "no" || input == "exit"
            goodbye
        else
            system("clear")
            initial_prompt
        end
    end

    #Sequence for invalid/unclear input
    def unclear
        system("clear")
        puts "I'm sorry. That seems to be invalid input.\n
        Please try again."
        sleep(1)
        system("clear")
        initial_prompt
    end

    #Exit sequence
    def goodbye

        system("clear")
        puts "==========================="
        puts "|| Thanks for exploring! ||"
        puts "---------------------------"
        puts "||        Goodbye!       ||"
        puts "==========================="
        exit
    end
end