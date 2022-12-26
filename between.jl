include("functions.jl")


function try_move(r, side):: Bool #можно ли сделать шаг в заданном направлении?
    if !isborder(r, side)
        move!(r, side)
    else return false
    end
    return true
end

function stop(r)
    if ismarker(r)
        return true
    return false
    end
end

function hey(r)
    return along_if(() -> stop(r), r, Ost, 100)
end


