//
//  SongDetailViewController.swift
//  MusicLibraryExplorerApp
//
//  Created by Oscar Cortes Calderon  on 30/10/26.
//

import Foundation
import UIKit

class SongDetailViewController: UIViewController {

    private let band: Band
    private let album: Album
    private let song: Song

    // Visualizacion del ScrollView y contentView
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // Imagen de la portada del álbum
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Título de la canción
    private let songTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Nombre de la banda
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Información del álbum y año
    private let albumInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Duración de la canción
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Recibe todos los datos requeridos
    init(band: Band, album: Album, song: Song) {
        self.band = band
        self.album = album
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = song.title // El título
        view.backgroundColor = .systemBackground
        
        setupLayout()
        configureData()
    }

    // Configuración del ScrollView, StackView y Auto Layout
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Usamos un UIStackView vertical para ordenar los elementos automáticamente
        let stackView = UIStackView(arrangedSubviews: [
            albumCoverImageView,
            songTitleLabel,
            artistLabel,
            albumInfoLabel,
            durationLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            // (Safe Area)
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // Anclajes del ContentView al ScrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            // Tamaño de la imagen de portada
            albumCoverImageView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }

    // Asignación de datos a los controles visuales en caso de que no haya imagen 
    private func configureData() {
        songTitleLabel.text = song.title
        artistLabel.text = band.name
        albumInfoLabel.text = "Álbum: \(album.title) (\(album.releaseYear))"
        durationLabel.text = "Duración: \(song.duration)"
        albumCoverImageView.image = UIImage(named: album.coverImage) ?? UIImage(systemName: "music.note.list")
    }
}
