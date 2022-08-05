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



  def initialize(pos)
    @pos = pos
    @board = Array.new(8) { Array.new(8) }

  end

  def get_position

  end

  private
  def self.valid?(pos)
    pos.all? { |i| i >= 0 && i < 8 }
  end
end