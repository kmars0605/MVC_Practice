import UIKit

class MyView: UIView {
    var leftValueTextField: UITextField!
    var rightValueTextField: UITextField!
    var resultButton: UIButton!
    var resultLabel: UILabel!
    var left: String?
    var right: String?

    func setView(width: CGFloat) {
        leftValueTextField = UITextField()
        leftValueTextField.accessibilityIdentifier = "leftValueTextField"
        leftValueTextField.frame = CGRect(x: width * 0.05, y: 200, width: width * 0.4, height: 60)
        leftValueTextField.layer.borderWidth = 1
        leftValueTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        leftValueTextField.textAlignment = .center
        leftValueTextField.keyboardType = .numberPad
        addSubview(leftValueTextField)

        rightValueTextField = UITextField()
        rightValueTextField.accessibilityIdentifier = "rightValueTextField"
        rightValueTextField.frame = CGRect(x: width * 0.55, y: 200, width: width * 0.4, height: 60)
        rightValueTextField.layer.borderWidth = 1
        rightValueTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        rightValueTextField.textAlignment = .center
        rightValueTextField.keyboardType = .numberPad
        addSubview(rightValueTextField)

        resultButton = UIButton()
        resultButton.accessibilityIdentifier = "resultButton"
        resultButton.frame = CGRect(x: width * 0.2, y: 300, width: width * 0.6, height: 60)
        resultButton.setTitle("=", for: .normal)
        resultButton.setTitleColor(.black, for: .normal)
        resultButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 38)
        resultButton.isEnabled = false
        resultButton.layer.borderWidth = 1
        resultButton.addTarget(self, action: #selector(resultButtonOnTap), for: .touchDown)
        addSubview(resultButton)

        resultLabel = UILabel()
        resultLabel.accessibilityIdentifier = "resultLabel"
        resultLabel.frame = CGRect(x: width * 0.2, y: 400, width: width * 0.6, height: 60)
        resultLabel.textAlignment = .center
        addSubview(resultLabel)
    }
}

//MVPで言うところのinput部分
extension MyView {
    //ViewのtextFieldにinputがあったらControllerに通知
    @objc func textFieldDidChange() {
        guard let leftText = leftValueTextField.text, let rightText = rightValueTextField.text else { return }
        left = leftText
        right = rightText
        NotificationCenter.default.post(name: .textDidChange, object: nil)
    }
    //ViewのButtonにinputがあったらControllerに通知
    @objc func resultButtonOnTap() {
        guard let _ = leftValueTextField.text, let _ = rightValueTextField.text else { return }
        NotificationCenter.default.post(name: .resultButtonOnTap, object: nil)
    }
}
//MVPで言うところのoutput部分
extension MyView {
    func changeResultButtonEnable(isEnable: Bool) {
        self.resultButton.isEnabled = isEnable
        if isEnable {
            resultButton.setTitleColor(UIColor.blue, for: .normal)
        } else {
            resultButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    func setResultLabel(text: String) {
        self.resultLabel.text = text
    }
    func showErrorAlert(viewController: ViewController,title: String, message: String) {
        let actionAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "閉じる", style: UIAlertAction.Style.cancel, handler: nil)
        actionAlert.addAction(cancelAction)
        viewController.present(actionAlert, animated: true, completion: nil)
    }
}
