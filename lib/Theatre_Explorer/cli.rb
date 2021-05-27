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
        puts "Searching by year"
        input = gets.strip.downcase
        if input == "exit"
            goodbye 
        else
            
        end
    end

    def production_search
        system("clear")
        puts "Searching by production"
        input = gets.strip.downcase
        if input == "exit"
            goodbye 
        else
            
        end
    end

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