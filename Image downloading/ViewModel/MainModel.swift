import Foundation

class MainModel {
    var randomCatUrl: String?
    weak var delegate: ModelDelegate?
    
    func callService() {
        
        DispatchQueue.global().async {
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
                        self.delegate?.didReceiveImageUrl(responseData.file)
                    } catch {
                        print("error \(error)")
                    }
                }
            }
        }
    }
}

protocol ModelDelegate: class {
    func didReceiveImageUrl(_ data: String)
}
