//
//  FullScreenImageViewModel.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 03/02/2024.
//

import SDWebImage

class FullScreenImageViewModel {
    var imageURL: String?

    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = imageURL else {
            completion(nil)
            return
        }

        SDWebImageManager.shared.loadImage(
            with: URL(string: imageURL),
            options: .highPriority,
            progress: nil
        ) { (image, _, _, _, _, _) in
            completion(image)
        }
    }
}
