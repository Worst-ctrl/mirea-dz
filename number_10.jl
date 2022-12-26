include("functions.jl")
"""10. ДАНО: Робот - в произвольной клетке ограниченного прямоугольного 
поля (без внутренних перегородок)
РЕЗУЛЬТАТ: Робот - в исходном положении, и на всем поле расставлены 
маркеры в шахматном порядке клетками размера N*N (N-параметр функции), 
начиная с юго-западного угла """

function number_10(r, n) #!!!не работаеt!!!!
    back_path = move_to_angle(r)
    h, w = know_border(r)
    if h%n == 0
        num_rows = h // n
    else
        num_rows = (h // n) + 1
    end
    side = Ost
    for _ in 1:num_rows
        while !isborder(r, side) 
            flag = true
            square(r, n, side)
            while ismarker(r)
                if !try_move!(r, Sud)
                    flag = false
                    break
                end
            end
            if flag
                move!(r, Nord) #т.к. в цикле while ismarker всегда делает 1 лишний шаг
            end
            along(r, side, n+1)
        end
        side = inverse(side)
        along(r, Nord, n)
    end
    move_to_back(r, back_path)
end