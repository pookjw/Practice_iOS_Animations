/*
 * Copyright (c) 2014-present Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {
    
    // MARK: IB outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    var statusPosition = CGPoint.zero
    
    /* --- END EXAMPLE --- */
    var animationContainerView: UIView!
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
        
        /* --- END EXAMPLE --- */
        // set up the animation container
        animationContainerView = UIView(frame: view.bounds)
        animationContainerView.frame = view.bounds
        animationContainerView.isUserInteractionEnabled = false
        view.addSubview(animationContainerView)
        
        statusPosition = status.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x  -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        
        cloud1.alpha = 0.0
        cloud2.alpha = 0.0
        cloud3.alpha = 0.0
        cloud4.alpha = 0.0
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.heading.center.x += self.view.bounds.width
        }
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
            self.username.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
            self.password.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.cloud1.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
            self.cloud2.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
            self.cloud3.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
            self.cloud4.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0,
                       options: [], animations: {
                        self.loginButton.center.y -= 30.0
                        self.loginButton.alpha = 1.0
                       }, completion: nil)
        
        /* --- END EXAMPLE --- */
        
        // create new view
        let newView = UIImageView(image: UIImage(named: "banner"))
        newView.center = animationContainerView.center
        
        // MARK: - Adding the View
        
        // add the new view via transition
        UIView.transition(with: animationContainerView,
                          duration: 0.33,
                          options: [.curveEaseOut, .transitionFlipFromBottom]) {
            self.animationContainerView.addSubview(newView)
        }
        
        // MARK: - Removeing, Hiding the View
        
        // remove the view via transition
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            UIView.transition(with: self.animationContainerView,
//                              duration: 0.33,
//                              options: [.curveEaseOut, .transitionFlipFromBottom]) {
//                newView.removeFromSuperview()
//            }
//        }
        
        // hide the view via transition
        /*
         이게 isHidden = false일 때는 transition이 작동하는데 true는 안 돼서 이렇게 해줘야함.
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.transition(with: newView,
                              duration: 0.33,
                              options: [.curveEaseOut, .transitionFlipFromBottom]) {
                newView.alpha = 0
            } completion: { _ in
                newView.isHidden = true
            }
        }
        
        // Replacing a view with another view
        /*
         from은 removeFromSuperview() 처리가 되고,
         to는 addSubview() 처리가 모두 자동으로 된다.
         */
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            let anotherView = UIView(frame: self.view.bounds)
//            anotherView.frame = self.view.bounds
//            anotherView.backgroundColor = .brown
//            UIView.transition(from: newView, to: anotherView, duration: 0.33, options: .transitionFlipFromTop) { _ in
//                print(newView.isHidden)
//                print(anotherView.isHidden)
//                print(newView.alpha)
//                print(anotherView.alpha)
//                print(newView.superview)
//                print(anotherView.superview)
//            }
//        }
    }
    
    // MARK: further methods
    
    @IBAction func login() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.bounds.size.width += 80.0
        }, completion: { _ in
            /* --- END EXAMPLE --- */
            self.showMessage(index: 0)
        })
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60.0
            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            self.spinner.center = CGPoint(
                x: 40.0,
                y: self.loginButton.frame.size.height/2
            )
            self.spinner.alpha = 1.0
        }, completion: nil)
        
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
    
    /* --- END EXAMPLE --- */
    func showMessage(index: Int) {
        label.text = messages[index]
        
        /*
         이게 isHidden = false일 때는 transition이 작동하는데 true는 안 됨.
         */
        UIView.transition(with: status,
                          duration: 0.33,
                          options: [.curveEaseOut, .transitionCurlDown]) {
            self.status.isHidden = false
        } completion: { _ in
            delay(2.0) {
                if index < self.messages.count - 1 {
                    self.removeMessage(index: index)
                } else {
                    // reset form
                }
            }
        }
    }
    
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: []) {
            self.status.center.x += self.view.frame.size.width
        } completion: { _ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.showMessage(index: index + 1)
        }
    }
}
