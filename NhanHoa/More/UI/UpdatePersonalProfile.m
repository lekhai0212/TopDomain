//
//  UpdatePersonalProfile.m
//  NhanHoa
//
//  Created by lam quang quan on 6/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdatePersonalProfile.h"
#import "AccountModel.h"

@implementation UpdatePersonalProfile
@synthesize lbName, tfName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, btnBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbAddress, tfAddress, lbCountry, tfCountry, lbCity, tfCity, btnCity, btnSave, btnReset, imgArrCity;
@synthesize gender, datePicker, toolBar, viewPicker, cityCode, delegate, hContent;

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hLabel = 30.0;
    float mTop = 10.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnView.delegate = self;
    [self addGestureRecognizer: tapOnView];
    
    //  name
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfName.delegate = self;
    [AppUtils setBorderForTextfield:tfName borderColor:BORDER_COLOR];
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbName.mas_bottom);
        make.left.right.equalTo(self.lbName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  gender and birth of day
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnBOD setTitle:@"" forState:UIControlStateNormal];
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.tfBOD);
    }];
    
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbBOD);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
    }];
    
    icMale.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbGender).offset(-4.0);
        make.centerY.equalTo(self.tfBOD.mas_centerY);
        make.width.height.mas_equalTo(hLabel);
    }];
    
    icFemale.imageEdgeInsets = self.icMale.imageEdgeInsets;
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCREEN_WIDTH/4);
        make.top.bottom.equalTo(self.icMale);
        make.width.equalTo(self.icMale.mas_width);
    }];
    
    //  add action when tap on male label
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMale)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icMale);
        make.left.equalTo(self.icMale.mas_right).offset(5.0);
        make.right.equalTo(self.icFemale.mas_left).offset(-5.0);
    }];
    
    //  add action when tap on female label
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icFemale);
        make.left.equalTo(self.icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  cmnd
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbName);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPassport.delegate = self;
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  phone
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPhone.delegate = self;
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  address
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfAddress borderColor:BORDER_COLOR];
    tfAddress.delegate = self;
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  country, district
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self.lbAddress);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfCountry.enabled = FALSE;
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfCountry.text = @"Việt Nam";
    
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tfCountry);
        make.left.equalTo(self.lbCity);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [imgArrCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCity);
    }];
    
    btnReset.backgroundColor = OLD_PRICE_COLOR;
    btnReset.layer.borderColor = OLD_PRICE_COLOR.CGColor;
    btnReset.layer.borderWidth = 1.0;
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    if ([DeviceUtils isScreen320]) {
        [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(padding);
            make.right.equalTo(self.mas_centerX).offset(-padding/2);
            make.top.equalTo(self.btnCity.mas_bottom).offset(4*padding);
            make.height.mas_equalTo(45.0);
        }];
        
    }else{
        [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(padding);
            make.bottom.equalTo(self).offset(-padding);
            make.right.equalTo(self.mas_centerX).offset(-padding/2);
            make.height.mas_equalTo(45.0);
        }];
    }
    
    btnSave.backgroundColor = BLUE_COLOR;
    btnSave.layer.borderColor = BLUE_COLOR.CGColor;
    btnSave.layer.borderWidth = 1.0;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnReset.mas_right).offset(padding);
        make.top.bottom.equalTo(self.btnReset);
        make.right.equalTo(self).offset(-padding);
    }];
    
    btnReset.layer.cornerRadius = btnSave.layer.cornerRadius = 45.0/2;
    btnReset.titleLabel.font = btnSave.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbName.font = lbGender.font = lbBOD.font = lbPassport.font = lbPhone.font = lbAddress.font = lbCountry.font = lbCity.font = [AppDelegate sharedInstance].fontMedium;
    tfName.font = tfBOD.font = tfPassport.font = tfPhone.font = tfAddress.font = tfCountry.font = tfCity.font = [AppDelegate sharedInstance].fontRegular;
    btnReset.titleLabel.font = btnSave.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbName.textColor = tfName.textColor = lbGender.textColor = lbBOD.textColor = lbMale.textColor = lbFemale.textColor = tfBOD.textColor = lbPassport.textColor = tfPassport.textColor = lbPhone.textColor = tfPhone.textColor = lbAddress.textColor = tfAddress.textColor = lbCountry.textColor = tfCountry.textColor = lbCity.textColor = tfCity.textColor = TITLE_COLOR;
    
    //  Add datepicker
    [self addDatePickerForView];
    
    hContent = (padding + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + 4*padding + 45.0 + 4*padding;
}

- (void)selectMale {
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_men;
}

- (void)selectFemale {
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_women;
}

- (void)addDatePickerForView {
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.backgroundColor = UIColor.whiteColor;
    [datePicker setValue:BLUE_COLOR forKey:@"textColor"];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [self addSubview: datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0);
    }];
    
    toolBar = [[UIView alloc] init];
    toolBar.clipsToBounds = TRUE;
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [self addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    UIButton *btnClose = [[UIButton alloc] init];
    [btnClose setTitle:text_close forState:UIControlStateNormal];
    btnClose.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnClose setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    btnClose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnClose addTarget:self
                 action:@selector(closePickerView)
       forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview: btnClose];
    [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.toolBar).offset(15.0);
        make.bottom.top.equalTo(self.toolBar);
        make.width.mas_equalTo(100);
    }];
    
    UIButton *btnChoose = [[UIButton alloc] init];
    [btnChoose setTitle:text_select forState:UIControlStateNormal];
    btnChoose.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnChoose setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnChoose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnChoose addTarget:self
                  action:@selector(chooseDatePicker)
        forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview: btnChoose];
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.toolBar).offset(-15.0);
        make.bottom.top.equalTo(self.toolBar);
        make.width.mas_equalTo(100);
    }];
    
    viewPicker = [[UIView alloc] init];
    viewPicker.backgroundColor = UIColor.blackColor;
    viewPicker.alpha = 0.3;
    viewPicker.hidden = TRUE;
    [self addSubview: viewPicker];
    [viewPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.toolBar.mas_top);
    }];
}

