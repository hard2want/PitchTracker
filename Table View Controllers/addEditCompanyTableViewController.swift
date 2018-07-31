//
//  addEditCompanyTableViewController.swift
//  Pitch Tracker
//
//  Created by The Duke on 7/30/18.
//  Copyright © 2018 The Duke. All rights reserved.
//

import UIKit

class addEditCompanyTableViewController: UITableViewController {
    
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    } // end textEditingChanged()
    
    var company: Company?
    
    
    func updateSaveButtonState() {
        let companyNameText = companyNameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let cityText = cityTextField.text ?? ""
        let stateText = stateTextField.text ?? ""
        let websiteText = websiteTextField.text ?? ""
        saveButton.isEnabled = !companyNameText.isEmpty && !descriptionText.isEmpty && !cityText.isEmpty && !stateText.isEmpty && !websiteText.isEmpty
    } // end updateSaveButtonState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let company = company {
            companyNameTextField.text = company.companyName
            descriptionTextField.text = company.description
            cityTextField.text = company.city
            stateTextField.text = company.state
            websiteTextField.text = company.website
        }
        
        updateSaveButtonState()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {
            print("segue was booted at the add /edit guard")
            return}
        
        let companyName = companyNameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let city = cityTextField.text ?? ""
        let state = stateTextField.text ?? ""
        let website = websiteTextField.text ?? ""
        
        company = Company(companyName: companyName, description: description, city: city, state: state, website: website)
        print("the segue was prepared from the add / edit controller")
        
    } // end prepare(for segue: )
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } // end didReceiveMemoryWarning()
    
}
