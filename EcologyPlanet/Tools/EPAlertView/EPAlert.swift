//
//  EPAlert.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/18.
//

import UIKit

class EPAlert: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var btnStacView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func initWith(topTitle:String,content:String,cancelTitle:String,okTitile:String) -> EPAlert{
        let alert = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! EPAlert
        
        alert.title?.isHidden = topTitle.isEmpty
        alert.contentTitle?.isHidden = content.isEmpty
        alert.cancelBtn?.isHidden = cancelTitle.isEmpty
        alert.okBtn?.isHidden = okTitile.isEmpty

        alert.title?.text = topTitle
        alert.contentTitle?.text = content
        alert.cancelBtn?.setTitle(cancelTitle, for: .normal)
        alert.okBtn?.setTitle(okTitile, for: .normal)
        
        return alert
    }
    public func show() {
        let widw = UIApplication.shared.keyWindow
        widw?.addSubview(self)
        self.center = widw!.center
  

        
    }
}
