//
//  CartViewController.h
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewEmpty;
@property (weak, nonatomic) IBOutlet UIImageView *imgCartEmpty;
@property (weak, nonatomic) IBOutlet UILabel *lbEmpty;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UITableView *tbDomains;

@property (weak, nonatomic) IBOutlet UIView *viewFooter;

@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbPriceValue;
@property (weak, nonatomic) IBOutlet UILabel *lbVAT;
@property (weak, nonatomic) IBOutlet UILabel *lbVATValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalValue;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (weak, nonatomic) IBOutlet UIButton *btnGoShop;

@property (nonatomic, assign) float hInfo;
@property (nonatomic, strong) UITableView *tbSelectYear;
- (IBAction)btnContinuePress:(UIButton *)sender;
- (IBAction)btnGoShopPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
