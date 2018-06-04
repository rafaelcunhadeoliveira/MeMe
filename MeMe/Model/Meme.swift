//
//  Meme.swift
//  MeMe
//
//  Created by Rafael Cunha de Oliveira on 03/06/18.
//  Copyright © 2018 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class Meme: NSObject {
    var topString: String
    var bottomString: String
    var originalImage: UIImage
    var memedImage: [UIImage]

    init(topString: String, bottomString: String, originalImage: UIImage, memedImage: [UIImage]) {
        self.topString = topString
        self.bottomString = bottomString
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    convenience override init() {
        self.init(topString: "", bottomString: "", originalImage: UIImage(), memedImage: [UIImage()])
    }
    
}
