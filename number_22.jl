include("functions.jl")
"""22. Написать рекурсивную функцию, перемещающую робота на расстояние 
вдвое большее исходного расстояния от перегородки, находящейся с заданного 
направления (предполагается, что размеры поля позволяют это сделать). """

function number_22(r, side)
    if !isborder(r, side)
        move!(r, side)
        number_22(r, side)
        try_move!(r, inverse(side))
        try_move!(r, inverse(side))
    end
end
