//
//  RootViewController.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 11/20/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var headerNameLabel: UILabel!
    @IBOutlet weak var newButton: UIButton!
    
    @IBAction func newButtonClicked(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
