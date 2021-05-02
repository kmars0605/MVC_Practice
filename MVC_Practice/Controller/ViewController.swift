import UIKit

class ViewController: UIViewController {
    var myView: MyView!
    var model: Model!

    func inject(myView: MyView, model: Model) {
        self.myView = myView
        self.model = model
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let width = view.frame.width
        myView.setView(width: width)
        view = myView
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: .textDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultButtonOnTap), name: .resultButtonOnTap, object: nil)
    }
    //Viewからのinputを受けてViewにoutput
    @objc func textDidChange() {
        if myView.left! != "" && myView.right! != "" {
            //入力完了
            myView.changeResultButtonEnable(isEnable: true)
        } else {
            //未入力あり
            myView.changeResultButtonEnable(isEnable: false)
        }
    }
    //Viewからのinputを受けてViewにoutput
    @objc func resultButtonOnTap() {
        guard let leftText = myView.leftValueTextField.text, let rightText = myView.rightValueTextField.text else { return }
        guard let leftNumber = Float(leftText), let rightNumber = Float(rightText) else {
            myView.showErrorAlert(viewController: self, title: "エラー", message: "数字を入れてください")
            return
        }
        myView.setResultLabel(text: String(format: "%.1f", model.multiply(leftNumber, rightNumber)))
    }
}
