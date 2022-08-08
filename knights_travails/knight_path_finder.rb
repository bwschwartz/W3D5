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

  attr_reader :pos, :considered_positions
  attr_writer :root_node

  def initialize(pos)
    @pos = pos
    # @board = Array.new(8) { Array.new(8, '_') }
    @board = KnightPathFinder.initialize_board
    @considered_positions = [pos]
    @root_node = PolyTreeNode.new(self.pos)
  end

  def self.initialize_board
    board = Array.new(8) { Array.new(8, '_') }
    for i in (0...8)
      for j in (0...8)
        board[i][j] = '■' if i.even? && j.even?
        board[i][j] = '□' if i.odd? && j.even?
        board[i][j] = '■' if  i.odd? && j.odd?
        board[i][j] = '□' if i.even? && j.odd?
      end
    end
    board

  end

  def new_move_positions(pos)
    valids = KnightPathFinder.valid_moves(pos)
    valids.reject!{ |pos| @considered_positions.include?(pos) }
    @considered_positions += valids
    valids
  end

  def render_path(path_list, destination)
    path_list.each.with_index { |pos, i| @board[pos[0]][pos[1]] = i+1 }
    @board[destination[0]][destination[1]] = "X"

    print "  "
    (0..7).each do |col|
      print col.to_s + " "
    end
    puts

    @board.each.with_index do |row, i|
      puts i.to_s + " " + row.join(" ")
    end
  end

  def get_path(target_position)

    queue = [@root_node]
    until queue.empty?
      curr_node = queue.shift
      if curr_node.value == target_position
        self.render_path(KnightPathFinder.get_path(curr_node), target_position)
        return KnightPathFinder.get_path(curr_node)
      else
        curr_node.children.each { |child| queue << child}
      end
    end
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      curr_node = queue.shift
      possible_moves = new_move_positions(curr_node.value)
      possible_moves.each{ |move| curr_node.add_child(PolyTreeNode.new(move))}
      curr_node.children.each { |child| queue << child }
    end
  end

  private
  def self.valid?(pos)
    pos.all? { |i| i >= 0 && i < 8 }
  end

end