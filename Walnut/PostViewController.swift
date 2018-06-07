import UIKit

public protocol PostAction {
    func cancel() -> Void
    func compelete(text: String) -> Void
    func validate(text: String) -> Bool
}

public class PostViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!

    public var postAction: PostAction?
}

extension PostViewController {
    public static func initView() -> PostViewController? {
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PostView") as? PostViewController
    }
}

extension PostViewController {
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillChangeFrame(notification:)),
                                               name: Notification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        textView.becomeFirstResponder()
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillChangeFrame(notification: Notification) {
        if let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let endFrameY = endFrame.origin.y
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.textViewBottomConstraint?.constant = 0.0
            } else {
                self.textViewBottomConstraint?.constant = endFrame.size.height
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}

extension PostViewController {
    func setAccessory() {
        let toolbar = UIToolbar()
        let bounds = self.view.bounds

        toolbar.bounds = CGRect(x: 0, y: 0, width: bounds.width, height: 44)
        toolbar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 44)
        toolbar.isTranslucent = false
        toolbar.autoresizingMask = .flexibleWidth
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(PostViewController.cancel))
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PostViewController.complete))

        toolbar.setItems([cancelItem, flexSpaceItem, doneButtonItem], animated: false)
        textView.inputAccessoryView = toolbar
    }

    @objc func cancel() {
        textView.resignFirstResponder()
        postAction?.cancel()
    }

    @objc func complete() {
        textView.resignFirstResponder()
        let text = textView.text
        textView.text = ""
        postAction?.compelete(text: text ?? "")
    }
}

extension PostViewController: UITextViewDelegate {
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        setAccessory()
        return true
    }
}
