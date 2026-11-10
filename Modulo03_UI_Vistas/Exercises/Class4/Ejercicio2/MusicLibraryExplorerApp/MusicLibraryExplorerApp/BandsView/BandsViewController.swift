//
//  BandsViewController.swift
//  MusicLibraryExplorerApp
//
//  Created by Oscar Cortes Calderon  on 30/10/26.
//

import Foundation
import UIKit

class BandsViewController: UIViewController {

    private let tableView = UITableView()
    private let viewModel = BandsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bands" // Título
        view.backgroundColor = .systemBackground
        setupTableView()
    }

    // UITableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Visualizacion y acciones de la tabla
        tableView.dataSource = self
        tableView.delegate = self
        
        // Registro de cada celda
        tableView.register(BandTableViewCell.self, forCellReuseIdentifier: BandTableViewCell.reuseIdentifier)
    }
}

extension BandsViewController: UITableViewDataSource {
    
    // Cantidad de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bands.count
    }
    
    // Hace un casteo
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BandTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? BandTableViewCell else {
            return UITableViewCell()
        }
        
        // Se extrae el objeto conforme su indice
        let band = viewModel.bands[indexPath.row]
        cell.configure(with: band)
        return cell
    }
}

extension BandsViewController: UITableViewDelegate {
    
    // fondo al seleccionar 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedBand = viewModel.bands[indexPath.row]
        let discographyVC = DiscographyViewController(band: selectedBand)
        
        // Boton de regresar 
        navigationController?.pushViewController(discographyVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
