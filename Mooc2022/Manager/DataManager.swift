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
}
