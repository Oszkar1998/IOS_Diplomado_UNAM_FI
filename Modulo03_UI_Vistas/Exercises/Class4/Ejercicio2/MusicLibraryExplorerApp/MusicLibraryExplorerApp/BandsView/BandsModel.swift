import Foundation

// Canción individual
struct Song {
    let title: String
    let duration: String
}

// Álbum con sus canciones integradas
struct Album {
    let title: String
    let releaseYear: Int
    let coverImage: String
    let songs: [Song]
}

// Banda / Artista con sus álbumes integrados
struct Band {
    let name: String
    let imageName: String
    let albums: [Album]
}

class BandsModel {
    
    let bands: [Band] = [
        // Fuerza Regida
        Band(
            name: "Fuerza Regida",
            imageName: "FuerzaRegida",
            albums: [
                Album(
                    title: "Pa las Baby's y Belikeada",
                    releaseYear: 2023,
                    coverImage: "PaLasBabysBlikiada",
                    songs: [
                        Song(title: "Sabor a Fresa", duration: "2:45"),
                        Song(title: "Qué Onda", duration: "3:10"),
                        Song(title: "Harley Quinn", duration: "2:23")
                    ]
                ),
                Album(
                    title: "Pero No Te Enamores",
                    releaseYear: 2024,
                    coverImage: "PeroNoTeEnamores",
                    songs: [
                        Song(title: "Se Logró", duration: "2:52"),
                        Song(title: "Nel", duration: "2:35"),
                        Song(title: "Kurioki", duration: "2:40")
                    ]
                )
            ]
        ),
        
        // Peso Pluma
        Band(
            name: "Peso Pluma",
            imageName: "PesoPluma",
            albums: [
                Album(
                    title: "GÉNESIS",
                    releaseYear: 2023,
                    coverImage: "Genesis",
                    songs: [
                        Song(title: "AMG", duration: "3:04"),
                        Song(title: "PRC", duration: "3:05"),
                        Song(title: "LADY GAGA", duration: "3:05")
                    ]
                ),
                Album(
                    title: "ÉXODO",
                    releaseYear: 2024,
                    coverImage: "Exodo",
                    songs: [
                        Song(title: "Bruce Wayne", duration: "2:42"),
                        Song(title: "Chiclona", duration: "3:00"),
                        Song(title: "La People II", duration: "3:13")
                    ]
                )
            ]
        ),
        
        // Xavi & Eme MalaFe
        Band(
            name: "Xavi & Eme MalaFe",
            imageName: "Xavi",
            albums: [
                Album(
                    title: "My Baby's Firm",
                    releaseYear: 2024,
                    coverImage: "MyBabysFirm",
                    songs: [
                        Song(title: "Corazón de Piedra", duration: "3:08"),
                        Song(title: "La Víctima", duration: "3:16"),
                        Song(title: "Diabla", duration: "2:54")
                    ]
                ),
                Album(
                    title: "Bélicos y Callejeros",
                    releaseYear: 2023,
                    coverImage: "BelikosYCallejeros",
                    songs: [
                        Song(title: "La Brabus", duration: "3:20"),
                        Song(title: "Brillosa", duration: "2:48"),
                        Song(title: "Dopamina", duration: "2:55")
                    ]
                )
            ]
        )
    ]
}
