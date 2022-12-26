include("functions.jl")
"""17. Решить задачу 8 с использованием обобщённой функции 
spiral!(stop_condition::Function, robot) 
п.с.  8. ДАНО: Где-то на неограниченном со всех сторон поле без внутренних 
перегородок имеется единственный маркер. Робот - в произвольной клетке этого 
поля.
РЕЗУЛЬТАТ: Робот - в клетке с маркером
"""

function stop_condition(r)
    if ismarker(r)
        return true
    end
    return false
end

function number_17(r)
    spriral!(() -> stop_condition(r), r, Nord)
end
