//
//  ViewController.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 16/01/2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        label1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
        }
        
        label2.snp.makeConstraints {
            $0.top.equalTo(label1.snp.bottom).offset(20)
        }
        label3.snp.makeConstraints {
            $0.top.equalTo(label2.snp.bottom).offset(20)
        }
        label4.snp.makeConstraints {
            $0.top.equalTo(label3.snp.bottom).offset(20)
        }
        label5.snp.makeConstraints {
            $0.top.equalTo(label4.snp.bottom).offset(20)
        }
        
        label1.font = UIFont.largeTitle
        label1.text = "MARS.CAMERA"
        
        label2.font = UIFont.title2
        label2.text = "MARS.CAMERA"
        
        label3.font = UIFont.title
        label3.text = "MARS.CAMERA"
        
        label4.font = UIFont.body2
        label4.text = "MARS.CAMERA"
        
        label5.font = UIFont.body
        label5.text = "MARS.CAMERA"
        // Do any additional setup after loading the view.
    }


}

