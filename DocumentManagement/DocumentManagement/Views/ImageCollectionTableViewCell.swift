//
//  ImageCollectionTableViewCell.swift
//  DocumentManagement
//
//  Created by Erik Perez on 11/1/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import UIKit

protocol ImageCollectionTableViewCellDelegate {
    func downloadButtonPressedFor(_ imageCollection: ImageCollection, index: Int)
}

class ImageCollectionTableViewCell: UITableViewCell {
    var imageCollection: ImageCollection!
    var buttonTag: Int!
    var delegate: ImageCollectionTableViewCellDelegate?
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        
        delegate?.downloadButtonPressedFor(imageCollection, index: buttonTag)
        
//        delegate?.downloadButtonPressed(urlString: imageCollection.zippedImagesURL, collectionName: imageCollection.name)
    }
    
}
