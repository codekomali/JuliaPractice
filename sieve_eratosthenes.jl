using Test

# Generate prime as per sieve of eratosthenes
function generateprime(limit)
    boolArray = fill!(Vector{Bool}(undef,limit), true) #may be simplified
    boolArray[1] = false
    for num in 2:limit
        if boolArray[num] == false
            continue
        end
        for j in (num*2):num:limit
            boolArray[j] = false
        end
    end
    return primeindexes(boolArray)
end

#TODO: need to test which one of the below works faster
function primeindexes(boolArray)
    filter(
        x -> x!=-1, #filter all -1
        #note: the additional comma is required for destructing tuples in anonymous functions
        map(
            ((i,v),)->v ? i : -1, #if value is true return index otherwise -1
            enumerate(boolArray))) # enumerate index and value
end

function primeindexes_alt(boolArray)
    #note: the additional comma is required for destructing tuples in anonymous functions
    map(
        ((i,_),)->i, # return only the index from the tuples
        filter(
            ((_,v),) -> v, # filter all tuples with 'false' val
            collect(enumerate(boolArray)))) #enumerate to get (index, val) tuples
end

@testset "sieve of erastosthenes" begin
    @test generateprime(20) == [2, 3, 5, 7, 11, 13, 17, 19]
end

generateprime(1)
