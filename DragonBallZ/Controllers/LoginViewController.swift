import UIKit

class LoginViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: Actions
    @IBAction func LoginButtonAction(_ sender: Any) {
        NetworkModel.login(email: EmailTextField.text!, password: PasswordTextField.text!) { token, error in
            guard error==nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            print("el token es: \(token)")
            
        }
    }
}
