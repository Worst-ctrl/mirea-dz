include("functions.jl")

"""1. ДАНО: Робот находится в произвольной клетке ограниченного 
прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из 
маркеров, расставленных вплоть до внешней рамки."""

function number_1(r)
    side = Ost
   for i in 1:4
        numsteps_along(r, inverse(side), num_steps_mark_along(r, side))
        side = right(side)
   end
end