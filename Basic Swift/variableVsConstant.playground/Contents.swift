//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
 “Value types and reference types
 Swift has two fundamental types: value types and reference types. Value types are a type whose value is copied when it is assigned to a variable or constant, or when it is passed to a function. Value types have only one owner. Value types include structures and enumerations. All of Swift's basic types are implemented as structures.
 
 Reference types, unlike value types, are not copied on assignment but are shared. Instead of a copy being made when assigning a variable or passing to a function, a reference to the same existing instance is used. Reference types have multiple owners.
 
 The Swift standard library defines many commonly used native types such as int, double, float, string, character, bool, array, dictionary, and set.”
 
 “Named and compound types
 In Swift, types are also classified as named types and compound types. A named type is a type that can be user-defined and given a particular name when it's defined. Named types include classes, structures, enumerations, and protocols. In addition to user-defined named types, the Swift standard library also includes named types that represent arrays, dictionaries, sets, and optional values. Named types can also have their behavior extended by using an extension declaration.”
 
 “Compound types are types without a name, In Swift, the language defines two compound types: function types and type types. A compound type can contain both named types, and other compound types. As an example, the following tuple type contains two elements: the first is the named type Int, and the second is another compound type (Float, Float):
 
 (Int, (Float, Float))”
 
 “Type aliases define an alternative name for existing types. The typealias keyword is similar to typedef in C-based languages. Type aliases are useful when working with existing types that you want to be more contextually appropriate to the domain you are working in. For example, the following associates the identifier TCPPacket with the type UInt16:”
 
 */

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mercury,venus,earth,mars,jupiter,saturnmuranus,neptune
}

var directionToHead = CompassPoint.west
directionToHead = .east

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}





