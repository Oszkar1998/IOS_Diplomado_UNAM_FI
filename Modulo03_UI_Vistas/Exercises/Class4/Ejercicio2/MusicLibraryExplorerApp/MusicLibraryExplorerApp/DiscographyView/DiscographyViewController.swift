//
//  DiscographyViewController.swift
//  MusicLibraryExplorerApp
//
//  Created by Oscar Cortes Calderon  on 30/10/26.
//

import Foundation
import UIKit

class DiscographyViewController: UIViewController {

    private let band: Band
    private let tableView = UITableView(frame: .zero, style: .grouped)

    init(band: Band) {
        self.band = band
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = band.name // El título de la banda seleccionada
        view.backgroundColor = .systemBackground
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Registramos una celda
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SongCell")
    }
}

extension DiscographyViewController: UITableViewDataSource {

    // Divide la tabla por albunes
    func numberOfSections(in tableView: UITableView) -> Int {
        return band.albums.count
    }

    // Determina el numnero de canciones
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return band.albums[section].songs.count
    }

    // Nombre de album y año
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let album = band.albums[section]
        return "\(album.title) - \(album.releaseYear)"
    }

    // Visualizacion de cada fila/cancion
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell")
            ?? UITableViewCell(style: .value1, reuseIdentifier: "SongCell")
        
        let song = band.albums[indexPath.section].songs[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = song.title
        content.secondaryText = song.duration
        content.textProperties.font = .systemFont(ofSize: 16, weight: .medium)
        content.secondaryTextProperties.color = .secondaryLabel
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension DiscographyViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Cancion que se pulsa
        let selectedAlbum = band.albums[indexPath.section]
        let selectedSong = selectedAlbum.songs[indexPath.row]

        // Navegamos a la pantalla de la cancion
        let detailVC = SongDetailViewController(band: band, album: selectedAlbum, song: selectedSong)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
