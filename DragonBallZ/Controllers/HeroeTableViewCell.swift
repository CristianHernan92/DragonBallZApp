import UIKit

class HeroeTableViewCell: UITableViewCell {
    
    weak var navigationControllerReference: UINavigationController? = nil

    //MARK: OUTLETS
    
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroTitle: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    //MARK: ACTIONS
    @IBAction func showHeroDetail(_ sender: Any) {
        //creamos y mostramos el HeroeDetailTableViewController con el listado de heroes
        if let navigationControllerReference {
            DispatchQueue.main.async {
                navigationControllerReference.pushViewController(
                    HeroeDetailTableViewController(heroNameTitle: self.heroTitle.text!, heroDescription: self.heroDescription.text!, heroImage: self.heroImage.image!), animated: true
                )
            }
        }
    }
}
