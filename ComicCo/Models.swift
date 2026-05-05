import Foundation
// api key: a23646e57aa68cf68abfa6f0f81f9b49961621f3
// remember to always end with format=json

struct ComicResponse: Codable {
    var results: [Comic]
}
struct Comic: Codable, Identifiable {
    var api_detail_url: String // I think this will have to be parsed separately once the comic itself is pulled up
    var cover_date: String
    var id: Int
    var name: String?
    var issue_number: String
    var image: Image
}

struct Image: Codable {
    var icon_url: String
    var medium_url: String
    var screen_url: String
    var small_url: String
    var super_url: String
    var thumb_url: String
    var tiny_url: String
}

struct ComicDetails: Codable {
    var description: String
    var name: String?
    var person_credits: Person
    var volume: Volume
}

struct Person: Codable {
    var name: String
    var role: String
}

struct Volume: Codable {
    var name: String
}
