import Foundation

class LineLoader {
    
    func loadJson(filename fileName: String) -> [Lines]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(AllLines.self, from: data)
                return jsonData.lines
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

