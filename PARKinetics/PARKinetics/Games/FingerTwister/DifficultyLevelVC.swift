//
//  File.swift
//  PARKinetics
//
//  Created by Negar Hariri on 2019-11-27.
//  Copyright © 2019 Kai Sackville-Hii. All rights reserved.
//



import Foundation
//
//  MenuVC.swift
//
//
//  Created by Negar Hariri on 2019-11-23.
//

import UIKit

var level: Int = 0

class DifficultyLevelVC: UIViewController {

     
    @IBAction func Level(_ sender: Any) {
        level = 1
        performSegue(withIdentifier: "LevelOne", sender: sender)
    }
    
    
    @IBAction func LevelTwo(_ sender: Any) {
        level = 2
        performSegue(withIdentifier: "LevelTwo", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        print(UIScreen.main.bounds,screenSize.width, screenSize.height)
        let scaleX = screenSize.width / 768//768 is ipadPro screen width
        let scaleY = screenSize.height / 1024 //1024 is ipadPro screen height
        self.view.transform = CGAffineTransform.identity.scaledBy(x: scaleX, y: scaleY)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        self.navigationController?.setToolbarHidden(true, animated: animated)
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
    


