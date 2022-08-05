class KnightPathFinder

  def self.valid_moves(pos)
    available_pos = []
    new_pos = pos +
  end



  def initialize(pos)
    @pos = pos
    @board = Array.new(8) { Array.new(8) }

  end

  def get_position

  end

  private
  def within_bounds(pos)
    pos.each { |i| i <=0 && i }
  end
end