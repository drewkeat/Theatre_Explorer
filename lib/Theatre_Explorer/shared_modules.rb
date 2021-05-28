module Shared
  
    module Findable
      
      def find_or_create(label)
        object = self.all.detect {|inst| inst.label == label}
        if object
            object
        else
            self.new(label)
        end
      end

    end
    
  end
  