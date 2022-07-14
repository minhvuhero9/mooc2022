//
//  BaseNibView.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 12/07/2022.
//

import UIKit

open class BaseNibView: UIView {

    private var contentView: UIView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
     func loadNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))

        guard let contentView: UIView = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            return UIView(frame: frame)
        }
        return contentView
    }
    
    public func loadContentViewWithNib(nibName: String) {
        backgroundColor = UIColor.clear
        if contentView == nil {
            contentView = self.loadNib(nibName: nibName)
            contentView?.frame = bounds
            contentView?.backgroundColor = .clear
            guard let content = contentView else {
                return
            }
            addSubview(content)
            addConstraintsWithFormat(format: "H:|[v0]|", views: content)
            addConstraintsWithFormat(format: "V:|[v0]|", views: content)
        }
    }

}

