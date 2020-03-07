import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveToGetImages(_ sender: Any) {
        self.performSegue(withIdentifier: "moveToImages", sender:self)
    }
}

