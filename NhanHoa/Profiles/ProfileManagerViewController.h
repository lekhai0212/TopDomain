//
//  ProfileManagerViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileManagerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbNoData;
@property (weak, nonatomic) IBOutlet UITableView *tbProfiles;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *icClear;

- (IBAction)icClearClick:(UIButton *)sender;

@end
