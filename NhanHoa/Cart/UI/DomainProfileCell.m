//
//  DomainProfileCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainProfileCell.h"

@implementation DomainProfileCell
@synthesize lbDomain, btnChooseProfile, viewProfileInfo, imgType, lbType, lbTypeValue, lbCompanyValue, lbProfile, lbProfileValue, lbSepa;
@synthesize padding, hBTN, sizeType, sizeProfile;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    hBTN = 34.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:16.0];
    sizeType = [AppUtils getSizeWithText:@"Hồ sơ:" withFont:textFont].width+5;
    sizeProfile = [AppUtils getSizeWithText:@"Người đại diện:" withFont:textFont].width+5;
    
    lbType.font = lbTypeValue.font = lbProfile.font = lbProfileValue.font = lbCompanyValue.font = textFont;
    lbDomain.textColor = lbType.textColor = lbTypeValue.textColor = lbCompanyValue.textColor = lbProfile.textColor = lbProfileValue.textColor = TITLE_COLOR;
    
    btnChooseProfile.layer.cornerRadius = hBTN/2;
    btnChooseProfile.titleLabel.font = textFont;
    btnChooseProfile.backgroundColor = BLUE_COLOR;
    [btnChooseProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-self.padding);
        make.top.equalTo(self).offset(10.0);
        make.width.mas_equalTo(100.0);
        make.height.mas_equalTo(self.hBTN);
    }];
    
    lbDomain.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self.btnChooseProfile.mas_left).offset(-10.0);
        make.top.bottom.equalTo(self.btnChooseProfile);
    }];
    
    //  profile info
    viewProfileInfo.clipsToBounds = TRUE;
    [viewProfileInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnChooseProfile.mas_bottom);
        make.bottom.equalTo(self).offset(-10.0);
        make.left.right.equalTo(self);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewProfileInfo.mas_centerY);
        make.left.equalTo(self.viewProfileInfo).offset(self.padding);
        make.width.height.mas_equalTo(35.0);
    }];
    
    //  company
    [lbCompanyValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewProfileInfo.mas_centerY);
        make.height.mas_equalTo(20.0);
        make.left.equalTo(self.imgType.mas_right).offset(5.0);
        make.right.equalTo(self.viewProfileInfo).offset(-self.padding);
    }];
    
    //  type
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbCompanyValue.mas_top);
        make.left.equalTo(self.lbCompanyValue);
        make.height.mas_equalTo(20.0);
        make.width.mas_equalTo(self.sizeType);
    }];
    
    [lbTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbType);
        make.left.equalTo(self.lbType.mas_right);
        make.right.equalTo(self.viewProfileInfo).offset(-self.padding);
    }];
    
    //  profile
    [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCompanyValue.mas_bottom);
        make.left.equalTo(self.lbCompanyValue);
        make.height.mas_equalTo(20.0);
        make.width.mas_equalTo(self.sizeProfile);
    }];
    
    [lbProfileValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbProfile);
        make.left.equalTo(self.lbProfile.mas_right);
        make.right.equalTo(self.viewProfileInfo).offset(-self.padding);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.padding);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showProfileView: (BOOL)show withBusiness: (BOOL)business {
    NSString *content = btnChooseProfile.currentTitle;
    float wText = [AppUtils getSizeWithText:content withFont:btnChooseProfile.titleLabel.font].width;
    
    [btnChooseProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-self.padding);
        make.top.equalTo(self).offset(10.0);
        make.width.mas_equalTo(wText + 20);
        make.height.mas_equalTo(self.hBTN);
    }];
    
    if (show) {
        [viewProfileInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnChooseProfile.mas_bottom);
            make.bottom.equalTo(self).offset(-10.0);
            make.left.equalTo(self).offset(self.padding);
            make.right.equalTo(self).offset(-self.padding);
        }];
        
        if (business) {
            lbCompanyValue.textColor = TITLE_COLOR;
            
            //  type
            [lbType mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.lbCompanyValue.mas_top);
                make.left.equalTo(self.lbCompanyValue);
                make.height.mas_equalTo(20.0);
                make.width.mas_equalTo(self.sizeType);
            }];
            
            //  profile
            [lbProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lbCompanyValue.mas_bottom);
                make.left.equalTo(self.lbCompanyValue);
                make.height.mas_equalTo(20.0);
                make.width.mas_equalTo(self.sizeProfile);
            }];
            
        }else{
            lbCompanyValue.textColor = UIColor.clearColor;
            //  type
            [lbType mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imgType.mas_right).offset(5.0);
                make.bottom.equalTo(self.viewProfileInfo.mas_centerY);
                make.height.mas_equalTo(20.0);
                make.width.mas_equalTo(self.sizeType);
            }];
            
            //  profile
            [lbProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.viewProfileInfo.mas_centerY);
                make.left.equalTo(self.lbType);
                make.height.mas_equalTo(20.0);
                make.width.mas_equalTo(self.sizeProfile);
            }];
        }
        
    }else{
        [viewProfileInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnChooseProfile.mas_bottom);
            make.left.equalTo(self).offset(self.padding);
            make.right.equalTo(self).offset(-self.padding);
            make.height.mas_equalTo(0);
        }];
    }
}

- (void)showProfileContentWithInfo: (NSDictionary *)profile {
    NSString *type = [profile objectForKey:@"cus_own_type"];
    if ([type isEqualToString:@"0"]) {
        lbTypeValue.text = text_personal;
        lbCompanyValue.text = @"";
    }else{
        lbTypeValue.text = text_business;
        
        NSString *cus_company = [profile objectForKey:@"cus_company"];
        if (cus_company != nil) {
            lbCompanyValue.text = cus_company;
        }else{
            lbCompanyValue.text = @"";
        }
    }
    
    //  Show profile name
    NSString *name = [profile objectForKey:@"cus_realname"];
    if (name != nil && [name isKindOfClass:[NSString class]]) {
        lbProfileValue.text = name;
    }else{
        lbProfileValue.text = @"";
    }
}

@end
