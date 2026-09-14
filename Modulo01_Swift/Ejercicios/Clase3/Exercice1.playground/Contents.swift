import UIKit

//🛍️ Exercise: Store Management
///Crea un pequeño sistema para administrar los productos de una tienda.

///1. Crea una class llamada Product con las siguientes propiedades:
/*
 name
 price
 category [ENUM]
 stock
*/

///2. Crea un struct llamado Customer con:
/*
 name:
 age:
 isMember:
*/

///3. Crea una class llamada PremiumProduct que herede de Product.
///4. Dentro de Product, crea una función showInfo() que muestre el nombre, precio y categoría del producto.
///5. Haz Method Overriding en PremiumProduct para que showInfo() muestre también que el producto es Premium.
///6. Crea un Array con diferentes productos(al menos 5). Incluye al menos un PremiumProduct.
///8. Crea un Dictionary que almacene el descuento de cada categoría.
///9. Crea un Customer y utiliza sus datos para determinar si puede obtener un descuento adicional.
///10. Crea una función calculatePrice() que reciba:
/*
El precio.
La cantidad.
*/
///La función debe regresar el total de la compra.
///11. Crea otra función calculatePrice() con Function Overloading que reciba únicamente el precio y aplique un descuento del 10%.
///12. Utiliza un for-in para recorrer todos los productos.
///13. Utiliza if / else para verificar:
/*
Si el producto tiene stock.
Si el cliente es miembro.
*/
///14. Utiliza un switch para mostrar un mensaje dependiendo de la categoría:
///15. Utiliza String Interpolation para mostrar la información de cada producto.
///16. Al final, muestra:
/*
 Nombre del cliente.
 Número de productos disponibles.
 Categorías disponibles.
 Precio final de cada producto.
 Si el cliente recibió un descuento adicional.
*/

// Punto 1
enum Category: String {
    case ropa = "Ropa"
    case calzado = "Calzado"
    case accesorios = "Accesorios"
    case electronica = "Electrónica"
    case hogar = "Hogar"
}

class Product {
    var name: String
    var price: Double
    var category: Category
    var stock: Int
    
    init(name: String, price: Double, category: Category, stock: Int) {
        self.name = name
        self.price = price
        self.category = category
        self.stock = stock
    }
    
    // Punto 4
    func showInfo() {
        print("Nombre: \(name), Precio: \(price), Categoría: \(category.rawValue)")
    }
}

// Punto 2
struct Customer {
    var name: String
    var age: Int
    var isMember: Bool
}

// Punto 10
func calculatePrice(price: Double, quantity: Int) -> Double {
    return price * Double(quantity)
}

// Punto 11
func calculatePrice(price: Double) -> Double {
    return price * 0.90
}

// Punto 3 y 5
class PremiumProduct: Product {
    override func showInfo() {
        print("Nombre: \(name), Precio: \(price), Categoría: \(category.rawValue) --> El Producto es Premium")
    }
}

// Punto 6
let productos: [Product] = [
    Product(name: "Camiseta", price: 200.0, category: .ropa, stock: 10),
    Product(name: "Celular", price: 8000.0, category: .electronica, stock: 5),
    PremiumProduct(name: "Zapatos de lujo", price: 15000.0, category: .calzado, stock: 2),
    Product(name: "Gorra", price: 300.0, category: .accesorios, stock: 0),
    PremiumProduct(name: "Bolso de lujo", price: 18000.0, category: .accesorios, stock: 3)
]

// Punto 8 
let descuentos: [Category: Double] = [
    .ropa: 0.10,
    .calzado: 0.15,
    .accesorios: 0.20,
    .electronica: 0.5,
    .hogar: 0.15
]

// Punto 9
let cliente = Customer(name: "Oscar", age: 30, isMember: true)

// Punto 12
for producto in productos {
    producto.showInfo()
    
    // Punto 13
    if producto.stock > 0 {
        print("El producto \(producto.name) tiene stock disponible.")
    } else {
        print("El producto \(producto.name) está agotado.")
    }
    
    if cliente.isMember {
        print("El cliente \(cliente.name) es miembro y puede obtener descuentos adicionales.")
    } else {
        print("El cliente \(cliente.name) no es miembro y no puede obtener descuentos adicionales.")
    }
    
    // Punto 14
    switch producto.category {
    case .ropa:
        print("Categoría: Ropa")
    case .calzado:
        print("Categoría: Calzado")
    case .accesorios:
        print("Categoría: Accesorios")
    case .electronica:
        print("Categoría: Electrónica")
    case .hogar:
        print("Categoría: Hogar")
    }
    
    // Punto 15
    let precioFinal = calculatePrice(price: producto.price, quantity: 1)
    print("Precio final del producto \(producto.name): \(precioFinal)")
    
    if cliente.isMember {
        let precioConDescuento = calculatePrice(price: precioFinal)
        print("Precio con descuento adicional para el cliente \(cliente.name): \(precioConDescuento)")
    }
}

// Punto 16
var productosDisponiblesCount = 0
var categoriasExistentes: Set<String> = []

print("\n--- RESUMEN FINAL DE LA TIENDA ---")
print("Nombre del cliente: \(cliente.name)")

for producto in productos {
    if producto.stock > 0 {
        productosDisponiblesCount += 1
    }
    categoriasExistentes.insert(producto.category.rawValue)
    
    // Cálculo del precio final con descuento de categoría y de miembro
    let descCat = descuentos[producto.category] ?? 0.0
    var pFinal = producto.price * (1.0 - descCat)
    if cliente.isMember {
        pFinal = calculatePrice(price: pFinal)
    }
    print("Precio final de '\(producto.name)': $\(pFinal)")
}

print("Número de productos disponibles con stock: \(productosDisponiblesCount)")
print("Categorías disponibles en tienda: \(categoriasExistentes)")

if cliente.isMember {
    print("El cliente recibió un descuento adicional por ser Miembro: SÍ")
} else {
    print("El cliente recibió un descuento adicional por ser Miembro: NO")
}