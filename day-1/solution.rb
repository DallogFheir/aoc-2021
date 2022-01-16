def part_1(depths)
    how_many = 0

    for i in 1...depths.length
        if depths[i] > depths[i - 1]
            how_many += 1
        end
    end

    return how_many
end

def part_2(depths)
    how_many = 0

    for i in 0...depths.length - 3
        first_window = depths[i] + depths[i + 1] + depths[i + 2]
        second_window = depths[i + 1] + depths[i + 2] + depths[i + 3]

        if second_window > first_window
            how_many += 1
        end
    end

    return how_many
end

###
file = File.open(File.dirname(__FILE__) + "/input.txt")
depths = file.read.split.map(&:to_i)
file.close

puts "Part 1: %d" % part_1(depths)
puts "Part 2: %d" % part_2(depths)