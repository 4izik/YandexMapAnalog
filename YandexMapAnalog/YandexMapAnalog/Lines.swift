
import Foundation
class Lines:Codable {
    let hex_color:String
    let name:String
    let stations:[Stations]
}
struct Stations:Codable, Hashable {
    let name:String
    let lat:Int
    let lng:Int
    let order:Int
}

struct CustomDecodeError: Codable {
    let detail: String?
    init(description: String?) {

        detail = description

    }


}

