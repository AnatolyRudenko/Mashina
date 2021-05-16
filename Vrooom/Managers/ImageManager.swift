//
//  ImageManager.swift
//  Vrooom
//
//  Created by Admin on 04.05.2021.
//  Copyright © 2021 Rudenko. All rights reserved.
//

import UIKit

struct ImageManager {
    
    let defaultImage = #imageLiteral(resourceName: "NoImage")
    
    func saveImageAndGetItsPath(image: UIImage, name: String) -> String { //call this to save an image and get its path extension back
        let imageFileName = "\(name).png"
        let imagePath = fileInDocumentsDirectory(imageFileName)
        let resizedImage = resizeImageToFitScreenWidth(image) //Чтоб не ресайзить картинку в cellForRow
        writeImage(resizedImage, path: imagePath)
        return imageFileName
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
    
    private func resizeImageToFitScreenWidth(_ image: UIImage) -> UIImage {
        let size = image.size
        let targetWidth = UIScreen.main.bounds.width
        guard size.width != targetWidth else { return image }
        let ratio = size.width > targetWidth ?
            targetWidth / size.width :
            size.width / targetWidth
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? image
    }
    
    // MARK: - Supporting methods
    
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
