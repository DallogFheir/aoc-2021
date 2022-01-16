require "set"

def find_low_points(map)
    low_points = []

    for i in 0...map.length
        for j in 0...map[0].length
            to_checks = [[i - 1, j], [i + 1, j]].select{|x| x[0] >= 0 and x[0] < map.length} + [[i, j - 1], [i, j + 1]].select{|x| x[1] >= 0 and x[1] < map[0].length}

            there_was_lower = false
            for to_check in to_checks
                if map[to_check[0]][to_check[1]] <= map[i][j]
                    there_was_lower = true
                    break
                end
            end

            if not there_was_lower
                low_points.push([i, j])
            end
        end
    end

    return low_points
end

def part_1(map)
    low_points = find_low_points(map)

    sum = 0
    for low_point in low_points
        risk_level = map[low_point[0]][low_point[1]] + 1
        sum += risk_level
    end

    return sum
end

def find_basins(map)
    processed = Set.new
    basins = []

    for i in 0...map.length
        for j in 0...map[0].length
            if not processed.include?([i, j]) and map[i][j] != 9
                basin_size = 0
                q = Queue.new
                q.push([i, j])

                while not q.empty?
                    a, b = q.pop

                    if not processed.include?([a, b])
                        to_checks = [[a + 1, b], [a - 1, b]].select{|x| x[0] >= 0 and x[0] < map.length} + [[a, b + 1], [a, b - 1]].select{|x| x[1] >= 0 and x[1] < map[0].length}

                        for to_check in to_checks
                            coords = [to_check[0], to_check[1]]
                            point = map[coords[0]][coords[1]]

                            if not processed.include?(coords) and point != 9
                                q.push(coords)
                            end
                        end

                        basin_size += 1
                        processed.add([a, b])
                    end
                end

                basins.push(basin_size)
            end
        end
    end

    return basins
end

def part_2(map)
    basins = find_basins(map)
    basins.sort!
    return basins[-1] * basins[-2] * basins[-3]
end

###

file = File.open(File.dirname(__FILE__) + "/input.txt")
map = file.read.split.collect{|x| x.split("").collect(&:to_i)}
file.close

puts "Part 1: #{part_1(map)}"
puts "Part 2: #{part_2(map)}"
