include("functions.jl")
""". ДАНО: Робот - в произвольной клетке ограниченного прямоугольного 
поля
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля 
промаркированы """

function number_3(r) #не оч обобщенно
    back_path = move_to_angle(r)
    side = Nord
    while true
        along_mark(r, side)
        if !try_move!(r, Ost)
            break
        end
        side = inverse(side)
    end
    move_to_back(r, back_path)
end
