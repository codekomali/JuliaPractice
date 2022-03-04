using Test

function insert!(heap, elm; 
    min=true, 
    compareFn= min ? (x,y)->x<y : (x,y)->x>y)
    push!(heap,elm)
    val = percolateup!(heap, min=min, compareFn=compareFn)
    return val
end

function delete!(heap;
    min=true, 
    compareFn= min ? (x,y)->x<y : (x,y)->x>y)
    isempty(heap) && return
    swap!(heap,1,lastindex(heap))
    elem = pop!(heap)
    percoloatedown!(heap, min=min, compareFn=compareFn)
    return elem
end

function percolateup!(heap; 
    curr = lastindex(heap),
    min=true, 
    compareFn= min ? (x,y)->x<y : (x,y)->x>y)
    parent = curr ÷ 2
    if parent != 0 && compareFn(heap[curr],heap[parent])
        swap!(heap, curr, parent)
        val = percolateup!(heap,curr=parent, min=min, compareFn=compareFn)
        return val
    else
        return heap
    end
end

function percoloatedown!(heap; 
    curr=1,
    min=true, 
    compareFn= min ? (x,y)->x<y : (x,y)->x>y)
    lchild = curr * 2
    if lchild > lastindex(heap)
        return heap
    end
    rchild = lchild + 1
    if rchild > lastindex(heap)
        targetchild = lchild
    else
        targetchild = compareFn(heap[lchild],heap[rchild]) ? lchild : rchild
    end
    if compareFn(heap[targetchild],heap[curr])
        swap!(heap, curr, targetchild)
        percoloatedown!(heap,curr=targetchild,min=min,compareFn=compareFn)
    else
        return heap
    end
end

function swap!(heap, index1, index2)
    temp = heap[index1]
    heap[index1] = heap[index2]
    heap[index2] = temp
end

function add(a,b)
    println(a,b)
    a + b
end

function heapsort(arr::Vector; desc=true, min=!desc, compareFn= min ? (x,y)->x<y : (x,y)->x>y)
    insertFn! = (_heap,_elm) -> insert!(_heap,_elm,min=min, compareFn = compareFn)
    deleteFn! = (_heap) -> delete!(_heap, min=min, compareFn = compareFn)
    heap = reduce(insertFn!,arr,init=[])
    res = []
    while !isempty(heap)
        push!(res,deleteFn!(heap))
    end
    return res
end

heapsort([6,4,12,10,15,17,3])
heapsort([6,4,12,10,15,17,3], desc=false)


# heap=[]
# reduce(insert!,[6,4,12,10,15,17,3],init=heap)





# insert!(heap, 6)
# insert!(heap, 4)
# insert!(heap, 12)
# insert!(heap, 10)
# insert!(heap, 15)
# insert!(heap, 17)
# insert!(heap, 3)

# delete!(heap, min=false)

# insert!(heap, 6, min=false)
# insert!(heap, 4, min=false)
# insert!(heap, 12, min=false)
# insert!(heap, 10, min=false)
# insert!(heap, 17, min=false)