//
//  MemeTableViewController.swift
//  MeMe
//
//  Created by Rafael Cunha de Oliveira on 03/06/18.
//  Copyright © 2018 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController {
    
    var memes: [Meme] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setVariables()
    }
    
    func setVariables(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
    }
    
    func formatCellLabel(topString: String, bottomString: String) -> String{
        return topString + " ... " + bottomString
    }

}
extension MemeTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell") as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.imageTableViewCell.image = meme.memedImage[0]
        cell.labelTableViewCell.text = formatCellLabel(topString: meme.topString, bottomString: meme.bottomString)
        return cell
    }
}

