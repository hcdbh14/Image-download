import UIKit

class CatCell: UITableViewCell, ModelDelegate {
    let viewModel = MainModel()
    @IBOutlet weak var catImage: UIImageView!
    
     
    func callRandomImageUrl() {
        viewModel.delegate = self
        DispatchQueue.global().async {
            self.viewModel.callService()
        }
    }
    
    func didReceiveImageUrl(_ data: String) {
        self.catImage.load(url: URL(string: data)!)
    }
}





extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
