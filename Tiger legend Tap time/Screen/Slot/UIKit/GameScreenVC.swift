//
//  GameScreenVC.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import Foundation
import UIKit
import Then
import SnapKit
class GameScreenVC: UIViewController {
    
    var backgroundImage: UIImageView!
    var backButton: UIButton!
    var visibleCellsIndexPaths = [IndexPath]()
    var visibleCellsMatrix = [[[Int]]]()
    var collectionViewBackground: UIImageView!
    var collectionView: UICollectionView!
    var bottomBackgroundImage: UIImageView!
    var spinButton: UIButton!
    
    var coinImage: UIImageView!
    var bankLabel: UILabel!
    
    var totalWinBackgroundImage: UIImageView!
    var totalWinLabel: UILabel!
    
    var containerView: UIView!
    var lineImage: UIImageView!
    var backgroundContainerImage: UIImageView!
    var winLabel: UILabel!
    var coinContainerImage: UIImageView!
    
    var playerBalanceBackgroundImage: UIImageView!
    var playerBalanceLabel: UILabel!
    var viewModel: SlotsViewModel
    init(viewModel: SlotsViewModel) {
                 self.viewModel = viewModel
                 super.init(nibName: nil, bundle: nil)
             }
          
     required init?(coder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.gameManager?.delegate = self
        viewModel.gameManager?.createElements()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

}


extension GameScreenVC {
    
    func setupUI() {
        
        
        coinImage = UIImageView().then({ image in
            view.addSubview(image)
            image.image = UIImage(named: "coin")
            image.contentMode = .scaleToFill
            image.snp.makeConstraints { make in
                make.width.equalTo(48)
                make.height.equalTo(48)
                make.top.equalToSuperview().offset(30)
                make.centerX.equalToSuperview().offset(-40)
            }
        })
        
        bankLabel = UILabel().then({ label in
            view.addSubview(label)
            label.text = "\(viewModel.settingViewModel!.updatePlayer.formattedCoins)"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            label.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(30)
                make.centerX.equalToSuperview().offset(40)
            }
        })
        
        collectionViewBackground = UIImageView().then({ image in
            view.addSubview(image)
            image.image = UIImage(named: "SlotMaschineBG")
            image.alpha = 0
            image.contentMode = .scaleToFill
            image.snp.makeConstraints { make in
                make.width.equalTo(349)
                make.height.equalTo(313)
                make.top.equalTo(coinImage.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
            }
        })
        
        
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then({ collectionView in
            collectionViewBackground.addSubview(collectionView)
            collectionView.backgroundColor = .clear
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.id)
            collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 1)
            collectionView.isUserInteractionEnabled = false
            collectionView.alpha = 0
            collectionView.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.height.equalTo(313)
                make.width.equalTo(230)
                make.centerX.equalToSuperview()
            }
        })
        
        collectionView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        
        containerView = UIView().then({ container in
            collectionViewBackground.addSubview(container)
            container.backgroundColor = .clear
            container.alpha = 0
            container.snp.makeConstraints { make in
                make.width.equalTo(306)
                make.height.equalTo(34)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        })
        
        lineImage = UIImageView().then({ image in
            containerView.addSubview(image)
            image.image = UIImage(named: "line")
            image.contentMode = .scaleToFill
            image.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(1)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        })
        
        backgroundContainerImage = UIImageView().then({ image in
            containerView.addSubview(image)
            image.image = UIImage(named: "backgroundWin")
            image.contentMode = .scaleToFill
            image.snp.makeConstraints { make in
                make.width.equalTo(87)
                make.height.equalTo(34)
                make.centerX.equalToSuperview()
            }
        })
        
        winLabel = UILabel().then({ label in
            backgroundContainerImage.addSubview(label)
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            label.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(12)
            }
        })
        
        coinContainerImage = UIImageView().then({ image in
            backgroundContainerImage.addSubview(image)
            image.image = UIImage(named: "coin")
            image.snp.makeConstraints { make in
                make.width.equalTo(18)
                make.height.equalTo(18)
                make.left.equalTo(winLabel.snp.right).offset(4)
                make.centerY.equalToSuperview()
            }
        })
        
        
        spinButton = UIButton().then({ button in
            view.addSubview(button)
            button.backgroundColor = UIColor(hexString: "#FF4004")
            button.layer.cornerRadius = 10
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowRadius = 17
            button.setTitle("Spin", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            button.titleLabel?.textColor = .white
            button.addTarget(self, action: #selector(makeSpin), for: .touchUpInside)
            button.alpha = 0
            button.snp.makeConstraints { make in
                make.width.equalTo(351)
                make.height.equalTo(41)
                make.centerX.equalToSuperview()
                make.top.equalTo(collectionView.snp.bottom).offset(36)
            }
            
        })

        animate()
    }
}



