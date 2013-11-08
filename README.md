The Game Of Life
=========
The game of life was a simulation proposed by John Conway. A set of rules determine if a cell will live, die during
each round.

Rules
--------
1. Any live cell with fewer than two live neighbours dies, as if caused by under-population.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overcrowding.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

Implementation
--------
This program was written in ruby and uses the Gosu ruby gem for the user interface.
I have also written the same program in JavaScript and a demo can be seen [here](http://www.johnpatrickkohler.com/life.html)
