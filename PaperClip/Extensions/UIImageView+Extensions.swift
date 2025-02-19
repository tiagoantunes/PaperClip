//
//  UIImageView+Extensions.swift
//  PaperClip
//
//  Created by Tiago Antunes on 17/02/2025.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        let cacheKey = url.absoluteString
        // Check if the image is already in the cache
        if let cachedImage = ImageCache.shared.getImage(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        // Download the image if it's not in the cache
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                return
            }
            // Cache the image
            ImageCache.shared.setImage(image, forKey: cacheKey)
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
