//
//  NSError.swift
//  TableView
//
//  Created by Bee_MacPro on 17/02/2022.
//

import Foundation

extension NSError {
    static func createError(_ code: Int, description: String) -> NSError {
        return NSError(domain: "com.aprearo.TableView",
                       code: 400,
                       userInfo: [
                        "NSLocalizedDescription" : description
            ])
    }
}
