require 'rubygems'
require 'gosu'
require '~/ruby_sandbox/life/Grid.rb'
class GameWindow < Gosu::Window
  def initialize
    super 600,600,false
    self.caption = "The Game Of Life"
    @grid = Grid.new(12,12)
    initial_list =[] # if you want to harwire in specific cells
    @grid.makeLiving(initial_list)
    @grid.setNeighbors
    @interval = 30
    @interval_counter = 0
    @start = 0
    

    @live_image = Gosu::Image.new(self,"livingCell.png",true)
    @dead_image = Gosu::Image.new(self,"deadCell.png",true)
  end

  def update
    if @start == 1
      if @interval_counter % @interval == 0
        @grid.updateAll
        @grid.setNeighbors
      end
      @interval_counter+=1
    else # the game hasn't started yet
      if button_down?(Gosu::MsLeft)
        click_cell(mouse_x.to_int / 50,mouse_y.to_int / 50)
      end
      if button_down?(Gosu::KbReturn)
        @start = 1
      end

    end
  end

  def needs_cursor?
    return true
  end

  def draw
    for r in 0...12
      for c in 0...12
        drawCell(r,c)
      end
    end
  end
  def click_cell(x,y)
    @grid.getCell(x,y).spawn
    @grid.setNeighbors
  end

  def drawCell(row,col)
    if @grid.getCell(row,col).living
      @live_image.draw(row * 50,col*50,0)
    else
      @dead_image.draw(row * 50,col *50,0)
    end
  end



end # end class
window = GameWindow.new
window.show
