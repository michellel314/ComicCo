//
//  DataManager.swift
//  ComicCo
//
//  Created by Student on 4/30/26.
//

import SwiftUI

@Observable
class DataManager {
    private(set) var issues: [Comic] = []
    
    func getIssueData() async {
        print("called")
        let urlStr = "https://comicvine.gamespot.com/api/issues/?api_key=a23646e57aa68cf68abfa6f0f81f9b49961621f3&format=json&name!=null"
        let url: URL? = URL(string: urlStr)
        guard let urlUnwrapped = url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: urlUnwrapped)
            let comics: ComicResponse = try JSONDecoder().decode(ComicResponse.self, from: data)
            for issue in comics.results {
                issues.append(issue)
            }
        } catch let error {
            print(error)
        }
    }
    
    func getPersonData(detailURL: String) async {
        print("called 2 electric boogaloo")
        let urlStr = detailURL+"?api_key=a23646e57aa68cf68abfa6f0f81f9b49961621f3&format=json"
        let url: URL? = URL(string: urlStr)
        guard let urlUnwrapped = url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: urlUnwrapped)
            let details: DetailResponse = try JSONDecoder().decode(DetailResponse.self, from: data)
            
        } catch let error {
            print(error)
        }
    }
}

