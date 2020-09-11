//
//  PropertyCustomCell.swift
//  GSquadTest
//
//  Created by Apple on 11/09/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class PropertyCustomCell  : UICollectionViewCell
{
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_reference: UILabel!
    @IBOutlet weak var img_media: UIImageView!

    func loadData(property : Property)
    {
        lbl_price.text = property.financial.priceFormatted
        lbl_address.text = property.address.addressFormatted
        lbl_reference.text  = property.reference
        if(!property.medias.isEmpty)
        {
            img_media.downloaded(from: property.medias[0].url)
        }
    }
}
