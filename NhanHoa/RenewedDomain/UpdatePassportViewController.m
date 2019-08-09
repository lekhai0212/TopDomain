//
//  UpdatePassportViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdatePassportViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHAsset.h>
#import "AccountModel.h"
#import "UploadPicture.h"

@interface UpdatePassportViewController ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, WebServiceUtilsDelegate>
{
    UIImagePickerController *imagePickerController;
    int type;
}
@end

@implementation UpdatePassportViewController
@synthesize btnBanKhai, imgWaitBanKhai, lbBanKhai, btnCMND_a,imgWaitCMND_a, lbCMND_a, btnCMND_b, imgWaitCMND_b, lbCMND_b, btnSave, btnCancel;
@synthesize linkCMND_a, linkCMND_b, cusId, curCMND_a, curCMND_b, linkBanKhai, curBanKhai, domain, domainId, domainType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Cập nhật CMND";
    [self setupUIForView];
    [self addRightBarButtonForNavigationBar];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"UpdatePassportViewController"];
    
    [self showCurrentPassportForDomain];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    if ([self isMovingFromParentViewController])
    {
        imagePickerController = nil;
        [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
        [AppDelegate sharedInstance].profileEdit = nil;
        [AppDelegate sharedInstance].editCMND_a = nil;
        [AppDelegate sharedInstance].editCMND_b = nil;
    }else {
        NSLog(@"New view controller was pushed");
    }
}

- (void)addRightBarButtonForNavigationBar {
    UIView *viewSave = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    viewSave.backgroundColor = UIColor.clearColor;
    
    UIButton *btnSave =  [UIButton buttonWithType:UIButtonTypeCustom];
    btnSave.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    btnSave.frame = CGRectMake(15, 0, 40, 40);
    btnSave.backgroundColor = UIColor.clearColor;
    [btnSave setImage:[UIImage imageNamed:@"tick_white"] forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [viewSave addSubview: btnSave];
    
    UIBarButtonItem *btnSaveBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: viewSave];
    self.navigationItem.rightBarButtonItem =  btnSaveBarButtonItem;
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 35.0; // or whatever you want
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.navigationItem.rightBarButtonItems = @[fixedItem, flexibleItem, btnSaveBarButtonItem];
}

