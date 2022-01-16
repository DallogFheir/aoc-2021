#####

def part_1(start_1, start_2)
    i = 0
    player = 0
    players = [start_1 - 1, start_2 - 1]
    scores = [0, 0]
    roll_count = 0

    while true
        roll = (i % 100 + 1) * 3 + 3
        roll_count += 1

        player_idx = player % 2
        player_position = players[player_idx]
        landing_position = (player_position + roll) % 10
        players[player_idx] = landing_position
        scores[player_idx] += landing_position + 1

        if scores[player_idx] >= 1000
            return scores[~player_idx] * roll_count * 3
        end

        i += 3
        player += 1
    end
end

#####

start_1 = 4
start_2 = 8

puts "Part 1: #{part_1(start_1, start_2)}"