import UIKit

class HeroeTableViewCell: UITableViewCell {
    
    weak var navigationControllerReference: UINavigationController? = nil

    //MARK: OUTLETS
    @IBOutlet weak var descriptionOfCell: UILabel!
    @IBOutlet weak var titleOfCell: UILabel!
    @IBOutlet weak var imageOfCell: UIImageView!
    
    //MARK: ACTIONS
    @IBAction func showHeroDetail(_ sender: Any) {
            //creamos y mostramos otra instancia de TableViewController con la celda de detalle del heroe
        
            //creamos el array de tipo "CellData" que contrendrá los datos para la celda de la tabla
            var cellDataList : [CellData] = []
            cellDataList.append(CellData.init(title: self.titleOfCell.text!, description: self.descriptionOfCell.text!, image: (URL:nil,UIImage:self.imageOfCell.image!)))
            
            DispatchQueue.main.async {
                self.navigationControllerReference!.pushViewController(
                    TableViewController(navigatorTitle: self.titleOfCell.text!, hidesBackButtonOfNavigator: false, cellDataList: cellDataList,nameOfCellToUse: "HeroeDetailTableViewCell", identifierOfCellToUse: "HeroDetailCell", heigthOfCell: 725.0),
                    animated: true)
            }
    }
}
