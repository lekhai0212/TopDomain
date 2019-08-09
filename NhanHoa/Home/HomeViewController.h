//
//  HomeViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerSliderView.h"

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet UIView *viewWallet;

@property (weak, nonatomic) IBOutlet UIView *viewMainWallet;
@property (weak, nonatomic) IBOutlet UIImageView *imgMainWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMainWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;

@property (weak, nonatomic) IBOutlet UICollectionView *clvMenu;

@property (nonatomic, assign) float hMenu;

@property (nonatomic, strong) BannerSliderView *viewBanner;
- (IBAction)btnSearchPress:(UIButton *)sender;

@end
