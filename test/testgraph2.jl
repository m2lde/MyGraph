using MyGraph

cap = -1
T = [9 1 4 9 0 4 8 9 0 1] # map(parse, split(readline(STDIN), r"(\s+)"))
G = DictGraph()

# search for the capital vertex
# T[Q] = Q then Q is the capital

for Q = 1:lastindex(T)
	Q - 1 == T[Q] && (global cap = T[Q])
end

if cap == -1
    error("no capital exists")
else
    println("The capital is $cap")
    for i = 1:lastindex(T)
        addEdge!(G, i - 1, T[i])
    end
end

D = DFS(G)
B = BFS(G, cap)

R = [0 for _ = 1:B.count]

for k in keys(B)
    R[B[k][2] + 1] += 1
end

println("R = $(R[2:end])")
