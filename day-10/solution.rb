def find_syntax_error(chunk)
    pairs = {
        "(" => ")",
        "[" => "]",
        "{" => "}",
        "<" => ">"
    }
    stack = []

    for bracket in chunk.chars
        if "([{<".include?(bracket)
            stack << bracket
        elsif ")]}>".include?(bracket)
            in_stack = stack.pop 

            if pairs[in_stack] != bracket
                return bracket
            end
        else
            raise StandardError.new("Invalid character.")
        end
    end

    return stack
end

def part_1(chunks)
    score_system = {
        ")" => 3,
        "]" => 57,
        "}" => 1197,
        ">" => 25137
    }
    score = 0

    for chunk in chunks
        after_processing = find_syntax_error(chunk)

        if after_processing.is_a?(String)
            score += score_system[after_processing]
        end
    end

    return score
end

def part_2(chunks)
    score_system = " ([{<"
    scores = []

    for chunk in chunks
        after_processing = find_syntax_error(chunk)

        if after_processing.is_a?(Array)
            score = 0
            for bracket in after_processing.reverse
                score *= 5
                score += score_system.index(bracket)
            end
            scores << score
        end
    end

    return scores.sort[scores.length / 2]
end
###

file = File.open(File.dirname(__FILE__) + "/input.txt")
chunks = file.read.split
file.close

puts "Part 1: #{part_1(chunks)}"
puts "Part 2: #{part_2(chunks)}"