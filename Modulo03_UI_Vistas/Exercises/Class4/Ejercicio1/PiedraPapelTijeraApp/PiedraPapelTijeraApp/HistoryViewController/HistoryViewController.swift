//
//  HistoryViewController.swift
//  PiedraPapelTijeraApp
//
//  Created by Oscar Cortes Calderon  on 16/10/26.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var historyList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = "Historial de Rondas"
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        tableView.backgroundColor = .systemGroupedBackground
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.isEmpty ? 1 : historyList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)

        if historyList.isEmpty {
            var content = cell.defaultContentConfiguration()
            content.text = "No hay jugadas registradas aún."
            content.textProperties.color = .secondaryLabel
            content.textProperties.alignment = .center
            cell.contentConfiguration = content
        } else {
            var content = cell.defaultContentConfiguration()
            content.text = historyList[indexPath.row]
            content.textProperties.font = .systemFont(ofSize: 16, weight: .medium)
            
            if historyList[indexPath.row].contains("Ganaste") {
                content.image = UIImage(systemName: "checkmark.circle.fill")
                content.imageProperties.tintColor = .systemGreen
            } else if historyList[indexPath.row].contains("Perdiste") {
                content.image = UIImage(systemName: "xmark.circle.fill")
                content.imageProperties.tintColor = .systemRed
            } else {
                content.image = UIImage(systemName: "minus.circle.fill")
                content.imageProperties.tintColor = .systemGray
            }
            
            cell.contentConfiguration = content
        }

        return cell
    }
}
