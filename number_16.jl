include("functions.jl")
""" 
Решить задачу 7 с использованием обобщённой функции 
shuttle!(stop_condition::Function, robot, side)

7. ДАНО: Робот - рядом с горизонтальной бесконечно продолжающейся в 
обе стороны перегородкой (под ней), в которой имеется проход шириной в одну 
клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом 
"""

function stop_condition(r)
    if !isborder(r, Nord)
        return true
    end
    return false
end

function number_16(r)
    n = 1
    side = Ost
    shuttle!(() -> stop_condition(r), r, side)
end