//
//  ZipProcessor.swift
//  DocumentManagement
//
//  Created by Erik Perez on 11/2/17.
//  Copyright © 2017 Erik Perez. All rights reserved.
//

import Foundation
import Zip

class ZipProcessor {
    
    // Downloading
    static func downloadImageCollectionFrom(_ urlString: String, completionHandler: @escaping (URL, URL) -> Void) {
        guard let zipURL = URL(string: urlString) else { fatalError("urlString -> URL conversion failed. Networking.downloadImageCllectionFrom") }
        
        let request = URLRequest(url: zipURL)
        let session = URLSession.shared
        
        session.downloadTask(with: request) { url, urlResponse, error in
            if let url = url {
                completionHandler(url, zipURL)
            }
        }.resume()
    }
    
    // Unzipping
    static func unzipFileAt(_ tempURL: URL, zipURL: URL) -> String? {
        let fileManager = FileManager.default
        do {
            let cacheURL = try fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            Zip.addCustomFileExtension("tmp")
            try Zip.unzipFile(tempURL, destination: cacheURL, overwrite: true, password: nil)
            print("zipped passed")
            
            let folderName = String(zipURL.lastPathComponent.dropLast(4))
            return folderName
            
        } catch let error {
            print("zip failed", error)
        }
        return nil
    }
    
    // Extracting _preview and images
    static func extractImagesFromFolderNamed(_ name: String) -> [URL]? {
        let fileManager = FileManager.default
        
        do {
            let cacheDirectoryURL = try fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let imagesDirectoryURL = cacheDirectoryURL.appendingPathComponent(name)
            
            let imageURLS = try fileManager.contentsOfDirectory(at: imagesDirectoryURL, includingPropertiesForKeys: [], options: [])
            
            return imageURLS
        } catch let error {
            print(error, "kdjflsdklf")
        }
        
        return nil
        
    }
    
}
