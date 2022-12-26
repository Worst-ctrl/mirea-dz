include("functions.jl")
"""19. Написать рекурсивную функцию, перемещающую робота до упора в 
заданном направлении. """

function tolim(r, side) # !!! 19 задача !!!! идет до упора, но через рекурсию
    if !isborder(r, side)
        move!(r, side)
        tolim(r, side)
    end
end
