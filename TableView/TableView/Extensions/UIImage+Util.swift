//
//  UIImage+Util.swift
//  TableView
//
//  Created by Bee_MacPro on 16/02/2022.
//

import UIKit

extension UIImage {
    static func downloadImageFromUrl(_ url: String, completionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else {
                      completionHandler(nil)
                      return
                  }
            completionHandler(image)
        }
        task.resume()
    }
}
