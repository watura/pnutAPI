import UIKit

public protocol PostAction {
    func cancel()
    func compelete(text: String)
    func validate(text: String) -> Bool
}

public class PostViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!

    public var postAction: PostAction?
}

extension PostViewController {
    public static var storyboardName: String {
        return "Post"
    }

    public static var identifier: String {
        return "PostView"
    }

    public static func initView() -> PostViewController? {
        let storyboardBundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? PostViewController
    }
}

extension PostViewController {
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillChangeFrame(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        textView.becomeFirstResponder()
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillChangeFrame(notification: Notification) {
        if let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let endFrameY = endFrame.origin.y
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
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
