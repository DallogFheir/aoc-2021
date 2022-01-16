require "set"

####

class Packet
    def initialize(version, type)
        @version = version
        @type = type
    end

    def self.parse_from_binary(packet)
        version = packet[0...3].to_i(2)
        type = packet[3...6].to_i(2)
        content = packet[6..-1]

        if type == 4
            bits = ""
            i = 0
            while content[i] != "0"
                bits += content[i+1..i+4]
                i += 5
            end
            bits += content[i+1..i+4]
            i += 5

            value = bits.to_i(2)
            rest = content[i..-1]

            return LiteralValuePacket.new(version, type, value), rest
        else
            length_type = content[0]

            if length_type == "0"
                total_length = content[1..15].to_i(2)

                rest_of_content = content[16..-1]
                subpackets = rest_of_content[0...total_length]
                rest = rest_of_content[total_length..-1]
                
                parsed_subpackets = []
                while /^0*$/.match(subpackets) == nil
                    parsed_subpacket, subpackets = self.parse_from_binary(subpackets)
                    parsed_subpackets << parsed_subpacket
                end

                return OperatorPacket.new(version, type, parsed_subpackets), rest
            elsif length_type == "1"
                num_of_subpackets = content[1..11].to_i(2)
                rest = content[12..-1]

                parsed_subpackets = []
                num_of_subpackets.times do
                    parsed_subpacket, rest = self.parse_from_binary(rest)
                    parsed_subpackets << parsed_subpacket
                end

                return OperatorPacket.new(version, type, parsed_subpackets), rest
            else
                raise StandardError.new("Invalid binary digit #{length_type}.")
            end
        end
    end

    def self.parse_from_hex(packet)
        bin = ""
        for digit in packet.chars
            bin_digit = digit.to_i(16).to_s(2).rjust(4, "0")
            bin += bin_digit
        end

        return self.parse_from_binary(bin)
    end

    attr_reader :version
    attr_reader :type
end

class LiteralValuePacket < Packet
    def initialize(version, type, value)
        super(version, type)
        @value = value
    end

    def inspect
        return "#{self.class.name}(v. #{@version}, type #{@type}, value #{@value})"
    end

    def calculate
        return @value
    end

    attr_reader :value
end

class OperatorPacket < Packet
    def initialize(version, type, subpackets)
        super(version, type)
        @subpackets = subpackets
    end

    def inspect
        return "#{self.class.name}(v. #{@version}, type #{@type}, #{@subpackets.length} subpackets)"
    end

    def calculate
        calced_subpackets = @subpackets.collect{ |x| x.calculate }

        case @type
        when 0
            return calced_subpackets.sum
        when 1
            return calced_subpackets.reduce{ |a, b| a * b}
        when 2
            return calced_subpackets.min
        when 3
            return calced_subpackets.max
        when 5
            return calced_subpackets[0] > calced_subpackets[1] ? 1 : 0
        when 6
            return calced_subpackets[0] < calced_subpackets[1] ? 1 : 0
        when 7
            return calced_subpackets[0] == calced_subpackets[1] ? 1 : 0
        else
            throw StandardError.new("Invalid type.")
        end
    end

    attr_reader :subpackets
end

#####

def part_1(packet)
    parsed_packet, _ = Packet.parse_from_hex(packet)

    version_sum = parsed_packet.version
    q = parsed_packet.subpackets.clone
    while not q.empty?
        pack = q.pop
        version_sum += pack.version

        if pack.is_a?(OperatorPacket)
            q += pack.subpackets
        end
    end

    return version_sum
end

def part_2(packet)
    return Packet.parse_from_hex(packet)[0].calculate
end

######

file = File.open(File.dirname(__FILE__) + "/input.txt")
packet = file.read
file.close


puts "Part 1: #{part_1(packet)}"
puts "Part 2: #{part_2(packet)}"
