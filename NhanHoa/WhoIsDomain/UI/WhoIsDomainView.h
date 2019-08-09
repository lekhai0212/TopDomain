//
//  WhoIsDomainView.h
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhoIsDomainView : UIView


@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbStatusValue;
@property (weak, nonatomic) IBOutlet UILabel *lbRegisterName;
@property (weak, nonatomic) IBOutlet UILabel *lbRegisterNameValue;
@property (weak, nonatomic) IBOutlet UILabel *lbOwner;
@property (weak, nonatomic) IBOutlet UILabel *lbOwnerValue;

@property (weak, nonatomic) IBOutlet UILabel *lbIssueDate;
@property (weak, nonatomic) IBOutlet UILabel *lbIssueDateValue;
@property (weak, nonatomic) IBOutlet UILabel *lbExpiredDate;
@property (weak, nonatomic) IBOutlet UILabel *lbExpiredDateValue;

@property (weak, nonatomic) IBOutlet UILabel *lbDNS;
@property (weak, nonatomic) IBOutlet UILabel *lbDNSValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDNSSEC;
@property (weak, nonatomic) IBOutlet UILabel *lbDNSSECValue;

- (void)setupUIForView;
- (float)showContentOfDomainWithInfo: (NSDictionary *)info;

@property (nonatomic, assign) float hLabel;
@property (nonatomic, assign) float sizeLeft;
@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float mTop;

- (void)resetAllValueForView;

@end

NS_ASSUME_NONNULL_END
