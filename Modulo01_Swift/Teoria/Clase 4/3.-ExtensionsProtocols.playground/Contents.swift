import UIKit

//🧩 Extensions y Protocols en Swift
///Extensions y Protocols son conceptos muy importantes en Swift porque nos ayudan a escribir código más organizado, reutilizable y flexible.

//1. ¿Qué es una Extension?
///Una Extension permite agregar nuevas funcionalidades a un tipo que ya existe.

///Podemos extender:
/*
- Struct
- Class
- Enum
- Protocol
- Tipos existentes como String, Int, Array, etc.
 */

//extension TypeName {
    // Nueva funcionalidad
//}

//2. Extension básica
///Imagina que tenemos un struct:
struct User {
    var name: String
    var age: Int
}
///Podemos agregar una función utilizando una Extension:
extension User {
    func sayHello() {
        print("Hello, my name is \(name)")
    }
}

let user = User(name: "Luna", age: 25)
user.sayHello()

//3. Extensions con tipos existentes
///Podemos extender tipos que ya existen en Swift.
///Por ejemplo, String:
extension String {
    func greeting() -> String {
        return "Hello, \(self)"
    }
}

let name = "Juan"
print(name.greeting())

//4. Extension para agregar propiedades computadas
///Las Extensions pueden agregar Computed Properties.

extension String {
    var isLongText: Bool {
        return count > 10
    }
}
let text = "Hello World!"
print(text.isLongText)

///⚠️ Una Extension normalmente no puede agregar Stored Properties.
///Esto no es válido:
extension User {
//    var email: String // ❌
}

///Pero sí podemos agregar una Computed Property:
extension User {
    var description: String {
        "\(name) - \(age)"
    }
}

//5. Extensions con Functions
///Un uso muy común es separar funcionalidades.
class Client {
    var name: String

    init(name: String) {
        self.name = name
    }
}

extension Client {

    func login() {
        print("\(name) logged in")
    }

    func logout() {
        print("\(name) logged out")
    }
}

//6. Extensions y Initializers
///Las Extensions también pueden agregar inicializadores.

struct Product {
    var name: String
    var price: Double
}

extension Product {

    init(name: String) {
        self.name = name
        self.price = 0
    }
}

let product = Product(name: "iPhone")

/*
🧠 Resumen de Extensions

Una Extension puede agregar:

✅ Functions
✅ Computed Properties
✅ Initializers
✅ Conformance a Protocols

Pero normalmente no puede agregar:

❌ Stored Properties
 */

//🔷 Parte 2: Protocols
//1. ¿Qué es un Protocol?

///Un Protocol define un conjunto de reglas o requisitos que un tipo debe cumplir.
///Una forma sencilla de entenderlo es:
///Un Protocol define qué debe hacer un tipo, pero no necesariamente cómo debe hacerlo.

protocol Vehicle {
    func move()
}

///Estamos diciendo:
///Cualquier tipo que adopte Vehicle debe tener una función llamada move().
//2. Adoptar un Protocol
///Creamos un struct:
struct Car: Vehicle {
    func move() {
        print("Car is moving")
    }
}
///Ahora Car cumple con las reglas de Vehicle.
let car = Car()
car.move()

//3. Protocol con propiedades
///Un Protocol también puede requerir propiedades.
protocol Person {
    var name: String { get }
}

///Esto significa que cualquier tipo que adopte Person debe tener una propiedad llamada name.

class MaxUser: Person{
    
    let name: String
    
    init(name: String) {
        self.name = name
    }

}

struct User2: Person {
    var name: String
}

//4. { get } y { get set }

protocol UserInfo {
    var name: String { get set }
}
///Ahora la propiedad debe poder:
/*
- Leer → get
- Modificar → set
 */

struct User3: UserInfo {
    var name: String
}

//5. Protocols con múltiples requisitos
///Un Protocol puede tener varias reglas.

protocol Employee {
    var name: String { get }
    var salary: Double { get }

    func work()
}

struct Developer: Employee {

    var name: String
    var salary: Double

    func work() {
        print("\(name) is coding")
    }
}

let developer = Developer(name: "Axel", salary: 20_000)
developer.work()

//6. Protocols y Classes
///Los Protocols no son exclusivos de struct.
///También pueden ser utilizados por class.

protocol Animal {
    func makeSound()
}

class Dog: Animal {

    func makeSound() {
        print("Woof!")
    }
}

///También pueden utilizarlos los enum.

enum TrafficLight: Vehicle {

    case red
    case yellow
    case green

    func move() {
        print("Traffic light action")
    }
}

//7. Protocols y Polymorphism ⭐
///Los Protocols también permiten utilizar Polymorphism.

struct Cat: Animal {
    func makeSound() {
        print("Meow!")
    }
}

let animals: [any Animal] = [
    Dog(),
    Cat()
]
for animal in animals {
    animal.makeSound()
}

//8. Protocol Extensions ⭐

///Aquí es donde Extensions + Protocols se vuelven muy poderosos.
///Podemos agregar una implementación por defecto a un Protocol.
extension Vehicle {
    func stop() {
        print("Vehicle stopped")
    }
}

struct Boat: Vehicle {

    func move() {
        print("Car is moving")
    }
}
let boat = Boat()

car.move()
car.stop()

//9. Personalizar una implementación
///Un tipo puede utilizar la implementación por defecto o crear la suya.
///
protocol Greeting {
    func sayHello()
}

extension Greeting {
    func sayHello() {
        print("Hello!")
    }
}

struct Admin{
    
}

extension Admin: Greeting {
    func sayHello() {
            print("Welcome, Admin!")
        }
}


//🧩 Protocol Composition
///También podemos combinar Protocols.
///Por ejemplo:
protocol Printable {
    func printInfo()
}

protocol Saveable {
    func save()
}

struct Document: Printable, Saveable {

    func printInfo() {
        print("Document information")
    }

    func save() {
        print("Document saved")
    }
}


