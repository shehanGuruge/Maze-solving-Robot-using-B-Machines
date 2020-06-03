/* Maze
 * Author: shehan
 * Creation date: 12/4/2019
 */
MACHINE Maze
    
SETS 
   MESSAGE = {MAZEWALL_IN_NORTH, MOVE_NORTH_SUCCESS , BOUNDARY_IN_NORTH,
           MAZEWALL_IN_SOUTH, MOVE_SOUTH_SUCCESS , BOUNDARY_IN_SOUTH,
           MAZEWALL_IN_WEST, MOVE_WEST_SUCCESS , BOUNDARY_IN_WEST,
           MAZEWALL_IN_EAST, MOVE_EAST_SUCCESS , BOUNDARY_IN_EAST,
           TELEPORT_FAILED_MAZEWALL, TELEPORT_FAILED_BOUNDARY, TELEPORT_SUCCESS, 
           FAILED_OUTSIDE_MAZE, CANNOT_GO_DIRECTLY_TO_EXIT, YES , NO, FAILED_MAZEWALL, 
           FAILED_BOUNDARY, TELEPORT_FAILED_ALREADY_IN_THE_SAME_CELL }
               
CONSTANTS 
    maze, MAZE_WIDTH , MAZE_HEIGHT , maze_walls , exit_cell, entry_cell
    
PROPERTIES
    MAZE_WIDTH : NATURAL1 &
    MAZE_HEIGHT : NATURAL1 &
    MAZE_WIDTH = 7 &
    MAZE_HEIGHT = 5 &
    maze : NATURAL1 <-> NATURAL1 &
    maze = (1..MAZE_WIDTH) * (1..MAZE_HEIGHT) &
    maze_walls <: maze &
    maze_walls = {(1 |-> 3), (2 |-> 1), ( 2 |-> 3), ( 2 |-> 5), ( 3 |-> 3) , ( 4 |-> 2), ( 4 |-> 3),
    ( 4 |-> 4), ( 6 |-> 1), ( 6 |-> 2), ( 6 |-> 4), ( 7 |-> 4)} &
    exit_cell : maze & exit_cell = (1 |-> 5) &
    entry_cell : maze & entry_cell = (1 |-> 1)

END
