//
//  ViewController.swift
//  FirstFunctionalApp
//
//  Created by Luis Fernando Gutierrez Orozpe on 26/09/26.
//

import UIKit

struct Album {
    let imageName: String
    let title: String
    let backgroundColor: UIColor
}

class ViewController: UIViewController {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    private var albumInfo: [Album] = [
        Album(imageName: "Parachutes", title: "Parachutes", backgroundColor: .black),
        Album(imageName: "AROBTTH", title: "A Rush Of Blood To The Head", backgroundColor: .white),
        Album(imageName: "X&Y", title: "X&Y", backgroundColor: .blue),
        Album(imageName: "Viva", title: "Viva la vida", backgroundColor: .brown),
        Album(imageName: "MX", title: "Mylo Xyloto", backgroundColor: .white),
        Album(imageName: "GS", title: "Ghost Stories", backgroundColor: .blue),
        Album(imageName: "AHFOD", title: "A Head Full Of Dreams", backgroundColor: .green),
        Album(imageName: "Everyday", title: "Everyday Life", backgroundColor: .black),
        Album(imageName: "MOTS", title: "Music Of The Spheres", backgroundColor: .blue),
        Album(imageName: "Moon", title: "Moon Music", backgroundColor: .blue)
    ]
    private var currentImageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1 - viewDidLoad")
        firstButton.setTitle("Album Siguiente", for: .normal)
        secondButton.setTitle("Album anterior", for: .normal)
        thirdButton.setTitle("Restaurar", for: .normal)
        currentImageIndex = 4
        albumImageView.image = UIImage(named: albumInfo [currentImageIndex].imageName)
        
        /// COFIGURAR LABEL
        albumTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        albumTitleLabel.textAlignment = .center
        albumTitleLabel.numberOfLines = 1
        albumTitleLabel.lineBreakMode = .byTruncatingTail
        albumTitleLabel.text = albumInfo[currentImageIndex].title
        
        /// CONFIGURAR BACKGROUND
        view.backgroundColor = albumInfo[currentImageIndex].backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2 - viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("3 - viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("4 - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("5 - viewDidDisappear")
    }
    
    @IBAction func firstButtonPressed(_ sender: UIButton) {
        if currentImageIndex < albumInfo.count - 1 {
            currentImageIndex += 1
            albumImageView.image = UIImage(named: albumInfo[currentImageIndex].imageName)
            albumTitleLabel.text = albumInfo[currentImageIndex].title
            view.backgroundColor = albumInfo[currentImageIndex].backgroundColor
        }
    }
    
    
    @IBAction func secondButtonPressed(_ sender: UIButton) {
        if currentImageIndex > 0 {
            currentImageIndex -= 1
            albumImageView.image = UIImage(named: albumInfo[currentImageIndex].imageName)
            albumTitleLabel.text = albumInfo[currentImageIndex].title
            view.backgroundColor = albumInfo[currentImageIndex].backgroundColor
        }
    }
    
    
    @IBAction func thirdButtonPressed(_ sender: UIButton) {
        currentImageIndex = 4
        albumImageView.image = UIImage(named: albumInfo[currentImageIndex].imageName)
        albumTitleLabel.text = albumInfo[currentImageIndex].title
        view.backgroundColor = .systemBackground
        view.backgroundColor = albumInfo[currentImageIndex].backgroundColor
    }
}

