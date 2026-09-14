import UIKit

//🔒 Closures en Swift
///Las Closures son bloques de código que pueden almacenarse en una variable, pasarse como parámetro o ejecutarse más tarde.
///Una forma sencilla de entenderlas es:
///Una Closure es como una función, pero puede existir sin tener un nombre.

//1. ¿Qué es una Closure?
///Una función normal:

//func sayHello() {
//    print("Hello!")
//}

///Una Closure puede hacer lo mismo:
let sayHello = {
    print("Hello!")
}

sayHello()

//2. Sintaxis básica

///La estructura de una Closure es:
let message = {
    print("Welcome to Swift!")
}
message()

//3. Closures con parámetros
///Una Closure puede recibir parámetros.
let greet = { (name: String) in
    print("Hello, \(name)")
}

greet("Amy")

//4. Closures con Return
///Una Closure también puede regresar un valor.
let add = { (first: Int, second: Int) -> Int in
    return first + second
}
///Uso:
let result = add(10, 20)
print(result)

//5. Type Inference
///Swift muchas veces puede inferir el tipo.
///Por ejemplo:
let multiply: (Int, Int) -> Int = { first, second in
    first * second
}
let resultMultiply = multiply(10,10)
print(resultMultiply)

//6. Closures como parámetros ⭐
///Uno de los usos más importantes de las Closures es pasarlas a una función.
func processNumbers(
    completion: () -> Void
) {
    print("Processing numbers...")
    completion()
}

processNumbers {
    print("Process completed!")
}

//7. Closure con parámetros como Completion
///También podemos enviar información a la Closure.

func getUser(
    completion: (String) -> Void
) {
    let name = "César"
    completion(name)
}
getUser { name in
    print("User: \(name)")
}

//8. Closure con varios parámetros

func calculate(
    completion: (Int, Int) -> Void
) {
    completion(10, 20)
}

calculate { first, second in
    print(first + second)
}

//9. Closure que devuelve un valor
///También podemos recibir una Closure que regrese información.
func calculate(
    operation: (Int, Int) -> Int
) {
    let result = operation(10, 5)
    
    print(result)
}

calculate { first, second in
    first * second
}

///La misma función puede recibir diferentes comportamientos.

//10. Shorthand Argument Names
///Swift permite utilizar nombres abreviados para los parámetros:
let newAdd: (Int, Int) -> Int = {
    $0 + $1
}
let addResult = add(10, 20)
print(addResult)

//12. Closures con Arrays ⭐
///Las Closures se utilizan mucho con Collections.
///Por ejemplo, con forEach:
let names = ["César", "Ana", "Juan"]

names.forEach { name in
    print(name)
}
//También podemos escribir:
names.forEach {
    print($0)
}

//13. map
///map permite transformar los elementos de una colección.
let numbers = [1, 2, 3, 4, 5]

let doubledNumbers = numbers.map { number in
    number * 2
}
print(doubledNumbers)

//14. filter
///filter permite obtener únicamente los elementos que cumplen una condición.

let evenNumbers = numbers.filter { number in
    number % 2 == 0
}
print(evenNumbers)

//15. sorted
///También podemos utilizar Closures para ordenar información.

let newNumbers = [5, 2, 8, 1]
let sortedNumbers = newNumbers.sorted { first, second in
    first < second
}
print(sortedNumbers)

//16. Closures como Completion Handlers
///Un uso muy común es esperar a que termine una operación.
func downloadData(
    completion: () -> Void
) {
    
    print("Downloading...")
    
    completion()
}
downloadData {
    print("Download completed!")
}




