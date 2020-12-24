singular(cl) = rstrip(cl, 's')

function parserule(rule)
    color, contains = split(rstrip(rule, '.'), " contain ")

    if contains == "no other bags"
        return (color, Dict())
    end

    inner = split.(split(contains, ", "), " "; limit=2)

    subbags = Dict((singular(color), parse(Int, count)) for (count, color) in inner)

    return (singular(color), subbags)
end

function bagpaths!(currentset::Set, bagrules::Dict, lookfor::AbstractString)

    hasbag = Set(
        color for (color, contains) in bagrules if lookfor ∈ Set(keys(contains)))

    union!(currentset, hasbag)

    for bag ∈ hasbag bagpaths!(currentset, bagrules, bag) end
end

function countin(bagrules::Dict, findinside::AbstractString)
    inside = get(bagrules, findinside, Dict())
    if isempty(inside) return 0 end

    return sum(count * (1 + countin(bagrules, color)) for (color, count) in inside)
end

rawrules = readlines("src/files/dayseven.txt")
mybag = "shiny gold bag"

bagrules = Dict(parserule.(rawrules))

paths = Set{AbstractString}()
bagpaths!(paths, bagrules, mybag)
total = length(paths)

nestedbagsN = countin(bagrules, mybag)