extension GameScreenVC {
    
    
    @objc func makeSpin() {
        UIView.animate(withDuration: 0.2) {
            self.spinButton.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            self.spinButton.transform = .identity
            self.spinCollection()
        }
    }
}

extension GameScreenVC {
    private func createLayout() -> UICollectionViewCompositionalLayout {
           return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
               switch sectionNumber {
               case 0: return self.layoutSection()
               case 1: return self.layoutSection()
               case 2: return self.layoutSection()
               case 3: return self.layoutSection()
               default:
                   return self.layoutSection()
               }
           }
       }
       private func layoutSection() -> NSCollectionLayoutSection {
           let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(65), heightDimension: .absolute(65))
                   let item = NSCollectionLayoutItem(layoutSize: itemSize)
                   item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

                   // Group
                   let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(148), heightDimension: .absolute(82))
                   let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item]) // 3 items in a row
                   group.interItemSpacing = .fixed(10)
                   // Section
                   let section = NSCollectionLayoutSection(group: group)
                   section.orthogonalScrollingBehavior = .groupPaging
                   section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom:  0, trailing:  0)

                   return section
       }
}



import UIKit

extension GameScreenVC: GameManagerDelegate {
    func updateLabel() {
        AppData.shared.player = viewModel.settingViewModel!.updatePlayer
        viewModel.settingViewModel?.updatePlayer = AppData.shared.player
        bankLabel.text = "\(viewModel.settingViewModel!.updatePlayer.formattedCoins)"
    }
    
    func updateWinLabel(with win: Int) {
        print(win)
        AppData.shared.player =  viewModel.settingViewModel!.updatePlayer 
        viewModel.settingViewModel?.updatePlayer = AppData.shared.player
        bankLabel.text = "\(viewModel.settingViewModel!.updatePlayer.formattedCoins)"
        winLabel.text = "\(win)"
        UIView.animate(withDuration: 0.2) {
            self.containerView.alpha = 1
        } completion: { com in
            UIView.animate(withDuration: 0.7) {
                self.containerView.alpha = 0
            }
        }
    }
    func showAlertPopUPForBet() {
//        showAlert(with: "Not enough money", with: "to make bet", viewcontroller: self)
    }
    func makeASelectItemsInCollectionView() {
//        for (_, indexPath) in viewModel.gameManager?.winElements.enumerated() {
//
//        }
        if let winElements = viewModel.gameManager?.winElements {
            for (_, indexPath) in winElements.enumerated() {
                collectionView.selectItem(at: IndexPath(item: indexPath.1, section: indexPath.0), animated: true, scrollPosition: .right)
                self.collectionView(self.collectionView, didSelectItemAt: IndexPath(item: indexPath.1, section: indexPath.0))
            }
        }
        
    }
}

extension GameScreenVC {
    func animate() {
        UIView.animate(withDuration: 0.8) {
//            self.backgroundImage.alpha = 1
        } completion: { com in
//            self.backButton.alpha = 1
            UIView.animate(withDuration: 0.6) {
                self.collectionViewBackground.alpha = 1
            } completion: { com in
                UIView.animate(withDuration: 1.2) {
                    self.collectionView.alpha = 1
                } completion: { com in
                    UIView.animate(withDuration: 0.3) {
//                        self.bottomBackgroundImage.alpha = 1
                    } completion: { com in
                        UIView.animate(withDuration: 0.3) {
                            self.spinButton.alpha = 1
                        } completion: { com in
                            UIView.animate(withDuration: 0.3) {
//                                self.minusBetButton.alpha = 1
//                                self.betBackgroundImage.alpha = 1
//                                self.betAmountLabel.alpha = 1
//                                self.pluseBetButton.alpha = 1
                            } completion: { com in
                                UIView.animate(withDuration: 0.3) {
//                                    self.playerBalanceBackgroundImage.alpha = 1
//                                    self.playerBalanceLabel.alpha = 1
                                } completion: { com in
                                    UIView.animate(withDuration: 0.3) {
//                                        self.totalWinBackgroundImage.alpha = 1
//                                        self.totalWinLabel.alpha = 1
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
      
    }
    
    func updateUI() {
        viewModel.settingViewModel?.updateOnAppear()
        if bankLabel != nil {
            bankLabel.text = "\(viewModel.settingViewModel!.updatePlayer.coins)"
        }
    }
}
