include("functions.jl")
"""7. ДАНО: Робот - рядом с горизонтальной бесконечно продолжающейся в 
обе стороны перегородкой (под ней), в которой имеется проход шириной в одну 
клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом """


function number_7(r)
    n = 1
    side = Ost
    while isborder(r, Nord)
        along(r, side, n)
        side = inverse(side)
        n += 1
    end
end