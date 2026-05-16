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
    private(set) var currentData: ComicDetails = ComicDetails(description:"",name: "",  person_credits: [], volume: Volume(name:""))
    
    // Stores the user's personal rating for each comic.
    // Dictionary key = comic ID
    // Dictionary value = rating score from slider.
    //
    // didSet automatically saves ratings whenever they change.
    var ratings: [Int: Double] = [:] {
        didSet {
            saveRatings()
        }
    }
    
    // Stores all comics the user has saved to their personal library.
    // didSet runs automatically every time collection changes
    // (adding, removing, or clearing comics).
    // This lets us automatically save the updated collection.
    var collection: [Comic] = [] {
        didSet{
            saveCollection()
            
        }
    }
    
    // Runs automatically when DataManager is first created.
    // Loads previously saved collection and ratings from UserDefaults
    // so user data persists after the app is closed.
    init(){
        loadCollection()
        loadRatings()
    }
    
    
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
        let formattedSearch = searchText.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? ""

            let urlStr = "https://comicvine.gamespot.com/api/search/?api_key=a23646e57aa68cf68abfa6f0f81f9b49961621f3&format=json&query=\(formattedSearch)&resources=issue"

            guard let url = URL(string: urlStr) else {
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                let comics = try JSONDecoder().decode(ComicResponse.self, from: data)
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
        if !collection.contains(where: { $0.id == comic.id }) {
                collection.append(comic)
        }
    }
    
    // remove from collection
    func removeFromCollection(comic: Comic){
        if let index = collection.firstIndex(where: {$0.id == comic.id}) {
            collection.remove(at: index)
        }
    }
    
    // exactly what it says
    func clearCollection(){
        collection.removeAll()
    }
    
    // Converts the collection array into storable data
    // and saves it locally using UserDefaults.
    func saveCollection(){
        if let encoded = try? JSONEncoder().encode(collection) {
                UserDefaults.standard.set(encoded, forKey: "comicCollection")
        }
    }
    
    // Checks if saved comic data already exists in UserDefaults.
    // If found, decodes the data back into an array of Comic objects
    // and restores the user's collection.
    func loadCollection() {
        if let data = UserDefaults.standard.data(forKey: "comicCollection"),
           let decoded = try? JSONDecoder().decode([Comic].self, from: data) {
            collection = decoded
        }
    }
    
    
    // Encodes the ratings dictionary into data
    // and stores it locally using UserDefaults.
    func saveRatings(){
        if let encoded = try? JSONEncoder().encode(ratings) {
                UserDefaults.standard.set(encoded, forKey: "comicRatings")
            }
    }
    
    // Retrieves saved rating data from UserDefaults.
    // If saved data exists, decode it back into the ratings dictionary.
    func loadRatings(){
        if let data = UserDefaults.standard.data(forKey: "comicRatings"),
               let decoded = try? JSONDecoder().decode([Int: Double].self, from: data) {
                ratings = decoded
        }
    }
}

