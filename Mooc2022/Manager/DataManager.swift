//
//  DataManager.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 12/07/2022.
//

import UIKit

class DataManager {
    private static var instance: DataManager?
    private init(){
        
    }
    
    static var shared: DataManager {
        guard let dataManager = instance else {
            instance = DataManager()
            return instance!
        }
        return dataManager
    }
    
    public class func getImageURL(_ name: String?) -> URL? {
        guard let name = name,
              let escapedString = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                  return nil
              }
        return URL(string: NetworkManager.shared.baseURLImage + escapedString)
    }
}
