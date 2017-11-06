//
//  ImageCollectionsTableViewController.swift
//  DocumentManagement
//
//  Created by Erik Perez on 11/1/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import UIKit
import Zip


class ImageCollectionsTableViewController: UITableViewController {
    var imageCollections = [ImageCollection]() {
        didSet{
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let url = URL(string: "https://api.myjson.com/bins/17ge17")!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            if let data = data {
                let decodedCollections = try? JSONDecoder().decode([ImageCollection].self, from: data)
                guard let collections = decodedCollections else { fatalError("Image Collections failed to be decoded") }
                
                self.imageCollections = collections
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageCollections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCollectionCell", for: indexPath) as! ImageCollectionTableViewCell
        
//        DispatchQueue.main.async {
//            var images = self.imageCollections[indexPath.row].unzippedImageURLS {
//                didSet{
//                    if let image = UIImage(contentsOfFile: images[0].absoluteString){
//                        print("success")
//                    }else {
//                        print("image failed")
//                    }
//                }
//            }
//        }
        
        let link = imageCollections[indexPath.row].unzippedImageURLS[0]
        
        if let image = UIImage(contentsOfFile: link.absoluteString) {
            print("success")
        }else {
            print("failed")
        }
        
//        let link = imageCollections[indexPath.row].unzippedImageURLS[0]
//        
//        if let image = UIImage(contentsOfFile: link.absoluteString) {
//            print("success")
//        }else {
//            print("failed")
//        }
        cell.imageCollection = imageCollections[indexPath.row]
        cell.delegate = self
        cell.buttonTag = indexPath.row
        
        cell.previewImageView.image = UIImage(named: "not-available")
        cell.collectionNameLabel.text = imageCollections[indexPath.row].name
        
        
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

extension ImageCollectionsTableViewController: ImageCollectionTableViewCellDelegate {
    func downloadButtonPressedFor(_ imageCollection: ImageCollection, index: Int) {
        
        ZipProcessor.downloadImageCollectionFrom(imageCollection.zippedImagesURL) { tempURL, zipURL in
            let folderName = ZipProcessor.unzipFileAt(tempURL, zipURL: zipURL)
            if let folderName = folderName {
                let imageURLS = ZipProcessor.extractImagesFromFolderNamed(folderName)
                
                if let imageURLS = imageURLS {
//                    imageURLS.forEach { print($0) }
                    
                    let filteredImageUrls = imageURLS.filter({ (url) -> Bool in
                        return url.pathExtension == "jpg" || url.pathExtension == "jpeg"
                    })
                    
                    print("filtered counts", filteredImageUrls.count)
//                    for url in filteredImageUrls {
//                        let str = url.absoluteString
//                        let image = UIImage(contentsOfFile: str)
//                        if let image = image {
//                            self.imageCollections[index].images.append(image)
//                        }else {
//                            print("url to IMage failed00000000000")
//                        }
//                        self.imageCollections[index].images.append()
//                        print(self.imageCollections[index].images.count, "88888888888")
//                    }
                    self.imageCollections[index].unzippedImageURLS = filteredImageUrls
//                    for item in self.imageCollections[index].unzippedImageURLS {
//                        print("=======", item, "========")
//                    }
//                    print(self.imageCollections[index].unzippedImageURLS, "slkdjflsdjljdsj-=-=-=-=-=-=")
//                    imageCollection.unzippedImageUrl = imageURLS
                    
                }
            }
        }
        
//        guard let url = URL(string: imageCollection.zippedImagesURL) else { fatalError("urlString->URL conversion failed") }
//        let request = URLRequest(url: url)
//        let session = URLSession.shared
////        imageCollec /tion.unzippedImageUrl = url.lastPathComponent
//
//        session.downloadTask(with: request) { tempURL, urlResponse, error in
//            if let tempURL = tempURL {
//                let fileManager = FileManager.default
//
//                do {
//                    let fileURL = try fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//
//                    Zip.addCustomFileExtension("tmp")
//                    try Zip.unzipFile(tempURL, destination: fileURL, overwrite: true, password: nil)
//                    print("zipped passed")
//                    print("zip urlss", url)
//
//                    let name = String(url.lastPathComponent.dropLast(4))
//                    print("nameeeee", name)
//                    /*
//                     1. Update the ImageCollection model with unzippedUrl
//                     2. Display the _preview.png image. Use UIImage(contentsOfFile: "")
//                     3. Optionally store the urls for the images as a property of the ImageCollection model
//                     4. When user taps a downloaded collection, segue to new vc that shows all the images for that collection
//                    */
//
//                } catch let error {
//                    print("zip failed", error)
//                }
//            }
//        }.resume()
//        print(url)
        
    }
    
    
}





