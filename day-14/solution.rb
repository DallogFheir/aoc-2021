def polymerize(start, insertion_rules, how_many_times)
    elements = Hash.new(0)
    pairs = Hash.new(0)

    for i in 0...start.length-1
        pair = start[i] + start[i + 1]
        pairs[pair] += 1
        elements[start[i]] += 1
    end
    elements[start[-1]] += 1

    how_many_times.times do
        for pair, count in pairs.clone
            new_element = insertion_rules[pair]
            elements[new_element] += count

            new_pair_1 = pair[0] + new_element
            new_pair_2 = new_element + pair[1]
            pairs[new_pair_1] += count
            pairs[new_pair_2] += count
            pairs[pair] -= count
        end
    end

    return elements
end

###

def part_1(start, insertion_rules)
    elements = polymerize(start, insertion_rules, 10)

    return (elements.max_by{ |k, v| v}[1] - elements.min_by{ |k, v| v}[1])
end

def part_2(start, insertion_rules)
    elements = polymerize(start, insertion_rules, 40)

    return (elements.max_by{ |k, v| v}[1] - elements.min_by{ |k, v| v}[1])
end

###

file = File.open(File.dirname(__FILE__) + "/input.txt")
ins = file.read.split("\n\n")
start = ins[0]
insertion_rules = Hash[ins[1].split("\n").collect{|x| x.split(" -> ")}]
file.close

puts "Part 1: #{part_1(start, insertion_rules)}"
puts "Part 2: #{part_2(start, insertion_rules)}"
