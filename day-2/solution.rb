def part_1(ins)
    hor = 0
    depth = 0

    for instruction in ins
        dir, amt = instruction.split
        amt = amt.to_i
        
        case dir
        when "forward"
            hor += amt
        when "down"
            depth += amt
        when "up"
            depth -= amt
        else
            raise StandardError.new("Unknown instruction.")
        end
    end

    return hor * depth
end

def part_2(ins)
    hor = 0
    depth = 0
    aim = 0

    for instruction in ins
        dir, amt = instruction.split
        amt = amt.to_i
        
        case dir
        when "forward"
            hor += amt
            depth += aim * amt
        when "down"
            aim += amt
        when "up"
            aim -= amt
        else
            raise StandardError.new("Unknown instruction.")
        end
    end

    return hor * depth
end

###
file = File.open(File.dirname(__FILE__) + "/input.txt")
ins = file.read.split("\n")
file.close

puts "Part 1: %d" % part_1(ins)
puts "Part 2: %d" % part_2(ins)