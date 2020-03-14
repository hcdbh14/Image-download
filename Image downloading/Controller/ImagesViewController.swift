import UIKit

class ImagesViewController: UICollectionViewController, ModelDelegate {
    
    private let viewModel = MainModel()
    private var catImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0...10 {
            self.callRandomImageUrl()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catImages.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as? CatCell else {
            return UICollectionViewCell()
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
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}
