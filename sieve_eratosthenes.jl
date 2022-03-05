function sweep!(arr, num=arr[1], res=[])
    condFn = (x) -> !(x == num^2 || (x > num^2 && x%num ==0))
    filter!(condFn,arr[2:end])
end

function generateprime(limit)
    lst = collect(range(2,limit))

