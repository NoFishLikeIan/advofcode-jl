isnumeric(str) = occursin(r"^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$", str)
isyear(str) = occursin(r"^\d{4}$", str)
isyearin(lower, upper) = y -> isyear(y) && (lower ≤ parse(Int, y) ≤ upper)
iscolor(str) = match(r"^\#[a-f0-9]{6}$", str) !== nothing
iseyecolor(str) = str ∈ Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
ispassportid(str) = match(r"^[0-9]{9}$", str) !== nothing

function isheight(str)
    if !occursin(r"(\d+cm)|(\d+in)", str) return false end

    if occursin("cm", str)
        height = parse(Int, split(str, "cm")[1])
        return 150 ≤ height ≤ 193
    else
        height = parse(Int, split(str, "in")[1])
        return 59 ≤ height ≤ 76
    end
end

validator = Dict(
    "byr" => isyearin(1920, 2002),
    "iyr" => isyearin(2010, 2020),
    "eyr" => isyearin(2020, 2030),
    "hgt" => isheight,
    "hcl" => iscolor,
    "ecl" => iseyecolor,
    "pid" => ispassportid
)

required = Set(keys(validator))
optional = Set([ "cid" ])

Passport = Dict{AbstractString,Union{AbstractString,Int}}

function parseentry(entry::AbstractString)::Passport
    fields = split(entry, (' ', '\n'))
    return Dict(split.(fields, ":"))
end

function parserawpassport(raw::String)::Vector{Passport}
    entries = split(raw, "\n\n")
    passports = parseentry.(entries)
end

hasrequiredentries(passport::Passport)::Bool = symdiff(Set(keys(passport)), required) ⊆ optional 

function isvalid(passport::Passport)::Bool
    if !hasrequiredentries(passport) return false end

    for (key, value) in passport
        if key ∉ optional && !validator[key](value)
            return false
        end
    end

    return true
end

raw = read("src/files/dayfour.txt", String)

passports = parserawpassport(raw)
Nhaverequired = count(hasrequiredentries, passports)
Narevalid = count(isvalid, passports)