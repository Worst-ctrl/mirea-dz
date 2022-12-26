function try_move(r, side):: Bool #можно ли сделать шаг в заданном направлении?
    if !isborder(r, side)
        move!(r, side)
    else return false
    end
    return true
end

function hey(n)
    for i in 1:2
        print(i)
    end
end