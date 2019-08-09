//
//  AppString.h
//  NhanHoa
//
//  Created by admin on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#ifndef AppString_h
#define AppString_h

#define SFM(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define simulator       @"x86_64"
#define Iphone4s        @"iPhone4,1"
#define Iphone5_1       @"iPhone5,1"
#define Iphone5_2       @"iPhone5,2"
#define Iphone5c_1      @"iPhone5,3"
#define Iphone5c_2      @"iPhone5,4"
#define Iphone5s_1      @"iPhone6,1"
#define Iphone5s_2      @"iPhone6,2"
#define Iphone6         @"iPhone7,2"
#define Iphone6_Plus    @"iPhone7,1"
#define Iphone6s        @"iPhone8,1"
#define Iphone6s_Plus   @"iPhone8,2"
#define IphoneSE        @"iPhone8,4"
#define Iphone7_1       @"iPhone9,1"
#define Iphone7_2       @"iPhone9,3"
#define Iphone7_Plus1   @"iPhone9,2"
#define Iphone7_Plus2   @"iPhone9,4"
#define Iphone8_1       @"iPhone10,1"
#define Iphone8_2       @"iPhone10,4"
#define Iphone8_Plus1   @"iPhone10,2"
#define Iphone8_Plus2   @"iPhone10,5"
#define IphoneX_1       @"iPhone10,3"
#define IphoneX_2       @"iPhone10,6"
#define IphoneXR        @"iPhone11,8"
#define IphoneXS        @"iPhone11,2"
#define IphoneXS_Max1   @"iPhone11,6"
#define IphoneXS_Max2   @"iPhone11,4"

#define RobotoBlack         @"Roboto-Black"
#define RobotoBlackItalic   @"Roboto-BlackItalic"
#define RobotoBold          @"Roboto-Bold"
#define RobotoBoldItalic    @"Roboto-BoldItalic"
#define RobotoItalic        @"Roboto-Italic"
#define RobotoLightItalic   @"Roboto-LightItalic"
#define RobotoMedium        @"Roboto-Medium"
#define RobotoMediumItalic  @"Roboto-MediumItalic"
#define RobotoRegular       @"Roboto-Regular"
#define RobotoThin          @"Roboto-Thin"
#define RobotoThinItalic    @"Roboto-ThinItalic"

#define HEADER_ICON_WIDTH 35.0

#define PASSWORD_MIN_CHARS  6
#define MAX_YEAR_FOR_RENEW  10
#define MIN_MONEY_TOPUP     200000
#define phone_support       @"19006680"

#define type_na             2
#define type_men            1
#define type_women          0

#define type_personal       0
#define type_business       1

#define type_A              @"A"
#define type_AAAA           @"AAAA"
#define type_CNAME          @"CNAME"
#define type_MX             @"MX"
#define type_URL_Redirect   @"URL Redirect"
#define type_URL_Frame      @"URL Frame"
#define type_TXT            @"TXT"
#define type_SRV            @"SRV"
#define type_SPF            @"SPF"

#define TTL_MIN     300
#define TTL_MAX     86400

#define MX_MIN      1
#define MX_MAX      100

#define TAG_HUD             100
#define TIME_FOR_SLIDER     6
#define COUNTRY_CODE        @"231"

#define URL_Payment         @"https://onepay.vn/onecomm-pay/vpc.op"
#define MERCHANT_ID         @"NHANHOA"
#define ACCESSCODE          @"KCGTKP1O"
#define HASHCODE            @"CD67F28EA5A64ED380D8388F686AE727"

#define URL_Payment_VISA    @"https://onepay.vn/vpcpay/vpcpay.op"
#define MERCHANT_ID_VISA    @"NHANHOA"
#define ACCESSCODE_VISA     @"2A5A6E8D"
#define HASHCODE_VISA       @"DBDBB856693DF3086604FDB60277D4A5"

#define register_domain     @"register_domain"
#define renew_domain        @"renew_domain"
#define topup_money         @"topup_money"

