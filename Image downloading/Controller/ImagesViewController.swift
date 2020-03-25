import UIKit

class ImagesViewController: UICollectionViewController, ModelDelegate {
    
    private let viewModel = MainModel()
    private var catImages: [UIImage] = []
    private var itemIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async {
            for _ in 0...1000 {
                self.callRandomImageUrl()
            }
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
        DispatchQueue.global().async {
            self.viewModel.delegate = self
            self.viewModel.callService()
        }
    }
    
    internal func didReceiveImageUrl(_ data: String) {
        DispatchQueue.global().async {
            guard let url = URL(string: data) else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    
                    
                    if self.catImages.count == 0 {
                        self.catImages.append(image)
                        DispatchQueue.main.async { self.collectionView.reloadData() }
                    } else {
                        self.catImages.append(image)
                        let indexPath = IndexPath(item: self.itemIndex, section: 0)
                        DispatchQueue.main.async { self.collectionView.reloadItems(at: [indexPath]) }
                        self.itemIndex += 1
                    }
                }
            }
        }
    }
}

