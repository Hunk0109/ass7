import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func customerButton(_ sender: UIButton) {
        let customerVC = CustomerViewController(nibName: "CustomerViewScreen", bundle: nil)
        self.present(customerVC, animated: true, completion: nil)
    }
    
    @IBAction func policyButton(_ sender: UIButton) {
        let policyVC = PolicyViewController(nibName: "PolicyViewScreen", bundle: nil)
        self.present(policyVC, animated: true, completion: nil)
    }
    
    @IBAction func claimButton(_ sender: UIButton) {
        let claimVC = ClaimViewController(nibName: "ClaimViewScreen", bundle: nil)
        self.present(claimVC, animated: true, completion: nil)
    }
    
    @IBAction func paymentButton(_ sender: UIButton) {
        let paymentVC = PaymentsViewController(nibName: "PaymentViewScreen", bundle: nil)
        self.present(paymentVC, animated: true, completion: nil)
    }
}
