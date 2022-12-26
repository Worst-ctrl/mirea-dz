

function along(r, side):: Nothing #идти до упорa
    while !isborder(r, side)
        try_move!(r, side)
    end
end

function along_mark(r, side)::Nothing #идти до упора + поставить маркеры
    putmarker!(r)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end
end

function along_mark(r, side, n) #идти определенное число шагов(n - 1) + поставить маркеры (маркеров будет n штук)
    putmarker!(r)
    flag = true
    for i in 1:n-1
        flag = try_move!(r, side)
        putmarker!(r)
        if !flag
            return flag
        end
    end
    return flag
end



function along_mark(r, side, n, s)::Nothing #идет до упора + ставит маркеры с промежутком n-1 + если s == true начинает ставить маркер со своего местоположения
    k = 1
    if s
        putmarker!(r)
    else k = n
    end
    while !isborder(r, side)
        move!(r, side)
        if k % n == 0
            putmarker!(r)
        end
        k += 1
    end
end


function snake(r, side) #движется змейкой, если движение прекратиталось заранее, то возвращает side
    flag = true
    h, w = know_border(r)
    while true
        if num_steps_along(r, side) + 1 < h
            flag = false
            break
        end
        if !try_move!(r, Ost)
            break
        end
        side = inverse(side)
    end
    if !flag
        return side
    end
end



function know_border(r) #узнаем высоту и ширину поля
    back_path = move_to_angle(r)
    h = num_steps_along(r, Nord) + 1
    w = num_steps_along(r, Ost) + 1
    #move_to_back(r, back_path)
    move_to_angle(r)
    return h, w
end


function square(r, n, side) # рисует квадрат со стороной n (робот находится в левом нижнем углу) и начинает в сторону side
    for i in 1:n
        flag = along_mark(r, side, n)
        if !try_move!(r, Nord)
            break
        end
        side = inverse(side)
        if !flag
            move!(r, Sud)
            while ismarker(r)
                move!(r, side)
            end
            move!(r, Nord)
            side = inverse(side)
            move!(r, side)
        end
    end
    move!(r, Sud)
end

function obhod(r, side1) #обходит внутреннюю прямоугольную перегородку; side - сторона, где находится "прямоугольник"
    if side1 == Nord
        side2 = Ost
        flag = false
    else
        side2 = West
        flag = true
    end
    for i in 0:4
        while isborder(r, side1)
            putmarker!(r)
            move!(r, side2)
        end
        side1, side2 = right(side1), right(side2)
        putmarker!(r)
        move!(r, side2)
    end
end


function along(r, side, num_steps)::Nothing #пройти определенное число шагов
    for i in 1:num_steps
        try_move!(r, side)
    end
end

function num_steps_along(r, side):: Int #идти до упора + вернуть кол-во шагов
    num_steps = 0
    while !isborder(r, side)
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

try_move!(r, side) = (!isborder(r, side) && (move!(r, side); return true); false)

function numsteps_along(r, side, max_num_steps)::Int #нужноe кол-во шагов (или до упора, если расстояние меньше, чем кол-во треб. шагов)
    num_steps = 0 # будет == 0, при это тип данных будет совпадать с max_num_steps
    while (num_steps != max_num_steps && try_move!(r, side))
        num_steps += 1
    end
    return num_steps
end

function num_steps_mark_along(r, side):: Int #идти до упора + вернуть кол-во шагов + поставить везде маркеры
    num_steps = 0
    putmarker!(r)
    while !isborder(r, side)
        move!(r, side)
        num_steps += 1
        putmarker!(r)
    end
    return num_steps 
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) #возвращает противоположную сторону

right(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4)) #возвращает следующую сторону ПО часовой стрелки

left(side::HorizonSide) = HorizonSide(mod(Int(side)-1, 4)) #возвращает следующую сторону ПРОТИВ часовой стрелки

function diag_mark(r, side1, side2) #движение ДО УПОРА по диагонали с маркерами + возвращает количество повторов
    putmarker!(r)
    it = 0
    while (!isborder(r, side1) && !isborder(r, side2))
        try_move(r, side1) 
        try_move(r, side2)
        putmarker!(r)
        it += 1
    end
    return it
end
 
function diag_it(r, side1, side2, it)
    for i in 1:it
        try_move(r, side1)
        try_move(r, side2)
    end
end
    
function move_to_angle(r) #передвигает робота в левый нижний угол
    return (side = Nord, num_steps = num_steps_along(r, Sud)), (side = Ost, num_steps = num_steps_along(r, West)), (side = Nord, num_steps = num_steps_along(r, Sud))
end

function move_to_back(r, back_path) #возвращает робота обратно (использовать из левого нижнего угла!!!)
    s = 0
    for next in back_path
        along(r, next.side, next.num_steps)
        s += next.num_steps
    end
    if s == 0
        move_to_angle(r)
    end
end

function num_borders!(r, side) #количество перегородок НАД этим рядом
    state = 0
    num_borders = 0
    while try_move!(r, side)
        if state == 0
            if isborder(r, Nord)
                state = 1
            end
        else
            if !isborder(r, Nord)
                state = 0
                num_borders += 1
            end
        end
    end
    return num_borders
end

