//
//  DataManager.swift
//  ComicCo
//
//  Created by Student on 4/30/26.
//

import SwiftUI

@Observable
class DataManager {
    private(set) var collection: [Comic] = []
    private(set) var issues: [Comic] = []
    private(set) var currentData: ComicDetails = ComicDetails(description:"",name: "",  person_credits: [], volume: Volume(name:""))
    
    // Grabs data of each issue using the given results, then puts them in a list of issues that'll be used to display those results
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
    
    
    func searchIssues(searchText: String) async {
        // Converts spaces and special characters into a URL-safe format.
        // Example:
        // "Spider Man" becomes "Spider%20Man"
        // so the API request does not break.
        let formattedSearch = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let urlStr = "https://comicvine.gamespot.com/api/issues/?api_key=a23646e57aa68cf68abfa6f0f81f9b49961621f3&format=json&filter=name:\(formattedSearch)"
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let comics = try JSONDecoder()
                .decode(ComicResponse.self, from: data)
            issues = comics.results
        } catch {
            print(error)
        }
    }
    
    
    // Gets the details of an issue to display later
    func getDetailData(detailURL: String) async {
        print("called 2 electric boogaloo")
        let urlStr = detailURL+"?api_key=a23646e57aa68cf68abfa6f0f81f9b49961621f3&format=json"
        let url: URL? = URL(string: urlStr)
        guard let urlUnwrapped = url else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: urlUnwrapped)
            let details: DetailResponse = try JSONDecoder().decode(DetailResponse.self, from: data)
            currentData = details.results
        } catch let error {
            print(error)
        }
    }
    
    // add to collection
    func addToCollection(comic: Comic){
        collection.append(comic)
    }
}

