//
//  AddPersonViewController.swift
//  CoreDataPractice
//
//  Created by Hungju Lu on 01/12/2016.
//  Copyright © 2016 Hungju. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    fileprivate var dataConnector: CoreDataConnection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Add Person", comment: "")
        self.addButton.isEnabled = false
        self.textField.delegate = self
        
        self.dataConnector = CoreDataConnection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text {
            let amendedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            self.addButton.isEnabled = (amendedText.characters.count > 0)
        }
        
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let name = self.textField.text,
            self.dataConnector.insertPerson(withName: name) else {
                let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        
        let _ = self.navigationController?.popViewController(animated: true)
    }
}
