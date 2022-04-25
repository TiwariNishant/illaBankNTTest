//
//  FirstViewModel.swift
//  NishantCaroselDemo
//
//  Created by webwerks on 23/04/22.
//

import Foundation
import UIKit

class FirstViewModel {
    
    // MARK: - Property Declaration
    var firstArrayList = [FirstModel]()
    var searchArrayList = [FirstModel]()
    var isSearchActive:Bool = false

    // get file path and load data
    func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch (_) {
                completion(nil)
            }
        }
    }
    
    // MARK: -  Get all the data from json file and bind with the model
    func getList(completion: @escaping (Bool) -> Void) {
        loadJsonDataFromFile("FirstJson") { (data) in
            if let json = data {
                do {
                    let list = try JSONDecoder().decode([FirstModel].self, from: json)
                    self.firstArrayList = list
                    completion(true)
                } catch {
                    completion(false)
                }
            }
        }
    }
    
    // MARK: - Get Carousel table list count
    func getListCount() -> Int {
        if !isSearchActive {
            return firstArrayList.count
        } else {
            return searchArrayList.count
        }
    }
}
