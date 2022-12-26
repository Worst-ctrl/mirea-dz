include("functions.jl")
"""20. Написать рекурсивную функцию, перемещающую робота до упора в 
заданном направлении, ставящую возле перегородки маркер и возвращающую 
робота в исходное положение.
 """
 function mark_lim(r, side) #!!! 20 задача!!!
    if isborder(r, side)
         putmarker!(r)
    else
         move!(r, side)
         mark_lim(r, side)
         move!(r, inverse(side))
    end
 end
 