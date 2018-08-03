//
//  ViewController.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/24.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit

protocol FirstView: class {
    var message: Message { get set }
}

class FirstViewController: UIViewController, FirstView {

    var message: Message = Message(value: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let second as SecondView:
            second.message = message
        default:
            break
        }
    }
}

extension FirstViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        message.value = textField.text ?? ""
    }
}
