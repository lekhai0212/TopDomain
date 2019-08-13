//
//  AccountInfoView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AccountInfoView.h"
#import "AccountModel.h"

@implementation AccountInfoView
@synthesize imgAvatar, lbName, lbEmail, imgSepa, viewWallet, imgWallet, lbMainAccount, lbMainMoney;

- (void)setupUIForView {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 7.0;
    
    float padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    imgAvatar.clipsToBounds = TRUE;
    imgAvatar.layer.cornerRadius = 50.0/2;
    imgAvatar.layer.borderColor = BLUE_COLOR.CGColor;
    imgAvatar.layer.borderWidth = 1.0;
    [imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(5.0);
        make.width.height.mas_equalTo(50.0);
    }];
    
    lbName.font = [UIFont fontWithName:RobotoMedium size:18.0];
    lbName.textColor = TITLE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgAvatar);
        make.left.equalTo(self.imgAvatar.mas_right).offset(5.0);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    lbEmail.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbEmail.textColor = TITLE_COLOR;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbName);
        make.top.equalTo(lbName.mas_bottom);
        make.height.mas_equalTo(20.0);
    }];
    
    imgSepa.backgroundColor = BORDER_COLOR;
    [imgSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgAvatar);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.imgAvatar.mas_bottom).offset(10.0);
        make.height.mas_equalTo(1.0);
    }];
    
    //  main wallet
    viewWallet.backgroundColor = UIColor.clearColor;
    [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgSepa.mas_bottom).offset(10.0);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-10.0);
    }];
    
    imgWallet.layer.cornerRadius = 30.0/2;
    imgWallet.clipsToBounds = TRUE;
    [imgWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewWallet).offset(padding);
        make.centerY.equalTo(self.viewWallet.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbMainAccount.textColor = TITLE_COLOR;
    lbMainAccount.font = [AppDelegate sharedInstance].fontBTN;
    lbMainAccount.text = [NSString stringWithFormat:@"%@:", balance_text];
    [lbMainAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgWallet.mas_right).offset(5.0);
        make.top.bottom.equalTo(imgWallet);
    }];
    
    lbMainMoney.font = [UIFont fontWithName:RobotoRegular size:22.0];
    lbMainMoney.textColor = ORANGE_COLOR;
    [lbMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMainAccount.mas_right).offset(5.0);
        make.top.bottom.equalTo(lbMainAccount);
        make.right.equalTo(viewWallet).offset(-padding);
    }];
}

- (void)displayInformation
{
    NSString *realName = [AccountModel getCusRealName];
    if (![AppUtils isNullOrEmpty: realName]) {
        lbName.text = realName;
    }else{
        lbName.text = @"Chưa cập nhật";
    }
    
    NSString *email = [AccountModel getCusEmail];
    if (![AppUtils isNullOrEmpty: email]) {
        lbEmail.text = email;
    }else{
        lbEmail.text = @"";
    }
    
    NSString *balance = [AccountModel getCusBalance];
    if (![AppUtils isNullOrEmpty: balance]) {
        balance = [AppUtils convertStringToCurrencyFormat: balance];
        lbMainMoney.text = [NSString stringWithFormat:@"%@VNĐ", balance];
    }else{
        lbMainMoney.text = @"0VNĐ";
    }
    
    NSString *avatarURL = [AccountModel getCusPhoto];
    if (![AppUtils isNullOrEmpty: avatarURL]) {
        [imgAvatar sd_setImageWithURL:[NSURL URLWithString:avatarURL] placeholderImage:DEFAULT_AVATAR];
    }else{
        imgAvatar.image = DEFAULT_AVATAR;
    }
}

@end