- (void)saveInfo {
    if ([AppDelegate sharedInstance].editCMND_a == nil && [AppDelegate sharedInstance].editCMND_b == nil && [AppDelegate sharedInstance].editBanKhai == nil) {
        [self.view makeToast:@"Vui lòng chọn hình ảnh để cập nhật!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cusId]) {
        [self.view makeToast:@"Không thể lấy được cusId. Vui lòng thử lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang cập nhật..." Interaction:NO];
    
    [self uploadBanKhaiPicture];
}

- (void)showCurrentPassportForDomain {
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        [btnCMND_a setImage:[AppDelegate sharedInstance].editCMND_a forState:UIControlStateNormal];
    }else{
        if (![AppUtils isNullOrEmpty: curCMND_a])
        {
            imgWaitCMND_a.hidden = FALSE;
            [imgWaitCMND_a startAnimating];
            
            [btnCMND_a sd_setImageWithURL:[NSURL URLWithString:curCMND_a] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
            {
                if (image == nil) {
                    [self.btnCMND_a setImage:FRONT_EMPTY_IMG forState:UIControlStateNormal];
                }
                self.imgWaitCMND_a.hidden = TRUE;
                [self.imgWaitCMND_a stopAnimating];
            }];
        }else{
            [btnCMND_a setImage:FRONT_EMPTY_IMG forState:UIControlStateNormal];
        }
    }
    
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [btnCMND_b setImage:[AppDelegate sharedInstance].editCMND_b forState:UIControlStateNormal];
    }else{
        if (![AppUtils isNullOrEmpty: curCMND_b]) {
            imgWaitCMND_b.hidden = FALSE;
            [imgWaitCMND_b startAnimating];
            
            [btnCMND_b sd_setImageWithURL:[NSURL URLWithString:curCMND_b] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
             {
                 if (image == nil) {
                     [self.btnCMND_b setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
                 }
                 self.imgWaitCMND_b.hidden = TRUE;
                 [self.imgWaitCMND_b stopAnimating];
             }];
        }else{
            [btnCMND_b setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
        }
    }
    
    if ([AppDelegate sharedInstance].editBanKhai != nil) {
        [btnBanKhai setImage:[AppDelegate sharedInstance].editBanKhai forState:UIControlStateNormal];
    }else{
        if (![AppUtils isNullOrEmpty: curBanKhai]) {
            imgWaitBanKhai.hidden = FALSE;
            [imgWaitBanKhai startAnimating];
            
            [btnBanKhai sd_setImageWithURL:[NSURL URLWithString:curBanKhai] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
             {
                 if (image == nil) {
                     [self.btnBanKhai setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
                 }
                 [self.imgWaitBanKhai stopAnimating];
                 self.imgWaitBanKhai.hidden = TRUE;
             }];
        }else{
            [btnBanKhai setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
        }
    }
}

- (IBAction)btnCMND_a_Press:(UIButton *)sender {
    type = 1;
    
    if ([AppDelegate sharedInstance].editCMND_a == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
        [self showActionSheetChooseWithRemove: TRUE];
    }
}

- (IBAction)btnCMND_b_Press:(UIButton *)sender {
    type = 2;
    
    if ([AppDelegate sharedInstance].editCMND_b == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
        [self showActionSheetChooseWithRemove: TRUE];
    }
}

- (IBAction)btnBanKhaiPress:(UIButton *)sender {
    type = 3;
    
    if ([AppDelegate sharedInstance].editBanKhai == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
        [self showActionSheetChooseWithRemove: TRUE];
    }
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)btnSavePress:(UIButton *)sender {
    if ([AppDelegate sharedInstance].editCMND_a == nil && [AppDelegate sharedInstance].editCMND_b == nil) {
        [self.view makeToast:@"Bạn chưa chọn CMND để cập nhật!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cusId]) {
        [self.view makeToast:@"Không thể lấy được cusId. Vui lòng thử lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang cập nhật. Vui lòng chờ trong giây lát" Interaction:NO];
}

- (void)uploadBanKhaiPicture {
    if ([AppDelegate sharedInstance].editBanKhai != nil) {
        //  resize image to reduce quality
        [AppDelegate sharedInstance].editBanKhai = [AppUtils resizeImage: [AppDelegate sharedInstance].editBanKhai];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editBanKhai);
        
        if (uploadData == nil) {
            [WriteLogsUtils writeLogContent:SFM(@"[%s] ERROR: >>>>>>>>>> Can not get data from editBanKhai image, continue get data for CMND_a", __FUNCTION__)];
            [self uploadPassportFrontPicture];
            
        }else{
            NSString *imageName = [NSString stringWithFormat:@"%@_bankhai_%@.PNG", [AccountModel getCusIdOfUser], [AppUtils getCurrentDateTime]];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UploadPicture *session = [[UploadPicture alloc] init];
                [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                            [WriteLogsUtils writeLogContent:SFM(@"[%s] BanKhai was not uploaded successful", __FUNCTION__)];
                            
                            self.linkBanKhai = @"";
                            
                        }else{
                            [WriteLogsUtils writeLogContent:SFM(@"[%s] BanKhai was uploaded successful", __FUNCTION__)];
                            
                            self.linkBanKhai = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                        }
                        [self uploadPassportFrontPicture];
                    });
                }];
            });
        }
    }else{
        self.linkBanKhai = curBanKhai;
        [self uploadPassportFrontPicture];
    }
}

- (void)uploadPassportFrontPicture {
    if ([AppDelegate sharedInstance].editCMND_a != nil)
    {
        //  resize image to reduce quality
        [AppDelegate sharedInstance].editCMND_a = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_a];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_a);
        if (uploadData == nil) {
            [WriteLogsUtils writeLogContent:SFM(@"[%s] ERROR: >>>>>>>>>> Can not get data from CMND_a image, continue get data for CMND_b", __FUNCTION__)];
            
            [self uploadPassportBehindPicture];
        }else{
            NSString *imageName = [NSString stringWithFormat:@"%@_front_%@.PNG", [AccountModel getCusIdOfUser], [AppUtils getCurrentDateTime]];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UploadPicture *session = [[UploadPicture alloc] init];
                [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                            [WriteLogsUtils writeLogContent:SFM(@"[%s] CMND_a was not uploaded successful", __FUNCTION__)];
                            
                            self.linkCMND_a = @"";
                            
                        }else{
                            [WriteLogsUtils writeLogContent:SFM(@"[%s] CMND_a was uploaded successful", __FUNCTION__)];
                            
                            self.linkCMND_a = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                        }
                        
                        [self uploadPassportBehindPicture];
                    });
                }];
            });
        }
    }else{
        self.linkCMND_a = curCMND_a;
        [self uploadPassportBehindPicture];
    }
}

