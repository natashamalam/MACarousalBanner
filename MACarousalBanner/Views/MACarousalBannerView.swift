//
//  MACarousalBannerView.swift
//  MACarousalBanner
//
//  Created by Mahjabin Alam on 2022/07/11.
//

import UIKit

protocol MACarousalBannerViewDelegate: AnyObject {
    func moveForwards()
    func moveBackwards()
}

class MACarousalBannerView: UIView {
  
    var abTestingPattern: String? {
        didSet {
            DispatchQueue.main.async {
                self.setLeftAndRightIndicatorImage(forPattern: self.abTestingPattern)
            }
        }
    }
    
    weak var delegate: MACarousalBannerViewDelegate?
    
    var datasource: MAChain<UIImage> {
        didSet {
            imageCollectionView.reloadData()
            currentVisibleIndexpath = IndexPath(row: 0, section: 0)
        }
    }
    
    var currentVisibleIndexpath: IndexPath?
    
    let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = 5.0
        collectionViewFlowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()

    let leftArrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "left_C"), for: .normal)
        return button
    }()
    
    let rightArrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "right_C"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        self.datasource = MAChain<UIImage>()
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        self.datasource = MAChain<UIImage>()
        super.init(coder: coder)
        addSubViews()
    }
    
    // MARK: - adding and configuring subViews
    
    func addSubViews() {
        wrapperView.addSubview(leftArrowButton)
        wrapperView.addSubview(rightArrowButton)
        wrapperView.addSubview(imageCollectionView)
        self.addSubview(wrapperView)
        configureSubviews()
    }
    
    func configureSubviews() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.register(MACarousalViewCell.self, forCellWithReuseIdentifier: "CarousalViewCell")
        
        setLeftAndRightIndicatorImage(forPattern: abTestingPattern)
        leftArrowButton.addTarget(self, action: #selector(moveBackwards), for: .touchUpInside)
        rightArrowButton.addTarget(self, action: #selector(moveForwards), for: .touchUpInside)
    }
    
    func setLeftAndRightIndicatorImage(forPattern pattern: String?) {
        guard let pattern = pattern else {
            // user default image
            return
        }
        let leftImageName = "left_" + pattern
        let rightImageName = "right_" + pattern
        
        leftArrowButton.setImage(UIImage(named: leftImageName), for: .normal)
        rightArrowButton.setImage(UIImage(named: rightImageName), for: .normal)
    }
    
    // MARK: - layingOut  Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        addLayOutConstraints()
    }
    
    func addLayOutConstraints() {
        let constraints = [
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wrapperView.leftAnchor.constraint(equalTo: self.leftAnchor),
            wrapperView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            leftArrowButton.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            leftArrowButton.leftAnchor.constraint(equalTo: wrapperView.leftAnchor),
            leftArrowButton.heightAnchor.constraint(equalToConstant: 60),
            leftArrowButton.widthAnchor.constraint(equalTo: leftArrowButton.heightAnchor),
            
            rightArrowButton.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            rightArrowButton.rightAnchor.constraint(equalTo: wrapperView.rightAnchor),
            rightArrowButton.heightAnchor.constraint(equalToConstant: 60),
            rightArrowButton.widthAnchor.constraint(equalTo: rightArrowButton.heightAnchor),
        
            imageCollectionView.leftAnchor.constraint(equalTo: leftArrowButton.rightAnchor, constant: 5),
            imageCollectionView.rightAnchor.constraint(equalTo: rightArrowButton.leftAnchor, constant: -5),
            imageCollectionView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - action methods
    
    @objc func moveForwards() {
        guard let currentIndex = currentVisibleIndexpath?.row else {return}
        currentVisibleIndexpath = IndexPath(row: (currentIndex + 1), section: 0)
        
        if let targetIndexpath = currentVisibleIndexpath {
            imageCollectionView.scrollToItem(at: targetIndexpath, at: .centeredHorizontally, animated: true)
            delegate?.moveForwards()
        }
    }
    
    @objc func moveBackwards() {
        guard let currentIndex = currentVisibleIndexpath?.row else {return}
        currentVisibleIndexpath = IndexPath(row: (currentIndex - 1), section: 0)
        
        if let targetIndexpath = currentVisibleIndexpath {
            imageCollectionView.scrollToItem(at: targetIndexpath, at: .centeredHorizontally, animated: true)
            delegate?.moveBackwards()
        }
    }
}

// MARK: - CollectionView datatasource and delegate

extension MACarousalBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let carousalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarousalViewCell", for: indexPath) as? MACarousalViewCell else { return UICollectionViewCell() }
        carousalCell.image = datasource.itemAt(indexPath.row)
        return carousalCell
    }
    
}
