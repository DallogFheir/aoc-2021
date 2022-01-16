require "set"

def fold(dots, fold)
    fold_line = fold[1]
    if fold[0] == "y"
        new_dots = Set.new

        for dot in dots
            if dot[1] < fold_line
                new_dots << dot
            else
                new_dot_y = 2 * fold_line - dot[1]
                new_dots << [dot[0], new_dot_y]
            end
        end
    elsif fold[0] == "x"
        new_dots = Set.new

        for dot in dots
            if dot[0] < fold_line
                new_dots << dot
            else
                new_dot_x = 2 * fold_line - dot[0]
                new_dots << [new_dot_x, dot[1]]
            end
        end
    else
        raise StandardError.new("Invalid folding axis.")
    end

    return Array[*new_dots]
end

###

def part_1(dots, folds)
    return fold(dots, folds[0]).length
end

def part_2(dots, folds)
    for fold in folds
        dots = fold(dots, fold)
    end

    max_x = dots[0][0]
    max_y = dots[0][1]
    for dot in dots[1..-1]
        if dot[0] > max_x
            max_x = dot[0]
        end

        if dot[1] > max_y
            max_y = dot[1]
        end
    end

    img_arr = Array.new(max_y + 1)
    img_arr.fill{|_| Array.new(max_x + 1, ".")}

    for dot in dots
        img_arr[dot[1]][dot[0]] = "#"
    end

    return img_arr.collect{|x| x.join}.join("\n")
end
###

file = File.open(File.dirname(__FILE__) + "/input.txt")
manual = file.read.split("\n\n")
dots = manual[0].split.collect{|x| x.split(",").collect(&:to_i)}
folds = manual[1].split("\n").collect{|x| x.delete_prefix("fold along ").split("=")}.collect{|x| [x[0], x[1].to_i]}
file.close

puts "Part 1: #{part_1(dots, folds)}"
puts "Part 2:\n#{part_2(dots, folds)}"
