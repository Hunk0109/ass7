//import UIKit
//
//class CustomerViewController: UIViewController {
//    
//    var customers: [Customer] {
//        get { SharedData.shared.customers }
//        set { SharedData.shared.customers = newValue }
//    }
//    
//    var policies: [Policy] {
//        get { SharedData.shared.policies }
//        set { SharedData.shared.policies = newValue }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//    
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var idTextField: UITextField!
//    @IBOutlet weak var ageTextField: UITextField!
//    @IBOutlet weak var emailTextField: UITextField!
//
//
//    
//    @IBAction func addCustomerButton(_ sender: UIButton) {
//        guard let name = nameTextField.text, !name.isEmpty,
//              let idString = idTextField.text, let id = Int(idString) else {
//            showAlert(title: "Error", message: "Please Enter Both Name And ID.")
//            return
//        }
//        
//        if customers.contains(where: { $0.id == id }) {
//            showAlert(title: "Error", message: "Customer With ID: \(id) Already Exists.")
//            return
//        }
//        
//        customers.append(Customer(id: id, name: name))
//        nameTextField.text = ""
//        idTextField.text = ""
//        
//        showAlert(title: "Success", message: "Customer Added Successfully With ID: \(id) And Name: \(name).")
//    }
//    
//    
//    @IBAction func deleteCustomerButton(_ sender: UIButton) {
//        let actionSheet = UIAlertController(title: "Choose Customer To Delete", message: nil, preferredStyle: .actionSheet)
//        for customer in customers {
//            let action = UIAlertAction(title: customer.name, style: .default) { _ in
//                if let index = self.customers.firstIndex(where: { $0.id == customer.id }) {
//                    if SharedData.shared.policies.contains(where: { $0.customerId == customer.id }) {
//                        self.showAlert(title: "Error", message: "Cannot Delete Customer With Associated Policies.")
//                    } else {
//                        self.customers.remove(at: index)
//                        self.showAlert(title: "Success", message: "Customer Successfully Deleted.")
//                    }
//                }
//            }
//            actionSheet.addAction(action)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        actionSheet.addAction(cancelAction)
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//    
//    
//    @IBAction func updateCustomerButton(_ sender: UIButton) {
//        let actionSheet = UIAlertController(title: "Choose Customer To Update", message: nil, preferredStyle: .actionSheet)
//        for customer in customers {
//            let action = UIAlertAction(title: customer.name, style: .default) { _ in
//                let alert = UIAlertController(title: "Enter New Name", message: nil, preferredStyle: .alert)
//                alert.addTextField { textField in
//                    textField.placeholder = "New Name"
//                }
//                let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
//                    if let newName = alert.textFields?.first?.text, !newName.isEmpty, let index = self.customers.firstIndex(where: { $0.id == customer.id }) {
//                        self.customers[index].name = newName
//                        self.showAlert(title: "Success", message: "Customer Successfully Updated.")
//                    }
//                }
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                alert.addAction(updateAction)
//                alert.addAction(cancelAction)
//                self.present(alert, animated: true, completion: nil)
//            }
//            actionSheet.addAction(action)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        actionSheet.addAction(cancelAction)
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//    
//    
//    @IBAction func displayCustomerButton(_ sender: UIButton) {
//        var displayText = "Customer:\n"
//        for customer in customers {
//            displayText += "ID: \(customer.id), Name: \(customer.name)\n"
//        }
//        showAlert(title: "Customer", message: displayText)
//    }
//    
//    @IBAction func searchCustomer(_ sender: UIButton) {
//        guard let searchText = nameTextField?.text, !searchText.isEmpty else {
//            showAlert(title: "Error", message: "Please Enter A Search Term [ID Is Not Required].")
//            return
//        }
//        
//        let searchResults = SharedData.shared.customers.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
//        
//        if searchResults.isEmpty {
//            showAlert(title: "No Results", message: "No Customer Found Matching The Search Term.")
//        } else {
//            var displayText = "Search Results:\n"
//            for customer in searchResults {
//                displayText += "ID: \(customer.id), Name: \(customer.name)\n"
//            }
//            nameTextField?.text = ""
//            idTextField?.text = ""
//            showAlert(title: "Search Results", message: displayText)
//        }
//    }
//    
//    @IBAction func backButton(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    func showAlert(title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
//}

import UIKit

