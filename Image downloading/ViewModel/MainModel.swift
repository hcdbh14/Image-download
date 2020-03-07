import Foundation

class MainModel {
    var randomCatUrl: String?
    
    func callService() {
        let Request: NetworkingManager
        Request = NetworkingManager.init(endpoint: "https://aws.random.cat/meow")
        Request.httpRequest(httpMethod: .get) { result in
            
            switch result {
            case .failure(let error):
                print("error \(error)")
                
            case .success (let response):
                let decoder = JSONDecoder()
                do {
                    let responseData = try decoder.decode(CatUrl.self, from: response)
                    self.randomCatUrl = responseData.file
                } catch {
                    print("error \(error)")
                }
            }
        }
    }
}

