require "set"

def check_if_won(board, nums)
    if nums.length < board.length
        return false
    end

    # horizontally
    for row in board
        won = true

        for num in row
            if not nums.include?(num)
                won = false
                break
            end
        end

        if won
            return true
        end
    end

    # vertically
    for i in 0...board[0].length
        won = true

        for row in board
            if not nums.include?(row[i])
                won = false
                break
            end
        end

        if won
            return true
        end
    end

    return false
end

def sum_of_unmarked(board, nums)
    sum = 0

    for row in board
        for num in row
            if not nums.include?(num)
                sum += num
            end
        end
    end

    return sum
end

###
def part_1(boards, nums)
    drawn_nums = Set.new
    
    for num in nums
        drawn_nums.add(num)
        
        for board in boards
            if check_if_won(board, drawn_nums)
                sum = sum_of_unmarked(board, drawn_nums)

                return num * sum
            end
        end
    end
end

def part_2(boards, nums)
    drawn_nums = Set.new
    
    for num in nums
        drawn_nums.add(num)
        idxs_to_remove = []

        boards.each_with_index do |board, i|
            if check_if_won(board, drawn_nums)
                idxs_to_remove << i
            end
        end

        if boards.length == 1 and idxs_to_remove.length > 0
            sum = 0

            for row in boards[0]
                for row_num in row
                    if not drawn_nums.include?(row_num)
                        sum += row_num
                    end
                end
            end

            return num * sum
        end

        boards = boards.select.with_index{|_, idx| not idxs_to_remove.include?(idx)}
    end
end

###
file = File.open(File.dirname(__FILE__) + "/input.txt")

data = file.read.split("\n\n")
nums = data[0].split(",").collect(&:to_i)
boards = data[1..-1].collect{|x| x.split("\n").collect{|y| y.split().collect(&:to_i)}}
file.close

puts "Part 1: #{part_1(boards, nums)}"
puts "Part 2: #{part_2(boards, nums)}"