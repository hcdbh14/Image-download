import UIKit

private struct Constants {
    static let numCells = 10
}

class ImagesViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numCells
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell") as? CatCell else {
            return UITableViewCell()
        }
        cell.callRandomImageUrl()
        
        return cell
    }
}

