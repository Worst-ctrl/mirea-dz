include("functions.jl")
"""29. Написать функцию, расставляющие маркеры в каждой клетке внутри 
произвольного замкнутого лабиринта, ограниченного 
а) маркерами,
б) перегородками,
и возвращающую робота в исходное положение """

function number_29_a(r)
    if !ismarker(r)
        putmarker!(r)
        for side in (Nord, West, Sud, Ost)
            try_move!(r, side)
            number_29_a(r)
            try_move!(r, inverse(side))
        end
    end
end         

function number_29_b(r)
    if !ismarker(r)
        putmarker!(r)
        for side in (Nord, West, Sud, Ost)
            move!(r, side)
            number_29_b(r)
            move!(r, inverse(side))
        end
    end
end         

