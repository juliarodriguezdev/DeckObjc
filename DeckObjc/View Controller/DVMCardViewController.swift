//
//  DVMCardViewController.swift
//  DeckObjc
//
//  Created by Julia Rodriguez on 7/2/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class DVMCardViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    
    
    @IBOutlet weak var cardLabelText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func drawCardButtonTapped(_ sender: Any) {
        updateViews()
        
    }
    
    func updateViews() {
        
        DVMCardController.drawNewCard { (card, error) in
            let drawnCard = card[0]
            DVMCardController.fetchImage(drawnCard, completion: { (drawnImage, error) in
                DispatchQueue.main.async {
                    self.cardImageView.image = drawnImage
                    self.cardLabelText.text = drawnCard.suit
                }
              
            })
            
        }
        
    }

}
