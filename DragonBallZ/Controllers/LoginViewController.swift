import UIKit

final class LoginViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: Actions
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        
        //NetworkModel.login(email: EmailTextField.text!, password: PasswordTextField.text!)
        
        NetworkModel.login(email: "cristianhernandelrio@gmail.com", password: "KQFhbcuj9Hwgf39") { token, error in
            guard error==nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            //hacemos la llamada a la base de datos trayendo toda la lista de los heroes
            NetworkModel.getHeroesList(token: token){data, error in
                guard error == nil else {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                //creamos y mostramos la tableview con el listado de heroes
                DispatchQueue.main.async {
                    let HeroesListTableViewController = HeroesListTableViewController(heroesList: data)
                    self.navigationController?.pushViewController(HeroesListTableViewController, animated: true)
                }
                
            }
        }
    }
}
