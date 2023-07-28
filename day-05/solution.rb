class Vent
    def initialize(str_repr)
        p_start, p_end = str_repr.split(" -> ")
        x_start, y_start = p_start.split(",").collect(&:to_i)
        x_end, y_end = p_end.split(",").collect(&:to_i)

        @start = [x_start, y_start]
        @end = [y_start, y_end]
        
        x_range = x_start > x_end ? x_start.downto(x_end) : (x_start..x_end)
        y_range = y_start > y_end ? y_start.downto(y_end) : (y_start..y_end)
        if x_start == x_end
            @points = Array.new((y_end - y_start).abs + 1, x_start).zip(y_range)
            @type = :vertical
        elsif y_start == y_end
            @points = (x_range).zip(Array.new((x_end - x_start).abs + 1, y_start))
            @type = :horizontal
        else
            @points = (x_range).zip(y_range)
            @type = :diagonal
        end
    end

    def inspect
        return "Vent(#{@start}, #{@end})"
    end

    def get_type
        return @type
    end

    def get_points
        return @points
    end
end

###
def part_1(vents)
    points = Hash.new(0)

    for vent in vents
        if vent.get_type != :diagonal
            for point in vent.get_points
                points[point] += 1
            end
        end
    end

    how_many_danger = 0
    for point, count in points
        how_many_danger += 1 if count > 1
    end

    return how_many_danger
end

def part_2(vents)
    points = Hash.new(0)

    for vent in vents
        for point in vent.get_points
            points[point] += 1
        end
    end

    how_many_danger = 0
    for point, count in points
        how_many_danger += 1 if count > 1
    end

    return how_many_danger
end

###
file = File.open(File.dirname(__FILE__) + "/input.txt")
vents = file.read.split("\n").collect{|x| Vent.new(x)}
file.close

puts "Part 1: #{part_1(vents)}"
puts "Part 2: #{part_2(vents)}"
