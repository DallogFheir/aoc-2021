class SnailfishNumber
    def initialize(left, right)
        @left = left
        @right = right
    end

    def inspect
        left_ins = @left.is_a?(SnailfishNumber) ? @left.inspect : @left
        right_ins = @right.is_a?(SnailfishNumber) ? @right.inspect : @right
        return "[#{left_ins}, #{right_ins}]"
    end

    def +(other)
        return self.class.new(self, other).reduce
    end

    def reduce
        
    end

    def self.parse_from_string(string)
        stack = []
        
        for char in string.chars
            case char
            when "[", ","
                stack << char
            when "]"
                if stack[-2] != "," or stack[-4] != "["
                    raise StandardError.new("Invalid number.")
                end

                cur_right = stack.pop
                stack.pop
                cur_left = stack.pop
                stack[-1] = SnailfishNumber.new(cur_left, cur_right)
            else
                stack << char.to_i
            end
        end

        return stack[0]
    end
end

a = SnailfishNumber.parse_from_string("[[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]")
p a