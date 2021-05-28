module Shared
  
    module Findable
      
      def find(label)
        object = self.all.detect {|inst| inst.label == label}
      end

      def find_or_create(label)
        object = self.find(label)
        if object
            object
        else
            self.new(label)
        end
      end

    end
    
  end
  