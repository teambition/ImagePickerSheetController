//
//  PreviewCollectionViewCell.swift
//  ImagePickerSheet
//
//  Created by Laurin Brandner on 06/09/14.
//  Copyright (c) 2014 Laurin Brandner. All rights reserved.
//

import UIKit

class PreviewCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor.lightText
        
        return imageView
    }()
    
    let videoIndicatorView: UIImageView = {
        let imageView = UIImageView(image: videoImage)
        imageView.isHidden = true
        
        return imageView
    }()
    
    let iCloudIndicatorView: UIImageView = {
        let imageView = UIImageView(image: iCloudImage)
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let hightLightView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.alpha = 0.7
        view.isHidden = true
        return view
    }()
    
    var localIdetifier: String = ""
    
    fileprivate class var videoImage: UIImage? {
        let bundle = Bundle(for: ImagePickerSheetController.self)
        let image = UIImage(named: "PreviewCollectionViewCell-video", in: bundle, compatibleWith: nil)
        
        return image
    }
    
    fileprivate class var iCloudImage: UIImage? {
        let bundle = Bundle(for: ImagePickerSheetController.self)
        let image = UIImage(named: "iCloud", in: bundle, compatibleWith: nil)
        
        return image
    }
    
    override var isHighlighted: Bool {
        didSet {
            hightLightView.isHidden = !isHighlighted
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    fileprivate func initialize() {
        addSubview(imageView)
        addSubview(videoIndicatorView)
        
        addSubview(hightLightView)
        hightLightView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: hightLightView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: hightLightView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: hightLightView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: hightLightView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        
        addSubview(iCloudIndicatorView)
        NSLayoutConstraint(item: iCloudIndicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 24).isActive = true
        NSLayoutConstraint(item: iCloudIndicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 24).isActive = true
        NSLayoutConstraint(item: iCloudIndicatorView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -15).isActive = true
        NSLayoutConstraint(item: iCloudIndicatorView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -15).isActive = true
    }
    
    // MARK: - Other Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        videoIndicatorView.isHidden = true
        iCloudIndicatorView.isHidden = true
        hightLightView.isHidden = true
        localIdetifier = ""
        
        isUserInteractionEnabled = false
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
        
        let videoIndicatViewSize = videoIndicatorView.image?.size ?? CGSize()
        let inset: CGFloat = 4
        let videoIndicatorViewOrigin = CGPoint(x: bounds.minX + inset, y: bounds.maxY - inset - videoIndicatViewSize.height)
        videoIndicatorView.frame = CGRect(origin: videoIndicatorViewOrigin, size: videoIndicatViewSize)
        
        hightLightView.backgroundColor = tintColor
    }
}
