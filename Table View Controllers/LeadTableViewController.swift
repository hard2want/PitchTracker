//
//  LeadTableViewController.swift
//  Pitch Tracker
//
//  Created by The Duke on 7/30/18.
//  Copyright © 2018 The Duke. All rights reserved.
//

import UIKit

class LeadTableViewController: UITableViewController {
    
    // ----------------------------------- Empty companies array []
    var companies: [Company] = [
        // start with an empty collection
    ]
    
    // ----------------------------------- Edit Button Tapped ()
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    } // end editButtonTapped()
    
    
    // ----------------------------------- View Did Load ()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        // modify Row Height to accomodate longer descriptions
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        // ---------- load saved companies or default starter list
        if let savedCompanies = Company.loadFromFile() {
            companies = savedCompanies
        } // end if let savedCompanies
    } // end viewDidLoad
    
    // ----------------------------------- Did Receive Memory Warning ()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    // ----------------------------------- Number Of Sections ( in  tabelView )
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    } // end numberOfSections()
    
    
    // ----------------------------------- ( Number Of Rows In Section )
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    } // end numberOfRowsInSection
    
    
    // ----------------------------------- ( Cell For Row At )
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! LeadTableViewCell
        
        let company = self.companies[indexPath.row]
        
        cell.update(with: company)

        cell.showsReorderControl = true
        
        return cell
    } // end cellForRowAt
    
    
    // ----------------------------------- ( Editing Style For Row At )
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    } // end editingStyleForRowAt
    
    
    // ----------------------------------- ( Commit Editing Style ) w/ Save To File
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            companies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        // Save user changes to storage
        Company.saveToFile(companies: companies)
    } // end editingStyle
    
    
    // ----------------------------------- ( Can Edit Row At )
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // ----------------------------------- ( Move Row At )
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedCompany = companies.remove(at: fromIndexPath.row)
        companies.insert(movedCompany, at: to.row)
        tableView.reloadData()
    }// end moveRowAt
    
    
    // ----------------------------------- ( SEGUE to Add Edit )
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditCompany" {
            let indexPath = tableView.indexPathForSelectedRow!
            let company = companies[indexPath.row]
            let nav = segue.destination as! UINavigationController
            let addEditCompanyTableViewController = nav.topViewController as! addEditCompanyTableViewController
            addEditCompanyTableViewController.company = company
        } // end if
    } // end prepare(for segue: )
    
    
    // ----------------------------------- Unwind To Company Table View () w/ Save To File
    @IBAction func unwindToLeadTableView(segue: UIStoryboardSegue ){
        print("Save button made it to step 1: the lead table view segue")
        guard segue.identifier == "saveUnwind" else {
            print("seque was booted at the guard.")
            return }
        let sourceViewController = segue.source as!addEditCompanyTableViewController
        print("Save segue made it to step 2")
        if let company = sourceViewController.company {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                companies[selectedIndexPath.row] = company
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: companies.count, section: 0)
                companies.append(company)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                print("save segue made it to step 3")
            } // end else
        } // end if let company
        
        // save data to file
        Company.saveToFile(companies: companies)
    } // end unwindToCompanyTableView(segue: )

} // end LeadTableViewController
