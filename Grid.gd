extends Node2D

var Cell = preload("res://Cell.tscn")

var cell_size := 40
var grid_size: Vector2

# Stores the Cell objects, indexed by a Vector2 position
var cells: Dictionary

# Stores cell state updates to be made on the next update pass,
# indexed by a Vector2 position
var cellUpdates: Dictionary

func _init():
    # Find how many cells can fit the screen size
    var size = Vector2(1920, 1080)
    grid_size.x = size.x / cell_size
    grid_size.y = size.y / cell_size
    print(grid_size)
    
    for y in range(0, grid_size.y):
        for x in range(0, grid_size.x):
            var cell = Cell.instance()
            var position = Vector2(x,y)
            
            cells[position] = cell
            cell.position = position
            cellUpdates[position] = cell.state
            
            cell.rect_position = Vector2(
                x * cell_size,
                y * cell_size
            )
            add_child(cell)
    
func _input(event):
    if event is InputEventMouseButton:
        if event.pressed:
            # print("Mouse click at: ", event.position)
            var cell_position = Vector2(
                int(event.position.x / cell_size),
                int(event.position.y / cell_size)
            )
            
            var cell = cells[cell_position]
            var nextState = cell.toggledState()
            cellUpdates[cell_position] = nextState
            updateVisuals()
            
func updateState():
    # Find number of neighbors and set next state       
    for key in cells:
        var livingNeighborCount: int = findLivingNeighborsCount(key)
        var cell: Cell = cells[key]
        cell.neighborCount = livingNeighborCount

        if livingNeighborCount < 2:
            cellUpdates[key] = Global.CellState.DEAD
            
        if livingNeighborCount == 3:
            cellUpdates[key] = Global.CellState.ALIVE
            
        if livingNeighborCount > 3:
            cellUpdates[key] = Global.CellState.DEAD
                    
func updateVisuals():    
    for key in cellUpdates.keys():
        var nextState = cellUpdates[key]
        var cell: Cell = cells[key]
        cell.state = nextState
        cell.update() 

func _on_Main_update():
    updateState()
    updateVisuals()
    
func findLivingNeighborsCount(position: Vector2):
    var neighborPositions = [
        Vector2(position.x - 1, position.y - 1),
        Vector2(position.x, position.y - 1),
        Vector2(position.x + 1, position.y - 1),
        Vector2(position.x - 1, position.y),
        Vector2(position.x + 1, position.y),
        Vector2(position.x - 1, position.y + 1),
        Vector2(position.x, position.y + 1),
        Vector2(position.x + 1, position.y + 1)
    ]
    
    var livingNeighborCount = 0
    
    for neighborPosition in neighborPositions:
        if cells.has(neighborPosition):    
            var neighborCell: Cell = cells[neighborPosition]
            if neighborCell.state == Global.CellState.ALIVE:
                livingNeighborCount += 1
              
    return livingNeighborCount
        
