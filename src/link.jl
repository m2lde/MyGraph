struct Link
    u::Int
    w::Float64
    Link(u,w) = new(u,w)
end

isequal(l1::Link, l2::Link)  = l1.u == l2.u
==(l1::Link, l2::Link)  = l1.u == l2.u
==(l::Link, n::Int)     = l.u == n
==(n::Int, l::Link)     = l.u == n
isless(x::Link, y::Link) = x.u < y.u
