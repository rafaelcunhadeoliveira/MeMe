//
//  DetailViewController.swift
//  MeMe
//
//  Created by Rafael Cunha de Oliveira on 15/06/18.
//  Copyright © 2018 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    public var image: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = image.memedImage[0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        toolBarController(setHidden: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        toolBarController(setHidden: false)
    }
    
    func toolBarController(setHidden: Bool){
        self.tabBarController?.tabBar.isHidden = setHidden
    }

}
