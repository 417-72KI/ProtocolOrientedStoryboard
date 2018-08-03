//
//  TimelineViewController.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/25.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit

protocol TimelineView {

}

class TimelineViewController: UIViewController, TimelineView {

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TimelineViewController: StoryboardIdentifiable {
    static let identifier: String = "timeline"
}
