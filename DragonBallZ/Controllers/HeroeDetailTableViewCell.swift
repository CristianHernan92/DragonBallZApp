import UIKit

class HeroeDetailTableViewCell: UITableViewCell {
    
    weak var navigationControllerReference: UINavigationController? = nil
    
    //MARK: OUTLETS
    @IBOutlet weak var titleOfCell: UILabel!
    @IBOutlet weak var descriptionOfCell: UILabel!
    @IBOutlet weak var imageOfCell: UIImageView!
    
    //MARK: ACTIONS
    @IBAction func transformationsButtonDidTap(_ sender: Any) {
        //hacemos la llamada a la base de datos trayendo el listado de las transformaciones del heroe
        DragonBallZNetworkModel.getHeroeTransformations{data, error in
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            //creamos y mostramos la tableview con el listado de las transformaciones del heroe
//            DispatchQueue.main.async {
//                self.navigationController?.pushViewController(HeroesListTableViewController(heroesList: data), animated: true)
//            }
        }
    }
}
