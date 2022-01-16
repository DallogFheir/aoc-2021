def part_1(nums)
    freqs = Array.new(nums[0].length, 0)

    for num in nums
        num.chars.each_with_index do |digit, idx|
            if digit == "1"
                freqs[idx] += 1
            elsif digit == "0"
                freqs[idx] -= 1
            else
                raise StandardError.new("Invalid binary digit.")
            end
        end
    end

    gamma = ""
    epsilon = ""
    for freq in freqs
        if freq > 0
            gamma += "1"
            epsilon += "0"
        elsif freq < 0
            gamma += "0"
            epsilon += "1"
        else
            raise StandardError.new("Equal number of 0s and 1s.")
        end
    end

    return gamma.to_i(2) * epsilon.to_i(2)
end

def part_2(nums)
    oxygen = nums.clone
    co2 = nums.clone

    for i in 0...nums[0].length
        if oxygen.length > 1
            oxygen_freq = 0
            for num in oxygen
                if num[i] == "1"
                    oxygen_freq += 1
                elsif num[i] == "0"
                    oxygen_freq -= 1
                else
                    raise StandardError.new("Invalid binary digit.")
                end
            end
            most_common = oxygen_freq >= 0 ? "1" : "0"
            oxygen = oxygen.select{|x| x[i] == most_common}
        end

        if co2.length > 1
            co2_freq = 0
            for num in co2
                if num[i] == "1"
                    co2_freq += 1
                elsif num[i] == "0"
                    co2_freq -= 1
                else
                    raise StandardError.new("Invalid binary digit.")
                end
            end
            least_common = co2_freq >= 0 ? "0" : "1"
            co2 = co2.select{|x| x[i] == least_common}
        end
    end

    oxygen_rate = oxygen[0].to_i(2)
    co2_rate = co2[0].to_i(2)

    return oxygen_rate * co2_rate
end

###
file = File.open(File.dirname(__FILE__) + "/input.txt")
nums = file.read.split
file.close

puts "Part 1: %d" % part_1(nums)
puts "Part 2: %d" % part_2(nums)