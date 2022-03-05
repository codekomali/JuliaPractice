# Copyright (c) 2022 Code Komali
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT


module StudentData

export Student, students, sortedStudents, studentCompareFn

# Complex type
struct Student
    name::String
    rollno::String
    cgpa::Float64
end
# instances of the complex type Student
students = [
    Student("jack", "s2020123", 8.9),
    Student("jill", "s2020124", 4.9),
    Student("tom", "s2020125", 6.9),
    Student("pip", "s2020126", 9.9),
    Student("mark", "s2020127", 7.9)
]

# expected result after sorting students (descending) by CGPA
sortedStudents = [
    Student("pip", "s2020126", 9.9),
    Student("jack", "s2020123", 8.9),
    Student("mark", "s2020127", 7.9),
    Student("tom", "s2020125", 6.9),
    Student("jill", "s2020124", 4.9)
]
# comparison function for student
function studentCompareFn(x::Student, y::Student)
    x.cgpa > y.cgpa
end
end