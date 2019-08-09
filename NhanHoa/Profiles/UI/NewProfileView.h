//
//  NewProfileView.h
//  NhanHoa
//
//  Created by admin on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

typedef enum {
    eAddNewProfile,
    eEditProfile,
    eViewProfile,
}PersonalProfileMode;

NS_ASSUME_NONNULL_BEGIN

@protocol NewProfileViewDelegate
@optional
- (void)onCancelButtonClicked;
- (void)onPassportFrontPress;
- (void)onPassportBehindPress;
- (void)profileWasCreated;
- (void)onSelectBusinessProfile;
- (void)onButtonEditPersonalProfilePressed;
- (void)personalProfileWasUpdated;

@end

@interface NewProfileView : UIView<ChooseCityPopupViewDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate, UIActionSheetDelegate, WebServiceUtilsDelegate, UITextFieldDelegate>

@property (retain) id <NSObject, NewProfileViewDelegate > delegate;

@property (nonatomic, assign) PersonalProfileMode mode;

@property (weak, nonatomic) IBOutlet UIScrollView *scvPersonal;
@property (weak, nonatomic) IBOutlet UILabel *lbVision;
@property (weak, nonatomic) IBOutlet UIButton *icPersonal;
@property (weak, nonatomic) IBOutlet UILabel *lbPersonal;
@property (weak, nonatomic) IBOutlet UIButton *icBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbWarningName;

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UILabel *lbGender;
@property (weak, nonatomic) IBOutlet UIButton *icMale;
@property (weak, nonatomic) IBOutlet UILabel *lbMale;
@property (weak, nonatomic) IBOutlet UIButton *icFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbBOD;
@property (weak, nonatomic) IBOutlet UITextField *tfBOD;
@property (weak, nonatomic) IBOutlet UIButton *btnBOD;

@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbWarningPhone;

@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbWarningAddress;

@property (weak, nonatomic) IBOutlet UITextField *tfAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbWarningCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UILabel *lbWarningCity;

@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrCity;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;

@property (weak, nonatomic) IBOutlet UIView *viewPassport;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbTitlePassport;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassportFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassportBehind;
@property (weak, nonatomic) IBOutlet UILabel *lbPassportFront;
@property (weak, nonatomic) IBOutlet UILabel *lbPassportBehind;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

- (void)setupForAddProfileUIForAddNew: (BOOL)isAddNew isUpdate: (BOOL)isUpdate;
- (IBAction)btnSavePress:(UIButton *)sender;
- (IBAction)btnCancelPress:(UIButton *)sender;
- (IBAction)btnBODPress:(UIButton *)sender;
- (IBAction)btnCityPress:(UIButton *)sender;
- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnEditPress:(UIButton *)sender;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;

@property (nonatomic, assign) int gender;
@property (nonatomic, strong) NSString *cityCode;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float mTop;
@property (nonatomic, assign) float hLabel;

@property (nonatomic, strong) NSString *linkFrontPassport;
@property (nonatomic, strong) NSString *linkBehindPassport;

@property (nonatomic, strong) NSString *cusId;

- (void)setupViewForAddNewProfileView;
- (void)removePassportFrontPhoto;
- (void)removePassportBehindPhoto;
- (void)setupUIForOnlyView;

- (void)displayInfoForPersonalProfileWithInfo: (NSDictionary *)info;
- (void)saveAllValueBeforeChangeView;

@end

NS_ASSUME_NONNULL_END
