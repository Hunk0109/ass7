import UIKit

class PaymentsViewController: UIViewController {
    
    //    var payments: [Payment] {
    //        get { SharedData.shared.payments }
    //        set { SharedData.shared.payments = newValue }
    //    }
    //
    //    var claims: [Claim] {
    //        get { SharedData.shared.claims }
    //        set { SharedData.shared.claims = newValue }
    //    }
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //    }
    //
    //    @IBOutlet weak var genreNameTextField: UITextField!
    //    @IBOutlet weak var genreIdTextField: UITextField!
    //
    //
    //    @IBAction func addPayment(_ sender: UIButton) {
    //        guard let name = genreNameTextField?.text, !name.isEmpty,
    //              let idString = genreIdTextField?.text, let id = Int(idString) else {
    //            showAlert(title: "Error", message: "Please Enter Both Name And ID.")
    //            return
    //        }
    //
    //        if payments.contains(where: { $0.id == id }) {
    //            showAlert(title: "Error", message: "Genre With ID: \(id) already exists.")
    //            return
    //        }
    //
    //        payments.append(Payment(id: id, name: name))
    //        genreNameTextField.text = ""
    //        genreIdTextField.text = ""
    //        showAlert(title: "Success", message: "Genre Successfully Added.")
    //    }
    //
    //    @IBAction func deletePayment(_ sender: UIButton) {
    //        let actionSheet = UIAlertController(title: "Choose Genre To Delete", message: nil, preferredStyle: .actionSheet)
    //        for payment in payments {
    //            let action = UIAlertAction(title: payment.name, style: .default) { _ in
    //                if self.claims.contains(where: { $0.genre_id == payment.id }) {
    //                    self.showAlert(title: "Error", message: "Cannot Delete Genre With Associated Songs.")
    //                } else {
    //                    if let index = self.payments.firstIndex(where: { $0.id == payment.id }) {
    //                        self.payments.remove(at: index)
    //                        self.showAlert(title: "Success", message: "Genre Successfully Deleted.")
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
    //    @IBAction func updateGenre(_ sender: UIButton) {
    //        let actionSheet = UIAlertController(title: "Choose Genre To Update", message: nil, preferredStyle: .actionSheet)
    //        for payment in payments {
    //            let action = UIAlertAction(title: payment.name, style: .default) { _ in
    //                let alert = UIAlertController(title: "Enter New Name", message: nil, preferredStyle: .alert)
    //                alert.addTextField { textField in
    //                    textField.placeholder = "New Name"
    //                    textField.text = payment.name
    //                }
    //                let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
    //                    if let newName = alert.textFields?.first?.text, !newName.isEmpty {
    //                        if let index = self.payments.firstIndex(where: { $0.id == payment.id }) {
    //                            self.payments[index].name = newName
    //                            self.showAlert(title: "Success", message: "Genre Successfully Updated.")
    //                        }
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
    //    @IBAction func displayGenre(_ sender: UIButton) {
    //        var displayText = "Genres:\n"
    //        for payment in payments {
    //            displayText += "ID: \(payment.id), Name: \(payment.name)\n"
    //        }
    //        showAlert(title: "Genres", message: displayText)
    //    }
    //
    //
    //    @IBAction func searchGenre(_ sender: UIButton) {
    //        guard let searchText = genreNameTextField?.text, !searchText.isEmpty else {
    //            showAlert(title: "Error", message: "Please Enter A Search Term.")
    //            return
    //        }
    //
    //        let searchResults = SharedData.shared.payments.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    //
    //        if searchResults.isEmpty {
    //            showAlert(title: "No Results", message: "No Genres Found Matching The Search Term.")
    //        } else {
    //            var displayText = "Search Results:\n"
    //            for payment in searchResults {
    //                displayText += "ID: \(payment.id), Name: \(payment.name)\n"
    //            }
    //
    //            genreNameTextField?.text = ""
    //            genreIdTextField?.text = ""
    //            showAlert(title: "Search Results", message: displayText)
    //        }
    //    }
    //
    //    @IBAction func backButton(_ sender: UIButton) {
    //        self.dismiss(animated: true, completion: nil)
    //    }
    //
    //    func showAlert(title: String, message: String) {
    //        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    //        alertController.addAction(okAction)
    //        present(alertController, animated: true, completion: nil)
    //    }
    //}
}