- (void)closePickerView {
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0);
    }];
    
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.viewPicker.hidden = TRUE;
        [self layoutIfNeeded];
    }];
}

- (void)chooseDatePicker {
    [self closePickerView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    
    tfBOD.text = [dateFormatter stringFromDate:datePicker.date];
}

/*
cn_name: Họ và tên (string)
cn_sex: number (1: nam | 0: nữ)
cn_birthday: dd/mm/yyyy (ngày tháng năm sinh)
cn_cmnd: string / number (Số CMND / Passport)
cn_phone: string / number (Số ĐT)
cn_address: string (địa chỉ)
cn_country: 231 (cố định: Viêt Nam [231])
cn_city: number (mã tỉnh / thành theo danh sách anh đã gửi).
*/
- (IBAction)icMaleClick:(UIButton *)sender {
    [self selectMale];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [self selectFemale];
}

- (IBAction)btnBODPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    float hPickerView;
    float hToolbar;
    if (datePicker.frame.size.height > 0) {
        viewPicker.hidden = TRUE;
        hPickerView = 0;
        hToolbar = 0;
    }else{
        viewPicker.hidden = FALSE;
        hPickerView = 200;
        hToolbar = 44.0;
    }
    
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(hPickerView);
    }];
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(hToolbar);
    }];
    
    //  set date for picker
    if (![AppUtils isNullOrEmpty: tfBOD.text]) {
        NSDate *bodDate = [AppUtils convertStringToDate: tfBOD.text];
        if (bodDate != nil) {
            datePicker.date = bodDate;
        }else{
            datePicker.date = [NSDate date];
        }
    }else{
        datePicker.date = [NSDate date];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.datePicker.maximumDate = [NSDate date];
    }];
}

- (IBAction)btnResetPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:OLD_PRICE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startResetValue) withObject:nil afterDelay:0.05];
}

- (void)startResetValue {
    btnReset.backgroundColor = OLD_PRICE_COLOR;
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [self displayPersonalInformation];
}

- (IBAction)btnSavePress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(startUpdateAllValue) withObject:nil afterDelay:0.05];
}

- (void)startUpdateAllValue {
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if ([AppUtils isNullOrEmpty: tfName.text]) {
        [self makeToast:@"Vui lòng nhập họ tên" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [self makeToast:@"Vui lòng nhập CMND" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhone.text]) {
        [self makeToast:@"Vui lòng nhập điện thoại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfAddress.text]) {
        [self makeToast:@"Vui lòng nhập địa chỉ" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text] || [AppUtils isNullOrEmpty: cityCode]) {
        [self makeToast:@"Vui lòng nhập đầy đủ thông tin" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([delegate respondsToSelector:@selector(savePersonalMyAccountInformation:)]) {
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        [info setObject:[NSNumber numberWithInt:type_personal] forKey:@"own_type"];
        [info setObject:tfName.text forKey:@"cn_name"];
        [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
        [info setObject:tfBOD.text forKey:@"cn_birthday"];
        [info setObject:tfPassport.text forKey:@"cn_cmnd"];
        [info setObject:tfPhone.text forKey:@"cn_phone"];
        [info setObject:tfAddress.text forKey:@"cn_address"];
        [info setObject:COUNTRY_CODE forKey:@"cn_country"];
        [info setObject:cityCode forKey:@"cn_city"];
        
        [delegate savePersonalMyAccountInformation: info];
    }
}

- (IBAction)btnCityPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    float realHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 50, 300, realHeight-100)];
    popupView.delegate = self;
    [popupView showInView:self animated:TRUE];
}

- (void)displayPersonalInformation
{
    int gender = [AccountModel getCusGender];
    if (gender == type_men) {
        [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
        [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
        
    }else {
        [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
        [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    }
    tfName.text = [AccountModel getCusRealName];
    tfBOD.text = [AccountModel getCusBirthday];
    tfPassport.text = [AccountModel getCusPassport];
    tfPhone.text = [AccountModel getCusPhone];
    tfAddress.text = [AccountModel getCusAddress];
    
    cityCode = [AccountModel getCusCityCode];
    NSString *cityName = [[AppDelegate sharedInstance] findCityObjectWithCityCode: cityCode];
    if ([AppUtils isNullOrEmpty: cityName]) {
        cityCode = @"1";
    }else{
        tfCity.text = cityName;
    }
}

#pragma mark - Choose city delegate
-(void)choosedCity:(CityObject *)city {
    tfCity.text = city.name;
    cityCode = city.code;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer * __unused)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UITableViewCell class]] || [touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")])
    {
        return NO;
    }
    return YES;
}

@end
