include("functions.jl")
"""26. Написать функцию, маркирующую все клетки лабиринта произвольной 
формы, ограниченного перегородками, и возвращающую робота в исходное 
положение. """

function number_26(r)
    if !ismarker(r)
        putmarker!(r)
        for side in (Nord, West, Sud, Ost)
            try_move!(r, side)
            number_26(r)
            try_move!(r, inverse(side))
        end
    end
end         
