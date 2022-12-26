include("functions.jl")
""" 24. Написать рекурсивную функцию, перемещающую робота на расстояние 
от перегородки с заданного направления вдвое меньшее исходного."""


function pause(r, side)   # условная пауза для 24 (задача 24 - пример использования косвенной рекурсии)
    if !isborder(r, side) 
        move!(r, side) 
        number_24(r, side)
    end
end


function number_24(r, side)  
    if !isborder(r, side)
        move!(r, side)
        pause(r, side)
        move!(r, inverse(side))
    end
end