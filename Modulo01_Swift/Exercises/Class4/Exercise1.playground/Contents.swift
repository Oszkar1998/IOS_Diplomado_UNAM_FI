//📝 Exercise: User Notification System

///Crea un pequeño sistema para administrar las notificaciones de una aplicación.

///Este ejercicio debe incluir:
/*
✅ Optionals
✅ Closures
✅ Protocols
✅ Extensions
*/

//📋 Instrucciones
///1. Crear un Protocol

///Crea un protocolo llamado Notifiable.
///Este protocolo debe requerir:
/*
Una propiedad llamada title de tipo String.
Una propiedad llamada message de tipo String.
Una función llamada sendNotification().
*/
///Utiliza { get } o { get set } dependiendo de cómo quieras que se comporte cada propiedad.
protocol Notifiable {
    var title: String {get}
    var message: String {get set}
    
    func sendNotification()
}

//2. Crear un Struct

///Crea un struct llamado Notification.
///Debe tener las siguientes propiedades:
/*
title: String
message: String
userName: String?
date: String?
isRead: Bool
*/
///Haz que este struct adopte el protocolo Notifiable.
struct Notification: Notifiable {
    var title: String
    var message: String
    var userName: String?
    var date: String?
    var isRead: Bool
    
    func sendNotification() {
        print("Sending notification: \(title)")
    }
}


//❓ Optionals
//3. Validar el usuario

///La propiedad: userName: String?
///Utiliza if let para verificar si existe un usuario.
///Ejemplo esperado: Notification for César
let sampleNotification = Notification(title: "Welcome", message: "Hello", userName: "César", date: nil, isRead: false)

//4. Utilizar Nil-Coalescing

///Utiliza el operador: ?? para mostrar una fecha por defecto cuando date sea nil.
///Ejemplo: Date: Unknown


//🧩 Extensions
//5. Crear una Extension para Notification

///Crea una extension Notification.
///Dentro agrega una función llamada: showDetails()
///Esta función debe mostrar:
/*
El título.
El mensaje.
El usuario.
La fecha.
El estado de la notificación.
*/
///Utiliza String Interpolation.
extension Notification {
    func showDetails() {
        print("-----------------------------------")
        print("Title: \(title)")
        print("Message: \(message)")


        if let user = userName {
            print("User: \(user)")
        } else {
            print("User: Guest")
        }

        print("Date: \(date ?? "Unknown")")
        print("Status: \(isRead ? "Read" : "Unread")")
    }
}

//🔌 Protocol Extension
//6. Agregar una implementación por defecto
///Crea una Extension para el protocolo:
//extension Notifiable
///Agrega una implementación por defecto de una función llamada: showNotification()
///Esta función debe mostrar: New notification: [Title]
extension Notifiable {
    func showNotification() {
        print("New notification: \(title)")
    }
}


//🔒 Closures
//7. Crear una función con Closure
///Crea una función llamada: processNotification()
//Esta función debe recibir:
/*
Una notificación.
Una Closure llamada completion.
*/

///La Closure debe recibir un String.
///La función debe procesar la notificación y enviar un mensaje a la Closure.
///La estructura podría ser: completion: (String) -> Void
///
func processNotification(notification: Notification, completion: (String) -> Void) {
    print("Processing notification '\(notification.title)'...")
   
    // Al terminar, enviamos un mensaje a través de la closure
    completion("Notification processed successfully")
}

//8. Utilizar Trailing Closure
///Llama a la función utilizando Trailing Closure Syntax.
///La Closure debe imprimir un mensaje como: Notification processed successfully
let tempNotification = Notification(title: "Welcome", message: "Hello!", userName: "Oscar", date: "2026-09-12", isRead: false)

processNotification(notification: tempNotification) { resultMessage in
    print(resultMessage)
}


//🔄 Collections
///9. Crear un Array de notificaciones
///Crea un Array con al menos 3 notificaciones.
///Algunas deben tener:
/*
Un userName.
userName = nil.
Una date.
date = nil.
*/
let notifications: [Notification] = [
    Notification(title: "Payment Received", message: "You received $500", userName: "César", date: "2026-09-12", isRead: true),
    Notification(title: "System Update", message: "iOS 20 is available", userName: nil, date: "2026-09-10", isRead: false),
    Notification(title: "Security Alert", message: "New login detected", userName: "Oscar", date: nil, isRead: false)
]

//10. Recorrer las notificaciones
///Utiliza un for-in para recorrer todas las notificaciones.
///Para cada una:
/*
Muestra sus detalles utilizando la Extension.
Utiliza la función del Protocol.
Procesa la notificación utilizando la Closure.
*/
print("\n=== EJECUCIÓN DEL SISTEMA DE NOTIFICACIONES ===")

for notif in notifications {
    // a. Muestra la implementación por defecto del Protocol
    notif.showNotification()
   
    // b. Muestra sus detalles desde la Extension
    notif.showDetails()
   
    // c. Procesa la notificación utilizando la Closure (Trailing Closure Syntax)
    processNotification(notification: notif) { status in
        print("Result: \(status)")
    }
    print("-----------------------------------\n")
}

