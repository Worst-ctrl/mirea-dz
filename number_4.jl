include("functions.jl")
"""4. ДАНО: Робот находится в произвольной клетке ограниченного 
прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре косого креста из 
маркеров, расставленных вплоть до внешней рамки. """

function number_4(r)
    side1, side2 = Nord, Ost
    for i in 1:2
        for j in 1:2
            diag_it(r, inverse(side1), inverse(side2), diag_mark(r, side1, side2))
            side2 = inverse(side2)
        end
    side1 = inverse(side1)
    end
end
