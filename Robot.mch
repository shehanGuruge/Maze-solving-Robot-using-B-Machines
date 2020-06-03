/* Robot
 * Author: shehan
 * Creation date: 12/4/2019
 */
MACHINE Robot
SEES Maze
    
    DEFINITIONS 
        isBlocked(coordinates) == (coordinates : maze & coordinates : maze_walls);
        isInsideMaze(coordinates) == (coordinates : maze);
        isDuplicate(x_coordinate,y_coordinate) == (x_coordinate : NAT1 & y_coordinate: NAT1 & 
            card(route |> {x_coordinate |-> y_coordinate}) > 1)
     
    VARIABLES 
        x_location, y_location, route 
        
    INVARIANT 
        x_location : NAT1 & y_location : NAT1 & route : seq(maze)
        
    INITIALISATION 
        x_location, y_location, route := prj1(NAT1,NAT1)(entry_cell) , prj2(NAT1,NAT1)(entry_cell),
        [entry_cell]

    OPERATIONS
        
        // This operation is responsible for moving the robot in the north direction by checking 
        // the coordinates against boundary and maze wall coordinates and printing the result
        result <-- moveNorth = 
        BEGIN
            IF (isBlocked(x_location |-> y_location + 1))
            THEN 
                result := MAZEWALL_IN_NORTH
            ELSIF isInsideMaze(x_location |-> y_location + 1)
            THEN 
                y_location := y_location + 1 ||
                route := route <- (x_location |-> y_location + 1) ||
                result := MOVE_NORTH_SUCCESS
            ELSE        
                result := BOUNDARY_IN_NORTH 
            END
        END;
        
        // This operation is responsible for moving the robot in the south direction by checking 
        // the coordinates against boundary and maze wall coordinates and printing the result
        result <-- moveSouth = 
        BEGIN
            IF (isBlocked(x_location |-> y_location - 1))
            THEN 
                result := MAZEWALL_IN_SOUTH
            ELSIF (isInsideMaze(x_location |-> y_location - 1))
            THEN         
                y_location := y_location - 1 ||
                route := route <- (x_location |-> y_location - 1) ||
                result := MOVE_SOUTH_SUCCESS 
            ELSE
                result := BOUNDARY_IN_SOUTH  
            END
        END;
        
        // This operation is responsible for moving the robot in the east direction by checking 
        // the coordinates against boundary and maze wall coordinates and printing the result
        result <-- moveEast = 
        BEGIN
            IF (isBlocked(x_location + 1 |-> y_location))
            THEN 
                result := MAZEWALL_IN_EAST
            ELSIF (isInsideMaze(x_location + 1 |-> y_location))
            THEN       
                x_location  := x_location + 1 ||
                route := route <- (x_location + 1 |-> y_location) ||
                result := MOVE_EAST_SUCCESS   
            ELSE 
                result := BOUNDARY_IN_EAST 
            END
        END;
        
        // This operation is responsible for moving the robot in the west direction by checking 
        // the coordinates against boundary and maze wall coordinates and printing the result
        result <-- moveWest = 
        BEGIN
            IF (isBlocked(x_location - 1 |-> y_location))
            THEN 
                result := MAZEWALL_IN_WEST
            ELSIF (isInsideMaze(x_location - 1 |-> y_location))
            THEN 
                x_location  := x_location - 1 ||
                route := route <- (x_location - 1 |-> y_location) ||
                result := MOVE_WEST_SUCCESS  
            ELSE  
                result := BOUNDARY_IN_WEST 
            END
        END;
        
        // teleports the robot to a specific location and prints the result whether movement is 
        // is success or not(reason for the movement failure)
        result <-- teleport(x_coordinate,y_coordinate) =
        PRE x_coordinate : NAT1 & y_coordinate : NAT1
        THEN
            IF isInsideMaze(x_coordinate |-> y_coordinate)
            THEN
                IF(x_coordinate = x_location & y_coordinate = y_location)
                THEN
                    result := TELEPORT_FAILED_ALREADY_IN_THE_SAME_CELL
                ELSE
                    
                    IF((x_coordinate |-> y_coordinate) = exit_cell)
                    THEN 
                        result := CANNOT_GO_DIRECTLY_TO_EXIT   
                    ELSIF (isBlocked(x_coordinate |-> y_coordinate))
                    THEN
                        result := TELEPORT_FAILED_MAZEWALL
                    ELSIF ((x_coordinate |-> y_coordinate) : maze)
                    THEN
                        x_location := x_coordinate ||
                        y_location := y_coordinate ||
                        route := route <- (x_coordinate |-> y_coordinate)||
                        result := TELEPORT_SUCCESS
                    END
                END
            ELSE
                 result := FAILED_OUTSIDE_MAZE
           END
        END;
        
        // get the current position of the robot in the maze
        result <-- getPosition =
        BEGIN 
          IF(size(route) > 0)
          THEN
              result := last(route)
          ELSE
              result := (1 |-> 1)
          END
        END;
        
        
        // prints out whether the robot has visited the exit cell in the maze or not
        answer <-- foundExit =
        BEGIN
            IF (x_location |-> y_location) = exit_cell
            THEN answer := YES
            ELSE answer := NO
            END
        END;
        
        
        // checks whether the particular square is visited or not by the robot in the maze
        answer <-- visitedSquare (square_X, square_Y) =
        PRE square_X : NAT1 & square_Y : NAT1
        THEN
            IF(isBlocked(square_X |-> square_Y))
            THEN
                answer := FAILED_MAZEWALL
            ELSIF (isInsideMaze(square_X |-> square_Y))
            THEN 
                IF((square_X |-> square_Y) : ran(route) & last(route) /= (square_X |-> square_Y) 
                    & isDuplicate(square_X,square_Y))
                THEN
                 
                    answer := YES
                ELSE 
                    answer := NO
                END
            ELSE
                answer := FAILED_OUTSIDE_MAZE
            END
        END;
        
        
        // prints out the route of the robots movement in the maze
        path <-- robotsRoute = 
        BEGIN
            path := route
        END
END
