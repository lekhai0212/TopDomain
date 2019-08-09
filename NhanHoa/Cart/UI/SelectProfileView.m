//
//  SelectProfileView.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SelectProfileView.h"
#import "AccountModel.h"
#import "CartModel.h"


@implementation SelectProfileView
@synthesize viewHeader, icAdd, lbTitle, tbProfile, icClose, icBack, lbNoData, tfSearch, icClear;
@synthesize hHeader, delegate, selectedRow, cartIndexItemSelect, cusIdSelected, searching, searchTimer, listSearch;

@synthesize webService, listProfiles;

- (void)setupUIForView {
    if (listSearch == nil) {
        listSearch = [[NSMutableArray alloc] init];
    }else{
        [listSearch removeAllObjects];
    }
    
    selectedRow = -1;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(self.hHeader);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([AppDelegate sharedInstance].hStatusBar);
        make.left.equalTo(self);
        make.width.height.mas_equalTo(self.hHeader - [AppDelegate sharedInstance].hStatusBar);
    }];
    
    icBack.hidden = TRUE;
    icBack.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.icClose);
    }];
    
    icAdd.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    [icAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.icClose.mas_width);
    }];
    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.left.equalTo(self.icClose.mas_right).offset(5.0);
        make.right.equalTo(self.icAdd.mas_left).offset(-5.0);
    }];
    
    float padding = 15.0;
    tfSearch.returnKeyType = UIReturnKeyDone;
    tfSearch.delegate = self;
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, [AppDelegate sharedInstance].hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    tfSearch.placeholder = @"Nhập để tìm kiếm...";
    tfSearch.textColor = TITLE_COLOR;
    tfSearch.font = [AppDelegate sharedInstance].fontRegular;
    tfSearch.layer.cornerRadius = [AppDelegate sharedInstance].hTextfield/2;
    tfSearch.layer.borderColor = BLUE_COLOR.CGColor;
    tfSearch.layer.borderWidth = 1.0;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    [tfSearch addTarget:self
                 action:@selector(searchTextfieldChanged:)
       forControlEvents:UIControlEventEditingChanged];
    
    icClear.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    icClear.backgroundColor = BORDER_COLOR;
    icClear.layer.cornerRadius = ([AppDelegate sharedInstance].hTextfield-6.0)/2;
    [icClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfSearch).offset(-3.0);
        make.top.equalTo(self.tfSearch).offset(3.0);
        make.bottom.equalTo(self.tfSearch).offset(-3.0);
        make.width.mas_equalTo([AppDelegate sharedInstance].hTextfield-6.0);
    }];
    if (tfSearch.text.length == 0) {
        icClear.hidden = TRUE;
    }else{
        icClear.hidden = FALSE;
    }
    
    tbProfile.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbProfile registerNib:[UINib nibWithNibName:@"ProfileDetailCell" bundle:nil] forCellReuseIdentifier:@"ProfileDetailCell"];
    tbProfile.delegate = self;
    tbProfile.dataSource = self;
    [tbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfSearch.mas_bottom).offset(padding);
        make.left.right.bottom.equalTo(self);
    }];
    
    lbNoData.textColor = [UIColor colorWithRed:(80/255.0) green:(80/255.0)
                                          blue:(80/255.0) alpha:1.0];
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    //  web service
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    [self getListProfilesForAccount];
}

- (void)whenTapOnFrontImage {
    if ([delegate respondsToSelector:@selector(onPassportFrontPress)]) {
        [delegate onPassportFrontPress];
    }
}

- (void)whenTapOnBehindImage {
    if ([delegate respondsToSelector:@selector(onPassportBehindPress)]) {
        [delegate onPassportBehindPress];
    }
}

