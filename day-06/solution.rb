def reproduce_fish(fishes, num_of_days)
    timers = Hash[(0..8).collect{|x| [x, 0]}]

    for fish in fishes
        timers[fish] += 1
    end

    num_of_days.times do
        new_timers = {
            0 => timers[1],
            1 => timers[2],
            2 => timers[3],
            3 => timers[4],
            4 => timers[5],
            5 => timers[6],
            6 => timers[0] + timers[7],
            7 => timers[8],
            8 => timers[0]
        }

        timers = new_timers
    end

    return timers
end

###

def part_1(fishes)
    return reproduce_fish(fishes, 80).values.sum
end

def part_2(fishes)
    return reproduce_fish(fishes, 256).values.sum
end

###

file = File.open(File.dirname(__FILE__) + "/input.txt")
fishes = file.read.split(",").collect(&:to_i)
file.close

puts "Part 1: #{part_1(fishes)}"
puts "Part 2: #{part_2(fishes)}"