include("functions.jl")
""" 8. ДАНО: Где-то на неограниченном со всех сторон поле без внутренних 
перегородок имеется единственный маркер. Робот - в произвольной клетке этого 
поля.
РЕЗУЛЬТАТ: Робот - в клетке с маркером"""

function number_8(r)
    n = 1
    side = Ost
    flag = true
    while flag
        for i in 1:2
            for i in 1:n
                if !ismarker(r)
                    move!(r, side)
                else flag = false
                    break
                end
            end
            if !flag break end
            side = right(side)
        end
        n += 1
    end
end