- (void)getListProfilesForAccount {
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang lấy danh sách hồ sơ..." Interaction:NO];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_profile_mod forKey:@"mod"];
    [jsonDict setObject:[AccountModel getCusUsernameOfUser] forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    
    [webService callWebServiceWithLink:get_profile_func withParams:jsonDict];
}

- (IBAction)icAddClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(onCreatNewProfileClicked)]) {
        [delegate onCreatNewProfileClicked];
    }
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [self endEditing: TRUE];
    [delegate onIconCloseClicked];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.lbTitle.text = @"Danh sách hồ sơ";
        self.icBack.hidden = TRUE;
        self.icClose.hidden = self.icAdd.hidden = FALSE;
    }];
}

- (IBAction)icClearClick:(UIButton *)sender {
    tfSearch.text = @"";
    sender.hidden = TRUE;
    searching = FALSE;
    [listSearch removeAllObjects];
    
    lbNoData.hidden = TRUE;
    tbProfile.hidden = FALSE;
    [tbProfile reloadData];
}

- (void)displayInformationWithData: (id)data {
    if ([data isKindOfClass:[NSArray class]]) {
        if (data == nil || [(NSArray *)data count] == 0) {
            lbNoData.text = @"Không có dữ liệu";
            lbNoData.hidden = FALSE;
            tbProfile.hidden = TRUE;
            
        }else{
            if (listProfiles == nil) {
                listProfiles = [[NSMutableArray alloc] initWithArray: data];
            }else{
                [listProfiles removeAllObjects];
                [listProfiles addObjectsFromArray: data];
            }
            [listProfiles insertObject:[AppDelegate sharedInstance].userInfo atIndex:0];
            
            lbNoData.hidden = TRUE;
            tbProfile.hidden = FALSE;
            [tbProfile reloadData];
        }
    }
}

- (void)searchTextfieldChanged: (UITextField *)textfield {
    selectedRow = -1;
    if (textfield.text.length > 0) {
        icClear.hidden = FALSE;
        searching = TRUE;
        
        if (searchTimer) {
            [searchTimer invalidate];
            searchTimer = nil;
        }
        searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(searchOnRegisteredDomains:) userInfo:textfield.text repeats:FALSE];
        
    }else{
        icClear.hidden = TRUE;
        searching = FALSE;
        lbNoData.hidden = TRUE;
        tbProfile.hidden = FALSE;
        [tbProfile reloadData];
        tbProfile.contentOffset = CGPointMake(0, 0);
    }
}

