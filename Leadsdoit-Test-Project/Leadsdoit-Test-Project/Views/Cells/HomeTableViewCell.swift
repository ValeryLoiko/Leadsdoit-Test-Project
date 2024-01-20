//
//  HomeTableViewCell.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 19/01/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    private lazy var cornerView: UIView = {
       let view = UIView()
       view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        let borderShadowLayer = CALayer()
          borderShadowLayer.frame = view.bounds
          borderShadowLayer.cornerRadius = 20
          borderShadowLayer.backgroundColor = UIColor.green.cgColor
          borderShadowLayer.shadowColor = UIColor.black.cgColor
          borderShadowLayer.shadowOffset = CGSize(width: 20, height: 20)
          borderShadowLayer.shadowOpacity = 0.5
          borderShadowLayer.shadowRadius = 20

        // Устанавливаем shadowPath
         borderShadowLayer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 20).cgPath
         
         // Добавляем тень после установки границы
         view.layer.addSublayer(borderShadowLayer)
       return view
    }()
    
    private lazy var roverLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var cameraLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var dateLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var cameraImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8, weight: .thin)
        return label
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure(imageURL: String, roverText: String, cameraText: String, dateText: String) {
        
         let grayAttributes: [NSAttributedString.Key: Any] = [
             .foregroundColor: UIColor.gray,
             .font: UIFont.systemFont(ofSize: 15, weight: .regular)
         ]
         
         let body2Attributes: [NSAttributedString.Key: Any] = [
             .foregroundColor: UIColor.black,
             .font: UIFont.body2!
         ]
         
         let attributedRoverText = NSMutableAttributedString(string: "Rover: ", attributes: grayAttributes)
         let attributedCameraText = NSMutableAttributedString(string: "Camera: ", attributes: grayAttributes)
         let attributedDateText = NSMutableAttributedString(string: "Date: ", attributes: grayAttributes)
         
         attributedRoverText.append(NSAttributedString(string: roverText, attributes: body2Attributes))
         attributedCameraText.append(NSAttributedString(string: cameraText, attributes: body2Attributes))
         attributedDateText.append(NSAttributedString(string: dateText, attributes: body2Attributes))

         roverLabel.attributedText = attributedRoverText
         cameraLabel.attributedText = attributedCameraText
         dateLabel.attributedText = attributedDateText

         cameraImage.image = UIImage(systemName: imageURL)
    }
}

private extension HomeTableViewCell {
    func setupUI() {
        addSubview(cornerView)
        cornerView.addSubview(roverLabel)
        cornerView.addSubview(cameraLabel)
        cornerView.addSubview(dateLabel)
        cornerView.addSubview(cameraImage)

        cameraLabel.numberOfLines = 2
        
        cornerView.snp.makeConstraints {
            $0.width.equalTo(353)
            $0.height.equalTo(150)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        roverLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(187)
            $0.top.equalToSuperview().offset(10)
        }
        
        cameraLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(187)
            $0.top.equalTo(roverLabel.snp.bottom).offset(10)
        }
        
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(187)
            $0.top.equalTo(cameraLabel.snp.bottom).offset(10)
        }
        cameraImage.snp.makeConstraints{
            $0.width.equalTo(130)
            $0.height.equalTo(130)
            $0.right.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
        }
    }
}
