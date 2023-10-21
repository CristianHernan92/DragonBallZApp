import Foundation

struct HeroTransformation: Codable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let hero:HeroID
}

struct HeroID: Codable {
    let id: String
}
