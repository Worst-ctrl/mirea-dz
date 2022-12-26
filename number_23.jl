include("functions.jl")
"""23. Написать рекурсивную функцию, перемещающую робота в позицию, 
симметричную по отношению к перегородке, находящейся с заданного 
направления, т.е. требуется, чтобы в результате робот оказался на расстоянии от 
противоположной перегородки равном расстоянию до заданной перегородки. """

function number_23(r, side)
    if isborder(r, side)
        tolim(r, inverse(side))
    else
        move!(r, side)
        number_23(r, side)
        move!(r, side)
    end
end
