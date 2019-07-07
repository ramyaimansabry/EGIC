//
//  TermsOfServiceController.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class TermsOfServiceController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTerms()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func setupTerms(){
        let htmlText = """
         <h4 class="p1" style="text-align: left;">Thank you for downloading our application. the below terms will apply as soon as you press the register button</h4>
         <p>&nbsp;</p>
         <p class="p1" style="text-align: left;">- The data you entered while registering will be used in internal marketing campaigns and visitor insights.</p>
         <p class="p1" style="text-align: left;">- Each time you login, your ip address will be obtained for our geographical analysis tools.</p>
         <p class="p1" style="text-align: left;">- Your activity within the products section will be recorded to provide insights for the firm.</p>
         <p class="p1" style="text-align: left;">- Your data WILL NOT BE FORWARDED to third parties.</p>
         <p class="p1" style="text-align: left;">- If there is any change in our ToS, we will notify you 30 days prior to the change. - The locations provided in our maps are genuine. However, we are not responsible for any circumstances that occur en route.</p>
         """
        textView.attributedText = htmlText.htmlToAttributedString
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.title = "Terms & Conditions"
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackICON")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.mainAppColor()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }

}
