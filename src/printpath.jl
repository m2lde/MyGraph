function printpath(d::Dict, s::Int, v::Int)
    if s == v
        println(s)
    elseif d[v][3] == -1
        println("no path from $s to $v exists.")
    else
        printpath(d, s, d[v][3])
        println(v)
    end
end
