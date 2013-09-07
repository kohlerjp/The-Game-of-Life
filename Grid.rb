require '~/ruby_sandbox/life/Row.rb'
require '~/ruby_sandbox/life/Cell.rb'
require 'gosu'
# A Grid is just a list of rows
class Grid
  attr_accessor :rows
  attr_reader :num_rows,:numcolumns

  # To initialize a grid, you need the number of rows
  # and the number of columns
  def initialize(num_rows,num_columns)
    @num_rows = num_rows
    @num_columns = num_columns
    @rows = []
    for x in  1..num_rows
      fresh_row = Row.new(num_columns)
      @rows << fresh_row
    end
  end # end initialize

  # This will get the cell at the given 
  # Row and Column
  def getCell(row,col)
    the_row = @rows[row]
    the_cell = the_row.cells[col]
    return the_cell
  end

  # This method will take in an array of two member array,
  # each representing a point on the grid
  def makeLiving(points)
    points.map do |p|
      getCell(p[0],p[1]).spawn
    end
  end

  # Will return the number of neighbors above given cell point
  def neighAbove(cur_row,cur_col)
    if cur_row == 0
      return 0
    else
      neighbor_cell = getCell(cur_row-1,cur_col)
      if(neighbor_cell.living == true)
        return 1
      else
        return 0
      end
    end # end if statement

  end # end method

  # Will return the number of neighbors below given cell point
  def neighBelow(cur_row,cur_col)
    if cur_row == @num_rows - 1
      return 0
    else
      neighbor_cell = getCell(cur_row+1,cur_col)
      if(neighbor_cell.living == true)
        return 1
      else
        return 0
      end
    end # end if statement

  end # end method

  # Will return the number of neighbors left of a given cell point
  def neighLeft(cur_row,cur_col)
    if cur_col == 0
      return 0
    else
      neighbor_cell = getCell(cur_row,cur_col - 1)
      if(neighbor_cell.living == true)
        return 1
      else
        return 0
      end
    end # end if statement

  end # end method

  # Will return the number of neighbors right of a given cell point
  def neighRight(cur_row,cur_col)
    if cur_col == @num_columns - 1
      return 0
    else
      neighbor_cell = getCell(cur_row,cur_col+1)
      if(neighbor_cell.living == true)
        return 1
      else
        return 0
      end
    end # end if statement
  end # end method

  # Will return the number of neighbors left of a given cell point
  def neighUpLeft(cur_row,cur_col)
    if cur_col == 0 || cur_row == 0
      return 0
    else
      neighbor_cell = getCell(cur_row - 1,cur_col - 1)
      if(neighbor_cell.living == true)
        return 1
      else
        return 0
      end
    end # end if statement

  end # end method

  def neighUpRight(cur_row,cur_col)
    if cur_col == @num_columns - 1 || cur_row == 0
      return 0
    else
      neighbor_cell = getCell(cur_row - 1,cur_col + 1)
      if(neighbor_cell.living == true)
        return 1
      else
        return 0
      end
    end # end if statement

  end # end method


  def neighDownLeft(cur_row,cur_col)
    if cur_col == 0 || cur_row == @num_rows - 1
      return 0
    else
      neighbor_cell = getCell(cur_row + 1,cur_col - 1)
      if(neighbor_cell.living == true)
        return 1
      else
        return 0
      end
    end # end if statement

  end # end method

  def neighDownRight(cur_row,cur_col)
    if cur_col == @num_columns - 1 || cur_row == @num_rows - 1
      return 0
    else
      neighbor_cell = getCell(cur_row + 1,cur_col + 1)
      if(neighbor_cell.living == true)
        return 1
      else
        return 0
      end
    end # end if statement

  end # end method

  def totalNeighbors(cur_row,cur_col)
    r = cur_row
    c = cur_col
    regFour = neighAbove(r,c) + neighBelow(r,c) + neighLeft(r,c) + neighRight(r,c)
    diagFour = neighUpLeft(r,c) + neighUpRight(r,c) + neighDownLeft(r,c) + neighDownRight(r,c)
    return diagFour + regFour
  end

  def setNeighbors
    for r in 0...@num_rows
      for c in 0...@num_columns
        cur_cell = getCell(r,c)
        cur_cell.neighbors = totalNeighbors(r,c)
      end # end column loop
    end # end row loop
  end

  #creates a deep copy of this grid
  def dup
    gridcpy = Grid.new(@num_rows,@num_columns)
    for r in 0...@num_rows
      for c in 0...@num_columns
        cur_cell = self.getCell(r,c)
        gridcpy.getCell(r,c).living = cur_cell.living
        gridcpy.getCell(r,c).neighbors = cur_cell.neighbors   
      end # end col loop
    end # end row loop
    return gridcpy
  end # end dup

  #determines the fate of a single cell
  #returns 1 if it will spawn,-1 if it will die
  #and 0 if it will survive
  #Does not change state of cell
  def fate(cell)
    if cell.living 
      if cell.neighbors < 2
        return -1
      elsif cell.neighbors == 2 || cell.neighbors == 3
        return 0
      else
        return -1
      end
    else # cell is not living
        if cell.neighbors == 3
          return 1
        else
          return -1
        end 
    end
  end # end method

  def updateAll
    cpy = self.dup
    for r in 0...@num_rows
      for c in 0...@num_columns
        cell_fate = cpy.fate(cpy.getCell(r,c))
        if cell_fate == 1
          self.getCell(r,c).spawn
        elsif cell_fate == -1
          self.getCell(r,c).kill
        end # end if statement

      end # end column loop
    end # end row loop
    
  end # end updateAll
  def printGrid
    for r in 0...@num_rows
      for c in 0...@num_columns
        cur_cell = self.getCell(r,c)
        if cur_cell.living
          print "X\t"
        else
          print "0\t"
        end
      end # end column loop
      puts ""
    end # end row loop
  end

end # end Grid Class













