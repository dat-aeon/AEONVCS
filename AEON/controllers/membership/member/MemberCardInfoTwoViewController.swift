//
//  MemberCardInfoTwoViewController.swift
//  AEON
//
//  Created by AcePlus101 on 2/1/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import SwiftyJSON

class MemberCardInfoTwoViewController: UIViewController {
    
    @IBOutlet weak var ivProfile: UIImageView!
    
    var registerResponse:RegisterResponse?
    var loginResponse:LoginResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registerResponseString = UserDefaults.standard.string(forKey: Constants.REGISTER_RESPONSE)
        
        registerResponse = try? JSONDecoder().decode(RegisterResponse.self, from: JSON(parseJSON: registerResponseString ?? "").rawData())
        
        let loginResponseString = UserDefaults.standard.string(forKey: Constants.LOGIN_RESPONSE)
        
        loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: JSON(parseJSON: loginResponseString ?? "").rawData())
        
        var photoPath = Constants.photo_base_url
        if let registerData = registerResponse{
            photoPath += registerData.photoPath ?? ""
        }
        if let loginData = loginResponse{
            photoPath += loginData.photoPath ?? ""
        }
        let photoUrl = URL(string: photoPath)
        self.ivProfile.kf.setImage(with: photoUrl)
    }

}
