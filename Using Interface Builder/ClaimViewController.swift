import UIKit

class ClaimViewController: UIViewController {
}
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        albumPicker.delegate = self
//        albumPicker.dataSource = self
//        genrePicker.delegate = self
//        genrePicker.dataSource = self
//    }
//    
//    var selectedAlbum: Policy?
//    var selectedGenre: Payment?
//    
//    @IBOutlet weak var songIDTextField: UITextField!
//    @IBOutlet weak var songTitleTextField: UITextField!
//    @IBOutlet weak var songDuration: UITextField!
//    @IBOutlet weak var songFavorite: UITextField!
//    @IBOutlet weak var albumPicker: UIPickerView!
//    @IBOutlet weak var genrePicker: UIPickerView!
//    
//    @IBAction func addSong(_ sender: UIButton) {
//        guard let songTitle = songTitleTextField?.text,
//              let durationText = songDuration?.text,
//              let duration = Double(durationText),
//              
//                let selectedAlbum = selectedAlbum,
//              let selectedGenre = selectedGenre else {
//            showAlert(title: "Error", message: "Please Enter All Fields And Select An Album And Genre.")
//            return
//        }
//        let isFavorite = songFavorite?.text?.lowercased() == "true"
//        
//        if SharedData.shared.claims.contains(where: { $0.title == songTitle && $0.policy_id == selectedAlbum.id }) {
//            showAlert(title: "Error", message: "Song With Title: '\(songTitle)' Already Exists For This Album.")
//            return
//        }
//        
//        let newSong = Claim(id: SharedData.shared.claims.count + 1,
//                           customer_id: selectedAlbum.customerId,
//                           policy_id: selectedAlbum.id,
//                           genre_id: selectedGenre.id,
//                           title: songTitle,
//                           duration: duration,
//                           favorite: isFavorite)
//        SharedData.shared.claims.append(newSong)
//        
//        // Display success message
//        showAlert(title: "Success", message: "Song Successfully Added.")
//        // Reset the form
//        songIDTextField?.text = ""
//        songTitleTextField?.text = ""
//        songDuration?.text = ""
//        songFavorite?.text = ""
//    }
//    
//    @IBAction func deleteSong(_ sender: UIButton) {
//        let actionSheet = UIAlertController(title: "Choose Song To Delete", message: nil, preferredStyle: .actionSheet)
//        for song in SharedData.shared.claims { // Assuming you use SharedData for global access
//            let action = UIAlertAction(title: song.title, style: .default) { [unowned self] _ in
//                if let index = SharedData.shared.claims.firstIndex(where: { $0.id == song.id }) {
//                    SharedData.shared.claims.remove(at: index)
//                    self.showAlert(title: "Success", message: "Song Successfully Deleted.")
//                }
//            }
//            actionSheet.addAction(action)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        actionSheet.addAction(cancelAction)
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//    
//    @IBAction func updateSong(_ sender: UIButton) {
//        let actionSheet = UIAlertController(title: "Choose Song To Update", message: nil, preferredStyle: .actionSheet)
//        for song in SharedData.shared.claims {
//            let action = UIAlertAction(title: song.title, style: .default) { [unowned self] _ in
//                let alert = UIAlertController(title: "Enter New Details", message: nil, preferredStyle: .alert)
//                alert.addTextField { textField in
//                    textField.placeholder = "New Title"
//                    textField.text = song.title
//                }
//                alert.addTextField { textField in
//                    textField.placeholder = "New Duration"
//                    textField.text = "\(song.duration)"
//                }
//                alert.addTextField { textField in
//                    textField.placeholder = "Favorite (true/false)"
//                    textField.text = song.favorite ? "true" : "false"
//                }
//                let updateAction = UIAlertAction(title: "Update", style: .default) { [unowned self] _ in
//                    if let newTitle = alert.textFields?[0].text, !newTitle.isEmpty,
//                       let newDurationString = alert.textFields?[1].text,
//                       let newDuration = Double(newDurationString),
//                       let newFavoriteString = alert.textFields?[2].text,
//                       let newFavorite = Bool(newFavoriteString.lowercased()) {
//                        if let index = SharedData.shared.claims.firstIndex(where: { $0.id == song.id }) {
//                            SharedData.shared.claims[index].title = newTitle
//                            SharedData.shared.claims[index].duration = newDuration
//                            SharedData.shared.claims[index].favorite = newFavorite
//                            self.showAlert(title: "Success", message: "Song Successfully Updated.")
//                        }
//                    }
//                }
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//                alert.addAction(updateAction)
//                alert.addAction(cancelAction)
//                self.present(alert, animated: true, completion: nil)
//            }
//            actionSheet.addAction(action)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        actionSheet.addAction(cancelAction)
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//    
//    @IBAction func displaySong(_ sender: UIButton) {
//        var displayText = "Songs:\n"
//        
//        for song in SharedData.shared.claims {
//            
//            let albumName = SharedData.shared.policies.first { $0.id == song.policy_id }?.policyType ?? "Unknown Album"
//            let genreName = SharedData.shared.payments.first { $0.id == song.genre_id }?.name ?? "Unknown Genre"
//            
//            displayText += "Title: \(song.title), Duration: \(song.duration) minutes, Favorite: \(song.favorite ? "Yes" : "No"), Album: \(albumName), Genre: \(genreName)\n"
//        }
//        
//        showAlert(title: "All Songs", message: displayText)
//    }
//    
//    
//    @IBAction func searchSong(_ sender: UIButton) {
//        guard let searchText = songTitleTextField?.text, !searchText.isEmpty else {
//            showAlert(title: "Error", message: "Please Enter Song Title.")
//            return
//        }
//        
//        let searchResults = SharedData.shared.claims.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
//        
//        if searchResults.isEmpty {
//            showAlert(title: "No Results", message: "No Songs Found Matching The Search Term.")
//        } else {
//            var displayText = "Search Results:\n"
//            for song in searchResults {
//                displayText += "ID: \(song.id), Title: \(song.title), Duration: \(song.duration) minutes, Favorite: \(song.favorite ? "Yes" : "No")\n"
//            }
//            showAlert(title: "Search Results", message: displayText)
//            songIDTextField?.text = ""
//            songTitleTextField?.text = ""
//            songDuration?.text = ""
//            songFavorite?.text = ""
//        }
//    }
//    
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
//
//// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
//extension ClaimViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == albumPicker {
//            return SharedData.shared.policies.count
//        } else if pickerView == genrePicker {
//            return SharedData.shared.payments.count
//        }
//        return 0
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == albumPicker {
//            return SharedData.shared.policies[row].policyType
//        } else if pickerView == genrePicker {
//            return SharedData.shared.payments[row].name
//        }
//        return nil
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == albumPicker {
//            selectedAlbum = SharedData.shared.policies[row]
//        } else if pickerView == genrePicker {
//            selectedGenre = SharedData.shared.payments[row]
//        }
//    }
//}

//import UIKit
//
//class ClaimViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        policyPicker.delegate = self
//        statusPicker.delegate = self
//    }
//
//    var selectedPolicy: Policy?
//    var selectedStatus: String?
//    
//    @IBOutlet weak var claimIDTextField: UITextField!
//    @IBOutlet weak var policyIDTextField: UITextField!
//    @IBOutlet weak var claimAmountTextField: UITextField!
//    @IBOutlet weak var endDateClaimTextField: UITextField!
//    @IBOutlet weak var policyPicker: UIPickerView!
//    @IBOutlet weak var statusPicker: UIPickerView!
//    
//    // Assuming these are the possible statuses for claims
//    let statuses = ["Pending", "Approved", "Rejected"]
//
//    @IBAction func addClaim(_ sender: UIButton) {
//        guard let claimAmountText = claimAmountTextField?.text,
//              let claimAmount = Double(claimAmountText),
//              let selectedPolicy = selectedPolicy else {
//            showAlert(title: "Error", message: "Please Enter Claim Amount and Select a Policy.")
//            return
//        }
//
//        let newClaim = Claim(id: SharedData.shared.claims.count + 1,
//                             customer_id: selectedPolicy.customer_id,
//                             policyId: selectedPolicy.id,
//                             claimAmount: claimAmount, dateOfClaim: <#String#>,
//                             status: "Pending") // Default status is 'Pending'
//        SharedData.shared.claims.append(newClaim)
//
//        // Display success message
//        showAlert(title: "Success", message: "Claim Successfully Added.")
//        // Reset the form
//        claimIDTextField?.text = ""
//        claimAmountTextField?.text = ""
//    }
//    
//    @IBAction func deleteClaim(_ sender: UIButton) {
//        let actionSheet = UIAlertController(title: "Choose Claim To Delete", message: nil, preferredStyle: .actionSheet)
//        for claim in SharedData.shared.claims {
//            // Prevent deletion of approved claims
//            if claim.status != "Approved" {
//                let action = UIAlertAction(title: "Claim ID: \(claim.id)", style: .default) { [unowned self] _ in
//                    if let index = SharedData.shared.claims.firstIndex(where: { $0.id == claim.id }) {
//                        SharedData.shared.claims.remove(at: index)
//                        self.showAlert(title: "Success", message: "Claim Successfully Deleted.")
//                    }
//                }
//                actionSheet.addAction(action)
//            }
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        actionSheet.addAction(cancelAction)
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//
//    @IBAction func updateClaim(_ sender: UIButton) {
//        let actionSheet = UIAlertController(title: "Choose Claim To Update", message: nil, preferredStyle: .actionSheet)
//        for claim in SharedData.shared.claims {
//            let action = UIAlertAction(title: "Claim ID: \(claim.id)", style: .default) { [unowned self] _ in
//                let alert = UIAlertController(title: "Enter New Details", message: nil, preferredStyle: .alert)
//                alert.addTextField { textField in
//                    textField.placeholder = "New Amount"
//                    textField.text = "\(claim.claimAmount)"
//                }
//                alert.addTextField { textField in
//                    textField.placeholder = "New Status"
//                    textField.text = claim.status
//                }
//                let updateAction = UIAlertAction(title: "Update", style: .default) { [unowned self] _ in
//                    if let newAmountString = alert.textFields?[0].text,
//                       let newAmount = Double(newAmountString),
//                       let newStatus = alert.textFields?[1].text {
//                        if let index = SharedData.shared.claims.firstIndex(where: { $0.id == claim.id }) {
//                            SharedData.shared.claims[index].claimAmount = newAmount
//                            SharedData.shared.claims[index].status = newStatus
//                            self.showAlert(title: "Success", message: "Claim Successfully Updated.")
//                        }
//                    }
//                }
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//                alert.addAction(updateAction)
//                alert.addAction(cancelAction)
//                self.present(alert, animated: true, completion: nil)
//            }
//            actionSheet.addAction(action)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        actionSheet.addAction(cancelAction)
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//    
//    @IBAction func viewClaims(_ sender: UIButton) {
//        var displayText = "Claims:\n"
//        
//        for claim in SharedData.shared.claims {
//            let policyType = SharedData.shared.policies.first { $0.id == claim.policyId }?.policyType ?? "Unknown Policy"
//            
//            displayText += "Claim ID: \(claim.id), Amount: \(claim.claimAmount), Status: \(claim.status), Policy: \(policyType)\n"
//        }
//        
//        showAlert(title: "All Claims", message: displayText)
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
//
//// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
//extension ClaimViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == policyPicker {
//            return SharedData.shared.policies.count
//        } else if pickerView == statusPicker {
//            return statuses.count
//        }
//        return 0
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == policyPicker {
//            return SharedData.shared.policies[row].policyType
//        } else if pickerView == statusPicker {
//            return statuses[row]
//        }
//        return nil
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == policyPicker {
//            selectedPolicy = SharedData.shared.policies[row]
//        } else if pickerView == statusPicker {
//            selectedStatus = statuses[row]
//        }
//    }
//}
