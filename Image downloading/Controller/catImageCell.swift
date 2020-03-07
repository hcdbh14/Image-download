import UIKit

class CatCell: UITableViewCell {
    let VM = MainModel()
    @IBOutlet weak var catImage: UIImageView!
    
    
    func callRandomImageUrl() {
        DispatchQueue.global().async {
            self.VM.callService()
        }
        catImage.load(url: URL(string: "https://purr.objects-us-east-1.dream.io/i/imag1178.jpg")!)
    }
}

private func callCatImage() {
    
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
