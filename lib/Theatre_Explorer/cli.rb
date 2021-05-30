class CLI
    def call
        system("clear")
        puts "
        =====================================
        ||   Welcome to Theatre Explore!   ||
        =====================================
        "
        initial_prompt
    end

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

            year = Year.find_or_create(input)
            year.display_productions
            puts "**Select a production by # to see more details**"
            input = gets.strip.to_i
            selection = year.scraped_list[year.scraped_list.keys[input - 1]]
            system("clear")
            show = Scraper.new.production(selection)
            show.print
            continue_prompt

        else

            unclear

        end

    end

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
            options = Scraper.new.show_search(input)
            options.keys.each.with_index(1) {|option, index| puts "#{index}) \t #{option}"}
            input = gets.strip.to_i
            selection = options[options.keys[input - 1]]
            show = Scraper.new.production("https://www.broadwayworld.com#{selection}")
            show.print
            continue_prompt
        end
    end

    def continue_prompt
        puts "\nWould you like to explore more?"
        input = gets.strip.downcase
        if input == "n" || input == "no" || input == "exit"
            goodbye
        else
            system("clear")
            initial_prompt
        end
    end

    def unclear
        system("clear")
        puts "I'm sorry. That seems to be invalid input.\n
        Please try again."
        sleep(1)
        system("clear")
        initial_prompt
    end

    def goodbye

        system("clear")
        puts "==========================="
        puts "|| Thanks for exploring! ||"
        puts "---------------------------"
        puts "||        Goodbye!       ||"
        puts "==========================="
        binding.pry
        exit
    end
end