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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setVariables()
        tableView.reloadData()
    }
    
    func setVariables(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
    }
    
    func formatCellLabel(topString: String, bottomString: String) -> String{
        return topString + " ... " + bottomString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewSegue"{
            if let vc = segue.destination as? DetailViewController{
                let indexPath = tableView.indexPathForSelectedRow!
                vc.image = memes[(indexPath.row)]
            }
        }
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

extension MemeTableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self
        performSegue(withIdentifier: "tableViewSegue", sender: nil)
    }
}

