pwdb = readlines("src/files/daytwo.txt")

nonempty(arr) = [s for s in arr if length(s) > 0]

function parseentry(rawentry::String)::Entry
    lower, upper, required, pwd = nonempty(split(rawentry, r"-|:| "))
    return Entry(parse(Int, lower), parse(Int, upper), only(required), pwd)
end

struct Entry
    lower::Int
    upper::Int
    required::Char
    password::String
end

function isvalidinterval(entry::Entry)::Bool
    n = count(==(entry.required), entry.password)
    return entry.lower ≤ n ≤ entry.upper
end

function isvalidpos(entry::Entry)::Bool
    infirst = entry.password[entry.lower] == entry.required
    insecond = entry.password[entry.upper] == entry.required

    return infirst ⊻ insecond
end


entries = parseentry.(pwdb)
valid_first = count(isvalidinterval, entries)
valid_second = count(isvalidpos, entries)