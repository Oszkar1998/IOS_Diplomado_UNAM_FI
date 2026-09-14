import UIKit

//🎓 Ejercicio: Sistema de calificaciones
///Crea un programa en Swift que permita procesar las calificaciones de un grupo de estudiantes.

//Datos
///1. Crea un Array con los nombres de 5 estudiantes.
let estudantes: [String] = ["Cesar", "Oscar", "Adrian", "Alfonso", "Axel"]

///2. Crea un Dictionary donde cada estudiante tenga asignada una calificación.
let calificaciones: [String: Int] = [
    "Cesar": 80,
    "Oscar": 95,
    "Adrian": 92,
    "Alfonso": 65,
    "Axel": 50
]
///3. Crea un Set con las materias disponibles(al menos 5):
let materias: Set<String> = ["Swift", "Python", "Java", "C++", "JavaScript"]

///4. Crea un String con el nombre de la materia que se está evaluando.
let materiaEvaluada: String = "Swift"


//Procesamiento
/*
 1. Recorre el Array de estudiantes utilizando for-in.
 2. Para cada estudiante, busca su calificación en el Dictionary.
 3. Utiliza if / else if / else para determinar el resultado:
     90 o más     → "Excelente"
     80 - 89      → "Muy bien"
     70 - 79      → "Aprobado"
     Menos de 70  → "Reprobado"
 Utiliza String Interpolation para mostrar algo como: César obtuvo 95 en Swift: Excelente
 4. Utiliza .count para mostrar cuántos estudiantes hay.
 5. Utiliza .contains() para comprobar si "Swift" está dentro del Set de materias.
 6. Utiliza un switch para mostrar un mensaje dependiendo de la materia:
    Swift   → "Programación en Swift"
*/
for estudiante in estudiantes {  
    if let calificacion = calificaciones[estudiante] {
        if calificacion >= 90 {  
            print("\(estudiante) obtuvo \(calificacion) en \(materiaEvaluada): Excelente")  
        } else if calificacion >= 80 {  
            print("\(estudiante) obtuvo \(calificacion) en \(materiaEvaluada): Muy bien")  
        } else if calificacion >= 70 {  
            print("\(estudiante) obtuvo \(calificacion) en \(materiaEvaluada): Aprobado")  
        } else {  
            print("\(estudiante) obtuvo \(calificacion) en \(materiaEvaluada): Reprobado")  
        }  
    }
}

print("Número de estudiantes: \(estudiantes.count)")
print("¿La materia Swift está en el Set? \(materias.contains("Swift"))")

switch materiaEvaluada {
case "Swift":
    print("Programación en Swift")   
case "Python":
    print("Programación en Python") 
case "Java":
    print("Programación en Java")
case "C++":
    print("Programación en C++")   
case "JavaScript":
    print("Programación en JavaScript")
default:
    print("Materia no registrada")

//📊 Estadísticas
/*
 1. Calcula cuántos estudiantes aprobaron.
 2. Calcula cuántos estudiantes reprobaron.
 3. Calcula el promedio de las calificaciones.
 4. Utiliza un if para determinar si el grupo tuvo un buen desempeño:
     Promedio >= 90 → "Excelente grupo"
     Promedio >= 80 → "Buen grupo"
     Promedio >= 70 → "Grupo aprobado"
     Menor a 70     → "Hay que mejorar"
*/
var aprobados = 0
var reprobados = 0
var sumaCalificaciones = 0
for calificacion in calificaciones.values {
    sumaCalificaciones += calificacion
    if calificacion >= 70 {
        aprobados += 1
    } else {
        reprobados += 1
    }
}
let promedio = Double(sumaCalificaciones) / Double(calificaciones.count)

print("Aprobados: \(aprobados)")
print("Reprobados: \(reprobados)")
print("Promedio: \(promedio)")

if promedio >= 90 {
    print("Excelente grupo")
} else if promedio >= 80 {
    print("Buen grupo")
} else if promedio >= 70 {
    print("Grupo aprobado")
} else {
    print("Hay que mejorar")
}

//📦 Tuple
///Crea una Tuple que contenga:
/*
 Materia
 Número de estudiantes
 Promedio
*/
let tupla1 = (materiaEvaluada, estudiantes.count, promedio)
print("Materia: \(tupla1.0), Número de estudiantes: \(tupla1.1), Promedio: \(tupla1.2)")
