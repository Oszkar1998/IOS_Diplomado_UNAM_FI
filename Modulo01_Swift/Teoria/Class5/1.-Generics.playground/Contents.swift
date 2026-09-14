import UIKit

//Guía de Generics en Swift

///Los Generics (Genéricos) permiten escribir código reutilizable que funciona con diferentes tipos de datos, sin tener que crear una versión de la misma lógica para cada tipo.
///La idea principal es:
///Escribe la lógica una sola vez y permite que funcione con diferentes tipos.

//1. ¿Cuál es el problema que resuelven?
///Imagina que quieres una función para intercambiar dos valores.
///Sin generics tendrías que crear diferentes funciones:

func swapInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

///Si después quieres hacerlo con String, necesitarías otra función:

func swapStrings(_ a: inout String, _ b: inout String) {
    let temp = a
    a = b
    b = temp
}

///La lógica es exactamente la misma.
///Con Generics podemos escribirla una sola vez.

//2. Generic Function
///La sintaxis básica es:

func functionName<T>(_ value: T) {
    // ...
}

///T representa un tipo genérico.
func printValue<T>(_ value: T) {
    print(value)
}

///Ahora podemos utilizar la misma función con diferentes tipos:
printValue(10)
printValue("Hello")
printValue(3.14)
printValue(true)

///Swift determina automáticamente qué tipo representa T.

//3. ¿Qué significa <T>?
///Cuando escribimos: func printValue<T>(_ value: T)
//T es un placeholder para un tipo.
//No significa que T sea específicamente Int, String, etc.
///Puede representar cualquier tipo permitido.


//4. Generic Function con retorno
///También podemos devolver un tipo genérico.
func getValue<T>(_ value: T) -> T {
    return value
}

let number = getValue(10)
let name = getValue("César")
let price = getValue(99.99)

//5. Dos tipos genéricos
///Podemos utilizar más de un tipo genérico:
func printPair<T, U>(_ first: T, _ second: U) {
    print("Generic return",first)
    print("Generic return",second)
}
printPair(10, "César")
printPair("Age", 29)

//6. Generic Array
///Los generics son muy utilizados con Collections.
///Por ejemplo, podemos crear una función que obtenga el primer elemento de un Array:

func firstElement<T>(from array: [T]) -> T? {
    return array.first
}

let numbers = [7, 9, 3]
let names = ["Ana", "Sofia", "Estela"]

let firstNumber = firstElement(from: numbers)
let firstName = firstElement(from: names)

//7. Generic Struct
///Los generics también pueden utilizarse en struct.

struct Box<T> {
    var value: T
}

///Ahora podemos crear diferentes tipos de Box:
let numberBox = Box(value: 100)
let stringBox = Box(value: "Hello")
let boolBox = Box(value: true)

//8. Generic Class
///También podemos utilizarlos con clases:

class Storage<T> {
    var value: T
    var id = UUID()
    
    init(value: T) {
        self.value = value
    }
}

let numberStorage = Storage(value: 100)
let nameStorage = Storage(value: "César")

//9. Generic Enum
///También podemos utilizar generics en enums.
///Un ejemplo muy común es representar un resultado:

enum Result<T> {
    case success(T)
    case failure
}
let numberResult = Result.success(100)
let nameResult = Result.success("César")

//10. Type Constraints
///Hasta ahora T podía representar prácticamente cualquier tipo.
///Pero a veces necesitamos limitar qué tipos puede utilizar.

//func add<T>(_ first: T, _ second: T) -> T {
//    // ...
//    return first + second
//}

func add<T: Numeric>(_ first: T, _ second: T) -> T {
    return first + second
}
///Ahora T debe cumplir con Numeric.

print("Numeric",add(10, 20))
print("Numeric",add(10.5, 20.5))
//add("Hello", "World")

//11. Generics con Protocols
///Aquí es donde los generics se vuelven especialmente útiles.

//func process<T: Vehicle>(_ vehicle: T) {
//    // ...
//}

///Esto significa: T puede ser cualquier tipo que cumpla con Vehicle.
protocol Vehicle {
    func move()
}

struct Car: Vehicle {
    func move() {
        print("Car is moving")
    }
}

struct Motorcycle: Vehicle {
    func move() {
        print("Motorcycle is moving")
    }
}

func process<T: Vehicle>(_ vehicle: T) {
    vehicle.move()
}

process(Car())
process(Motorcycle())




