//
//  MoreViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "MoreViewController.h"
#import "LaunchViewController.h"
#import "AccountSettingViewController.h"
#import "ContactInfoViewController.h"
#import "RenewedDomainViewController.h"
#import "SupportViewController.h"
#import "BankInfoViewController.h"
#import "AboutViewController.h"
#import "SettingMenuCell.h"
#import "AccountModel.h"

@interface MoreViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, WebServiceUtilsDelegate>
@end

@implementation MoreViewController
@synthesize viewHeader, tbContent, accInfoView;
@synthesize hAccount, padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [WriteLogsUtils writeForGoToScreen:@"MoreViewController"];
    
    [self addAccountInfoView];
    [accInfoView displayInformation];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    self.navigationController.navigationBarHidden = FALSE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)icCloseClick:(UIButton *)sender {
}

- (IBAction)icNotifyClick:(UIButton *)sender {
}

- (IBAction)icSearchClick:(UIButton *)sender {
}

- (void)setupUIForView {
    hAccount = 135; //  10 + 30 + 30 + 10 + 10 + 40.0 + 10;
    padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    
    float hHeader = self.hAccount/2 + 2*[AppDelegate sharedInstance].hStatusBar;
    
    viewHeader.backgroundColor = UIColor.orangeColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"SettingMenuCell" bundle:nil] forCellReuseIdentifier:@"SettingMenuCell"];
    tbContent.backgroundColor = UIColor.clearColor;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    CAGradientLayer *bottomGradientLayer = [CAGradientLayer layer];
    bottomGradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, hHeader);
    bottomGradientLayer.startPoint = CGPointMake(0, 0);
    bottomGradientLayer.endPoint = CGPointMake(1, 1);
    bottomGradientLayer.colors = @[(id)[UIColor colorWithRed:(14/255.0) green:(91/255.0) blue:(181/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(10/255.0) green:(87/255.0) blue:(179/255.0) alpha:1.0].CGColor];
    [viewHeader.layer insertSublayer:bottomGradientLayer atIndex:0];
}

- (void)addAccountInfoView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"AccountInfoView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[AccountInfoView class]]) {
            accInfoView = (AccountInfoView *) currentObject;
            break;
        }
    }
    [self.view addSubview: accInfoView];
    
    [accInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewHeader.mas_bottom).offset(20.0);
        make.left.equalTo(self.view).offset(self.padding);
        make.right.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(self.hAccount);
    }];
    [accInfoView setupUIForView];
    [AppUtils addBoxShadowForView:accInfoView withColor:UIColor.blackColor];
    
    UIView *tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.hAccount/2 + 20 + 10)];
    tbHeaderView.backgroundColor = UIColor.whiteColor;
    tbContent.tableHeaderView = tbHeaderView;
}

- (void)clearTokenOfUser {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang đang xuất. Vui lòng chờ trong giây lát" Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updateTokenWithValue:@""];
}

- (void)logoutScreen {
    [AppDelegate sharedInstance].userInfo = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:login_state];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:key_password];
    [[NSUserDefaults standardUserDefaults] synchronize];
     /*
    LaunchViewController *launchVC = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil];
    UINavigationController *launchNav = [[UINavigationController alloc] initWithRootViewController:launchVC];
    
    [[AppDelegate sharedInstance].window setRootViewController: launchNav];
    [[AppDelegate sharedInstance].window makeKeyAndVisible];    */
   
    LaunchViewController *launchVC = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil];
    UINavigationController *launchNav = [[UINavigationController alloc] initWithRootViewController:launchVC];
    [self presentViewController:launchNav animated:TRUE completion:nil];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingMenuCell *cell = (SettingMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"SettingMenuCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case eSettingAccount:{
            cell.lbName.text = @"Cài đặt tài khoản";
            cell.imgType.image = [UIImage imageNamed:@"ic_setting_acc.png"];
            break;
        }
        case eManagerDomainList:{
            cell.lbName.text = @"Quản lý tên miền";
            cell.imgType.image = [UIImage imageNamed:@"ic_manager_domain"];
            break;
        }
        case eCustomnerSupport:{
            cell.imgType.image = [UIImage imageNamed:@"ic_support"];
            cell.lbName.text = @"Hỗ trợ khách hàng";
            break;
        }
        case eBankInfo:{
            cell.imgType.image = [UIImage imageNamed:@"ic_bank_info"];
            cell.lbName.text = @"Thông tin tài khoản ngân hàng";
            break;
        }
        case eApplicationInfo:{
            cell.imgType.image = [UIImage imageNamed:@"ic_about"];
            cell.lbName.text = @"Thông tin ứng dụng";
            break;
        }
        case eSignOut:{
            cell.imgType.image = [UIImage imageNamed:@"ic_signout"];
            cell.lbName.text = @"Đăng xuất";
            break;
        }
            
        default:
            break;
    }
    
    if (indexPath.row == eSignOut) {
        cell.backgroundColor = UIColor.clearColor;
        cell.imgSepa.hidden = TRUE;
    }else{
        cell.backgroundColor = UIColor.whiteColor;
        cell.imgSepa.hidden = FALSE;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] selected index = %d", __FUNCTION__, (int)indexPath.row)];
    
    switch (indexPath.row) {
        case eSettingAccount:{
            AccountSettingViewController *accSettingVC = [[AccountSettingViewController alloc] initWithNibName:@"AccountSettingViewController" bundle:nil];
            accSettingVC.hidesBottomBarWhenPushed = TRUE;
            [self.navigationController pushViewController:accSettingVC animated:TRUE];
            break;
        }
        case eManagerDomainList:{
            RenewedDomainViewController *renewedDomainVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
            renewedDomainVC.hidesBottomBarWhenPushed = TRUE;
            [self.navigationController pushViewController:renewedDomainVC animated:TRUE];
            break;
        }
        case eCustomnerSupport:{
            SupportViewController *supportVC = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
            supportVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: supportVC animated:YES];
            break;
        }
        case eBankInfo:{
            BankInfoViewController *bankInfoVC = [[BankInfoViewController alloc] initWithNibName:@"BankInfoViewController" bundle:nil];
            bankInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: bankInfoVC animated:YES];
            break;
        }
        case eApplicationInfo:{
            AboutViewController *aboutVC = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
            aboutVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: aboutVC animated:YES];
            break;
        }
        case eSignOut:{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Bạn có muốn đăng xuất khỏi ứng dụng hay không?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Đăng xuất", nil];
            alertView.tag = 1;
            [alertView show];
            break;
        }
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - UIAlertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            if (![AppUtils checkNetworkAvailable]) {
                [self logoutScreen];
            }else{
                [self clearTokenOfUser];
            }
        }
    }
}

#pragma mark - Web services

-(void)failedToUpdateToken {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [ProgressHUD dismiss];
}

-(void)updateTokenSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [ProgressHUD dismiss];
    
    [self logoutScreen];
}

@end