- (void)uploadPassportBehindPicture {
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [AppDelegate sharedInstance].editCMND_b = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_b];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_b);
        
        NSString *imageName = [NSString stringWithFormat:@"%@_behind_%@.PNG", [AccountModel getCusIdOfUser], [AppUtils getCurrentDateTime]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] CMND_b was not uploaded successful", __FUNCTION__)];
                        
                        self.linkCMND_b = @"";
                        
                    }else{
                        self.linkCMND_b = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                    }
                    [self updateCMNDPhotoForDomain];
                });
            }];
        });
    }else{
        self.linkCMND_b = curCMND_b;
        [self updateCMNDPhotoForDomain];
    }
}

- (void)updateCMNDPhotoForDomain {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if ([AppUtils isNullOrEmpty: linkCMND_a] && [AppUtils isNullOrEmpty: linkCMND_b] && [AppUtils isNullOrEmpty: linkBanKhai]) {
        [self.view makeToast:@"CMND của bạn chưa được tải thành công. Vui lòng thử lại!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updateCMNDPhotoForDomainWithCMND_a:linkCMND_a CMND_b:linkCMND_b cusId:cusId domainName:domain domainType:domainType domainId:domainId banKhai:linkBanKhai];
}

- (void)showActionSheetChooseWithRemove: (BOOL)remove {
    if (remove) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:text_close destructiveButtonTitle:nil otherButtonTitles:text_capture, text_gallery, text_remove, nil];
        [actionSheet showInView: self.view];
        
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:text_close destructiveButtonTitle:nil otherButtonTitles:text_capture, text_gallery, nil];
        [actionSheet showInView: self.view];
    }
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    float padding = 15.0;
    float hFooterBTN = 45.0;
    float hLabel = 25.0;
    float hBTN = (SCREEN_HEIGHT - ([AppDelegate sharedInstance].hNav + 3*2*padding + 2*hLabel + hFooterBTN + 10.0))/2;
    hBTN = (SCREEN_HEIGHT - ([AppDelegate sharedInstance].hNav + [AppDelegate sharedInstance].hStatusBar + 4*padding + 3*hLabel))/3;
    
    imgWaitBanKhai.backgroundColor = imgWaitCMND_a.backgroundColor = imgWaitCMND_b.backgroundColor = UIColor.whiteColor;
    imgWaitBanKhai.alpha = imgWaitCMND_a.alpha = imgWaitCMND_b.alpha = 0.5;
    imgWaitBanKhai.hidden = imgWaitCMND_a.hidden = imgWaitCMND_b.hidden = TRUE;
    
    //  Ban khai
    btnBanKhai.layer.borderWidth = btnCMND_a.layer.borderWidth = btnCMND_b.layer.borderWidth = 1.0;
    btnBanKhai.layer.borderColor = btnCMND_a.layer.borderColor = btnCMND_b.layer.borderColor = BORDER_COLOR.CGColor;
    
    btnBanKhai.imageEdgeInsets = UIEdgeInsetsMake(7.5, 20, 7.5, 20);
    [btnBanKhai.imageView setContentMode: UIViewContentModeScaleAspectFit];
    [btnBanKhai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(padding);
        make.left.equalTo(self.view).offset(2*padding);
        make.right.equalTo(self.view).offset(-2*padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    [imgWaitBanKhai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.btnBanKhai);
    }];
    
    [lbBanKhai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnBanKhai.mas_bottom);
        make.left.right.equalTo(self.btnBanKhai);
        make.height.mas_equalTo(hLabel);
    }];
    
    //  CMND_a
    btnCMND_a.imageEdgeInsets = UIEdgeInsetsMake(7.5, 20, 7.5, 20);
    [btnCMND_a.imageView setContentMode: UIViewContentModeScaleAspectFit];
    [btnCMND_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBanKhai.mas_bottom).offset(padding);
        make.left.right.equalTo(self.btnBanKhai);
        make.height.mas_equalTo(hBTN);
    }];

    [imgWaitCMND_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.btnCMND_a);
    }];
    
    [lbCMND_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCMND_a.mas_bottom);
        make.left.right.equalTo(self.btnCMND_a);
        make.height.mas_equalTo(hLabel);
    }];

    //  CMND_b
    btnCMND_b.imageEdgeInsets = btnCMND_a.imageEdgeInsets;

    [btnCMND_b.imageView setContentMode: UIViewContentModeScaleAspectFit];
    [btnCMND_b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCMND_a.mas_bottom).offset(padding);
        make.left.right.equalTo(self.lbCMND_a);
        make.height.mas_equalTo(hBTN);
    }];

    [imgWaitCMND_b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.btnCMND_b);
    }];

    [lbCMND_b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCMND_b.mas_bottom);
        make.left.right.equalTo(self.btnCMND_b);
        make.height.mas_equalTo(hLabel);
    }];

    [btnCancel setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnCancel.backgroundColor = OLD_PRICE_COLOR;
    btnCancel.layer.cornerRadius = hFooterBTN/2;
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hFooterBTN);
    }];

    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSave.backgroundColor = BLUE_COLOR;
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btnCancel);
        make.left.equalTo(self.btnCancel.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];

    btnCancel.hidden = btnSave.hidden = TRUE;
    btnCancel.titleLabel.font = btnSave.titleLabel.font = lbCMND_a.font = lbCMND_b.font = [AppDelegate sharedInstance].fontBTN;
    lbBanKhai.textColor = lbCMND_a.textColor = lbCMND_b.textColor = TITLE_COLOR;
}

