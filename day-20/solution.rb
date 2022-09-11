require "set"

def parse_image(image)
    lit_pixels = Set.new

    image.each_with_index do |line, y|
        line.each_with_index do |pixel, x|
            if pixel == "#"
                lit_pixels.add([y, x])
            end
        end
    end

    return lit_pixels
end

def get_neighbors(coords)
    y, x = coords
    neighbors = []

    for i in -1..1
        for j in -1..1
            neighbors.add << [y + i, x + j]
        end
    end

    return neighbors
end

def enhance_image(image)
    
end

file = File.open(File.dirname(__FILE__) + "/test.txt")
algorithm, image_lines = file.read.split("\r\n\r\n")
image = image_lines.split("\n").collect{|line| line.chars}
file.close

lit_pixels = parse_image(image)