# Copyright (c) 2022 Code Komali
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
using Test
include("StudentData.jl")
using .StudentData

function swap!(arr,i,j)
    temp = arr[i]
    arr[i] = arr[j]
    arr[j] = temp
end

function partition(arr; 
    startindex=1, 
    endindex=lastindex(arr),
    desc = true, 
    compareFn = desc ? (x,y)->x>y : (x,y) -> x<y)
    i = startindex + 1
    j = i
    pivot = arr[startindex]
    while j <= endindex
        if compareFn(arr[j], pivot)
            swap!(arr,i,j)
            i+=1
        end
        j+=1
    end
    swap!(arr,startindex,i-1)
    return i-1
end

function quicksort(arr; 
    startindex=1, 
    endindex=lastindex(arr),
    desc = true, 
    compareFn = desc ? (x,y)->x>y : (x,y) -> x<y)
    startindex >= endindex && return arr
    j = partition(arr,startindex=startindex,endindex=endindex, desc=desc, compareFn = compareFn)
    quicksort(arr, startindex=startindex, endindex = j-1, desc=desc, compareFn = compareFn)
    quicksort(arr, startindex=j+1, endindex=endindex, desc=desc, compareFn = compareFn)
    return arr
end

# tests for quicksort
@testset "Quicksort tests" begin
    @test quicksort([11, 9, 7, 10, 8, 6]) == [11, 10, 9, 8, 7, 6]
    @test quicksort([11, 9, 7, 10, 8, 6], desc = false) == [6, 7, 8, 9, 10, 11]
    randArray = rand(Int8, 10)
    @test quicksort(randArray) == sort(randArray, rev = true) # Note: our quicksort implementation by default prefers descending order
    @test quicksort(randArray, desc = false) == sort(randArray)
    @test quicksort(students, compareFn = studentCompareFn) == sortedStudents
end