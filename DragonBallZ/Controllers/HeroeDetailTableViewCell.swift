import UIKit

class HeroeDetailTableViewCell: UITableViewCell {
    
    weak var navigationControllerReference: UINavigationController? = nil
    var heroId: String? = nil
    
    //MARK: OUTLETS
    @IBOutlet weak var titleOfCell: UILabel!
    @IBOutlet weak var descriptionOfCell: UILabel!
    @IBOutlet weak var imageOfCell: UIImageView!
    @IBOutlet weak var buttonOfTransformations: UIButton!
    
    //MARK: ACTIONS
    @IBAction func transformationsButtonDidTap(_ sender: Any) {
        //hacemos la llamada a la base de datos trayendo el listado de las transformaciones del heroe
        DragonBallZNetworkModel.getHeroeTransformations(heroId: heroId!){data, error in
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            //creamos el array de tipo "CellData" que contrendrá los datos para las celdas de la tabla
            var cellDataList : [CellData] = []
            for HeroTransformation in (data as [HeroTransformation]) {
                cellDataList.append(CellData.init(title: HeroTransformation.name, description: HeroTransformation.description, image: (URL:HeroTransformation.photo,UIImage:nil),heroId: nil))
            }
            
            //creamos y mostramos la tableview con el listado de transformaciones
            DispatchQueue.main.async {
                self.navigationControllerReference?.pushViewController(
                    TableViewController(navigatorTitle: "Transformaciones", hidesBackButtonOfNavigator: false, cellDataList: cellDataList,nameOfCellToUse: "HeroeTableViewCell", identifierOfCellToUse: "HeroCell", heigthOfCell: 125.0),
                    animated: true)
            }
        }
    }
}

