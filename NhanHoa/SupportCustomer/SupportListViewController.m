//
//  SupportListViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 7/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SupportListViewController.h"
#import "SupportCustomerCell.h"
#import "AppDelegate.h"

@interface SupportListViewController ()<UITextFieldDelegate, WebServiceUtilsDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *datas;
    NSString *extenCall;
    NSString *remoteName;
}

@end

@implementation SupportListViewController
@synthesize tbContent, lbNoData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Chăm sóc khách hàng";
    
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"SupportListViewController"];
    
    if (datas == nil) {
        datas = [[NSMutableArray alloc] init];
    }else{
        [datas removeAllObjects];
    }
    lbNoData.hidden = TRUE;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    //  [(AppDelegate *)[AppDelegate sharedInstance] removeAccount];
}

- (void)setupUIForView {
    [tbContent registerNib:[UINib nibWithNibName:@"SupportCustomerCell" bundle:nil] forCellReuseIdentifier:@"SupportCustomerCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    lbNoData.font = [AppDelegate sharedInstance].fontBTN;
    lbNoData.textColor = TITLE_COLOR;
    lbNoData.text = text_no_data;
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITextfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing: TRUE];
    return TRUE;
}



- (void)displayInfoAfterGetData {
    if (datas.count == 0) {
        lbNoData.hidden = FALSE;
        tbContent.hidden = TRUE;
    }else{
        lbNoData.hidden = TRUE;
        tbContent.hidden = FALSE;
        [tbContent reloadData];
    }
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SupportCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupportCustomerCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [datas objectAtIndex: indexPath.row];
    [cell displayContentWithInfo: info];
    
    cell.btnCall.tag = indexPath.row;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

@end
