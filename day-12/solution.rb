require "set"

class Path
    def initialize(caves=nil)
        @small_caves = Set.new
        @already_small_cave = false

        if caves == nil
            @path = []
        else
            @path = caves.clone

            for cave in caves
                if self.is_small_cave(cave)
                    if @small_caves.include?(cave)
                        @already_small_cave = true
                    else
                        @small_caves << cave
                    end
                end
            end
        end
    end

    def self.[](*caves)
        return self.new([*caves])
    end

    def <<(cave)
        self.push(cave)
    end

    def inspect
        return "Path(#{@path})"
    end

    def [](index)
        return @path[index]
    end

    def push(cave)
        if self.is_small_cave(cave)
            if @small_caves.include?(cave)
                @already_small_cave = true
            else
                @small_caves << cave
            end
        end

        @path << cave
    end

    def clone
        return Path.new(@path)
    end

    def include?(cave)
        return @path.include?(cave)
    end

    private def is_small_cave(cave)
        return (cave == cave.downcase and not ["start", "end"].include?(cave))
    end

    attr_reader :path
    attr_reader :already_small_cave
end

def create_map(conns)
    map = Hash.new{ |hash, key| hash[key] = []}

    for conn in conns
        if conn[0] == "start" or conn[1] == "start"
            other = (conn[0] == "start" ? conn[1] : conn[0])
            map["start"] << other
        elsif conn[0] == "end" or conn[1] == "end"
            other = (conn[0] == "end" ? conn[1] : conn[0])
            map[other] << "end"
        else
            map[conn[0]] << conn[1]
            map[conn[1]] << conn[0]
        end
    end

    return map
end

def find_paths(conns)
    map = create_map(conns)
    full_paths = []
    
    paths = Queue.new
    paths << Path["start"]
    while not paths.empty?
        path = paths.pop
        
        for next_cave in map[path[-1]]
            new_path = path.clone

            if next_cave == "end"
                new_path << next_cave
                full_paths << new_path
            elsif next_cave == next_cave.downcase
                if not new_path.include?(next_cave)
                    new_path << next_cave
                    paths << new_path
                end
            else
                new_path << next_cave
                paths << new_path
            end
        end
    end

    return full_paths
end

def find_paths_with_repeat(conns)
    map = create_map(conns)
    full_paths = []
    
    paths = Queue.new
    paths << Path["start"]
    while not paths.empty?
        path = paths.pop
        
        for next_cave in map[path[-1]]
            new_path = path.clone

            if next_cave == "end"
                new_path << next_cave
                full_paths << new_path
            elsif next_cave == next_cave.downcase
                if not new_path.include?(next_cave) or not new_path.already_small_cave
                    new_path << next_cave
                    paths << new_path
                end
            else
                new_path << next_cave
                paths << new_path
            end
        end
    end

    return full_paths
end

###

def part_1(conns)
    paths = find_paths(conns)
    return paths.length
end

def part_2(conns)
    paths = find_paths_with_repeat(conns)
    return paths.length
end

###

file = File.open(File.dirname(__FILE__) + "/input.txt")
conns = file.read.split.collect{|x| x.split("-")}
file.close

puts "Part 1: #{part_1(conns)}"
puts "Part 2: #{part_2(conns)}"
