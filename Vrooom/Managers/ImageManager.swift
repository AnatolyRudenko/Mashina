//
//  ImageManager.swift
//  Vrooom
//
//  Created by Admin on 04.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

struct ImageManager {
    
    private let defaultImage = #imageLiteral(resourceName: "NoImage")
    
    func saveImageAndGetItsPath(image: UIImage, name: String) -> String { //call this to save an image
        let imageFileName = "\(name).png"
        let imagePath = fileInDocumentsDirectory(imageFileName)
        writeImage(image, path: imagePath)
        return imagePath
    }

    func getImageFromImageName(_ path: String?) -> UIImage { //call this to get image from its path
        guard let path = path else {
            return self.defaultImage
        }
        
        if let preloadedImage = UIImage(named: path) {
            return preloadedImage
        }
        
        let imagePath = fileInDocumentsDirectory(path)
        let loadedImage = self.loadImageFromPath(imagePath)
        return loadedImage ?? self.defaultImage
    }
    
    private func loadImageFromPath(_ path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("couldn't find image in comfirm at path: \(path)")
        }
        return image
    }
    
    private func getDocumentsURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }

    private func fileInDocumentsDirectory(_ filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL.path
    }

    private func writeImage(_ image: UIImage, path: String ) {
        if let pngImageData = image.pngData() {
            try? pngImageData.write(to: URL(fileURLWithPath: path), options: [.atomic])
        }
    }
}
