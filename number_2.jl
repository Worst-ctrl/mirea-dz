include("functions.jl")
""" 2. ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок 
и маркеров)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру 
внешней рамки промаркированы"""

function number_2(r)
    side = Nord
    back_path =  move_to_angle(r)
    for i in 0:5
        side = right(side)
        along_mark(r, side)
    end
    move_to_back(r, back_path)
end