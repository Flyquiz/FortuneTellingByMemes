//
//  FortuneTellingViewController.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 19.02.2024.
//

import UIKit

final class FortuneTellingViewController: UIViewController {
    
    //MARK: UIElements
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEXTTEXTTEXTTEXTTEXTTEXTTEXTTEXT"
        return label
    }()
    
    private let memeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()
    
    private lazy var rejectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()
    
    //MARK: StackViews
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    
    //MARK: Layout
    private func setupLayout() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(questionLabel)
        view.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(memeImageView)
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(acceptButton)
        horizontalStackView.addArrangedSubview(rejectButton)
        
        let inset: CGFloat = 20
        let screenSize: CGSize = UIScreen.main.bounds.size
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset * 2),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            questionLabel.heightAnchor.constraint(equalToConstant: questionLabel.intrinsicContentSize.height),
            
            verticalStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            
            memeImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 3),
            memeImageView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            memeImageView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            
            acceptButton.widthAnchor.constraint(equalToConstant: screenSize.width / 3),
            acceptButton.heightAnchor.constraint(equalToConstant: screenSize.width / 4.5),
            
            rejectButton.widthAnchor.constraint(equalTo: acceptButton.widthAnchor),
            rejectButton.heightAnchor.constraint(equalTo: acceptButton.heightAnchor)
        ])
    }
}
