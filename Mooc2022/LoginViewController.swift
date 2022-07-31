//
//  LoginViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import UIKit

class LoginViewController: BaseViewController {
    
    weak var coordinator: LoginCoordinator?
    
    /// Properties helper login animation
    @IBOutlet weak private var loginAnimation: UIButton!
    /// View for collisionBehavior
    @IBOutlet weak private var rowView: UIView!
    
    private let transition: CircularTransition = CircularTransition()
    private var animator: UIDynamicAnimator = UIDynamicAnimator()
    private var countJump: Int = 0
    private var isShowAnimation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAccountLoggedIn()
        
        animator = UIDynamicAnimator(referenceView: self.view)
    }
    
    /// Set animation for loginAnimation
    func addBehaviorAnimationForLoginAnimation() {
        let gravityBehavior = UIGravityBehavior(items: [loginAnimation])
        animator.addBehavior(gravityBehavior)
        let collisionBehavior = UICollisionBehavior(items: [loginAnimation])
        collisionBehavior.addBoundary(withIdentifier: "rowView" as NSString, from: rowView.frame.origin, to: CGPoint(x: rowView.frame.origin.x + rowView.frame.size.width, y: rowView.frame.origin.y))
        collisionBehavior.collisionDelegate = self
        animator.addBehavior(collisionBehavior)
        let ballBehavior = UIDynamicItemBehavior(items: [loginAnimation])
        ballBehavior.elasticity = 0.75
        animator.addBehavior(ballBehavior)
    }
    
    /// Login animation action
    @IBAction func logicAnimationAction(_ sender: UIButton) {
        if !isShowAnimation {
            addBehaviorAnimationForLoginAnimation()
            isShowAnimation = true
        } else {
            let mainViewController = MainViewController()
            mainViewController.transitioningDelegate = self
            mainViewController.modalPresentationStyle = .custom
            present(mainViewController, animated: true)
        }
    }
    
    @IBAction func pressedLoginWithFacebook(_ sender: Any) {
        loginWithFacebookAction()
    }
    
    @IBAction func pressedLoginWithGoogle(_ sender: Any) {
        loginWithGoogleAction()
    }
    
    func checkAccountLoggedIn() {
        let currentUser = LoginService.shared.currentUser
        Log.debug.out("Provider uid current: \(currentUser?.uid ?? "")")
        if currentUser != nil {
            self.coordinator?.loginSuccess()
        }
    }
    // MARK: Google login method
    func loginWithGoogleAction() {
        LoginService.shared.loginWithGoogle(
            vc: self,
            onSuccess: { [weak self] in
                UserDefaults.standard.set(LoginService.LoginType.google.rawValue, forKey: "loginType")
                self?.coordinator?.loginSuccess()
            },
            onFailed: { [weak self] error in
                self?.showMessagePrompt(error?.localizedDescription ?? "Unknown")
            }
        )
    }
    
    // MARK: Facebook login method
    func loginWithFacebookAction() {
        LoginService.shared.loginWithFacebook(
            vc: self,
            onSuccess: { [weak self] in
                UserDefaults.standard.set(LoginService.LoginType.facebook.rawValue, forKey: "loginType")
                self?.coordinator?.loginSuccess()
            },
            onFailed: { [weak self] error in
                self?.showMessagePrompt(error?.localizedDescription ?? "Unknown")
            }
        )
    }
    
    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}

// MARK: UICollisionBehaviorDelegate
extension LoginViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        countJump += 1
        self.loginAnimation.setTitle("   Login Success", for: .normal)
        self.loginAnimation.setImage(UIImage(systemName: "lock.open"), for: .normal)
        if (countJump == 2) {
            loginAnimation.sendActions(for: .touchUpInside)
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension LoginViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = loginAnimation.center
        transition.circleColor = loginAnimation.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = loginAnimation.center
        transition.circleColor = loginAnimation.backgroundColor!
        
        return transition
    }
}
