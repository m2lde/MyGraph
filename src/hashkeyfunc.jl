function hashkey(v::UInt,u::UInt,w::Real)::UInt
    return hash(v*u*w*13)
end