function num_borders2!(r, side) #количество перегородок НАД этим рядом, но в перегородке может быть пробел
    state = 0
    num_borders = 0
    while try_move!(r, side)
        if state == 0
            if isborder(r, Nord)
                state = 1
            end
        elseif state == 1
            if !isborder(r, Nord)
                state = 2
            end
        else
            if !isborder(r, Nord)
                state = 0
                num_borders += 1
            end
        end
    end
    return num_borders
end

function number_1(r)
    side = Ost
   for i in 1:4
        numsteps_along(r, inverse(side), num_steps_mark_along(r, side))
        side = right(side)
   end
end

function number_2(r)
    side = Sud
    back_path =  move_to_angle(r)
    for i in 1:4
        side = left(side)
        along_mark(r, side)
    end
    numsteps_along(r, West, back_path[2])
    numsteps_along(r, Nord, back_path[1])
end

function number_3(r) #не оч обобщенно
    side = Sud
    back_path = move_to_angle(r)
    side = Nord
    while true
        along_mark(r, side)
        if !try_move!(r, West)
            break
        end
        side = inverse(side)
    end
    along(r, Ost)
    numsteps_along(r, West, back_path[2])
    numsteps_along(r, Nord, back_path[1])
end

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
            
function number_5(r)
    back_path = move_to_angle(r)   #доработать возвращение обратно!!!!!
    number_2(r)
    obhod(r, snake(r, Nord))
    move_to_back(r, back_path)
end

function number_6(r)
    while (!isborder(r, Ost))
        side = snake(r, Nord) 
        obhod(r, side)
    end
end

function number_7(r)
    n = 1
    side = Ost
    while isborder(r, Nord)
        along(r, side, n)
        side = inverse(side)
        n += 1
    end
end

function number_8(r)
    n = 1
    side = Ost
    while true
        for i in 1:n
            if !ismarker(r)
                move!(r, side)
            else break
            end
        end
        side = right(side)
        for i in 1:n
            if !ismarker(r)
                move!(r, side)
            else break
            end
        end
        side = right(side)
        n += 1
    end
end

function number_9(r)
    back_path = move_to_angle(r, Sud)
    side = Nord
    s = true
    while true
        along_mark(r, side, 2, s)
        if ismarker(r)
            s = false
        else s = true
        end
        if !try_move!(r, West)
            break
        end
        side = inverse(side)
    end
    move_to_angle(r, Sud)
    numsteps_along(r, West, back_path[2])
    numsteps_along(r, Nord, back_path[1])
end

function number_10(r, n) #!!!не работаеt!!!!
    #back_path = move_to_angle(r, West)
    side = Ost
    for _ in 1:4
        while !isborder(r, side) 
            flag = true
            square(r, n, side)
            while ismarker(r)
                if !try_move!(r, Sud)
                    flag = false
                    break
                end
            end
            if flag
                move!(r, Nord) #т.к. в цикле while ismarker всегда делает 1 лишний шаг
            end
            along(r, side, n+1)
        end
        side = inverse(side)
        along(r, Nord, n)
    end
end

function number_11(r, side)
    ans = 0
    while !isborder(r, Nord)
        ans += num_borders!(r, side)
        side = inverse(side)
        move!(r, Nord)
    end
    return ans
end

function number_12(r, side)  #какая-то хрень с большим кол-вом перегородок
    ans = 0
    while !isborder(r, Nord)
        ans += num_borders2!(r, side)
        side = inverse(side)
        move!(r, Nord)
    end
    return ans
end

#-------------------на рекурсию-------------------------

function tolim(r, side) # !!! 19 задача !!!! идет до упора, но через рекурсию
    if !isborder(r, side)
        move!(r, side)
        tolim(r, side)
    end
end

function mark_lim(r, side) #!!! 20 задача!!!
   if isborder(r, side)
        putmarker!(r)
   else
        move!(r, side)
        mark_lim(r, side)
        move!(r, inverse(side))
   end
end

function step!(r, side) #!!! 21 задача!!!
    if !isborder(r, side)
        move!(r, side)
    else
        move!(r, right(side))
        step!(r, side)
        move!(r, left(side))
    end
end

function number_22(r, side)
    if !isborder(r, side)
        move!(r, side)
        number_22(r, side)
        try_move!(r, inverse(side))
        try_move!(r, inverse(side))
    end
end

function number_23(r, side)
    if isborder(r, side)
        tolim(r, inverse(side))
    else
        move!(r, side)
        number_23(r, side)
        move!(r, side)
    end
end


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

function number_26(r) #имеются проблемки (может не сработать, когда лабиринт имеет маленькие ответвеления   )
    if !ismarker(r)
        putmarker!(r)
        for side in (Nord, West, Sud, Ost)
            try_move!(r, side)
            number_26(r)
            try_move!(r, inverse(side))
        end
    end
end         

function fib_rec_28(a) #решение 28 с рекурсией
    if a == 1
        return 1
    elseif a < 1
        return 0 
    else
        return (fib_rec_28(a-1) + fib_rec_28(a-2))
    end
end

function fib_unrec_28(n) #решение 28 без рекурсии
    v = [1, 1]
    for i in 3:n
        push!(v, v[i-1] + v[i-2])
    end
    return v[n]
end

function fib_mem_28(n) #решение 28 с мемоизацией
    if n == 0
        return 1, 0
    else curr, prev = fib_mem_28(n-1)
        return prev + curr, curr
    end
end

        
    
