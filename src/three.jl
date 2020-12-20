using Base

# Define a Int matrix that allows for horizontal overindexing
struct Trees <: AbstractMatrix{Int} 
    data::Matrix{Int}
end

Base.size(T::Trees) = Base.size(T.data)
Base.IndexStyle(::Type{<:Trees}) = IndexLinear()
Base.@propagate_inbounds function Base.getindex(T::Trees, i::Int, j::Int)
    N, M = size(T)
    jmod = mod1(j, M)

    @boundscheck checkbounds(T, i, jmod)
    @inbounds T.data[i, jmod]
end

# Problem

tree_string = readlines("src/files/daythree.txt")

function treestomatrix(trees::Vector{String})::Trees
    parsetree(tree) = [ch == '.' ? 0 : 1 for ch in tree]
    return Trees(vcat(parsetree.(trees)'...))
end

function counttrees(treemap::Trees, right::Int, down::Int)
    R, C = size(treemap)
    trees = 0

    let r = 1, c = 1
        while r ≤ R
            trees += treemap[r, c]
            r += down; c += right
        end
    end

    return trees
end

slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
evaluate_slope(tup) = counttrees(treestomatrix(tree_string), tup...)
product = *(evaluate_slope.(slopes)...)