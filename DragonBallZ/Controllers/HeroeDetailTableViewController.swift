import UIKit

class HeroeDetailTableViewController: UITableViewController {
        
    let heroNameTitle: String
    let heroDescription: String
    let heroImage: UIImage
    
    init(heroNameTitle: String,heroDescription: String,heroImage: UIImage) {
        self.heroNameTitle = heroNameTitle
        self.heroDescription = heroDescription
        self.heroImage = heroImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = heroNameTitle
        
        //registramos la celda personalizada que creamos (HeroeDetailTableViewCell) en la tabla cuyo identificador le pusimos "HeroDetailCell"
        let nib = UINib(nibName: "HeroeDetailTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "HeroDetailCell")
    }
    
    //MARK: LE DECIMOS LA CANTIDAD DE FILAS QUE TIENE QUE TENER LA TABLA
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: LE PASAMOS DATOS A CADA FILA DE LA TABLA
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //instanciamos la celda peronalizada que registramos más arriba en la tabla y lo casteamos al tipo de nuestra celda HeroeDetailTableViewCell para poder luego asignarles valor a sus atributos
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroDetailCell", for: indexPath) as! HeroeDetailTableViewCell
        
        cell.heroNameTitle.text = heroNameTitle
        cell.heroDescription.text = heroDescription
        cell.heroImage.image = heroImage
        
        //pasamos la referencia del "NavigationController" para que la celda pueda manejarla
        cell.navigationControllerReference = self.navigationController
        
        return cell
    }
    
    //MARK: LE DAMOS 125 DE ALTURA A LA CELDA
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 725.0
    }
}
