import UIKit 

//🧑‍💻 Ejercicio: Sistema de pedidos
///Crea un pequeño programa en Swift que simule un sistema de pedidos de una tienda.
///
//Datos iniciales
///1.Crea un Array con los nombres de varios productos:
///"iPhone", "iPad", "MacBook", "AirPods", "Apple Watch"
let productos: [String] = ["iPhone", "iPad", "MacBook", "AirPods", "Apple Watch"]

//2. Crea un Dictionary que contenga el precio de cada producto.
let precioProducto: [String: Int] = [
    "iPhone": 12000,
    "iPad": 8000,
    "MacBook": 25000,
    "AirPods": 5000,
    "Apple Watch": 10000
]

//3. Crea un Set con las categorías disponibles:
///"Electrónica", "Accesorios", "Computación"
let categorias: Set<String> = ["Electrónica", "Accesorios", "Computación"]

//4.Crea un String con el nombre del cliente.
let nomCliente: String = "Oscar" 

//🧑‍💻 Procesamiento
/*
1. Recorre el Array de productos utilizando un for-in.
2. Utiliza un if para imprimir únicamente los productos cuyo precio sea mayor a $10,000.
5. Utiliza .contains() para comprobar si la lista de productos contiene "AirPods".
6. Utiliza .count para mostrar cuántos productos existen.
*/
for producto in productos { 
    if let precio = precioProducto[producto], precio > 10000 {  
        print("Producto: \(producto) --> Precio: $\(precio)")  
    }  
}
print("¿Contiene AirPods? \(productos.contains("AirPods"))")
print("Cantidad de productos: \(productos.count)")

//🛒 Pedido 
///Crea un Array con los productos que el cliente desea comprar.
///Por ejemplo
///"iPhone", "AirPods", "Apple Watch"
let pedidoCompras: [String] = ["iPhone", "AirPods", "Apple Watch"]

/*
 1. Recorre los productos del pedido y busca su precio dentro del Dictionary.
 2. Calcula el total del pedido utilizando operaciones matemáticas.
 3. Utiliza un if:
 - Si el total es mayor a $30,000, imprime "Envío gratis".
 - Si no, imprime "Costo de envío: $500".
*/
var totalPedido: Int = 0
for producto in pedidoCompras {  
    // Asignamos 0 como valor por defecto si no encuentra el producto en el diccionario
    totalPedido += precioProducto[producto] ?? 0  
}

var costoEnvio = ""
if totalPedido > 30000 {
    print("Total del pedido: $\(totalPedido) --> Envio Gratis")
    costoEnvio = "Envío gratis"
} else {
    print("Total del pedido: $\(totalPedido) --> Costo de envío: $500")
    costoEnvio = "Costo de envío: $500"
}

//👤 Información del cliente
///Crea una Tuple que contenga:
///Nombre del cliente, Cantidad de productos, Total de la compra
let infoCliente: (nombreCliente: String, cantidadProductos: Int, totalCompra: Int) = (nomCliente, pedidoCompras.count, totalPedido)

/*
1. Imprime la información utilizando String Interpolation.
 El resultado debería verse aproximadamente así:
 Cliente: César
 Productos: 3
 Total: $XXXXX
 Envío: Gratis
 */
print("Cliente: \(infoCliente.nombreCliente)\nProductos: \(infoCliente.cantidadProductos)\nTotal: $\(infoCliente.totalCompra)\n\(costoEnvio)")

//🎯 Reto adicional
///Agrega una condición para determinar el nivel del cliente:
/*
 Total >= $50,000 → "Cliente Premium"
 Total >= $30,000 → "Cliente Gold"
 Total >= $10,000 → "Cliente Silver"
 Menor a $10,000 → "Cliente Básico"
 */
var nivelCliente: String = ""
if totalPedido >= 50000 {
    nivelCliente = "Cliente Premium"
} else if totalPedido >= 30000 {
    nivelCliente = "Cliente Gold"
} else if totalPedido >= 10000 {            
    nivelCliente = "Cliente Silver"
} else {
    nivelCliente = "Cliente Básico"
}
print("Nivel del cliente: \(nivelCliente)")
