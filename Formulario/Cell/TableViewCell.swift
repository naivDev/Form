//
//  TableViewCell.swift
//  Formulario
//
//  Created by Oscar Ivan Pérez Salazar on 22/01/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var lblFirstLastName: UILabel!
    @IBOutlet weak var lblSecondLastName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 15
        backView.layer.masksToBounds = false
        backView.layer.shadowColor = UIColor.red.cgColor
        backView.layer.shadowOpacity = 0.7
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 4
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

