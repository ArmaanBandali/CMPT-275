//
//  AdventureGameInst.swift
//  PARKinetics
//
//  Created by Kai Sackville-Hii on 2019-11-28.
//  Copyright © 2019 Kai Sackville-Hii. All rights reserved.
//

import Foundation
import UIKit

class AdventureGameInst: UIViewController {

    @IBAction func backButton1(_ sender: Any) {
        print("in")
        performSegue(withIdentifier: "unwindToHomeFromAdventureStoryInst", sender: self)
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    


