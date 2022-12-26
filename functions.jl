
function along(r, side):: Nothing #идти до упорa
    while !isborder(r, side)
        try_move!(r, side)
    end
end

function along_if(stop_condition::Function, r, side, max_num_steps):: Int #идет в опр. сторону, пока не выполнется условие (или он не врежется в перегородку)
    num_steps = 0
    while (!stop_condition() && num_steps != max_num_steps)
        try_move!(r, side)
        num_steps += 1
    end
    return num_steps
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
        try_move!(r, side1) 
        try_move!(r, side2)
        putmarker!(r)
        it += 1
    end
    return it
end
 
function diag_it(r, side1, side2, it)
    for i in 1:it
        try_move!(r, side1)
        try_move!(r, side2)
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

function shuttle!(stop_condition::Function, robot, side)
    n = 0 
    while !stop_condition()
        n += 1
        along(r, side, n)
        side = inverse(side)
    end
end

"""function spriral!(stop_condition::Function, r, side = Nord)  # !!! не работает !!!
    n = 1 
    while !stop_condition()
        along_if(() -> stop_condition(side), r, side, n)
        if stop_condition(side)
            continue
        end
        side = left(side)
        along_if(() -> stop_condition(side), r, side, n)
        if stop_condition(side)
            continue
        end
        side = left(side)
        n += 1
    end
end

function snake!(stop_condition::Function, r, (move_side, next_row_side)::NTuple{2,HorizonSide=(Nord, Ost)})
end"""
# ---- создаем абстракного робота, чтобы можно было передать его функцианал другим роботам --- 
"
using HorizonSideRobots
HSR = HorizonSideRobots

abstract type AbstractRobot end #создаем абстракного робота, чтобы можно было передать его функцианал другим роботам

#get_robot - определяется для каждого робота по отдельности, возвращает ссылку на объект типа робот

HSR.move!(r::AbstractRobot, side) = move!(get_robot(robot), side)
HSR.isborder(r::AbstractRobot, side) = isborder(get_robot(robot), side)
HSR.putmarker!(r::AbstractRobot) = putmarker!(get_robot(robot))
HSR.ismarker(r::AbstractRobot) = ismarker(get_robot(robot))
HSR.temperature(r::AbstractRobot) = temperature(get_robot(robot))
"
#--------- создадим коорд робота ------------
"
using HorizonSideRobots

mutable struct Coordinates
    x::Int
    y::Int
end 

function HorizonSideRobots.move!(coord::Coordinates,side::HorizonSide)
    if side == Nord
        coord.y+=1
    elseif side == Sud
        coord.y-=1
    elseif side == Ost
        coord.x+=1
    elseif side == West
        coord.x-=1
    end 
end 

get_coord(coord::Coordinates)=(coord.x, coord.y)


struct CoordRobot
    robot::Robot
    coord::Coordinates
end 



function HorizonSideRobots.move!(robot::CoordRobot,side)
    move!(robot.robot,side)
    move!(robot.coord,side)
end 

get_coord(robot::CoordRobot) = get_coord(robot.coord)


get_robot(robot::CoordRobot) = robot.robot

HorizonSideRobots.isborder(robot::CoordRobot,side)=isborder(robot.robot,side)
HorizonSideRobots.putmarker!(robot::CoordRobot)=putmarker!(robot.robot)
HorizonSideRobots.ismarker(robot::CoordRobot)=ismarker(robot.robot)
HorizonSideRobots.temperature(robot::CoordRobot)=temperature(robot.coord)

#----"