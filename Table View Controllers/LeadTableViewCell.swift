//
//  LeadTableViewCell.swift
//  Pitch Tracker
//
//  Created by The Duke on 7/30/18.
//  Copyright © 2018 The Duke. All rights reserved.
//

import UIKit

class LeadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    func update(with company: Company){
        companyNameLabel.text = company.companyName
        descriptionLabel.text = company.description
        cityLabel.text = company.city
        stateLabel.text = company.state
        websiteLabel.text = company.website
        
    } // end update()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
