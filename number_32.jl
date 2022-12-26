include("functions.jl")
""" 32. Написать рекурсивную функцию, выводящую на экран информацию о 
иерархии типов языка Julia.
"""

function show_typetree(type::DataType, level=0)
    println(" " ^ level, type)
    for t in subtypes(type) show_typetree(t, level+3) end
end
