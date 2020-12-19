using DelimitedFiles

inputs = readdlm("src/files/dayoneinput.txt", '\n', Int)

"""
Checks if (T + 1) numbers in arr sum to M and returns their product
"""
function sumto(arr::Array{Int}, M::Int)::Int sumto(arr, M, 1) end
function sumto(arr::Array{Int}, M::Int, T::Int)::Int
    N = length(arr)

    for i in 1:N
        remaining = M - arr[i]

        if T == 1
            for j in (i + 1):N
                if arr[j] == remaining return arr[i] * remaining end
            end
        else
            currentproduct = sumto(arr[i:end], remain, T - 1)
            if currentproduct > 0 return arr[i] * currentproduct end
        end
    end

    return -1 
end

twoprod = sumto(inputs, 2020)
threeprod = sumto(inputs, 2020, 2)