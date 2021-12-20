extends Node2D

var tick = 0
var Cell = preload("res://Cell.tscn")

var cell_size := 40
var grid_size: Vector2

var cells: Dictionary

func _init():
    var size = Vector2(1920, 1080)
    grid_size.x = size.x / cell_size
    grid_size.y = size.y / cell_size
    print(grid_size)
    
    for y in range(0, grid_size.y):
        for x in range(0, grid_size.x):
            var cell = Cell.instance()
            cells[Vector2(x,y)] = cell
            
            cell.rect_position = Vector2(
                x * cell_size,
                y * cell_size
            )
            add_child(cell)
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    tick += delta
    
    for cell in cells.values():
        cell.update() 
            
    if tick > 1:
        tick -= 1
        print("tick")
    
func _input(event):
    if event is InputEventMouseButton:
        if event.pressed:
            print("Mouse click at: ", event.position)
            var cell_position = Vector2(
                int(event.position.x / cell_size),
                int(event.position.y / cell_size)
            )
            
            cells[cell_position].toggleState()
            
            
    
