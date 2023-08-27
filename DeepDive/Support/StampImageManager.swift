//
//  StampImageManager.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/24/23.
//

import Foundation
import SwiftUI
import PhotosUI


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func saveStampImage(stamp: UIImage, id: String) {
    let filename = getDocumentsDirectory().appendingPathComponent(id)
    if let data = stamp.pngData() {
            try? data.write(to: filename)
        }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
