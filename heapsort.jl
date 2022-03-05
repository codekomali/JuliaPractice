using Test
include("StudentData.jl")
using .StudentData

function insert!(heap, elm;
    min = true,
    compareFn = min ? (x, y) -> x < y : (x, y) -> x > y)
    push!(heap, elm)
    val = percolateup!(heap, min = min, compareFn = compareFn)
    return val
end

function delete!(heap;
    min = true,
    compareFn = min ? (x, y) -> x < y : (x, y) -> x > y)
    isempty(heap) && return
    swap!(heap, 1, lastindex(heap))
    elem = pop!(heap)
    percoloatedown!(heap, min = min, compareFn = compareFn)
    return elem
end

function percolateup!(heap;
    curr = lastindex(heap),
    min = true,
    compareFn = min ? (x, y) -> x < y : (x, y) -> x > y)
    parent = curr ÷ 2
    if parent != 0 && compareFn(heap[curr], heap[parent])
        swap!(heap, curr, parent)
        percolateup!(heap, curr = parent, min = min, compareFn = compareFn)
    else
        heap
    end
end

function findtargetchild(heap, lchild;
    min = true,
    compareFn = min ? (x, y) -> x < y : (x, y) -> x > y)
    rchild = lchild + 1
    if rchild > lastindex(heap)
        lchild
    else
        compareFn(heap[lchild], heap[rchild]) ? lchild : rchild
    end
end

function percoloatedown!(heap;
    curr = 1,
    min = true,
    compareFn = min ? (x, y) -> x < y : (x, y) -> x > y)
    lchild = curr * 2
    lchild > lastindex(heap) && return heap
    targetchild = findtargetchild(heap, lchild, min = min, compareFn = compareFn)
    if compareFn(heap[targetchild], heap[curr])
        swap!(heap, curr, targetchild)
        percoloatedown!(heap, curr = targetchild, min = min, compareFn = compareFn)
    else
        return heap
    end
end

function swap!(heap, index1, index2)
    temp = heap[index1]
    heap[index1] = heap[index2]
    heap[index2] = temp
end


function heapsort(arr::Vector; 
    desc = true, 
    min = !desc, 
    compareFn = min ? (x, y) -> x < y : (x, y) -> x > y)
    insertFn! = (_heap, _elm) -> insert!(_heap, _elm, min = min, compareFn = compareFn)
    deleteFn! = (_heap) -> delete!(_heap, min = min, compareFn = compareFn)
    heap = reduce(insertFn!, arr, init = [])
    res = []
    while !isempty(heap)
        push!(res, deleteFn!(heap))
    end
    return res
end

# tests for heapsort
@testset "Heapsort tests" begin
    @test heapsort([11, 9, 7, 10, 8, 6]) == [11, 10, 9, 8, 7, 6]
    @test heapsort([11, 9, 7, 10, 8, 6], desc = false) == [6, 7, 8, 9, 10, 11]
    randArray = rand(Int8, 10)
    @test heapsort(randArray) == sort(randArray, rev = true) # Note: our heapsort implementation by default prefers descending order
    @test heapsort(randArray, desc = false) == sort(randArray)
    @test heapsort(students, compareFn = studentCompareFn) == sortedStudents
end
