import Foundation
// api key: a23646e57aa68cf68abfa6f0f81f9b49961621f3 
struct Comic: Codable {
    var api_detail_url: String // I think this will have to be parsed separately once the comic itself is pulled up
    var cover_date: Date
    var id: Int
    var name: String
    var issue_number: Int
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

