
function getanswer(groupanswer::AbstractString)::Array{Set{Char}}
    individual = Set.(split(groupanswer))
    return individual
end

groupanswers = split(read("src/files/daysix.txt", String), "\n\n")

answers = getanswer.(groupanswers)

allanswers = (sets -> ∪(sets...)).(answers)
totalall = sum(length.(allanswers))

commonanswers = (sets -> ∩(sets...)).(answers)
totalcommon = sum(length.(commonanswers))
