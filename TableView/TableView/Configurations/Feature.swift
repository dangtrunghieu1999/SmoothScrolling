//
//  Feature.swift
//  TableView
//
//  Created by Bee_MacPro on 17/02/2022.
//

import Foundation

class Feature: Codable {
    let identifier: String
    var value: Bool
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "Indentifier"
        case value      = "Value"
    }
    
    init(_ identifier: String) {
        self.identifier = identifier
        self.value = false
    }
    
    var isEnabled: Bool {
        return value == true
    }
    
    func setEnabled(_ value: Bool) {
        self.value = value
    }
    
    func enable() {
        setEnabled(true)
    }
    
    func disable() {
        setEnabled(false)
    }
}

extension Feature {
    static let clearCaches = Feature("ClearCaches")
    static let debugCellLifecycle = Feature("DebugCellLifecycle")
    
    private static let features = [Feature.clearCaches, Feature.debugCellLifecycle]
    
    private static func features(for identifier: String) -> Feature? {
        return features.filter{ $0.identifier ==  identifier } .first
    }
    
    static func initFromPlist() {
        if let url = Bundle.main.url(forResource: "Features", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                let featuresFromPlist = try decoder.decode([Feature].self, from: data)
                for featureFromPList in featuresFromPlist {
                    if let feature = Feature.features(for: featureFromPList.identifier) {
                        feature.setEnabled(featureFromPList.value)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