#define Approved_Code               @"0"
#define Bank_Declined_Code          @"1"
#define Merchant_not_exist_Code     @"3"
#define Invalid_access_Code         @"4"
#define Invalid_amount_Code         @"5"
#define Invalid_currency_Code       @"6"
#define Unspecified_failure_Code    @"7"
#define Invalid_card_number_Code    @"8"
#define Invalid_card_name_Code      @"9"
#define Expired_card_Code           @"10"
#define Card_not_registed_Code      @"11"
#define Invalid_card_date_Code      @"12"
#define Exist_Amount_Code           @"13"
#define Insufficient_fund_Code      @"21"
#define User_cancel_Code            @"99"
#define Failured_Content            @"Giao dịch thất bại"


#define link_api_call           @"https://api.vfone.vn:51100/cskhvoip"

#define link_support            @"https://tongdai.vfone.vn/callnew.php"
#define link_forgot_password    @"https://id.nhanhoa.com/login/forgot.html"
#define link_upload_photo       @"https://api.websudo.xyz"
#define return_url              @"https://nhanhoa.com/app-awk/onepay.php"
#define link_api                @"https://nhanhoa.com/app-awk"
#define login_func              @"Login"
#define whois_func              @"Whois"
#define get_profile_func        @"ListContact"
#define register_account_func   @"RegisterAccount"
#define add_contact_func        @"AddContact"
#define edit_contact_func       @"EditContact"
#define change_pass_func        @"ChangePassword"
#define list_domain_func        @"ListDomain"
#define domain_pricing_func     @"DomainPricing"
#define info_domain_func        @"InfoDomain"
#define update_cmnd_func        @"UpdateCMND"
#define change_dns_func         @"ChangeDNS"
#define get_dns_func            @"GetDNS"
#define send_question_func      @"SendQuestion"
#define edit_profile_func       @"EditProfile"
#define profile_photo_func      @"ProfilePhoto"
#define update_token_func       @"UpdateToken"
#define hash_key_func           @"HashKey"
#define check_otp_func          @"CheckOTP"
#define resend_otp_func         @"ResendOTP"
#define get_history_func        @"History"
#define renew_domain_func       @"RenewDomain"
#define renew_order_func        @"RenewOrder"
#define info_bank_func          @"InfoBank"
#define withdraw_func           @"Withdraw"
#define add_order_func          @"AddOrder"
#define addfun_func             @"Addfun"
#define WhoisProtect_func       @"WhoisProtect"
#define DNSRecord_func          @"DNSRecord"


#define login_mod               @"login"
#define whois_mod               @"whois"
#define get_profile_mod         @"contact_list"
#define register_account_mod    @"register_account"
#define add_contact_mod         @"add_contact"
#define edit_contact_mod        @"edit_contact"
#define change_password_mod     @"change_password"
#define list_domain_mod         @"list_domain"
#define domain_pricing_mod      @"domain_pricing"
#define info_domain_mod         @"info_domain"
#define update_cmnd_mod         @"update_cmnd"
#define change_dns_mod          @"change_dns"
#define get_dns_mod             @"get_dns"
#define question_mod            @"question"
#define edit_profile_mod        @"edit_profile"
#define profile_photo_mod       @"profile_photo"
#define update_token_mod        @"update_token"
#define hash_key_mod            @"hash_key"
#define check_otp_mod           @"check_otp"
#define resend_otp_mod          @"resend_otp"
#define get_history_mod         @"history"
#define renew_domain_mod        @"renew_domain"
#define renew_order_mod         @"renew_order"
#define info_bank_mod           @"info_bank"
#define withdraw_mod            @"withdraw"
#define add_order_mod           @"add_order"
#define addfun_mod              @"addfun"
#define whois_protect_mod       @"whois_protect"
#define dns_record_mod          @"dns_record"

#define GetAccVoipAction        @"GetAccVoip"
#define UpdateTokenAction       @"UpdateToken"
#define GetListCSKHAction       @"GetListCSKH"

#define logsFolderName      @"LogFiles"
#define login_state         @"login_state"
#define year_for_domain     @"year_for_domain"
#define whois_protect       @"whois_protect"

#define key_login           @"key_login"
#define key_password        @"key_password"
#define pass_for_backup     @"pass_for_backup"
#define domainvn_type       @"domainvn"
#define domain_type         @"domain"
#define profile_cart        @"profile_cart"

