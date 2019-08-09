//
//  SSLTbvCell.m
//  NhanHoa
//
//  Created by Khai Leo on 8/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SSLTbvCell.h"

@implementation SSLTbvCell

@synthesize viewWrapper, viewHeader, imgType, lbName, lbPrice, lbFeeSetup, lbFeeSetupValue, lbSepa1, lbFeeRenew, lbFeeRenewValue, lbSepa2, lbEncrypt, lbEncryptValue, lbSepa3, lbCert, lbCertValue, lbSepa4, lbDomainNum, lbDomainNumValue, lbSepa5, lbSAN, lbSANValue, lbSepa6, lbBlueAddr, lbBlueAddrValue, lbSepa7, lbPolicy, lbPolicyValue, lbSepa8, lbTrust, lbTrustValue, lbSepa9, lbTimeRegister, lbTimeRegisterValue, lbSepa10, lbSupport, lbSupportValue, lbSepa11, btnAddCart;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float paddingContent = 7.0;
    float padding = 10.0;
    float mTop = 15.0;
    
    viewWrapper.layer.borderWidth = 1.0;
    viewWrapper.layer.borderColor = BORDER_COLOR.CGColor;
    [viewWrapper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(paddingContent);
        make.right.equalTo(self).offset(-paddingContent);
        make.bottom.equalTo(self).offset(-paddingContent-mTop);
    }];
    [AppUtils addBoxShadowForView:viewWrapper color:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0] opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    viewHeader.backgroundColor = [UIColor colorWithRed:(236/255.0) green:(239/255.0)
                                                  blue:(241/255.0) alpha:1.0];
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(60.0);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(5.0);
        make.left.equalTo(viewHeader).offset(padding);
        make.width.height.mas_equalTo(30.0);
    }];
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(imgType);
        make.left.equalTo(imgType.mas_right).offset(5.0);
        make.right.equalTo(viewHeader).offset(-paddingContent);
    }];
    
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom);
        make.left.right.equalTo(lbName);
        make.height.mas_equalTo(20.0);
    }];
    
    float hItem = 40.0;
    float maxSize = [AppUtils getSizeWithText:@"Phí cài đặt" withFont:[AppDelegate sharedInstance].fontRegular].width + 5.0;
    [lbFeeSetup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(viewWrapper).offset(padding);
        make.width.mas_equalTo(maxSize);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbFeeSetupValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbFeeSetup);
        make.left.equalTo(lbFeeSetup.mas_right).offset(paddingContent);
        make.right.equalTo(viewWrapper).offset(-padding);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbFeeSetup.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  phí duy trì
    [lbFeeRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa1.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbFeeRenewValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbFeeRenew);
        make.left.equalTo(lbFeeRenew.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbFeeRenew.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  mã hoá
    [lbEncrypt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa2.mas_bottom);
        make.left.equalTo(viewWrapper).offset(padding);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbEncryptValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEncrypt);
        make.left.equalTo(lbEncrypt.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEncrypt.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  chứng thực
    [lbCert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa3.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbCertValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbCert);
        make.left.equalTo(lbCert.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCert.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Số domain được bảo mật
    [lbDomainNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa4.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDomainNumValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDomainNum);
        make.left.equalTo(lbDomainNum.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomainNum.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Hỗ trợ SAN
    [lbSAN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa5.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbSANValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbSAN);
        make.left.equalTo(lbSAN.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSAN.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Thanh địa chỉ màu xanh
    [lbBlueAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa6.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbBlueAddrValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbBlueAddr);
        make.left.equalTo(lbBlueAddr.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBlueAddr.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Chính sách bảo hiểm
    [lbPolicy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa7.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbPolicyValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPolicy);
        make.left.equalTo(lbPolicy.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPolicy.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Trust level
    [lbTrust mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa8.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbTrustValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbTrust);
        make.left.equalTo(lbTrust.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTrust.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Thời hạn đăng ký
    [lbTimeRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa9.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbTimeRegisterValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbTimeRegister);
        make.left.equalTo(lbTimeRegister.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTimeRegister.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Hỗ trợ khách hàng
    [lbSupport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa10.mas_bottom);
        make.left.equalTo(lbFeeSetup);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbSupportValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbSupport);
        make.left.equalTo(lbSupport.mas_right).offset(paddingContent);
        make.right.equalTo(lbFeeSetupValue);
    }];
    
    [lbSepa11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSupport.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    [btnAddCart setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAddCart.backgroundColor = [UIColor colorWithRed:(241/255.0) green:(103/255.0) blue:(37/255.0) alpha:1.0];
    [btnAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa11.mas_bottom).offset(mTop);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    lbFeeRenew.font = lbFeeSetup.font = lbEncrypt.font = lbCert.font = lbDomainNum.font = lbSAN.font = lbBlueAddr.font = lbPolicy.font = lbTrust.font = lbTimeRegister.font = lbSupport.font = [AppDelegate sharedInstance].fontRegular;
    
    lbFeeRenewValue.font = lbFeeSetupValue.font = lbEncryptValue.font = lbCertValue.font = lbDomainNumValue.font = lbSANValue.font = lbBlueAddrValue.font = lbPolicyValue.font = lbTrustValue.font = lbTimeRegisterValue.font = lbSupportValue.font = [AppDelegate sharedInstance].fontMedium;
    
    btnAddCart.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbFeeRenew.textColor = lbFeeSetup.textColor = lbEncrypt.textColor = lbCert.textColor = lbDomainNum.textColor = lbSAN.textColor = lbBlueAddr.textColor = lbPolicy.textColor = lbTrust.textColor = lbTimeRegister.textColor = lbSupport.textColor = TITLE_COLOR;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