class CustomerViewController: UIViewController {
    var nextCustomerID: Int = 1
    
    var customers: [Customer] {
        get { SharedData.shared.customers }
        set { SharedData.shared.customers = newValue }
    }
    
    var policies: [Policy] {
        get { SharedData.shared.policies }
        set { SharedData.shared.policies = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNextCustomerID()
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func addCustomerButton(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "Error", message: "Please enter a valid Name.")
            return
        }

        guard let ageString = ageTextField.text, let age = Int(ageString), age > 0 else {
            showAlert(title: "Error", message: "Please enter a valid Age (greater than 0).")
            return
        }

        guard let email = emailTextField.text, !email.isEmpty, isValidEmail(email) else {
            showAlert(title: "Error", message: "Please enter a valid Email.")
            return
        }

        let newCustomer = Customer(id: nextCustomerID, name: name, age: age, email: email)
        customers.append(newCustomer)

        nextCustomerID += 1
        clearTextFields()

        showAlert(title: "Success", message: "Customer added successfully with ID: \(newCustomer.id)!")
    }
    
    func updateNextCustomerID() {
          if let lastCustomer = customers.max(by: { $0.id < $1.id }) {
              nextCustomerID = lastCustomer.id + 1
          }
      }


    // Helper function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    
    // MARK: - Delete Customer
    @IBAction func deleteCustomerButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Customer to Delete", message: nil, preferredStyle: .actionSheet)
        for customer in customers {
            let action = UIAlertAction(title: customer.name, style: .default) { _ in
                if let index = self.customers.firstIndex(where: { $0.id == customer.id }) {
                    if self.policies.contains(where: { $0.customer_id == customer.id }) {
                        self.showAlert(title: "Error", message: "Cannot delete customer with associated policies.")
                    } else {
                        self.customers.remove(at: index)
                        self.showAlert(title: "Success", message: "Customer deleted successfully.")
                    }
                }
            }
            actionSheet.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Update Customer
    @IBAction func updateCustomerButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Customer to Update", message: nil, preferredStyle: .actionSheet)
        for customer in customers {
            let action = UIAlertAction(title: customer.name, style: .default) { _ in
                let alert = UIAlertController(title: "Update Customer", message: "Update Name and Age for \(customer.name)", preferredStyle: .alert)

                alert.addTextField { textField in
                    textField.placeholder = "New Name"
                    textField.text = customer.name
                }
                
                alert.addTextField { textField in
                    textField.placeholder = "New Age"
                    textField.keyboardType = .numberPad
                    textField.text = "\(customer.age)" // Set current age as default
                }

                let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
                    if let newName = alert.textFields?[0].text, !newName.isEmpty,
                       let ageText = alert.textFields?[1].text, let newAge = Int(ageText), newAge > 0,
                       let index = self.customers.firstIndex(where: { $0.id == customer.id }) {

                        self.customers[index].name = newName
                        self.customers[index].age = newAge
                        self.showAlert(title: "Success", message: "Customer updated successfully.")
                    } else {
                        self.showAlert(title: "Error", message: "Invalid name or age.")
                    }
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(updateAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }

    
    // MARK: - Display All Customers
    @IBAction func displayCustomerButton(_ sender: UIButton) {
        var displayText = "Customer List:\n"
        for customer in customers {
            displayText += "ID: \(customer.id), Name: \(customer.name), Age: \(customer.age), Email: \(customer.email)\n"
        }
        showAlert(title: "Customers", message: displayText)
    }
    
    // MARK: - Search Customer
    @IBAction func searchCustomer(_ sender: UIButton) {
        guard let searchText = nameTextField?.text, !searchText.isEmpty else {
            showAlert(title: "Error", message: "Please enter a search term.")
            return
        }
        
        let searchResults = customers.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        
        if searchResults.isEmpty {
            showAlert(title: "No Results", message: "No customer found matching the search term.")
        } else {
            var displayText = "Search Results:\n"
            for customer in searchResults {
                displayText += "ID: \(customer.id), Name: \(customer.name)\n"
            }
            clearTextFields()
            showAlert(title: "Search Results", message: displayText)
        }
    }
    
    // MARK: - Helper Functions
    private func clearTextFields() {
        nameTextField.text = ""
        idTextField.text = ""
        ageTextField.text = ""
        emailTextField.text = ""
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
