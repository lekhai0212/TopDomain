//
//  WhoIsViewController.m
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoIsViewController.h"
#import "WhoIsResultViewController.h"
#import "WhoIsCell.h"

@interface WhoIsViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    NSMutableArray *listDomain;
    float padding;
}

@end

@implementation WhoIsViewController
@synthesize tbContent, btnSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_search_domains;
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"WhoIsViewController"];
    
    if (listDomain == nil) {
        listDomain = [[NSMutableArray alloc] init];
    }else{
        [listDomain removeAllObjects];
    }
    
    NSArray *arr = [tbContent visibleCells];
    for (int i=0; i<arr.count; i++) {
        WhoIsCell *cell = [arr objectAtIndex: i];
        NSString *domain = cell.tfDomain.text;
        if ([domain isEqualToString:@""] || (![AppUtils isNullOrEmpty: domain] && ![listDomain containsObject: domain])) {
            [listDomain addObject: domain];
        }
    }
    
    if (listDomain.count == 0) {
        [listDomain addObject:@""];
        [listDomain addObject:@""];
        [listDomain addObject:@""];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (IBAction)btnSearchPress:(UIButton *)sender
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startSearchDomain) withObject:nil afterDelay:0.05];
}

- (void)startSearchDomain {
    btnSearch.backgroundColor = BLUE_COLOR;
    [btnSearch setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray: listDomain];
    [result removeObject:@""];
    if (result.count == 0) {
        [self.view makeToast:please_enter_your_domain_names duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    [WriteLogsUtils writeLogContent:SFM(@"[%s] list search = %@", __FUNCTION__, @[result])];
    
    WhoIsResultViewController *whoIsResultVC = [[WhoIsResultViewController alloc] init];
    whoIsResultVC.listSearch = result;
    [self.navigationController pushViewController:whoIsResultVC animated:YES];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [tbContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [tbContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(btnSearch).offset(-padding);
    }];
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
    
    float hBTN = 45.0;
    padding = 15.0;
    
    float bottomPadding = 0;
    if (@available(iOS 11.0, *)) {
        bottomPadding = [AppDelegate sharedInstance].window.safeAreaInsets.bottom;
    }
    if (bottomPadding == 0) {
        bottomPadding = padding;
    }
    
    btnSearch.layer.cornerRadius = hBTN/2;
    btnSearch.backgroundColor = BLUE_COLOR;
    btnSearch.layer.borderColor = BLUE_COLOR.CGColor;
    btnSearch.layer.borderWidth = 1.0;
    [btnSearch setTitle:text_search forState:UIControlStateNormal];
    btnSearch.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-bottomPadding);
        make.height.mas_equalTo(hBTN);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"WhoIsCell" bundle:nil] forCellReuseIdentifier:@"WhoIsCell"];
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(btnSearch.mas_top).offset(-padding);
    }];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0)];
    
    UILabel *lbTbHeader = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, headerView.frame.size.width-2*padding, headerView.frame.size.height)];
    lbTbHeader.numberOfLines = 5;
    lbTbHeader.textAlignment = NSTextAlignmentCenter;
    lbTbHeader.text = @"Enter one or more domains you want to search";
    lbTbHeader.font = [AppDelegate sharedInstance].fontRegular;
    lbTbHeader.textColor = TITLE_COLOR;
    [headerView addSubview: lbTbHeader];
    tbContent.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55.0)];
    UIButton *btnTbFooter = [UIButton buttonWithType: UIButtonTypeCustom];
    btnTbFooter.frame = CGRectMake(padding, footerView.frame.size.height-45.0, footerView.frame.size.width-2*padding, hBTN);
    btnTbFooter.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    btnTbFooter.backgroundColor = [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(202/255.0) alpha:1.0];
    NSAttributedString *content = [AppUtils generateTextWithContent:text_add_more font:[AppDelegate sharedInstance].fontBTN color:UIColor.whiteColor image:[UIImage imageNamed:@"add"] size:22.0 imageFirst:YES];
    [btnTbFooter setAttributedTitle:content forState:UIControlStateNormal];
    [btnTbFooter addTarget:self
                    action:@selector(addNewRowForDomain)
          forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview: btnTbFooter];
    
    tbContent.tableFooterView = footerView;
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)addNewRowForDomain {
    if (listDomain.count == 5 || listDomain.count > 5) {
        self.view.clipsToBounds = NO;
        [self.view makeToast:@"Sorry. You can not add more!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
    }else{
        [listDomain addObject:@""];
        [tbContent reloadData];
        [tbContent scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:listDomain.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)whenTextfieldDomainChanged: (UITextField *)textfield {
    int index = (int)textfield.tag;
    if (index < listDomain.count) {
        listDomain[index] = textfield.text;
    }
}

- (void)removeDomain: (UIButton *)sender {
    int index = (int)sender.tag;
    if (index < listDomain.count) {
        [listDomain removeObjectAtIndex: index];
        [tbContent reloadData];
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listDomain.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WhoIsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WhoIsCell" forIndexPath:indexPath];
    cell.tfDomain.delegate = self;
    cell.tfDomain.returnKeyType = UIReturnKeyDone;
    
    [cell.tfDomain addTarget:self
                      action:@selector(whenTextfieldDomainChanged:)
            forControlEvents:UIControlEventEditingChanged];
    cell.tfDomain.tag = indexPath.row;
    
    [cell.icRemove addTarget:self
                      action:@selector(removeDomain:)
            forControlEvents:UIControlEventTouchUpInside];
    cell.icRemove.tag = indexPath.row;
    
    NSString *domain = [listDomain objectAtIndex: indexPath.row];
    cell.tfDomain.text = domain;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing: YES];
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing: TRUE];
    return TRUE;
}

@end
