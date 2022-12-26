include("functions.jl")
"""9. ДАНО: Робот - в произвольной клетке ограниченного прямоугольного 
поля (без внутренних перегородок)
РЕЗУЛЬТАТ: Робот - в исходном положении, на всем поле расставлены 
маркеры в шахматном порядке, причем так, чтобы в клетке с роботом находился 
маркер """

function number_9(r)
    back_path = move_to_angle(r)
    side = Nord
    s = true
    while true
        along_mark(r, side, 2, s)
        if ismarker(r)
            s = false
        else s = true
        end
        if !try_move!(r, Ost)
            break
        end
        side = inverse(side)
    end
    move_to_back(r, back_path)
end