- (void)searchOnRegisteredDomains: (NSTimer *)timer {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cus_company CONTAINS[cd] %@ OR cus_realname CONTAINS[cd] %@", timer.userInfo, timer.userInfo];
    NSArray *filter = [listProfiles filteredArrayUsingPredicate: predicate];
    if (filter.count > 0) {
        [listSearch removeAllObjects];
        [listSearch addObjectsFromArray: filter];
        
        [tbProfile reloadData];
        lbNoData.hidden = TRUE;
        tbProfile.hidden = FALSE;
    }else{
        [listSearch removeAllObjects];
        lbNoData.hidden = FALSE;
        tbProfile.hidden = TRUE;
    }
    [tbProfile setContentOffset:CGPointZero animated:FALSE];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error]];
    [ProgressHUD dismiss];
    
    lbNoData.text = @"Đã có lỗi xảy ra. Vui lòng thử lại!";
    lbNoData.hidden = FALSE;
    tbProfile.hidden = TRUE;
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]]];
    [ProgressHUD dismiss];
    
    if ([link isEqualToString:get_profile_func]) {
        [self displayInformationWithData: data];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> function = %@ & responeCode = %d", __FUNCTION__, link, responeCode]];
    
    [ProgressHUD dismiss];
    
    if ([link isEqualToString: get_profile_func]) {
        if (responeCode != 200) {
            [self makeToast:@"Đã có lỗi xảy ra. Vui lòng thử lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching) {
        return listSearch.count;
    }else{
        return listProfiles.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileDetailCell *cell = (ProfileDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *profileInfo;
    if (searching) {
        profileInfo = [listSearch objectAtIndex: indexPath.row];
    }else{
        profileInfo = [listProfiles objectAtIndex: indexPath.row];
    }
    
    NSString *cusId = [profileInfo objectForKey:@"cus_id"];
    if (cusId != nil && ![AppUtils isNullOrEmpty: cusId] && [cusId isEqualToString: cusIdSelected]) {
        [cell.btnChoose setTitle:@"Bỏ chọn" forState:UIControlStateNormal];
        cell.btnChoose.backgroundColor = ORANGE_COLOR;
    }else{
        [cell.btnChoose setTitle:@"Chọn" forState:UIControlStateNormal];
        cell.btnChoose.backgroundColor = BLUE_COLOR;
    }
    
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    if ([type isEqualToString:@"0"]) {
        cell.lbTypeNameValue.text = text_personal;
        [cell updateUIForBusinessProfile: FALSE];
    }else{
        cell.lbTypeNameValue.text = text_business;
        
        NSString *cus_company = [profileInfo objectForKey:@"cus_company"];
        if (cus_company != nil) {
            cell.lbProfileNameValue.text = cell.lbCompanyValue.text = cus_company;
        }
        [cell updateUIForBusinessProfile: TRUE];
    }
    
    //  Show profile name
    NSString *name = [profileInfo objectForKey:@"cus_realname"];
    if (name != nil && [name isKindOfClass:[NSString class]]) {
        cell.lbProfileNameValue.text = name;
    }
    [cell displayProfileInfo: profileInfo];
    cell.delegate = self;
    
    cell.btnChoose.tag = indexPath.row;
    [cell.btnChoose addTarget:self
                       action:@selector(chooseProfileForDomain:)
             forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)selectedProfile:(NSDictionary *)profileInfo {
    
}

- (void)chooseProfileForDomain: (UIButton *)sender {
    [self endEditing: TRUE];
    if (searching) {
        if (sender.tag < listSearch.count && cartIndexItemSelect >= 0 && cartIndexItemSelect < [[CartModel getInstance] countItemInCart])
        {
            if ([sender.currentTitle isEqualToString:@"Bỏ chọn"]) {
                NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: cartIndexItemSelect];
                [domainInfo removeObjectForKey:profile_cart];
                [delegate onSelectedProfileForDomain];
                
            }else{
                NSDictionary *profile = [listSearch objectAtIndex: sender.tag];
                NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: cartIndexItemSelect];
                [domainInfo setObject:profile forKey:profile_cart];
                
                [delegate onSelectedProfileForDomain];
            }
        }
        
    }else{
        if (sender.tag < listProfiles.count && cartIndexItemSelect >= 0 && cartIndexItemSelect < [[CartModel getInstance] countItemInCart])
        {
            if ([sender.currentTitle isEqualToString:@"Bỏ chọn"]) {
                NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: cartIndexItemSelect];
                [domainInfo removeObjectForKey:profile_cart];
                [delegate onSelectedProfileForDomain];
                
            }else{
                NSDictionary *profile = [listProfiles objectAtIndex: sender.tag];
                NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: cartIndexItemSelect];
                [domainInfo setObject:profile forKey:profile_cart];
                
                [delegate onSelectedProfileForDomain];
            }
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != selectedRow) {
        selectedRow = (int)indexPath.row;
        [tableView beginUpdates];
        [tableView endUpdates];
    }else{
        selectedRow = -1;
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedRow) {
        return [self getHeightProfileTableViewCell: (int)indexPath.row];
    }else{
        return 75.0;
    }
}

- (float)getHeightProfileTableViewCell: (int)row {
    float hItem = 30.0;
    
    float wPassport = (SCREEN_WIDTH - 3*15.0)/2;
    float hPassport = wPassport * 2/3;
    float hDetailView = 15 + 9 * hItem + hPassport + hItem + 15;
    
    return 75.0 + hDetailView;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [self endEditing: TRUE];
    }
    return TRUE;
}

@end
