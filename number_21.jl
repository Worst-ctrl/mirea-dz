include("functions.jl")
"""21. Написать рекурсивную функцию, перемещающую робота в соседнюю 
клетку в заданном направлении, при этом на пути робота может находиться 
изолированная прямолинейная перегородка конечной длины. """

function step!(r, side) #!!! 21 задача!!!
    if !isborder(r, side)
        move!(r, side)
    else
        move!(r, right(side))
        step!(r, side)
        move!(r, left(side))
    end
end