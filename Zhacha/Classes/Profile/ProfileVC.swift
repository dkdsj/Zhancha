//
//  ProfileVC.swift
//  Zhacha
//
//  Created by ZZ on 2019/9/2.
//  Copyright © 2019 ZZ. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    var imageURL: String? = nil

    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        imageURL = url
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    convenience init(url: String, name: String) {
        self.init(url: url)

        imageURL = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var ivIcon: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 20, y: 200, width: 100, height: 100))
        iv.image = UIImage(named: "tab_home")?.imageWithColor(.red)
        
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.extRandom

        view.addSubview(ivIcon)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.backgroundColor = UIColor.extRandom
        
        ivIcon.image = UIImage.fromColor(color: .extRandom)
    }

}
