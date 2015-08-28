class User
    def initialize first, last
        @first = first
        @last = last
    end

    def name
        "#{@last.upcase} #{@first}"
    end

    def greeting
        "Hello, My name is #{name}"
    end
end
