include("functions.jl")
"""28. Написать функцию, возвращающую значение n-го члена 
последовательности Фибоначчи (1, 1, 2, 3, 5, 8, ...)
а) без использования рекурсии;
б) с использованием рекурсии;
практически убедиться, что наивная рекурсивная реализация такой функции 
будет крайне неэффективна в вычислительном отношении.
в) с использованием рекурсии и с мемоизацией """

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
