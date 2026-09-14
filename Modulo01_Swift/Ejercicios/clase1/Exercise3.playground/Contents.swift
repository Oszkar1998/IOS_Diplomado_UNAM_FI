import UIKit

//🎮 Ejercicio: Inventario de un videojuego
//1️⃣ Crea un enum llamado ItemType
///Debe representar los siguientes tipos:
/*
- weapon
- armor
- potion
- accessory
*/
///Utiliza String como Raw Value y asigna un nombre descriptivo en inglés a cada caso.
enum ItemType: String {
    case weapon = "MA40 Assault Rifle"
    case armor = "Mjolnir Powered Assault Armor"
    case potion = "Overshield"
    case accessory = "Active Camouflage"
} 

//2️⃣ Crea un struct llamado Item
///Debe tener las siguientes propiedades:
/*
 name → String
 price → Double
 type → ItemType
 quantity → Int
*/
struct Item {
    var name: String
    var price: Double
    var type: ItemType
    var quantity: Int
}

//3️⃣ Crea un Array llamado inventory
///Agrega mínimo 5 items con diferentes tipos, precios y cantidades.
let inventory: [Item] = [
    Item(name: "Oscar", price: 150.0, type: .weapon, quantity: 2),
    Item(name: "Alfonso", price: 1200.0, type: .armor, quantity: 1),
    Item(name: "Adrian", price: 700.0, type: .potion, quantity: 5),
    Item(name: "Arturo", price: 1100.0, type: .accessory, quantity: 1),
    Item(name: "Axel", price: 850.0, type: .potion, quantity: 10)
]

//4️⃣ Recorre el inventory
///Utiliza for-in para mostrar la siguiente información de cada Item:
/*
 Name
 Type
 Price
 Quantity
*/
///El type debe mostrarse utilizando su rawValue.
for item in inventory {
    print("Name: \(item.name)")
    print("Type: \(item.type.rawValue)")
    print("Price: \(item.price)")
    print("Quantity: \(item.quantity)")
    print("-------------")
}

//5️⃣ Evalúa el price
///Utiliza if / else para clasificar cada item:
/*
 price >= 1000 → "Legendary item"
 price >= 500  → "Rare item"
 otherwise     → "Common item"
*/
for item in inventory {
    if item.price >= 1000 {
        print("Price: \(item.price) ---> Legendary item")
    } else if item.price >= 500 {
        print("Price: \(item.price) ---> Rare item")
    } else {
        print("Price: \(item.price) ---> Common item")
    }
}

//6️⃣ Utiliza switch
///Evalúa el type del item:
/*
 weapon    → "Used for attack"
 armor     → "Increases defense"
 potion    → "Restores health"
 accessory → "Provides special abilities"
*/
for item in inventory {
    switch item.type {
    case .weapon:
        print("Used for attack")
    case .armor:
        print("Increases defense")
    case .potion:
        print("Restores health")
    case .accessory:
        print("Provides special abilities")
    }
}
