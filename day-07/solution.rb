def part_1(crabs)
    max = crabs.max
    min = crabs.min
    min_fuel = Float::INFINITY

    for i in min..max
        fuel = 0

        for crab in crabs
            fuel += (crab - i).abs
        end

        if fuel < min_fuel
            min_fuel = fuel
        end
    end

    return min_fuel
end

def part_2(crabs)
    max = crabs.max
    min = crabs.min
    min_fuel = Float::INFINITY

    for i in min..max
        fuel = 0

        for crab in crabs
            diff = (crab - i).abs
            fuel += (diff**2 + diff) / 2
        end

        if fuel < min_fuel
            min_fuel = fuel
        end
    end

    return min_fuel
end

###
file = File.open(File.dirname(__FILE__) + "/input.txt")
crabs = file.read.split(",").collect(&:to_i)
file.close

puts "Part 1: #{part_1(crabs)}"
puts "Part 2: #{part_2(crabs)}"
