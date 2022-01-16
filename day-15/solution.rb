require "pqueue"
require "set"

def dijkstra(graph)
    point_1 = graph[0][1]
    point_2 = graph[1][0]
    endpoint = [graph.length - 1, graph[0].length - 1]

    queue = PQueue.new([[[0, 1], point_1], [[1, 0], point_2]]){ |a, b| a[1] < b[1]}
    paths = { [0, 1] => [point_1, "start"], [1, 0] => [point_2, "start"]}
    processed = Set.new

    while true
        coords, shortest = queue.pop

        # end if end is at the beginning of the queue
        if coords == endpoint
            break
        end

        # if current node was already processed, skip iteration
        if processed.include?(coords)
            next
        end

        # otherwise process current node
        a, b = coords
        neighbors = [[a - 1, b], [a + 1, b], [a, b - 1], [a, b + 1]].select{|x| x[0] >= 0 and x[1] >= 0 and x[0] < graph.length and x[1] < graph[0].length}

        for neighbor in neighbors
            distance = graph[neighbor[0]][neighbor[1]] + shortest

            if paths.has_key?(neighbor)
                if distance < paths[neighbor][0]
                    paths[neighbor][0] = distance
                    paths[neighbor][1] = coords
                end
            else
                paths[neighbor] = [distance, coords]
            end

            queue << [[neighbor[0], neighbor[1]], distance]
        end

        processed << coords
    end

    node = [endpoint[0], endpoint[1]]
    path = [node]
    prev_node = nil
    while prev_node != "start"
        prev_node = paths[node][1]
        path << prev_node
        node = prev_node
    end

    return path.reverse[1..-1]
end

###

def part_1(risks)
    path = dijkstra(risks)
    
    sum = 0
    for node in path
        sum += risks[node[0]][node[1]]
    end

    return sum
end

def part_2(risks)
    all_tiles = risks.collect{|x| x.clone}
    len = risks[0].length

    4.times do
        for subarray in all_tiles
            new_subarray = []

            for i in -len..-1
                new_subarray << (subarray[i] + 1 > 9 ? 1 : subarray[i] + 1)
            end

            subarray.push(*new_subarray)
        end
    end

    len = all_tiles.length
    4.times do
        new_subarray = []

        for i in -len..-1
            new_subarray << all_tiles[i].collect{ |y| y + 1 > 9 ? 1 : y + 1}
        end

        all_tiles += new_subarray
    end

    # find path
    path = dijkstra(all_tiles)

    sum = 0
    for node in path
        sum += all_tiles[node[0]][node[1]]
    end

    return sum
end

###

file = File.open(File.dirname(__FILE__) + "/input.txt")
risks = file.read.split.collect{|x| x.split("").collect{|y| y.to_i}}
file.close

puts "Part 1: #{part_1(risks)}"
puts "Part 1: #{part_2(risks)}"
