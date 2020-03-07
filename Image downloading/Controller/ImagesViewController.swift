import UIKit

class ImagesViewController: UITableViewController, ModelDelegate {
    
    private let viewModel = MainModel()
    private var catImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0...10 {
            self.callRandomImageUrl()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catImages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell") as? CatCell else {
            return UITableViewCell()
        }
        cell.catImage.image = catImages[indexPath.row]
        
        return cell
    }
    
    private func callRandomImageUrl() {
        viewModel.delegate = self
        DispatchQueue.global().async {
            self.viewModel.callService()
        }
    }
    
    internal func didReceiveImageUrl(_ data: String) {
        guard let url = URL(string: data) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        
                        self.catImages.append(image)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
