require_relative 'polytreenode'
require 'byebug'

class KnightPathFinder

  def self.valid_moves(pos)
    moves =
    [[1, 2],
    [-1, 2],
    [-1, -2],
    [1, -2],
    [2, 1],
    [2, -1],
    [-2, -1],
    [-2, 1]]

    valid_pos = []

    moves.each do |move|
      potent_move = move.map.with_index { |num, i| num + pos[i] }
      valid_pos << potent_move if valid?(potent_move)
    end

    valid_pos
  end

  def self.get_path(curr_node)
    path = []
    while curr_node.parent 
      path << curr_node.parent.value
      curr_node = curr_node.parent
    end
    path.reverse

  end


  attr_reader :pos

  def initialize(pos)
    @pos = pos
    @board = Array.new(8) { Array.new(8, '_') }
    @considered_positions = []

  end


  def new_move_positions(pos)
    valids = KnightPathFinder.valid_moves(pos)
    @considered_positions << pos
    valids.reject{ |pos| @considered_positions.include?(pos) }
    @considered_positions += valids
    return valids
  end

  # def render
  #   print " "
  #   (0..7).each do |col|
  #     print col.to_s + " "
  #   end
  #   puts

  #   (0..7).each do |row|
  #     print row.to_s + " "
  #     (0...@board.length).each do |row|
        
  #     end

  #     puts
  #   end

  # end

  def render
    print "  "
    (0..7).each do |col|
      print col.to_s + " "
    end
    puts

    @board.each.with_index do |row, i|
      puts i.to_s + " " + row.join(" ")
    end
  end
  
  
  def build_move_tree(target_position) 
    root_node = PolyTreeNode.new(self.pos) 
    queue = [root_node]
    until queue.empty?
      curr_node = queue.shift
      if curr_node.value == target_position
        self.render
        return KnightPathFinder.get_path(curr_node)
      else
        # debugger
        possible_moves = new_move_positions(curr_node.value) #
        possible_moves.each{ |move| curr_node.add_child(PolyTreeNode.new(move)) }
        curr_node.children.each { |child| queue << child }


      end
    end
    queue
  end

  private
  def self.valid?(pos)
    pos.all? { |i| i >= 0 && i < 8 }
  end

end