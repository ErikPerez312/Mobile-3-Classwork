//
//  ImageCollection.swift
//  DocumentManagement
//
//  Created by Erik Perez on 11/1/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import Foundation
import UIKit

struct ImageCollection {
    var name: String
    var zippedImagesURL: String
    var unzippedImageURLS = [URL]()
    var images = [UIImage]()
    
    init (name: String, zippedImagesURL: String) {
        self.name = name
        self.zippedImagesURL = zippedImagesURL
    }
}

extension ImageCollection: Decodable {
    enum ImageCollectionKeys: String, CodingKey {
        case name = "collection_name"
        case zippedImagesURL = "zipped_images_url"
    }
    
    init(from decoder: Decoder) throws {
        let imageCollectionContainer = try decoder.container(keyedBy: ImageCollectionKeys.self)
        let name = try imageCollectionContainer.decode(String.self, forKey: .name)
        let url = try imageCollectionContainer.decode(String.self, forKey: .zippedImagesURL)
        
        self.init(name: name, zippedImagesURL: url)
    }
}
