require 'rubygems'
require 'Gosu'

class Cell
  attr_accessor :living,:neighbors
  
  def initialize(living,neighbors = 0)
    @living = living
    @neighbors = neighbors
  end
  def kill
    @living = false
  end
  def spawn
    @living = true
  end

end
