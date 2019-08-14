//
//  ProfileDetailsViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailsViewController.h"
#import "EditProfileViewController.h"

@interface ProfileDetailsViewController ()

@end

@implementation ProfileDetailsViewController
@synthesize personalProfileView, businessProfileView;

@synthesize profileInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_profile_details;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"ProfileDetailsViewController"];
    
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            [self addUpdatePersonalProfileViewIfNeed];
            [personalProfileView displayInfoForPersonalProfileWithInfo: profileInfo];
            [personalProfileView setupUIForOnlyView];
            personalProfileView.mode = eViewProfile;
            
        }else{
            [self addUpdateBusinessProfileViewIfNeed];
            [businessProfileView displayInfoForProfileWithInfo: profileInfo];
            [businessProfileView setupUIForOnlyView];
            businessProfileView.mode = eViewBusinessProfile;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUpdatePersonalProfileViewIfNeed {
    float bottomPadding = 0;
    if (@available(iOS 11.0, *)) {
        bottomPadding = [AppDelegate sharedInstance].window.safeAreaInsets.bottom;
    }
    
    if (personalProfileView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewProfileView class]]) {
                personalProfileView = (NewProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: personalProfileView];
    }
    personalProfileView.delegate = self;
    [personalProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bottomPadding);
    }];
    [personalProfileView setupForAddProfileUIForAddNew: FALSE isUpdate: TRUE];
}

- (void)addUpdateBusinessProfileViewIfNeed {
    float bottomPadding = 0;
    if (@available(iOS 11.0, *)) {
        bottomPadding = [AppDelegate sharedInstance].window.safeAreaInsets.bottom;
    }
    
    if (businessProfileView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewBusinessProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewBusinessProfileView class]]) {
                businessProfileView = (NewBusinessProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: businessProfileView];
    }
    businessProfileView.delegate = self;
    [businessProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bottomPadding);
    }];
    [businessProfileView setupUIForViewForAddProfile:FALSE update:TRUE];
}

#pragma mark - ProfileView Delegate
-(void)onButtonEditPressed {
    EditProfileViewController *editVC = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:nil];
    [AppDelegate sharedInstance].profileEdit = [[NSMutableDictionary alloc] initWithDictionary: profileInfo];
    [self.navigationController pushViewController:editVC animated:TRUE];
}

-(void)onButtonEditPersonalProfilePressed {
    EditProfileViewController *editVC = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:nil];
    [AppDelegate sharedInstance].profileEdit = [[NSMutableDictionary alloc] initWithDictionary: profileInfo];
    [self.navigationController pushViewController:editVC animated:TRUE];
}

@end
