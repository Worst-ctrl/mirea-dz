include("functions.jl")
"""
11. ДАНО: Робот - в произвольной клетке ограниченного прямоугольного 
поля, на поле расставлены горизонтальные перегородки различной длины 
(перегородки длиной в несколько клеток, считаются одной перегородкой), не 
касающиеся внешней рамки.
РЕЗУЛЬТАТ: Робот — в исходном положении, подсчитано и возвращено 
число всех перегородок на поле.
12. Отличается от предыдущей задачи тем, что если в перегородке имеются 
разрывы не более одной клетки каждый, то такая перегородка считается одной 
перегородкой.
 """

 function number_12(r, side) 
    ans = 0
    while !isborder(r, Nord)
        ans += num_borders2!(r, side)
        side = inverse(side)
        move!(r, Nord)
    end
    return ans
end
