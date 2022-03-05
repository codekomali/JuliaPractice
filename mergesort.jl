using Test

include("StudentData.jl")
using .StudentData

# Iterative version of merge
function merge(arr1::Vector, arr2::Vector, compareFn)
    iarr1 = 1
    iarr2 = 1
    res = []
    while iarr1 <= lastindex(arr1) && iarr2 <= lastindex(arr2)
        if compareFn(arr1[iarr1], arr2[iarr2])
            push!(res, arr1[iarr1])
            iarr1 += 1
        else
            push!(res, arr2[iarr2])
            iarr2 += 1
        end
    end
    if iarr1 <= lastindex(arr1)
        append!(res, arr1[iarr1:end])
    else
        append!(res, arr2[iarr2:end])
    end
end

@testset "Merge-iterative tests" begin
    @test merge([11, 6, 2], [9, 7, 5], (x, y) -> x > y) == [11,9,7,6,5,2]
    @test merge([2,6,11], [5,7,9], (x, y) -> x < y) == [2,5,6,7,9,11]
end

# Recursive implementation of merge
function merger(arr1::Vector, arr2::Vector, compareFn)
    if length(arr1) == 0
        arr2
    elseif length(arr2) == 0
        arr1
    elseif compareFn(arr1[1], arr2[1])
        [popfirst!(arr1); merger(arr1, arr2, compareFn)]
    else
        [popfirst!(arr2); merger(arr1, arr2, compareFn)]
    end
end

@testset "Merge-recursive tests" begin
    @test merger([11, 6, 2], [9, 7, 5], (x, y) -> x > y) == [11,9,7,6,5,2]
    @test merger([2,6,11], [5,7,9], (x, y) -> x < y) == [2,5,6,7,9,11]
end

# Recursive implementation of mergesort
function mergesortr(arr::Vector, desc = true, 
    compareFn = desc ? (x,y)->x>y : (x,y) -> x<y)
    pivot = length(arr) ÷ 2
    if pivot == 0
        arr
    else
        merger(mergesortr(arr[1:pivot], desc, compareFn),
            mergesortr(arr[pivot+1:end], desc, compareFn),
            compareFn)
    end
end

# test for recursive mergesort
@testset "Mergesort-recursive tests" begin
    @test mergesortr([11, 9, 7, 10, 8, 6], true) == [11,10,9,8,7,6]
    @test mergesortr([11, 9, 7, 10, 8, 6], false) == [6,7,8,9,10,11]
    randArray = rand(Int8,10)
    @test mergesortr(randArray, true) == sort(randArray,rev=true) # Note: our mergesort implementation by default prefers descending order
    @test mergesortr(randArray, false) == sort(randArray)
    @test mergesortr(students,nothing,studentCompareFn) == sortedStudents
end



