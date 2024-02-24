//
//  ViewController.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 19.02.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    private lazy var questionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.placeholder = "Введите свой вопрос здесь"
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var fortuneTellingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Получить предсказание", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(fortuneButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureToHideKeyboard()
        setupLayout()
    }
    
    
    private func setupLayout() {
        view.backgroundColor = .systemGray6
        navigationItem.title = "Fortune Telling By Memes"
        let toFavoritesButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(favoriteButtonAction))
        toFavoritesButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = toFavoritesButton
        
        [questionTextField,
         fortuneTellingButton].forEach { view.addSubview($0) }
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        NSLayoutConstraint.activate([
            questionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            questionTextField.widthAnchor.constraint(equalToConstant: screenSize.width - (screenSize.width / 8) * 2),
            questionTextField.heightAnchor.constraint(equalToConstant: questionTextField.intrinsicContentSize.height * 2),
            
            fortuneTellingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fortuneTellingButton.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 30),
            fortuneTellingButton.widthAnchor.constraint(equalTo: questionTextField.widthAnchor)
        ])
    }
    
    @objc private func fortuneButtonAction() {
        networkManager.fetchMemes { [weak self] result in
            switch result {
            case .success(let memes):
                DispatchQueue.main.async {
                    let destinationVC = FortuneTellingViewController(downloadedMemes: memes, question: self!.questionTextField.text ?? "")
                    self?.navigationController?.pushViewController(destinationVC, animated: true)
                }
            case .failure(let error):
                let alertController = UIAlertController(title: "Error", message: error.title, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .destructive)
                alertController.addAction(alertAction)
            }
        }
    }
    
    @objc private func favoriteButtonAction() {
        navigationController?.pushViewController(FavoritesMemesTableViewController(), animated: true)
    }
    
}
