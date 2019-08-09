//
//  HaveNotSignedView.h
//  NhanHoa
//
//  Created by lam quang quan on 6/17/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HaveNotSignedViewDelegate <NSObject>
@optional
- (void)tapOnViewSignToAccount;
@end

@interface HaveNotSignedView : UIView

@property (weak, nonatomic) id<HaveNotSignedViewDelegate, NSObject> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbNotSigned;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
