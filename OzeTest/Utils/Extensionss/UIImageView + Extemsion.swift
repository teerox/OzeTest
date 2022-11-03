//
//  UIImageView + Extemsion.swift
//  OzeAssesment
//
//  Created by Mac on 01/11/2022.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImage(urlString: String) {
        self.image = nil
        if let image = imageCache.object(forKey: NSString(string: urlString)){
            self.image = image
            return
        } else {
            guard let url = URL(string: urlString) else {
                return
            }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageCache.setObject(image, forKey: NSString(string: urlString))
                            self?.image = image
                        }
                    } else {
                        self?.image = UIImage(systemName: "person.circle.fill")
                    }
                } else {
                    DispatchQueue.main.async {
                        if let image = UIImage(systemName: "person.circle.fill") {
                            imageCache.setObject(image, forKey: NSString(string: urlString))
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
