using DelimitedFiles

inputs = readdlm("src/files/dayoneinput.txt", '\n', Int)

function sumto(arr::Array{Int}, M::Int)::Int
    N = length(arr)

    for i in 1:N
        remain = M - arr[i]
        for j in (i + 1):N
            if arr[j] == remain return arr[i] * remain end
        end
    end

    return -1
end

