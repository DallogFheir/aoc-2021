require "set"

def part_1(octopi)
    flashes = 0

    100.times do
        # increase all energy levels by 1
        for i in 0...octopi.length
            for j in 0...octopi[0].length
                octopi[i][j] += 1
            end
        end

        # flash
        theres_been_flashes = true
        already_flashed = Set.new

        while theres_been_flashes
            theres_been_flashes = false

            for i in 0...octopi.length
                for j in 0...octopi[0].length
                    if not already_flashed.include?([i, j]) and octopi[i][j] > 9
                        flashes += 1
                        theres_been_flashes = true
                        already_flashed.add([i, j])

                        # increase all adjacent
                        adjacent = [[i - 1, j - 1], [i - 1, j], [i - 1, j + 1], [i, j - 1], [i, j + 1], [i + 1, j - 1], [i + 1, j], [i + 1, j + 1]].select{|x| x[0] >= 0 and x[1] >= 0 and x[0] < octopi.length and x[1] < octopi[0].length}

                        for adj_octopus in adjacent
                            octopi[adj_octopus[0]][adj_octopus[1]] += 1
                        end
                    end
                end
            end
        end

        # reset to 0
        for flashed_octopus in already_flashed
            octopi[flashed_octopus[0]][flashed_octopus[1]] = 0
        end
    end

    return flashes
end

def part_2(octopi)
    octopi = octopi.clone
    count = 1

    while true
        # increase all energy levels by 1
        for i in 0...octopi.length
            for j in 0...octopi[0].length
                octopi[i][j] += 1
            end
        end

        # flash
        theres_been_flashes = true
        already_flashed = Set.new

        while theres_been_flashes
            theres_been_flashes = false

            for i in 0...octopi.length
                for j in 0...octopi[0].length
                    if not already_flashed.include?([i, j]) and octopi[i][j] > 9
                        theres_been_flashes = true
                        already_flashed.add([i, j])

                        # increase all adjacent
                        adjacent = [[i - 1, j - 1], [i - 1, j], [i - 1, j + 1], [i, j - 1], [i, j + 1], [i + 1, j - 1], [i + 1, j], [i + 1, j + 1]].select{|x| x[0] >= 0 and x[1] >= 0 and x[0] < octopi.length and x[1] < octopi[0].length}

                        for adj_octopus in adjacent
                            octopi[adj_octopus[0]][adj_octopus[1]] += 1
                        end
                    end
                end
            end
        end

        if already_flashed.length == 100
            return count
        end

        # reset to 0
        for flashed_octopus in already_flashed
            octopi[flashed_octopus[0]][flashed_octopus[1]] = 0
        end

        count += 1
    end
end
###

file = File.open(File.dirname(__FILE__) + "/input.txt")
octopi = file.read.split.collect{|x| x.split("").collect(&:to_i)}
octopi2 = octopi.collect{|x| x.clone}
file.close

puts "Part 1: #{part_1(octopi)}"
puts "Part 2: #{part_2(octopi2)}"