- (void)requestToAccessYourCamera {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    AVAuthorizationStatus cameraAuthStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    if (cameraAuthStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (granted) {
                    [self goToCaptureImagePickerView];
                }else{
                    [self.view makeToast:not_access_camera duration:3.0 position:CSToastPositionCenter];
                }
            });
        }];
    }else{
        if (cameraAuthStatus == AVAuthorizationStatusAuthorized) {
            [self goToCaptureImagePickerView];
        }else{
            if (cameraAuthStatus != AVAuthorizationStatusAuthorized && cameraAuthStatus != AVAuthorizationStatusNotDetermined) {
                [self.view makeToast:not_access_camera duration:3.0 position:CSToastPositionCenter];
            }
        }
    }
}

- (void)goToCaptureImagePickerView {
    if (imagePickerController == nil) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
    }
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)onSelectPhotosGallery {
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    if (photoAuthStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^() {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self goToGalleryPhotosView];
                }else{
                    [self.view makeToast:not_access_camera duration:3.0 position:CSToastPositionCenter];
                }
            });
        }];
    }else{
        if (photoAuthStatus == PHAuthorizationStatusAuthorized) {
            [self goToGalleryPhotosView];
        }else{
            [self.view makeToast:not_access_camera duration:3.0 position:CSToastPositionCenter];
        }
    }
}

- (void)goToGalleryPhotosView {
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: TRUE];
    
    if (imagePickerController == nil) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = FALSE;
    }
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)removeCurrentPhotos {
    if (type == 1) {
        [AppDelegate sharedInstance].editCMND_a = nil;
        if (![AppUtils isNullOrEmpty: curCMND_a]) {
            [btnCMND_a sd_setImageWithURL:[NSURL URLWithString:curCMND_a] forState:UIControlStateNormal placeholderImage:FRONT_EMPTY_IMG];
        }else{
            [btnCMND_a setImage:FRONT_EMPTY_IMG forState:UIControlStateNormal];
        }
    }else{
        [AppDelegate sharedInstance].editCMND_b = nil;
        if (![AppUtils isNullOrEmpty: curCMND_b]) {
            [btnCMND_b sd_setImageWithURL:[NSURL URLWithString:curCMND_b] forState:UIControlStateNormal placeholderImage:BEHIND_EMPTY_IMG];
        }else{
            [btnCMND_b setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
        }
    }
}

- (void)popupToPreviousView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [AppDelegate sharedInstance].editCMND_a = [AppDelegate sharedInstance].editCMND_b = nil;
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - ActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex: buttonIndex];
    if ([title isEqualToString: text_capture]) {
        [self requestToAccessYourCamera];
        
    }else if ([title isEqualToString: text_gallery]) {
        [self onSelectPhotosGallery];
        
    }else if ([title isEqualToString: text_remove]) {
        [self removeCurrentPhotos];
    }
}

#pragma mark - UIImagePickerViewDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (type == 1) {
        NSData *pngData = UIImagePNGRepresentation(image);
        [AppDelegate sharedInstance].editCMND_a = [UIImage imageWithData:pngData];
        
        [btnCMND_a setImage:[AppDelegate sharedInstance].editCMND_a forState:UIControlStateNormal];
        
    }else if (type == 2){
        NSData *pngData = UIImagePNGRepresentation(image);
        [AppDelegate sharedInstance].editCMND_b = [UIImage imageWithData:pngData];
        [btnCMND_b setImage:[AppDelegate sharedInstance].editCMND_b forState:UIControlStateNormal];
        
    }else if (type == 3){
        NSData *pngData = UIImagePNGRepresentation(image);
        [AppDelegate sharedInstance].editBanKhai = [UIImage imageWithData:pngData];
        [btnBanKhai setImage:[AppDelegate sharedInstance].editBanKhai forState:UIControlStateNormal];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Webservice Delegate
-(void)failedUpdatePassportForDomainWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)updatePassportForDomainSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD dismiss];
    [self.view makeToast:@"CMND đã được cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(popupToPreviousView) withObject:nil afterDelay:2.0];
}

@end
