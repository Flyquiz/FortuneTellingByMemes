//
//  FavoritesMemesTableViewController.swift
//  FortuneTellingByMemes
//
//  Created by Иван Захаров on 23.02.2024.
//

import UIKit

final class FavoritesMemesTableViewController: UITableViewController {
    
    private let dataStorе = DataStore.shared
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        let screenSize = UIScreen.main.bounds
        label.frame = CGRect(x: screenSize.width / 5.5, y: 50, width: 300, height: 50)
        label.text = "Can't find saved memes"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(FavoriteMemeCell.self, forCellReuseIdentifier: FavoriteMemeCell.identifier)
        if dataStorе.memes.count == 0 {
            view.addSubview(warningLabel)
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStorе.memes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMemeCell.identifier, for: indexPath) as! FavoriteMemeCell
        cell.setupCell(meme: dataStorе.memes[indexPath.row])
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataStorе.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
}
