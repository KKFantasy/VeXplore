//
//  MyFollowingCell.swift
//  VeXplore
//
//  Copyright © 2016 Jimmy. All rights reserved.
//

import SharedKit

class MyFollowingCell: BaseTableViewCell
{
    lazy var avatarImageView: AvatarImageView = {
        let view = AvatarImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = .body
        
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = SharedR.Font.Medium
        label.textColor = .desc
        
        return label
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .border
        
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomLine)
        let bindings = [
            "avatarImageView": avatarImageView,
            "contentLabel": contentLabel,
            "bottomLine": bottomLine
            ]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[avatarImageView(40@999)]-8-[contentLabel]-12-|", metrics: nil, views: bindings))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[avatarImageView]-8-[bottomLine(0.5)]|", metrics: nil, views: bindings))
        contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        preservesSuperviewLayoutMargins = false
        layoutMargins = .zero
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse()
    {
        avatarImageView.cancelImageDownloadTaskIfNeed()
        super.prepareForReuse()
        avatarImageView.image = nil
        contentLabel.font = SharedR.Font.Medium
    }
    
    @objc
    override func refreshColorScheme()
    {
        super.refreshColorScheme()
        avatarImageView.tintColor = .body
        contentLabel.textColor = .desc
        bottomLine.backgroundColor = .border
    }
    
}
