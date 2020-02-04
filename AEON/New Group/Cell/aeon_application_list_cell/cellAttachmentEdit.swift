//
//  cellAttachmentEdit.swift
//  AEONVCS
//
//  Created by mac on 11/25/19.
//  Copyright © 2019 AEON microfinance. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol cellAttachmentEditDelegate {
    func editAction(index: Int)
}

class cellAttachmentEdit: UITableViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImageview: UIImageView!
    @IBOutlet weak var cellBtnEdit: UIButton! {
        didSet {
            self.cellBtnEdit.layer.cornerRadius = 5
            self.cellBtnEdit.clipsToBounds = true
        }
    }
    
    var delegate: cellAttachmentEditDelegate?
    
    var imageview : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
        
        self.imageview = UIImageView(frame: CGRect(x: 5, y: 5, width: 198, height: 148))
        self.imageview.contentMode = .scaleAspectFit
    }
    
    
    func setData(para :PurchaseAttachmentResponse, imgfile: UIImage?) {
        switch para.fileType {
        case 1:
            cellTitle.text = "NRC Front"
        case 2:
            cellTitle.text = "NRC Back"
        case 3:
            cellTitle.text = "Residence Proof Attachment"
        case 4:
            cellTitle.text = "Income Proof Attachment"
        case 5:
            cellTitle.text = "Guarantor NRC Front"
        case 6:
            cellTitle.text = "Guarantor NRC Back"
        case 7:
            cellTitle.text = "Household or Criminal Clearence"
        case 8:
            cellTitle.text = "Applicant's Photo"
        case 9:
            cellTitle.text = "Customer Signature Attachment"
        default:
            cellTitle.text = ""
        }
        
        if imgfile == nil {
            let imgString = "https://ass.aeoncredit.com.mm/daso/digital-application-image-files/\(para.filePath ?? "")"
            if let urlstring = URL(string: imgString) {
                self.cellImageview?.kf.setImage(with: urlstring)
                self.cellImageview.kf.indicatorType = .activity
                //imageVIEW.image = self.imageview.image
                
            }
            imageView?.layer.cornerRadius = 3
            imageView?.clipsToBounds = true
            

        } else {
            cellImageview.image = imgfile ?? UIImage()
        }
        
        if para.editFlag ?? false {
            self.cellBtnEdit.isHidden = false
        } else {
            self.cellBtnEdit.isHidden = true
        }
    }
    
    @IBAction func tappedOnEdit(_ sender: Any) {
        if let btn = sender as? UIButton {
                   self.delegate?.editAction(index: btn.tag)
        }
    }
    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse?, data: Data?, error: Error?) -> Void in
                if let imageData = data as Data? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
