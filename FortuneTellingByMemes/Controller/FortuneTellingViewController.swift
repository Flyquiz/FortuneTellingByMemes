//
//  FortuneTellingViewController.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 19.02.2024.
//

import UIKit

final class FortuneTellingViewController: UIViewController {
    
    private let downloadedMemes: [Meme]
    
    private var question: String
    
    //MARK: - UIElements
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let memeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let imageCover: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = false
        return view
    }()

    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 40
        button.alpha = 0.5

        let symbolFont = UIFont.systemFont(ofSize: 50)
        let configuration = UIImage.SymbolConfiguration(font: symbolFont)
        let symbolImage = UIImage(systemName: "hand.thumbsup.fill", withConfiguration: configuration)
        button.setImage(symbolImage, for: .normal)
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(acceptAction), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var rejectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 40
        button.alpha = 0.5
        
        let symbolFont = UIFont.systemFont(ofSize: 50)
        let configuration = UIImage.SymbolConfiguration(font: symbolFont)
        let symbolImage = UIImage(systemName: "hand.thumbsdown.fill", withConfiguration: configuration)
        button.setImage(symbolImage, for: .normal)
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(rejectAction), for: .touchUpInside)
        button.isUserInteractionEnabled = false
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
    
    //MARK: - LifeCycle
    required init(downloadedMemes: [Meme], question: String) {
        self.downloadedMemes = downloadedMemes
        self.question = question
        self.questionLabel.text = question
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchMemeImage()
        animateImageCover(isTransparent: imageCover.isHidden)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        memeImageView.addSubview(imageCover)
        imageCover.frame = memeImageView.frame
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
    
    //MARK: Networking
    private func fetchMemeImage() {
        let randomMeme = downloadedMemes.randomElement()
        guard let randomMeme else { return }
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let imageData = try? Data(contentsOf: randomMeme.url) else { return }
            DispatchQueue.main.async {
                self?.memeImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    //MARK: Actions
    @objc private func rejectAction() {
        animateImageCover(isTransparent: imageCover.isHidden)
    }
    
    @objc private func acceptAction() {}
    
    //MARK: Animations
    private func animateImageCover(isTransparent: Bool) {
        
        enum Durations {
            case toHideImage
            case toShowImage
            case toButtons
            
            var values: Double {
                switch self {
                case .toHideImage:
                    return 0.25
                case .toShowImage:
                    return 2
                case .toButtons:
                    return 0.25
                }
            }
        }
        
        switch isTransparent {
        case true:
            acceptButton.isUserInteractionEnabled = false
            rejectButton.isUserInteractionEnabled = false
            imageCover.isHidden = !isTransparent
            
            UIView.animate(withDuration: Durations.toHideImage.values, 
                           delay: 0,
                           options: .curveEaseInOut) { [self] in
                imageCover.alpha = 1
                acceptButton.alpha = 0.5
                rejectButton.alpha = 0.5
                
            } completion: { [self] bool in
                fetchMemeImage()
                animateImageCover(isTransparent: imageCover.isHidden)
            }
            
        case false:
            UIView.animate(withDuration: Durations.toShowImage.values, 
                           delay: 1.0,
                           options: .curveEaseInOut) {
                self.imageCover.alpha = 0
                
            } completion: { _ in
                self.imageCover.isHidden = !isTransparent
                UIView.animate(withDuration: Durations.toButtons.values) {
                    self.acceptButton.alpha = 1.0
                    self.rejectButton.alpha = 1.0
                    
                } completion: { bool in
                    self.acceptButton.isUserInteractionEnabled = bool
                    self.rejectButton.isUserInteractionEnabled = bool
                }
            }
        }
    }
}