#define USERNAME ([[NSUserDefaults standardUserDefaults] objectForKey:key_login])
#define PASSWORD ([[NSUserDefaults standardUserDefaults] objectForKey:key_password])

#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define NAV_COLOR [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0]
#define ORANGE_COLOR [UIColor colorWithRed:(249/255.0) green:(157/255.0) blue:(28/255.0) alpha:1.0]
#define TITLE_COLOR [UIColor colorWithRed:(61/255.0) green:(77/255.0) blue:(103/255.0) alpha:1.0]
#define BLUE_COLOR [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0]
#define GREEN_COLOR [UIColor colorWithRed:(28/255.0) green:(189/255.0) blue:(92/255.0) alpha:1.0]
#define NEW_PRICE_COLOR [UIColor colorWithRed:(213/255.0) green:(53/255.0) blue:(93/255.0) alpha:1.0]
#define OLD_PRICE_COLOR [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(204/255.0) alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0]
#define LIGHT_GRAY_COLOR [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0]
#define ORANGE_BUTTON   UIColorFromRGB(0xf16725)

#define GRAY_240 [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0]
#define GRAY_235 [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0]
#define GRAY_230 [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0]
#define GRAY_225 [UIColor colorWithRed:(225/255.0) green:(225/255.0) blue:(225/255.0) alpha:1.0]
#define GRAY_220 [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0]
#define GRAY_215 [UIColor colorWithRed:(215/255.0) green:(215/255.0) blue:(215/255.0) alpha:1.0]
#define GRAY_200 [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0]

#define ProgressHUD_BG [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]


#define FRONT_EMPTY_IMG     [UIImage imageNamed:@"passport_empty_front.png"]
#define BEHIND_EMPTY_IMG    [UIImage imageNamed:@"passport_empty_behind.png"]
#define DEFAULT_AVATAR      [UIImage imageNamed:@"default_avatar.png"]

#define N_A             @"Không giá trị"
#define unknown         @"Chưa xác định"
#define not_support_yet @"Chưa hỗ trợ"

#define text_personal @"Cá nhân"
#define text_business @"Doanh nghiệp"

#define not_access_camera   @"Không thể truy cập vào camera. Vui lòng kiểm tra lại quyền truy cập của ứng dụng!"
#define no_internet         @"Không có kết nối internet. Vui lòng kiểm tra lại!"

#define text_close  @"Đóng"
#define text_choose @"Chọn"

#define text_capture    @"Chụp ảnh"
#define text_gallery    @"Thư viện ảnh"
#define text_remove     @"Xóa"
#define text_no_data    @"Không có dữ liệu"
#define topup_now       @"Nạp ngay"

#define text_not_support    @"Tính năng đang được phát triển"

#define text_today      @"Hôm nay"
#define text_yesterday  @"Hôm qua"

#define text_signed_contract    @"Hợp đồng đã ký tên"
#define text_signing_contract   @"Ký tên lên hợp đồng"

#define notifCallStateChanged       @"notifCallStateChanged"
#define notifRegStateChanged        @"notifRegStateChanged"

#define CALL_INV_STATE_NULL         @"PJSIP_INV_STATE_NULL"
#define CALL_INV_STATE_CALLING      @"PJSIP_INV_STATE_CALLING"
#define CALL_INV_STATE_INCOMING     @"PJSIP_INV_STATE_INCOMING"
#define CALL_INV_STATE_EARLY        @"PJSIP_INV_STATE_EARLY"
#define CALL_INV_STATE_CONNECTING   @"PJSIP_INV_STATE_CONNECTING"
#define CALL_INV_STATE_CONFIRMED    @"PJSIP_INV_STATE_CONFIRMED"
#define CALL_INV_STATE_DISCONNECTED @"PJSIP_INV_STATE_DISCONNECTED"




#define search_domain   @"Search domain..."
#define balance_text    @"Balance"


#endif /* AppString_h */



/*
 IP Host / FTP: 103.57.210.79
 Username:       apitest
 Password:       Ck79QMp6
 Domain:         api.websudo.xyz
*/
