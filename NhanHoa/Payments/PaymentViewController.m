//
//  PaymentViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentMethodCell.h"
#import <PayPalConfiguration.h>

@interface PaymentViewController ()<UITableViewDelegate, UITableViewDataSource, OnepayPaymentViewDelegate, PayPalPaymentDelegate> {
    
}
@end

@implementation PaymentViewController
@synthesize tbContent, btnContinue, money, typePaymentMethod, paymentView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_top_up_your_wallet;
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"PaymentViewController"];
    
    typePaymentMethod = ePaymentWithPaypal;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [self.paymentView removeFromSuperview];
}

- (void)setupUIForView {
    float padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnContinue.layer.cornerRadius = 45.0/2;
    btnContinue.layer.borderWidth = 1.0;
    btnContinue.layer.borderColor = BLUE_COLOR.CGColor;
    btnContinue.backgroundColor = BLUE_COLOR;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue setTitle:text_continue forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.btnContinue.mas_top).offset(-padding);
    }];
    [tbContent registerNib:[UINib nibWithNibName:@"PaymentMethodCell" bundle:nil] forCellReuseIdentifier:@"PaymentMethodCell"];
}


#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentMethodCell *cell = (PaymentMethodCell *)[tableView dequeueReusableCellWithIdentifier:@"PaymentMethodCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.imgType.image = [UIImage imageNamed:@"paypal_logo.png"];
        cell.lbTitle.text = text_payment_with_paypal;
        cell.lbSepa.hidden = FALSE;
        
    }else{
        cell.imgType.image = [UIImage imageNamed:@"onepay_logo.png"];
        cell.lbTitle.text = text_payment_with_onepay;
        cell.lbSepa.hidden = TRUE;
    }
    
    if (typePaymentMethod == (PaymentMethod)indexPath.row) {
        cell.imgChoose.hidden = FALSE;
    }else{
        cell.imgChoose.hidden = TRUE;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    typePaymentMethod = (PaymentMethod)indexPath.row;
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startContinuePayment) withObject:nil afterDelay:0.05];
}

- (void)startContinuePayment {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    btnContinue.backgroundColor = BLUE_COLOR;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (typePaymentMethod == ePaymentWithPaypal) {
        [self startPaymentWithPaypal];
        
    }else if (typePaymentMethod == ePaymentWithOnepay) {
        [self addOnepayPaymentViewIfNeed];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.paymentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }completion:^(BOOL finished) {
            self.paymentView.typePaymentMethod = self.typePaymentMethod;
            [self.paymentView showPaymentContentViewWithMoney: self.money];
        }];
    }
}

- (void)addOnepayPaymentViewIfNeed {
    if (paymentView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OnepayPaymentView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[OnepayPaymentView class]]) {
                paymentView = (OnepayPaymentView *) currentObject;
                break;
            }
        }
        UIWindow *curWindow = [[UIApplication sharedApplication] keyWindow];
        [curWindow addSubview: paymentView];
    }
    paymentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [paymentView setupUIForView];
    paymentView.delegate = self;
    paymentView.backgroundColor = UIColor.whiteColor;
}

- (void)startPaymentWithPaypal {
    PayPalConfiguration *payPalConfig = [[PayPalConfiguration alloc] init];

    payPalConfig.acceptCreditCards = TRUE;
    payPalConfig.merchantName = @"Nhan Hoa - Top Domain";
    payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://nhanhoa.com/trang/quy-dinh-su-dung-ten-mien.html"];
    payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://nhanhoa.com/trang/quy-dinh-su-dung-ten-mien.html"];
    payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionProvided;
    
    NSLog(@"Pay Pal SDK: %@", [PayPalMobile libraryVersion]);
    
    //  create list items
    PayPalItem *item1 = [PayPalItem itemWithName:@"Top up money to app" withQuantity:1 withPrice:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld", money]] withCurrency:@"USD" withSku:@"SKU-TOPUP-MONEY-APP"];
    
    NSArray *items = @[item1];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems: items];
    
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0"];
    
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal withShipping:shipping withTax:tax];
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding: shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = text_top_up_your_wallet;
    payment.items = items;
    payment.paymentDetails = paymentDetails;
    
    if (!payment.processable) {
        NSLog(@"Can not payment with paypal");
    }
    
    [self enableSizeForBarButtonItem: TRUE];
    PayPalPaymentViewController *paymentVC = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:payPalConfig delegate:self];
    
    [self presentViewController:paymentVC animated:TRUE completion:nil];
}

- (void)enableSizeForBarButtonItem: (BOOL)enable {
    float fontSize = 0.1;
    if (enable) {
        fontSize = 18.0;
    }
    NSDictionary *titleInfo = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoRegular size:fontSize], NSFontAttributeName, BLUE_COLOR, NSForegroundColorAttributeName, nil];
    [UIBarButtonItem.appearance setTitleTextAttributes:titleInfo forState:UIControlStateNormal];
    [UIBarButtonItem.appearance setTitleTextAttributes:titleInfo forState:UIControlStateHighlighted];
}


#pragma mark - PaymentView Delegate
-(void)onBackIconClick {
    [self.navigationController popViewControllerAnimated: TRUE];
}

-(void)onBackIconResultViewClick {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)userClickCancelPayment {
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)paymentResultWithInfo:(NSDictionary *)info {
    //  reset hashkey
    [AppDelegate sharedInstance].hashKey = @"";
    
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        if ([vpc_TxnResponseCode isEqualToString: User_cancel_Code]) {
            [self.view makeToast:@"Bạn đã hủy bỏ giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            //  [self performSelector:@selector(backToPreviousView) withObject:nil afterDelay:2.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_card_number_Code]) {
            [self.view makeToast:@"Số thẻ không chính xác. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
    }
}

- (void)dismissView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - Paypal Delegate
-(void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"payPalPaymentDidCancel");
    [self dismissViewControllerAnimated:TRUE completion:^{
        [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    }];
}

-(void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"%@", completedPayment);
    [self dismissViewControllerAnimated:TRUE completion:^{
        [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    }];
}

@end
