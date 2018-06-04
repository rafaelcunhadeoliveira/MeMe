//
//  MemeCollectionViewController.swift
//  MeMe
//
//  Created by Rafael Cunha de Oliveira on 03/06/18.
//  Copyright © 2018 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController {
    
    var memes: [Meme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVariables()
    }
    
    func setVariables(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
    }


}
extension MemeCollectionViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        cell.imageCollectionCell.image = self.memes[indexPath.row].memedImage[0]
        return cell
    }
    
    
}
