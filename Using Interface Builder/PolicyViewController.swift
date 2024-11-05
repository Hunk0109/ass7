import UIKit

class PolicyViewController: UIViewController {

    var customers: [Customer] {
        get { SharedData.shared.customers }
        set { SharedData.shared.customers = newValue }
    }
    
    var policies: [Policy] {
        get { SharedData.shared.policies }
        set { SharedData.shared.policies = newValue }
    }
    
    @IBOutlet weak var customerIDTextField: UITextField! 
    @IBOutlet weak var policyTypeTextField: UITextField!
    @IBOutlet weak var premiumAmountTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPolicy(_ sender: UIButton) {
        guard let customerIDText = customerIDTextField?.text, !customerIDText.isEmpty,
              let customerID = Int(customerIDText),
              let policyType = policyTypeTextField?.text, !policyType.isEmpty,
              let premiumAmountText = premiumAmountTextField?.text, let premiumAmount = Double(premiumAmountText),
              let startDate = startDateTextField?.text, !startDate.isEmpty,
              let endDate = endDateTextField?.text, !endDate.isEmpty else {
            showAlert(title: "Error", message: "Please enter all required fields.")
            return
        }
        
        // Validate Customer ID
        guard let _ = customers.first(where: { $0.id == customerID }) else {
            showAlert(title: "Error", message: "Invalid Customer ID.")
            return
        }
        
        let policyId = SharedData.shared.policies.map { $0.id }.max() ?? 0 + 1
        let policy = Policy(id: policyId, customer_id: customerID, policyType: policyType, premiumAmount: premiumAmount, startDate: startDate, endDate: endDate)
        SharedData.shared.policies.append(policy)
        
        showAlert(title: "Success", message: "Policy Successfully Added for Customer ID: \(customerID).")
        clearTextFields()
    }
    
    @IBAction func deletePolicy(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Policy To Delete", message: nil, preferredStyle: .actionSheet)
        for policy in policies {
            let action = UIAlertAction(title: policy.policyType, style: .default) { [unowned self] _ in
                guard !isPolicyActive(endDate: policy.endDate) else {
                    self.showAlert(title: "Error", message: "Cannot delete an active policy.")
                    return
                }
                if let index = SharedData.shared.policies.firstIndex(where: { $0.id == policy.id }) {
                    SharedData.shared.policies.remove(at: index)
                    self.showAlert(title: "Success", message: "Policy Successfully Deleted.")
                }
            }
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func updatePolicy(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Choose Policy To Update", message: nil, preferredStyle: .actionSheet)
        for policy in policies {
            let action = UIAlertAction(title: policy.policyType, style: .default) { [unowned self] _ in
                let alert = UIAlertController(title: "Enter New Details", message: nil, preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.placeholder = "New Policy Type"
                    textField.text = policy.policyType
                }
                alert.addTextField { textField in
                    textField.placeholder = "New Premium Amount"
                    textField.text = "\(policy.premiumAmount)"
                }
                alert.addTextField { textField in
                    textField.placeholder = "New End Date"
                    textField.text = policy.endDate
                }
                
                let updateAction = UIAlertAction(title: "Update", style: .default) { [unowned self] _ in
                    if let newPolicyType = alert.textFields?[0].text, !newPolicyType.isEmpty,
                       let newPremiumAmountText = alert.textFields?[1].text, let newPremiumAmount = Double(newPremiumAmountText),
                       let newEndDate = alert.textFields?[2].text, !newEndDate.isEmpty,
                       let index = self.policies.firstIndex(where: { $0.id == policy.id }) {
                        self.policies[index].policyType = newPolicyType
                        self.policies[index].premiumAmount = newPremiumAmount
                        self.policies[index].endDate = newEndDate
                        SharedData.shared.policies[index] = self.policies[index]
                        self.showAlert(title: "Success", message: "Policy Successfully Updated.")
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
    
    @IBAction func displayPolicies(_ sender: UIButton) {
        var displayText = "Policies:\n"
        for policy in SharedData.shared.policies {
            let customerName = SharedData.shared.customers.first { $0.id == policy.customer_id }?.name ?? "Unknown Customer"
            displayText += "ID: \(policy.id), Customer: \(customerName), Policy Type: \(policy.policyType), Premium: \(policy.premiumAmount), Start Date: \(policy.startDate), End Date: \(policy.endDate)\n"
        }
        showAlert(title: "Policies", message: displayText)
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
    
    func clearTextFields() {
        customerIDTextField.text = ""
        policyTypeTextField.text = ""
        premiumAmountTextField.text = ""
        startDateTextField.text = ""
        endDateTextField.text = ""
    }

    func isPolicyActive(endDate: String) -> Bool {
        // Implement your own logic to check if the policy is active based on the end date
        return false // Placeholder logic
    }
}
