//: Playground - noun: a place where people can play

import UIKit

/*
 “Contiguous data structures
 The first data structures we will explore are contiguous data structures. These linear data structures are index-based, where each element is accessed sequentially in a particular order.”
 
 */
//To declare an array using the full method, use the following code:
var myIntArrayMethod: Array<Int> = [1,3,5,7,9]
//To declare an array using the shorthand array syntax, use the following code:

var myIntArrayShortand: [Int] = [1,3,5,7,9]

//To declare an array using the type inference syntax,
var myIntArrayInference = [1.0,3,5,7,9]
print(myIntArrayInference)

//If you don't want to define any values at the time of declaration
var myIntArrayEmpty:[Int] = []
var students: Array<String> = Array()

//To declare a multidimensional array use nesting paires of square brackets.
var my2DArray: [[Int]] = [[1,2],[10,11],[20,30]]

//Retrieving Element

//There are multiple ways to retrieve value from an array.
//- you know the elements index, you can address it directly.
var myIntArrayAddress: [Int] = [1,2,3,9,5]
var someNumber = myIntArrayAddress
print("someNumber:\(someNumber)\n")

/*- some time you want to loop through, or iterate through the ccollection of element in an array. We'll use the for..in syntax for that. */
for element in myIntArrayAddress {
    print("element:\(element)\n")
}
 /* -There are other time when you may want to work with a subsequence of
 elements in an array. in this case we'll pass a rang instead of an index to get the
 subsequence. */

var someSubset = myIntArrayAddress[2...4]
print(someSubset)


////////////////////////
// 2 demension array
//- “Directly retrieve an element from a two-dimensional array using its index:”
var my2DArrayAddress:[[Int]] = [[1,2],[10,11],[20,30]]
var element = my2DArrayAddress[0][0]
var element2 = my2DArrayAddress[1][1]
print("2Demension:\(element)")

////////////////////////
//Adding elements
/* You can add elements to an array using servaral different methods, depending on whether
you want add element to the end of an array or insert an element anywhere between the beginning and end the array.
*/

//adding element to the end of an existing array:
my2DArrayAddress.append([10])
print(my2DArrayAddress)

//Inserting an element at a specific index in an existing array:
my2DArrayAddress.insert([4], at: 2) //add 4 into index 2
//Remove index an index at end of array an element of array anywhere between beginning and end of array.
myIntArrayAddress.remove(at: 0)
//myIntArrayAddress.removeAll()
myIntArrayAddress.removeLast()
myIntArrayAddress.removeFirst()

