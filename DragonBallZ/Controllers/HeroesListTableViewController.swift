import UIKit

final class HeroesListTableViewController: UITableViewController {
    
    let heroesList: [Hero]
    
    init(heroesList: [Hero]) {
        self.heroesList = heroesList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Heroes"
        
        //registramos la celda personalizada que creamos (HeroeTableViewCell) en la tabla cuyo identificador le pusimos "HeroCell"
        let nib = UINib(nibName: "HeroeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "HeroCell")
    }
    
    //MARK: LE DECIMOS LA CANTIDAD DE FILAS QUE TIENE QUE TENER LA TABLA
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //le pasamos que la cantidad de filas sea igual a la cantidad de heroes que nos trajo en endpoint de la lista de heroes
        //*(se saca el último personaje que viene del endpoint porque no es de dragon-ball)*
        return heroesList.count - 1
    }
    
    //MARK: LE PASAMOS DATOS A CADA FILA DE LA TABLA
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //instanciamos la celda peronalizada que registramos más arriba en la tabla y lo casteamos al tipo de nuestra celda HeroeTableViewCell para poder luego asignarles valor a sus atributos
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroeTableViewCell
        cell.heroDescription.text = heroesList[indexPath.row].description
        cell.heroTitle.text = heroesList[indexPath.row].name
        
        let task = URLSession.shared.dataTask(with: heroesList[indexPath.row].photo) { (data, response, error) in
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Response Error: \(String(describing: response))")
                return
            }
            guard let data else {
                print("No data error: \(String(describing: "El dato no es correcto"))")
                return
            }
            DispatchQueue.main.async {
                cell.heroImage.image = UIImage(data: data)
            }
        }
        task.resume()
        
        //pasamos la referencia del "NavigationController" para que la celda pueda manejarla
        cell.navigationControllerReference = self.navigationController
        
        return cell
    }
    
    //MARK: LE DAMOS 125 DE ALTURA A LAS CELDAS
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
}
