//
//  FavoriteMemeCell.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 23.02.2024.
//

import UIKit

final class FavoriteMemeCell: UITableViewCell {
    
    private let memeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(memeImageView)
        contentView.addSubview(questionLabel)
        
        
        let inset: CGFloat = 20
        NSLayoutConstraint.activate([
            memeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            memeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            memeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: inset),
            
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: memeImageView.trailingAnchor, constant: inset * 2)
        ])

    }
    
}
