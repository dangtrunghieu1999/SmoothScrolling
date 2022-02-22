//
//  ImageLoadOperation.swift
//  TableView
//
//  Created by Bee_MacPro on 16/02/2022.
//

import UIKit

typealias ImageLoadOperationCompletionHandlerType = ((UIImage) -> ())

class ImageLoadOperation: Operation {
    var url: String
    var completionHandler: ImageLoadOperationCompletionHandlerType?
    var image: UIImage?
    
    init(url: String) {
        self.url = url
    }
    
    override func main() {
        if isCancelled {
            return
        }
        UIImage.downloadImageFromUrl(url) { [weak self] (image) in
            guard let self = self, !self.isCancelled,
                  let image = image else {
                      return
                  }
            self.image = image
            self.completionHandler?(image)
        }
    }
}
