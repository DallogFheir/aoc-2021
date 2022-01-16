require "set"

def part_1(signals)
    count = 0

    for signal in signals
        for digit in signal[1]
            count += 1 if [2, 3, 4, 7].include?(digit.length) 
        end
    end

    return count
end

def parse_signal(patterns, output)
    trans = {}

    digits = {}
    six_segmental = []
    five_segmenetal = []
    for digit in patterns
        case digit.length
        when 2
            digits[1] = Set[*digit.chars]
        when 3
            digits[7] = Set[*digit.chars]
        when 4
            digits[4] = Set[*digit.chars]
        when 5
            five_segmenetal.push(Set[*digit.chars])
        when 6
            six_segmental.push(Set[*digit.chars])
        end
    end

    # A = segment in 7 that is not in 1
    seg_a = (digits[7] - digits[1]).to_a[0]
    trans[seg_a] = "A"
    # 3 segments missing from 0, 6, 9
    # 2 of those are in 4, other is E
    # C is in 1
    letters = Set[*"abcdefg".chars]
    missing = Set.new
    for digit in six_segmental
        missing.add((letters - digit).to_a[0])
    end
    seg_c = (missing & digits[1]).to_a[0]
    trans[seg_c] = "C"
    seg_e = (missing - digits[4]).to_a[0]
    trans[seg_e] = "E"
    seg_d = missing.subtract([seg_c, seg_e]).to_a[0]
    trans[seg_d] = "D"
    # F is in 1
    seg_f = digits[1].delete(seg_c).to_a[0]
    trans[seg_f] = "F"
    # B is in 4
    seg_b = digits[4].subtract([seg_c, seg_d, seg_f]).to_a[0]
    trans[seg_b] = "B"
    # G is the only one left
    seg_g = Set[*"abcdefg".chars].subtract([seg_a, seg_b, seg_c, seg_d, seg_e, seg_f]).to_a[0]
    trans[seg_g] = "G"

    # translate to real digits
    real_digits = {
        "ABCEFG" => "0",
        "CF" => "1",
        "ACDEG" => "2",
        "ACDFG" => "3",
        "BCDF" => "4",
        "ABDFG" => "5",
        "ABDEFG" => "6",
        "ACF" => "7",
        "ABCDEFG" => "8",
        "ABCDFG" => "9"
    }

    res = ""
    for digit in output
        new_digit = ""
        for letter in digit.chars
            new_digit += trans[letter]
        end

        new_digit = new_digit.chars.sort.join
        res += real_digits[new_digit]
    end

    return res.to_i
end

def part_2(signals)
    sum = 0
    for signal in signals
        sum += parse_signal(signal[0], signal[1])
    end

    return sum
end

###

file = File.open(File.dirname(__FILE__) + "/input.txt")
signals = file.read.split("\n").collect{|x| x.split("|")}.collect{|x| [x[0].split, x[1].split]}
file.close

puts "Part 1: #{part_1(signals)}"
puts "Part 2: #{part_2(signals)}"