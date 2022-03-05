# Copyright (c) 2022 Code Komali
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

using Test, Printf, Memoize

# A global variable just for simple benchmarking
called = 0

# Using the Memoize package
@memoize Dict function knapsack(values, weights, MaxWieght)
    global called += 1
    if MaxWieght < 0
        return -Inf
    elseif isempty(values)
        return 0
    else
        max(values[end] + knapsack(values[1:end-1], weights[1:end-1], MaxWieght - weights[end]),
            knapsack(values[1:end-1], weights[1:end-1], MaxWieght))
    end
end

# Non memoized bruteforce approach
function knapsack_bruteforce(values, weights, MaxWieght)
    global called += 1
    if MaxWieght < 0
        return -Inf
    elseif isempty(values)
        return 0
    else
        max(values[end] + knapsack_bruteforce(values[1:end-1], weights[1:end-1], MaxWieght - weights[end]),
            knapsack_bruteforce(values[1:end-1], weights[1:end-1], MaxWieght))
    end
end

function compute_knapsack(values, weights, MaxWieght; memoized = true)
    empty!(memoize_cache(knapsack))
    global called = 0
    result = memoized ? knapsack(values, weights, MaxWieght) : knapsack_bruteforce(values, weights, MaxWieght)
    #uncomment the below code for call count
    #@printf "\n Function called: %d \n" called
    return result
end


@testset "0-1 knapsack problem tests" begin
    @test compute_knapsack([20, 5, 10, 40, 15, 25], [1, 2, 3, 8, 7, 4], 10, memoized = false) == 60
    @test compute_knapsack([60, 100, 120], [10, 20, 30], 50, memoized = false) == 220
    @test compute_knapsack([20, 5, 10, 40, 15, 25], [1, 2, 3, 8, 7, 4], 10) == 60
    @test compute_knapsack([60, 100, 120], [10, 20, 30], 50) == 220
    @test compute_knapsack([92, 57, 49, 68, 60, 43, 67, 84, 87, 72],
        [23, 31, 29, 44, 53, 38, 63, 85, 89, 82], 165) == 309
end


@time compute_knapsack([92, 57, 49, 68, 60, 43, 67, 84, 87, 72],
    [23, 31, 29, 44, 53, 38, 63, 85, 89, 82], 165)
@time compute_knapsack([92, 57, 49, 68, 60, 43, 67, 84, 87, 72],
    [23, 31, 29, 44, 53, 38, 63, 85, 89, 82], 165, memoized = false)

#Note: 
# The memoized version is being called less number of times as expected.
# But, it is taking more time to compute. Need to investigate more.