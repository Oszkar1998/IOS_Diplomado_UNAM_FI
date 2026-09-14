import UIKit

//Proyecto Final: Task Manager

///Crear una pequeña aplicación de consola para administrar tareas personales.
///El programa permitirá crear, consultar, completar y eliminar tareas, además de mostrar estadísticas básicas.

//1. Modelo de datos

//Crear un enum para las prioridades:
enum Priority {
    case low
    case medium
    case high
}

//Crear un enum para el estado:
enum TaskStatus {
    case pending
    case completed
}

//2.Crear un struct Task, crea almenos 10 elementos:
/*
id Int
title
description?
priority
status
estimatedMinutes?
*/
//Nota: Incluye 5 elementos con valores opcionales usa if let para retornar valores default o nulos
struct Task {
    let id: Int
    var title: String
    var description: String?
    var priority: Priority
    var status: TaskStatus
    var estimatedMinutes: Int?
    
    func getDescriptionOrDefault() -> String {
        guard let desc = description else {
            return "No description provided"
        }
        return desc
    }
            
    func getEstimatedMinutesOrDefault() -> Int {
        guard let minutes = estimatedMinutes else {
            return 0
        }
        return minutes
    }
}

//4. Crear una extension de Task que contenga la implementación del siguiente protocolo, este debe imprimir un resumen de las tareas (titulo, descripción y horas)
protocol Describable {
    func getSummary(task: Task) -> String
}

extension Task: Describable {
    func getSummary(task: Task) -> String {
        let desc = task.getDescriptionOrDefault()
        let minutes = task.getEstimatedMinutesOrDefault()
        let hours = Double(minutes) / 60.0
        
        return "Task: '\(task.title)' | Description: '\(desc)' | Estimated Time: \(hours) hours (\(minutes) mins)"
    }
}

//3. Class

///Crear una clase: class TaskManager
///La clase será responsable de administrar las tareas.
///Debe tener como mínimo: var tasks: [Task]
//Y métodos para:
/*
Agregar tarea (Task)
Eliminar tarea (Task)
Completar tarea (Int)
Buscar tarea (Int) -> Task?
Mostrar tareas () print("Todos los atributos de cada task almacenada")
*/
//Nota: Usar todos los metodos al menos una vez, tambien usa .firstIndex(where: {}) para encontrar los atributos

class TaskManager {
    var tasks: [Task] = []
    
    // Agregar tarea
    func addTask(_ task: Task) {
        tasks.append(task)
        print("Task: \(task.title) added successfully")
    }
    
    // Eliminar tareas
    func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let removedTask = tasks.remove(at: index)
            print("Task '\(removedTask.title)' removed successfully.")
        } else {
            print("Task not found.")
        }
    }
    
    // Completar tarea
    func completedTask(id: Int) {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].status = .completed
            print("Task '\(tasks[index].title)' marked as completed.")
        } else {
            print("Task with ID \(id) not found.")
        }
    }
    
    // Buscar tarea
    func findTask(id: Int) -> Task? {
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            return tasks[index]
        }
        return nil
    }
    
    // Mostrar tarea
    func showTask() {
        print("\n--- ALL STORED TASKS ---")
        for task in tasks {
            print("ID: \(task.id)")
            print("Title: \(task.title)")
            print("Description: \(task.getDescriptionOrDefault())")
            print("Priority: \(task.priority)")
            print("Status: \(task.status)")
            print("Estimated Minutes: \(task.getEstimatedMinutesOrDefault())")
            print("Summary: \(task.getSummary(task: task))")
            print("-----------------------------------")
        }
    }
    
    //5. También crear una función que calcule estadísticas, la salida debe ser así:
    //===== STATISTICS =====
    //
    //Total tasks: 10
    //Completed: 6
    //Pending: 4
    //
    //High priority: 3
    //Medium priority: 4
    //Low priority: 3
    //
    //Estimated time: 420 minutes
    //Completion: 60%
    func printStatistics() {
        let totalTasks = tasks.count
        var completedCount = 0
        var pendingCount = 0
            
        var highPriorityCount = 0
        var mediumPriorityCount = 0
        var lowPriorityCount = 0
            
        var totalMinutes = 0
            
        for task in tasks {
            // Conteo por estado
            if task.status == .completed {
                completedCount += 1
            } else {
                pendingCount += 1
            }
                
            // Conteo por prioridad
            switch task.priority {
            case .high:
                highPriorityCount += 1
            case .medium:
                mediumPriorityCount += 1
            case .low:
                lowPriorityCount += 1
            }
                
            // Suma de minutos estimados usando guard let a través del método auxiliar
            totalMinutes += task.getEstimatedMinutesOrDefault()
        }
            
        // Cálculo del porcentaje de completado (evitando división entre cero)
        let completionPercentage: Int
        if totalTasks > 0 {
            completionPercentage = Int((Double(completedCount) / Double(totalTasks)) * 100)
        } else {
            completionPercentage = 0
        }
        
        print("\n===== STATISTICS =====")
        print("\nTotal tasks: \(totalTasks)")
        print("Completed: \(completedCount)")
        print("Pending: \(pendingCount)")
        print("\nHigh priority: \(highPriorityCount)")
        print("Medium priority: \(mediumPriorityCount)")
        print("Low priority: \(lowPriorityCount)")
        print("\nEstimated time: \(totalMinutes) minutes")
        print("Completion: \(completionPercentage)%\n")
    }
}

// Instancia del Administrador de Tareas
let manager = TaskManager()

// Creación de 10 tareas con IDs enteros (Int)
let task1 = Task(id: 1, title: "Study Swift Optionals", description: "Review if let and guard let", priority: .high, status: .completed, estimatedMinutes: 60)
let task2 = Task(id: 2, title: "Buy groceries", description: nil, priority: .medium, status: .completed, estimatedMinutes: 45)
let task3 = Task(id: 3, title: "Prepare presentation", description: "Create slides for Class 3", priority: .high, status: .pending, estimatedMinutes: 120)
let task4 = Task(id: 4, title: "Clean room", description: nil, priority: .low, status: .pending, estimatedMinutes: nil)
let task5 = Task(id: 5, title: "Workout", description: "Leg day at gym", priority: .medium, status: .completed, estimatedMinutes: 90)
let task6 = Task(id: 6, title: "Read Swift book", description: nil, priority: .low, status: .completed, estimatedMinutes: 30)
let task7 = Task(id: 7, title: "Pay Internet bill", description: "Use banking app", priority: .high, status: .pending, estimatedMinutes: 15)
let task8 = Task(id: 8, title: "Walk dog", description: nil, priority: .medium, status: .completed, estimatedMinutes: 30)
let task9 = Task(id: 9, title: "Update resume", description: "Add iOS Diplomado certification", priority: .medium, status: .pending, estimatedMinutes: nil)
let task10 = Task(id: 10, title: "Organize desk", description: nil, priority: .low, status: .completed, estimatedMinutes: 30)

// Agregar las 10 tareas al Manager
manager.addTask(task1)
manager.addTask(task2)
manager.addTask(task3)
manager.addTask(task4)
manager.addTask(task5)
manager.addTask(task6)
manager.addTask(task7)
manager.addTask(task8)
manager.addTask(task9)
manager.addTask(task10)

// 1. Mostrar todas las tareas
manager.showTask()

// 2. Buscar tarea por Int
if let foundTask = manager.findTask(id: 3) {
    print("\nFound task: \(foundTask.title)")
}

// 3. Completar tarea por Int ID
manager.completedTask(id: 3)

// 4. Eliminar tarea
manager.removeTask(task10)

// 5. Imprimir estadísticas
manager.printStatistics()

