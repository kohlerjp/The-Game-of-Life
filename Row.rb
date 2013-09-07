require '~/ruby_sandbox/life/Cell.rb'

# A Row is a list of cells
class Row
  attr_accessor :cells

  #Creates array of given size, All filled with Non-Living Cells
  def initialize(size)
    @cells = []
    for i in 1..size
      new_cell = Cell.new(false)
      @cells << new_cell
    end # end cell initialization loop

  end # end initialization

end # end class

