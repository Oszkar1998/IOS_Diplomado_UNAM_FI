import UIKit

//❓ Optionals en Swift
///Los Optionals son uno de los conceptos más importantes de Swift.
///Un Optional representa un valor que puede existir o puede no existir.
//En otras palabras:
///Un Optional puede contener un valor o nil.

//1. ¿Por qué necesitamos Optionals?
///Imagina que tenemos una edad:
let age: Int = 25

//let age: Int = nil // ❌ Error

///Porque un Int normal no puede ser nil.
///Pero podemos crear un Optional:
let newAge: Int? = nil
///El ? significa que el valor puede ser:
///- Un Int
///- nil

//2. ¿Qué es nil?
///nil significa que no existe un valor.
var name: String? = nil

//3. Declarar un Optional
///Se agrega ? después del tipo:
var newName: String?
var age_: Int?
var price: Double?
var isAvailable: Bool?

//4. Optional Binding con if let ⭐
///Una de las formas más utilizadas para trabajar con Optionals es if let.
let name2: String? = "César"
if let name = name2 {
    print(name)
}
//Lo que ocurre es:
///1. Swift verifica si existe un valor.
///2. Si existe, lo extrae.
///3. Podemos utilizarlo dentro del bloque.

let firstName: String? = nil

if let firstName = firstName{
    print(firstName)
} else {
    print("No name available")
}

//5. Optional Binding con guard let
///También podemos utilizar guard let.
func showName(name: String?) {
    
    guard let name = name else {
        print("No name available")
        return
    }
    
    print("Hello, \(name)")
}

//Regla sencilla
///if let
///↓
///Necesito el valor solamente aquí

///guard let
///↓
///Necesito el valor para continuar

//6. Force Unwrapping ! ⚠️
///Podemos obtener el valor utilizando !.
let names: String? = "César"
print(names!)

///Esto funciona si existe un valor.
///Pero si el valor es nil:
print(names!) // 💥 Crash

//7. Optional Chaining ?.
///El Optional Chaining permite acceder a propiedades o métodos de forma segura.
let lastName: String? = "César"
let count = lastName?.count
print(count)
//let name: String? = nil
//let count = name?.count

//8. Nil-Coalescing Operator ?? ⭐
///El operador ?? permite proporcionar un valor por defecto.

let infoName: String? = nil
let displayName = name ?? "Guest"
print(displayName)

//9. Optional Binding shorthand.
let city: String? = "CDMX"
if let city {
    print(city)
}

//10. Optionals en Functions
///Una función puede recibir un Optional:
func greet(name: String?) {
    
    if let name {
        print("Hello, \(name)")
    } else {
        print("Hello, Guest")
    }
}

//11. Functions que regresan Optionals
///Una función también puede regresar un Optional.
func findUser(id: Int) -> String? {
    if id == 1 {
        return "César"
    }
    return nil
}

//12. Optionals con Dictionaries
///Los Dictionaries normalmente regresan Optionals.
let users = [
    "001": "César",
    "002": "Ana"
]

let user_ = users["001"]
if let user = users["001"] {
    print(user)
}

//15. Optionals y Class
///También podemos tener propiedades opcionales:
class User {
    var name: String
    var email: String?
    
    init(name: String) {
        self.name = name
    }
}
let user = User(name: "César")
print(user.email)
user.email = "cesar@email.com"









