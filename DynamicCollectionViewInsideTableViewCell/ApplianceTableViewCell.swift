//
//  ApplianceCollectionViewCell.swift
//  DynamicCollectionViewInsideTableViewCell
//
//  Created by Vishal Madheshia on 1/4/19.
//  Copyright © 2019 Vishal Madheshia. All rights reserved.
//

import UIKit

class ApplianceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var applianceCollectionView: UICollectionView!
    @IBOutlet weak var applianceCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var collectionViewObserver: NSKeyValueObservation?

    
    @IBOutlet weak var firstStackView: UIStackView!
    
    var vehicle = Vehicle(houseType: "", vehicleType: "", included: [], imageUrl: "")
    let newBHKTypes = ["RK1":"1 RK", "BHK1":"1 BHK Lite", "BHK1_5":"1 BHK Heavy", "BHK2":"2 BHK Lite", "BHK2_5":"2 BHK Heavy", "BHK3":"3 BHK"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applianceCollectionView.register(UINib(nibName: "ApplianceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ApplianceCollectionViewCell")
        applianceCollectionView.dataSource = self
        applianceCollectionView.delegate = self
        let alignedFlowLayout = applianceCollectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
        alignedFlowLayout?.horizontalAlignment = .left
        addObserver()
        applianceCollectionView.isScrollEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
    func addObserver() {
        collectionViewObserver = applianceCollectionView.observe(\.contentSize, changeHandler: { [weak self] (collectionView, change) in
            self?.applianceCollectionView.invalidateIntrinsicContentSize()
            self?.applianceCollectionViewHeightConstraint.constant = collectionView.contentSize.height
            self?.applianceCollectionViewHeightConstraint.priority = UILayoutPriority(rawValue: 1000)
            self?.setNeedsLayout()
            self?.layoutIfNeeded()
        })
    }
    deinit {
        collectionViewObserver = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureForVehicle(_ vehicle: Vehicle, selectedHouseType: String) {
        self.vehicle = vehicle
        applianceCollectionView.reloadData()
//        setCollectionViewHeight()
    }
    
    func setCollectionViewHeight() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            UIView.animate(withDuration: 0.1, animations: {
//                self.applianceCollectionViewHeightConstraint.constant = self.applianceCollectionView.contentSize.height
                self.contentView.setNeedsLayout()
            })
        }
    }
    
    @IBAction func bhkButtonAction(_ sender: UIButton) {
        
    }
    
}


extension ApplianceTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehicle.included.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApplianceCollectionViewCell", for: indexPath) as! ApplianceCollectionViewCell
        cell.tagLabel.text = vehicle.included[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize = vehicle.included[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        if (size.width + 36) > applianceCollectionView.bounds.width {
            return CGSize(width: applianceCollectionView.bounds.width, height: 22)
        }
        return CGSize(width: size.width + 36.0, height: 22)
    }
}

