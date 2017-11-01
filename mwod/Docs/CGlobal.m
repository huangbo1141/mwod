//
//  CGlobal.m
//  SchoolApp
//
//  Created by apple on 9/24/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

#import "CGlobal.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import "UIView+Property.h"
#import "YTVimeoExtractor.h"

UIColor*   COLOR_TOOLBAR_TEXT;
UIColor*   COLOR_TOOLBAR_BACK;
UIColor*   COLOR_PRIMARY;
UIColor*   COLOR_SECONDARY_PRIMARY;
UIColor*   COLOR_SECONDARY_GRAY;
UIColor*   COLOR_SECONDARY_THIRD;
UIColor*   COLOR_RESERVED;

// https://www.mobilitywod.com/wp-json/custom-plugin/login

NSString* g_baseUrl = @"https://mobilitywod.com";
//NSString* g_baseUrl = @"http://192.168.1.106";
NSString* BASE_URL = @"/WebService/";
NSString* BASE_DATA_URL = @"/Basic/";
NSString* BASE_URL_ORDER = @"/Order/";
NSString* FORGOT = @"/Forgot/";
NSString* ZIP_LOCATION = @"http://maps.googleapis.com/maps/api/geocode/json";
NSString* PHOTO_URL = @"/uploads/";
//NSString* g_baseUrl = @"https://travpholer.com/adminuser";
BOOL g_lock = false;
BOOL g_isii = true;


NSString*   APISERVICE_IP_URL = @"http://ip-api.com/json";
NSString*   APISERVICE_MAP_URL = @"http://maps.googleapis.com/maps";
NSString*   COMMON_PATH1 = @"/assets/rest/";

NSString*   ACTION_LOGIN = @"/signup_fb.php";
NSString*   ACTION_CONFIRM = @"/confirm.php";
NSString*   ACTION_ADD_FRIEND = @"/add_friend.php";
NSString*   ACTION_INVITE_GAME = @"/invite_game.php";
NSString*   ACTION_UPDATE_GAME = @"/update_game.php";
NSString*   ACTION_GET_BELL = @"/get_bell.php";
NSString*   ACTION_CONQUERED_COUNTRY = @"/loadconquered_country.php";

NSString*   ACTION_UPLOAD = @"/fileuploadmm.php";
NSString*   ACTION_LIKEPIC = @"/actionlike.php";
NSString*   ACTION_REPORT = @"/actionreport.php";
NSString*   ACTION_MAKEPOST = @"/makepost.php";
NSString*   ACTION_COMMENT = @"/actioncomment.php";
NSString*   ACTION_USERINFO = @"/userinfo.php";
NSString*   ACTION_UPDATEPROFILE = @"/updateprofile.php";
NSString*   ACTION_LOADNOTI = @"/load_noti.php";
NSString*   ACTION_TOGO_IDS = @"/loadtogo_ids.php";

NSString*   ACTION_TOGO_DATA = @"/loadtogo_data.php";
NSString*   ACTION_CONQUERED_DATA = @"/loadconquered_data.php";

NSString*   ACTION_DEFAULTPROFILE = @"/assets/uploads/user1.png";

NSString*   G_SHARETEXT = @"Start tracking your pool games with us at jellyrollpool.com.";

int gms_camera_zoom = 12;
NSDictionary*g_launchoptions;
int g_mode = 0;
int c_PERSONAL = 0;
int c_GUEST = 1;
int c_CORPERATION = 2;

int g_ORDER_TYPE = 0;
int g_CAMERA_OPTION = 1;
int g_ITEM_OPTION = 2;
int g_PACKAGE_OPTION = 3;
int g_limitCnt = 10;
CGFloat g_txtBorderWidth = 1.7;

NSArray* g_securityList;
NSArray* c_quantity;
NSArray* c_weight;
NSArray* c_weight_value;
NSArray* c_packageLists;
NSArray* c_paymentWay;
NSArray* c_menu_title;


NSString* PUBLISHABLE_KEY;
NSString* curPaymentWay;


//basic info

// notifications
NSString *GLOBALNOTIFICATION_DATA_CHANGED_PHOTO = @"GLOBALNOTIFICATION_DATA_CHANGED_PHOTO";;
NSString *GLOBALNOTIFICATION_MAP_PICKLOCATION = @"GLOBALNOTIFICATION_MAP_PICKLOCATION";
NSString *GLOBALNOTIFICATION_RECEIVE_USERINFO_SUCC = @"GLOBALNOTIFICATION_RECEIVE_USERINFO_SUCC";
NSString *GLOBALNOTIFICATION_RECEIVE_USERINFO_FAIL = @"GLOBALNOTIFICATION_RECEIVE_USERINFO_FAIL";
NSString *GLOBALNOTIFICATION_CHANGEVIEWCONTROLLER = @"GLOBALNOTIFICATION_CHANGEVIEWCONTROLLER";
NSString *GLOBALNOTIFICATION_CHANGEVIEWCONTROLLERREBATE = @"GLOBALNOTIFICATION_CHANGEVIEWCONTROLLERREBATE";

NSString *GLOBALNOTIFICATION_MQTTPAYLOAD = @"GLOBALNOTIFICATION_MQTTPAYLOAD";
NSString *GLOBALNOTIFICATION_MQTTPAYLOAD_PROCESS = @"GLOBALNOTIFICATION_MQTTPAYLOAD_PROCESS";

NSString *GLOBALNOTIFICATION_ADDRESSPICKUP = @"GLOBALNOTIFICATION_ADDRESSPICKUP";
NSString *GLOBALNOTIFICATION_LIKEDBUTTON =  @"GLOBALNOTIFICATION_LIKEDBUTTON";

NSString *NOTIFICATION_RECEIVEUUID =  @"NOTIFICATION_RECEIVEUUID";

NSString *const kPhotoManagerChangedContentNotificationHot = @"NOTIFICATION_PhotoManagerChangedContentHot";

NSString *const kPhotoManagerChangedContentNotificationFresh = @"NOTIFICATION_PhotoManagerChangedContentFresh";

NSString *const kPhotoManagerChangedContentNotificationOthers = @"NOTIFICATION_PhotoManagerChangedContentOthers";


//MENU HEIGHT
CGFloat GLOBAL_MENUHEIGHT = 50;
CGFloat GLOBAL_MENUWIDTH = 200;

//common variables
NSMutableArray *g_buttonTitles;
UIFont * g_largefont;
CGFloat g_menuHeight = 50;
NSMutableArray* menu_bottomList;
NSMutableArray* menu_topList;

int g_thumb_w = 300;
int g_thumb_h = 167;

@implementation CGlobal

+(void)initSample{
    [self initConfig];
    
}
+(void)initConfig{
    
}


+ (CGlobal *)sharedId
{
    static dispatch_once_t onceToken;
    static CGlobal *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CGlobal alloc] init];
    });
    return instance;
}

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        _env = [[EnvVar alloc] init];
        //        _curUser = [[TblUser alloc] init];
        // 33.858606, 35.816947
        _defaultPos = CLLocationCoordinate2DMake(33.858606, 35.816947);
    }
    return self;
}

// Common Funcs
+(void)makeCountLabel:(UILabel*) label{
    
}
+(void)makeTermsPrivacyForLabel: (TTTAttributedLabel *) label withUrl:(NSString*)urlString{
    //TTTAttributedLabel *tttLabel = ;
    NSString *labelText = label.text;
    
    NSRange r = [labelText rangeOfString:labelText];
    [label addLinkToURL:[NSURL URLWithString:urlString] withRange:r];
    
}
+(void)showIndicator:(UIViewController*)viewcon{
    if (viewcon==nil) {
        return;
    }
    WNAActivityIndicator* activityIndicator = (WNAActivityIndicator*)[viewcon.view viewWithTag:1999];
    if(activityIndicator == nil){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        activityIndicator = [[WNAActivityIndicator alloc] initWithFrame:screenRect];
        activityIndicator.tag = 1999;
        [activityIndicator setHidden:NO];
    }
    if (![activityIndicator isDescendantOfView:viewcon.view]) {
        [viewcon.view addSubview:activityIndicator];
    }
    [viewcon.view bringSubviewToFront:activityIndicator];
}
+(void)stopIndicator:(UIViewController*)viewcon{
    if (viewcon==nil) {
        return;
    }
    WNAActivityIndicator* activityIndicator = (WNAActivityIndicator*)[viewcon.view viewWithTag:1999];
    if(activityIndicator!=nil){
        [activityIndicator setHidden:YES];
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }
    NSLog(@"ddd");
    
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
+(void)showIndicatorForView:(UIView*)viewcon{
    if (viewcon==nil) {
        return;
    }
    WNAActivityIndicator* activityIndicator = (WNAActivityIndicator*)[viewcon viewWithTag:1999];
    if(activityIndicator == nil){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        activityIndicator = [[WNAActivityIndicator alloc] initWithFrame:screenRect];
        activityIndicator.tag = 1999;
        [activityIndicator setHidden:NO];
    }
    if (![activityIndicator isDescendantOfView:viewcon]) {
        [viewcon addSubview:activityIndicator];
    }
    [viewcon bringSubviewToFront:activityIndicator];
}
+(void)stopIndicatorForView:(UIView*)viewcon{
    if (viewcon==nil) {
        return;
    }
    WNAActivityIndicator* activityIndicator = (WNAActivityIndicator*)[viewcon viewWithTag:1999];
    if(activityIndicator!=nil){
        [activityIndicator setHidden:YES];
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }
    NSLog(@"ddd1");
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
//+(void)showIndicator:(UIViewController*)viewcon{
//    UIActivityIndicatorView* view = (UIActivityIndicatorView*)[viewcon.view viewWithTag:1000];
//    if(view == nil){
//        CGFloat width = 60.0;
//        CGFloat height = 60.0;
//        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//
//        [indicatorView setColor:[UIColor colorWithRed:69.0/255.0 green:98.0/255.0 blue:163.0/255.0 alpha:1]];
//        indicatorView.center = viewcon.view.center;
//        indicatorView.tag = 1000;
//        [viewcon.view addSubview:indicatorView];
//        [viewcon.view bringSubviewToFront:indicatorView];
//
//        view = indicatorView;
//    }
//
//    view.hidden = false;
//    [viewcon.view bringSubviewToFront:view];
//    [view startAnimating];
//}
//+(void)stopIndicator:(UIViewController*)viewcon{
//    UIActivityIndicatorView* view = (UIActivityIndicatorView*)[viewcon.view viewWithTag:1000];
//    if(view != nil){
//        view.hidden = YES;
//        [view stopAnimating];
//    }
//}
+(void)removeIndicator:(UIViewController*)viewcon{
    UIActivityIndicatorView* view = (UIActivityIndicatorView*)[viewcon.view viewWithTag:1000];
    if(view != nil){
        [view removeFromSuperview];
    }
}
+(void)AlertMessage:(NSString*)message Title:(NSString*)title{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    [alert show];
}
+(void)makeBorderBlackAndBackWhite:(UIView*)target{
    target.layer.borderWidth = 1;
    target.layer.borderColor = [UIColor blackColor].CGColor;
    target.layer.masksToBounds = true;
}
+(void)makeBorderASUITextField:(UIView*)target{
    target.layer.borderWidth = 1;
    target.layer.borderColor = [UIColor blackColor].CGColor;
    target.layer.cornerRadius = 4;
    target.layer.masksToBounds = true;
}
+(CGFloat)heightForView:(NSString*)text Font:(UIFont*) font Width:(CGFloat) width{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = font;
    label.text = text;
    [label sizeToFit];
    
    CGFloat height = MAX(label.frame.size.height, 21);
    return height;
}

+(NSString*)getUDID{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return uuid;
}
+(void)setDefaultBackground:(UIViewController*)viewcon{
    UIImageView* view = (UIImageView*)[viewcon.view viewWithTag:2000];
    if(view == nil){
        view = [[UIImageView alloc] initWithFrame:viewcon.view.frame];
        view.image = [UIImage imageNamed:@"bg_shopping.png"];
        
        view.center = viewcon.view.center;
        view.tag = 2000;
        [viewcon.view addSubview:view];
        [viewcon.view sendSubviewToBack:view];
    }
}
+(int)getOrientationMode{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    int mode = 4;
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        mode = 1;
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        mode = 2;
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        mode = 3;
    } else if (orientation == UIDeviceOrientationPortrait) {
        mode = 4;
    }
    return mode;
}
+(NSString*) jsonStringFromDict:(BOOL) prettyPrint Dict:(NSDictionary*)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
+(NSString*)getEncodedString:(NSString*)input{
    NSCharacterSet *URLCombinedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@" \"#%/:<>?@[\\]^`,.&'{|}\n"] invertedSet];
    
    
    NSString *path = [input stringByAddingPercentEncodingWithAllowedCharacters:URLCombinedCharacterSet];
    return  path;
}

// datepicker and time

+(NSString*)getDateFromPickerForDb:(UIDatePicker*)datePicker{
    NSDate *myDate = datePicker.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    return prettyVersion;
}
+(NSDate*)getDateFromDbString:(NSString*)string{
    
    
    NSString *str =string;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    NSDate* date = [formatter dateFromString:str];
    
    //    NSLog(@"%@",date);
    return date;
}
+(NSDate*)getLocalDateFromDbString:(NSString*)string{
    
    
    NSString *str =string;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    //    NSTimeZone* timezone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timezone];
    NSDate* date = [formatter dateFromString:str];
    
    //    NSLog(@"%@",date);
    return date;
    
}
+(NSString*)getLocalDateFromDBString:(NSString*)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    NSTimeZone *gmtTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:gmtTimeZone];
    NSDate *dateFromString = [dateFormatter dateFromString:string];
    NSLog(@"Input date as GMT: %@",dateFromString);
    
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:sourceTimeZone];
    NSString *dateRepresentation = [dateFormatter stringFromDate:dateFromString];
    NSLog(@"Date formated with local time zone: %@",dateRepresentation);
    
    return dateRepresentation;
}
+(NSString*)getGmtHour{
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    //    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate] ;
    
    NSDate* sourceDateM = [[NSDate alloc] initWithTimeInterval:-interval sinceDate:destinationDate] ;
    
    NSUInteger componentFlags =  NSCalendarUnitHour|NSCalendarUnitMinute;
    //    NSDateComponents *compoenents = [[NSCalendar currentCalendar] components:componentFlags fromDate:destinationDate];
    
    NSDateComponents *compoenents = [[NSCalendar currentCalendar]  components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:sourceDateM toDate:destinationDate options:0];
    
    NSInteger hour = [compoenents hour];
    NSInteger min = [compoenents minute];
    NSString *gmt = [NSString stringWithFormat:@"%d;%d",hour,min];
    
    return gmt;
}
+(NSString*)getCurrentTimeInGmt0{
    NSDate* sourceDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *prettyVersion = [dateFormat stringFromDate:sourceDate];
    
    return prettyVersion;
}
+(NSString*)getTimeStringFromDate:(NSDate*)sourceDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *prettyVersion = [dateFormat stringFromDate:sourceDate];
    
    return prettyVersion;
}
+(NSArray*)getIntegerArrayFromRids:(NSString*)rids{
    if (rids == nil || [rids isBlank]) {
        return nil;
    }
    NSString*mm = [rids stringByReplacingOccurrencesOfString:@";;" withString:@";"];
    if ([mm length]>=3) {
        mm = [mm substringFrom:1 to:[mm length]-1];
    }else{
        return nil;
    }
    NSArray*foo = [mm componentsSeparatedByString:@";"];
    
    return foo;
}
+(NSString*)getFormattedTimeFormPicker:(UIDatePicker*)picker{
    return @"";
}
+(int)ageFromBirthday:(NSDate *)birthdate {
    NSDate *today = [NSDate date];
    NSString*date1 = [CGlobal getTimeStringFromDate:today];
    NSString*date2 = [CGlobal getTimeStringFromDate:birthdate];
    
    int age = [[date1 substringToIndex:4] intValue] - [[date2 substringToIndex:4] intValue];
    
    //    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
    //                                       components:NSYearCalendarUnit
    //                                       fromDate:birthdate
    //                                       toDate:today
    //                                       options:0];
    return age;
}
+(NSString*)getAgoTime:(NSString*)param1 IsGmt:(BOOL)isGmt{
    NSDate*agoDate = [self getDateFromDbString:param1];
    NSDate*curDate = [NSDate date];
    
    if ([agoDate compare:curDate] != NSOrderedAscending) {
        return @"Just Now";
    }
    
    NSDateComponents *compoenents = [[NSCalendar currentCalendar]  components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:agoDate toDate:curDate options:0];
    
    
    NSInteger hour = [compoenents hour];
    NSInteger min = [compoenents minute];
    NSInteger sec = [compoenents second];
    NSString *gmt = [NSString stringWithFormat:@"%d hours %d minutes ago",hour,min];
    if (hour == 0 && min == 0) {
        gmt = @"Just Now";
    }
    
    return gmt;
}
+(NSNumber*)getNumberFromStringForCurrency:(NSString*)formatted_str{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@""];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setMaximumFractionDigits:0];
    return [numberFormatter numberFromString:formatted_str];
}
+(NSString*)getStringFromNumberForCurrency:(NSNumber*)number{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@""];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setMaximumFractionDigits:0];
    return [numberFormatter stringFromNumber:number];
}
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert Alpha:(CGFloat)alpha
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:alpha];
}
+ (void)shareText:(NSString *)text andImage:(UIImage *)image andUrl:(NSURL *)url withView:(UIView*)view withController:(UIViewController*)controller
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (text) {
        [sharingItems addObject:text];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    if (url) {
        [sharingItems addObject:url];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityController.popoverPresentationController.sourceView = view;
    }
    
    [controller presentViewController:activityController animated:YES completion:nil];
}
+ (NSString *)urlencode:(NSString*)param1 {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[param1 UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+(NSString*)timeStamp{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]*1000 ];
}

+(NSTimeInterval)timeStampInterval{
    return [[NSDate date] timeIntervalSince1970];
}
// program specific
+(void)setStyleForInput1:(UIView*)buttonView{
    if (buttonView != nil) {
        if ([buttonView isKindOfClass:[UITextField class]]) {
            UITextField*text = (UITextField*)buttonView;
            [text setTextColor:[self colorWithHexString:@"#0099cc" Alpha:1.0]];
        }else if ([buttonView isKindOfClass:[UIButton class]]) {
            UIButton*text = (UIButton*)buttonView;
            [text setTitleColor:[self colorWithHexString:@"#0099cc" Alpha:1.0] forState:UIControlStateNormal];
        }
        buttonView.layer.borderWidth = 1;
        buttonView.layer.cornerRadius = 6;
        buttonView.layer.borderColor = [[self colorWithHexString:@"#0099cc" Alpha:1.0] CGColor];
        buttonView.layer.masksToBounds = true;
    }
}
+(void)setStyleForInput2:(UIView*)viewRound View:(UIView*)viewtext Radius:(CGFloat)radius{
    if (viewRound != nil) {
        viewRound.layer.cornerRadius =radius;
        viewRound.backgroundColor = [self colorWithHexString:@"#373737" Alpha:1.0];
        viewRound.layer.borderWidth = 0;
        viewRound.layer.masksToBounds = true;
    }
    
    if(viewtext!=nil){
        if ([viewtext isKindOfClass:[UITextField class]]) {
            ((UITextField*)viewtext).textColor = [UIColor whiteColor];
        }else if([viewtext isKindOfClass:[UILabel class]]) {
            ((UILabel*)viewtext).textColor = [UIColor whiteColor];
        }else if([viewtext isKindOfClass:[UITextView class]]) {
            ((UITextView*)viewtext).textColor = [UIColor whiteColor];
        }else if([viewtext isKindOfClass:[CustomTextField class]]) {
            ((CustomTextField*)viewtext).textColor = [UIColor whiteColor];
        }
        viewtext.layer.borderWidth = 0;
        viewtext.layer.masksToBounds = true;
        viewtext.backgroundColor = [UIColor clearColor];
        
    }
}
+(void)setStyleForInput3:(UIView*)viewRound TextField:(UITextField*)textField LeftorRight:(BOOL)isLeft Radius:(CGFloat)radius SelfView:(UIView*)view{
    if (viewRound != nil) {
        if(isLeft){
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewRound.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft ) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = view.bounds;
            maskLayer.path  = maskPath.CGPath;
            viewRound.layer.mask = maskLayer;
        }else{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewRound.bounds byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight ) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = view.bounds;
            maskLayer.path  = maskPath.CGPath;
            viewRound.layer.mask = maskLayer;
        }
    }
    
    if(textField!=nil){
        textField.textColor = [UIColor whiteColor];
    }
}

+(NSString*)checkTimeForCreateBid:(NSString*)string{
    NSString*ret = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    NSDate* suggestTime = [formatter dateFromString:string];
    NSDate* currentDate = [NSDate date];
    
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:suggestTime];
    
    
    
    NSInteger hour = secondsBetween/(60*60);
    if (hour < 24) {
        NSDate* dateAfter24 = [suggestTime dateByAddingTimeInterval:24*60*60];
        
        secondsBetween = [dateAfter24 timeIntervalSinceDate:currentDate];
        
        NSInteger hour = secondsBetween/(60*60);
        secondsBetween = secondsBetween - hour*(60*60);
        NSInteger min = secondsBetween/(60);
        secondsBetween = secondsBetween - min*(60);
        NSInteger sec = secondsBetween;
        
        ret = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec];
        
    }
    
    
    return ret;
}
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)getScaledImage:(UIImage*)image Source:(UIImagePickerControllerSourceType)sourceType
{
    CGImageRef cgImage =  image.CGImage;
    
    CGFloat width = CGImageGetWidth(cgImage);
    CGFloat height = CGImageGetHeight(cgImage);
    
    if(width<640){
        return image;
    }else{
        CGFloat newSizeWidth = 640;
        CGFloat newSizeHeight = 640;
        
        CGFloat scale = width / 640.0;
        newSizeHeight = height / scale;
        
        UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
        UIImageOrientation imageOrientation = UIImageOrientationLeft;
        
        int odd = 0;
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            switch (deviceOrientation)
            {
                case UIDeviceOrientationPortrait:
                    imageOrientation = UIImageOrientationRight;
                    NSLog(@"UIImageOrientationRight");
                    odd = 1;
                    break;
                case UIDeviceOrientationPortraitUpsideDown:
                    imageOrientation = UIImageOrientationLeft;
                    NSLog(@"UIImageOrientationLeft");
                    odd = 1;
                    break;
                case UIDeviceOrientationLandscapeLeft:
                    imageOrientation = UIImageOrientationUp;
                    NSLog(@"UIImageOrientationUp");
                    
                    break;
                case UIDeviceOrientationLandscapeRight:
                    imageOrientation = UIImageOrientationDown;
                    NSLog(@"UIImageOrientationDown");
                    
                    break;
                default:
                    NSLog(@"Default");
                    imageOrientation = UIImageOrientationRight ;
                    odd = 1;
                    break;
            }
        }else{
            odd = 0;
        }
        
        if (odd == 0) {
            return [CGlobal imageWithImage:image scaledToSize:CGSizeMake(newSizeWidth, newSizeHeight)];
        }else{
            return [CGlobal imageWithImage:image scaledToSize:CGSizeMake(newSizeHeight, newSizeWidth)];
        }
        
        
    }
}

- (UIImage *)image:(UIImage *)image scaledCopyOfSize:(CGSize)newSize {
    
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    UIImageOrientation imageOrientation = UIImageOrientationLeft;
    
    switch (deviceOrientation)
    {
        case UIDeviceOrientationPortrait:
            imageOrientation = UIImageOrientationRight;
            NSLog(@"UIImageOrientationRight");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            imageOrientation = UIImageOrientationLeft;
            NSLog(@"UIImageOrientationLeft");
            break;
        case UIDeviceOrientationLandscapeLeft:
            imageOrientation = UIImageOrientationUp;
            NSLog(@"UIImageOrientationUp");
            break;
        case UIDeviceOrientationLandscapeRight:
            imageOrientation = UIImageOrientationDown;
            NSLog(@"UIImageOrientationDown");
            break;
        default:
            NSLog(@"Default");
            imageOrientation = UIImageOrientationRight ;
            break;
    }
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > newSize.width || height > newSize.height) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = newSize.width;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = newSize.height;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

+(NSURL*)urlForPath:(NSString*)param{
    NSURL* url = [NSURL URLWithString:param];
    return url;
}
+(UIImage*)getImageForMap:(UIImage*)bm NSString:(NSString*)number{
    int spellsize = 12;
    UIFont*font = [UIFont fontWithName:@"Helvetica" size:spellsize];
    CGSize textSize = [number sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat bw = textSize.width;
    CGFloat bh = textSize.height;
    float radius = 10;
    if (bw<bh) {
        radius = bh/2;
    }else{
        radius = bw/2;
    }
    radius+=5;
    
    int sm,cw,tw,th;
    sm = 1;
    cw = radius;
    tw = 60;
    th = 60;
    int dw = tw - 2*sm - cw;
    int dh = tw - 2*sm-cw;
    int thumb_width = bm.size.width;
    int thumb_height = bm.size.height;
    int realwidth,realheight;
    if (thumb_width>thumb_height){
        realwidth = dw;
        realheight = (int) (((float)realwidth/(float)thumb_width)*thumb_height);
    }else{
        realheight = dh;
        realwidth =  (int) (((float)realheight/(float)thumb_height)*thumb_width);
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tw,th), NO, 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // drawing with a white stroke color
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    // drawing with a white fill color
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, CGRectMake(0, cw, sm*2+dw, th));
    
    int cx = (dw-realwidth)/2+sm,cy = (dh-realheight)/2+sm+cw;
    CGRect dst = CGRectMake(cx,cy,realwidth,realheight);
    [bm drawInRect:dst];
    
    if ([number intValue] > 1) {
        CGRect circle_rect = CGRectMake(tw-cw*2, 0, 2*cw, 2*cw);
        CGContextSetRGBFillColor(context, 0.29, 0.60, 0.85,1.0);
        CGContextFillEllipseInRect(context, circle_rect);
        
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
        NSDictionary* dict =  [NSDictionary dictionaryWithObjectsAndKeys:
                               font, NSFontAttributeName,
                               [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        CGRect text_rect = CGRectMake((circle_rect.size.width-bw)/2+circle_rect.origin.x,(circle_rect.size.height-bh)/2+circle_rect.origin.y,bw,bh);
        [number drawInRect:text_rect withAttributes:dict];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
+(UIImage*)drawFront:(UIImage*)image text:(NSString*)text atPoint:(CGPoint)point
{
    UIFont *font = [UIFont fontWithName:@"Halter" size:21];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, (point.y - 5), image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, [attString length]);
    
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(1.0f, 1.5f);
    [attString addAttribute:NSShadowAttributeName value:shadow range:range];
    
    [attString drawInRect:CGRectIntegral(rect)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(NSMutableDictionary*)getQuestionDict:(id)targetClass{
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableDictionary *questionDict;
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [objects addObject:value];
            [keys addObject:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    if ([objects count] > 0) {
        questionDict = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    }
    
    return questionDict;
}


+(void)parseResponse:(id)targetClass Dict:(NSDictionary*)dict{
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        id value = [dict objectForKey:name];
        
        if (value!=nil && [value isKindOfClass:[NSString class]] && value != [NSNull null] ) {
            [targetClass setValue:value forKey:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    
    
}

+(NSData*)buildJsonData:(id)targetClass{
    NSData* jsonData = nil;
    
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableDictionary *questionDict;
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [objects addObject:value];
            [keys addObject:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    if ([objects count] > 0) {
        questionDict = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * error = nil;
        jsonData = [NSJSONSerialization dataWithJSONObject:questionDict options:NSJSONWritingPrettyPrinted error:&error];
        
        
        
    }
    
    return jsonData;
}
+(id)getDuplicate:(id)targetClass{
    
    id ret = [[targetClass class] alloc];
    
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [ret setValue:value forKey:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    
    return ret;
}
+ (UIImage *)scaleAndRotateImage:(UIImage *)image {
    
    int kMaxResolution = 1600; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
+ (UIImage *)ipMaskedImageNamed:(NSString *)name color:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:name];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}
+ (CGSize)getSizeForAspect:(UIImage*)image Frame:(CGSize)frame{
    CGSize size = frame;
    CGImageRef cgImage =  image.CGImage;
    
    CGFloat width = CGImageGetWidth(cgImage);
    CGFloat height = CGImageGetHeight(cgImage);
    
    CGFloat retWidth = size.width;
    
    CGFloat retHeight = retWidth/width*height;
    
    return CGSizeMake(retWidth, retHeight);
}
+ (CGSize)getSizeForAspectFromSize:(CGSize)imageSize Frame:(CGSize)frame{
    CGSize size = frame;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat retWidth = size.width;
    
    CGFloat retHeight = retWidth/width*height;
    
    return CGSizeMake(retWidth, retHeight);
}
+(void)grantedPermissionCamera:(PermissionCallback)callback{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        callback(true);
        return;
        // do your logic
    }else if(authStatus ==AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            callback(granted);
        }];
        return;
    }
    else{
        callback(false);
        return;
    }
}
+(void)grantedPermissionPhotoLibrary:(PermissionCallback)callback{
    if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){
        callback(true);
        return;
    }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            callback(status);
            return;
        }];
        return;
    }else{
        callback(false);
        return;
    }
}
+(void)grantedPermissionLocation:(PermissionCallback)callback{
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        callback(true);
        return;
        
    }else if(authorizationStatus == kCLAuthorizationStatusNotDetermined){
        CLLocationManager * manager = [[CLLocationManager alloc] init];
        [manager requestAlwaysAuthorization];
    }
}
+(UIImage*)getImageForMap:(NSString*)number{
    
    int tw = 30;
    int th = 30;
    UIImage*bm = [UIImage imageNamed:number];
    //UIImage*bm = [CGlobal getColoredImage:@"marker1.png" Color:COLOR_PRIMARY];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tw,th), NO, 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // drawing with a white stroke color
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    // drawing with a white fill color
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    //    CGContextFillRect(context, CGRectMake(0, cw, sm*2+dw, th));
    
    CGRect dst = CGRectMake(0,0,tw,th);
    [bm drawInRect:dst];
    
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
    
//    int spellsize = 12;
//    UIFont*font = [UIFont fontWithName:@"Helvetica" size:spellsize];
//    CGSize textSize = [number sizeWithAttributes:@{NSFontAttributeName:font}];
//    CGFloat bw = textSize.width;
//    CGFloat bh = textSize.height;
//    UIImage*bm = [UIImage imageNamed:@"map_pos.png"];
//    float radius = 10;
//    if (bw<bh) {
//        radius = bh/2;
//    }else{
//        radius = bw/2;
//    }
//    //radius+=5;
//    
//    int sm,cw,tw,th;
//    sm = 1;
//    cw = radius;
//    tw = 40;
//    th = 60;
//    CGPoint A = CGPointMake(5, 5);
//    CGPoint B = CGPointMake(35, 35);
//    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tw,th), NO, 2.0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    // drawing with a white stroke color
//    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
//    // drawing with a white fill color
//    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
//    //    CGContextFillRect(context, CGRectMake(0, cw, sm*2+dw, th));
//    
//    CGRect dst = CGRectMake(0,0,tw,th);
//    [bm drawInRect:dst];
//    
//    if ([number intValue] >= 1) {
//        CGRect circle_rect = CGRectMake(A.x, A.y, B.x-A.x, B.y-A.y);
//        CGContextSetRGBFillColor(context, 0.29, 0.60, 0.85,1.0);
//        CGContextFillEllipseInRect(context, circle_rect);
//        
//        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
//        NSDictionary* dict =  [NSDictionary dictionaryWithObjectsAndKeys:
//                               font, NSFontAttributeName,
//                               [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
//        
//        CGRect text_rect = CGRectMake((circle_rect.size.width-bw)/2+circle_rect.origin.x,(circle_rect.size.height-bh)/2+circle_rect.origin.y,bw,bh);
//        [number drawInRect:text_rect withAttributes:dict];
//    }
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return resultImage;
}
+(UIImage*)getColoredImage:(NSString*)imgName Color:(UIColor*)color{
    UIImage *image = [UIImage imageNamed:imgName];
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    return flippedImage;
}
+(UIImage*)getColoredImageFromImage:(UIImage*)image Color:(UIColor*)color{
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    return flippedImage;
}
+(void) setTerm:(TTTAttributedLabel*)attributedLabel{
    NSString *labelText = attributedLabel.text;
    
    NSRange r = [labelText rangeOfString:@"Terms of Use"];
    attributedLabel.linkAttributes = @{NSForegroundColorAttributeName: [CGlobal colorWithHexString:@"66cce2" Alpha:1.0],
                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    [attributedLabel addLinkToURL:[NSURL URLWithString:@"weinsahra.com/tos"] withRange:r];
}
+(BOOL) isValidEmail:(NSString*)email
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(NSString *) escapeString:(NSString *)string {
    NSRange range = NSMakeRange(0, [string length]);
    return [string stringByReplacingOccurrencesOfString:@"'" withString:@"''" options:NSCaseInsensitiveSearch range:range];
}
+(NSString*) getDateString:(NSInteger)offset{
    NSDate* date = [NSDate date];
    NSTimeInterval off_interval = 24*60*60 * offset;
    date = [date dateByAddingTimeInterval:off_interval];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
    [dateFormat setTimeZone:sourceTimeZone];
    
    NSString *datestr = [dateFormat stringFromDate:date];
    return datestr;
}
+(void)showWebView:(NSString*)title WEBVIEW:(UIWebView*)webview{
    NSString* text = [NSString stringWithFormat:@"<html><head><style type=\"text/css\">body{color:#525252;}</style></head><body>%@</body></html>",title];
    [webview loadHTMLString:text baseURL:nil];
}
+(void)clearData{
    
    
}
+(void)initGlobal{
    NSArray* array = @[@"What is your favorite Sports team?",
                       @"What is your favorite movie?",
                       @"What was your favorite sport in high school?",
                       @"What was your favorite food?",
                       @"What was your childhood nickname?",
                       @"What is the name of your favorite childhood friend?",
                       @"What was the name of the hospital where you were born?",
                       @"What is your favorite Pass Time?",
                       @"What is your favorite Car?",
                       @"What is your favorite holiday spot?",];
    g_securityList = array;
    
    c_quantity = @[@"1"
                   ,@"2"
                   ,@"3"
                   ,@"4"
                   ,@"5"
                   ,@"6"
                   ,@"7"
                   ,@"8"
                   ,@"9"
                   ,@"10"];
    
    
    c_weight = @[@" < 1 Kg"
                 ,@"1 to 3 Kgs"
                 ,@"3 to 6 Kgs"
                 ,@"6 to 10 Kgs"
                 ,@"10 to 15 Kgs"
                 ,@"15 to 20 Kgs"
                 ,@"20 to 25 Kgs"
                 ,@"25 to 30 Kgs"
                 ,@"> 30 Kgs"];
    c_weight_value = @[@"1"
                       ,@"3"
                       ,@"6"
                       ,@"10"
                       ,@"15"
                       ,@"20"
                       ,@"25"
                       ,@"30"
                       ,@"40"];
    c_packageLists = @[@"Small size Package"
                       ,@"Medium size Package"
                       ,@"Large size Package"
                       ,@"Extra Large size Package"
                       ,@"Giant size Package"];
    
    c_paymentWay = @[@"Pay using Card",
                     @"Cash on Pick up"];
    
    COLOR_PRIMARY = [CGlobal colorWithHexString:@"008080" Alpha:1.0f];
    
    PUBLISHABLE_KEY = @"pk_test_C0xTsdez4BI0rXKZp6ObLitq";
    
    c_menu_title = @[@"profile",@"quotes",@"order",@"reschedule",@"cancel",@"about",@"contact",@"feedback",@"policy",@"sign"];
    
//    g_areaData = [[LoginResponse alloc] init];
    
}

+(BOOL)validatePassword:(NSString*)password{
    NSError *error = NULL;
    NSString *pattern = @".*\\d.*";
    NSRange range = NSMakeRange(0, password.length);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:password options:NSMatchingProgress range:range];
    if ([matches count] == 0) {
        return false;
    }else{
        return true;
    }
}
+(BOOL)isPostCode:(NSString*)postcode{
    if ([postcode length] >= 4) {
        return true;
    }else{
        return false;
    }
}
+(NSString*)encrypt:(NSString*)password{
    NSData *nsdata = [password
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    NSString* ret = [base64Encoded stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return ret;
}
+(NSString*)decrypt:(NSString*)password{
    NSData *nsdata = [[NSData alloc] initWithBase64EncodedString:password options:0];
    
    // Get NSString from NSData object in Base64
    NSString *decode = [[NSString alloc] initWithData:nsdata encoding:NSUTF8StringEncoding];;
    
    NSString* ret = [decode stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return ret;
}
+(void)getImageFromPath:(NSString*)path CallBack:(ImagePickerCallback)callBack{
    NSData* pngData = [NSData dataWithContentsOfFile:path];
    if (pngData!=nil) {
        UIImage *image = [UIImage imageWithData:pngData];
        callBack(image);
        return;
    }
    NSURL* url = [NSURL URLWithString:path];
    pngData = [NSData dataWithContentsOfURL:url];
    if (pngData!=nil) {
        UIImage *image = [UIImage imageWithData:pngData];
        callBack(image);
        return;
    }
    PHFetchResult<PHAsset *> *asset = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
    if (asset.firstObject!=nil) {
        PHImageManager* manager = [PHImageManager defaultManager];
        [manager requestImageDataForAsset:asset.firstObject options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            UIImage *image = [UIImage imageWithData:imageData];
            callBack(image);
        }];
    }else{
        callBack(nil);
        return;
    }
}
+(NSString*)getDeviceID{
    NSString* idd = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return idd;
}
+(NSString*)getDeviceName{
    NSString* idd = [UIDevice currentDevice].name;
    return idd;
}
+(NSComparisonResult)compareWithToday:(NSDate*)input DateStr:(NSString*)datestr mode:(int)mode{
    switch (mode) {
        case 2:{
            // date time
            
            NSDate*curDate = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm"];
            NSString *curStr = [dateFormat stringFromDate:curDate];
            
            //[dateFormat setDateFormat:@"hh:mm"];
            NSString* inputStr = [dateFormat stringFromDate:input];;
            
            return [curStr compare:inputStr];
        }
        case 1:
        {
            // time
            NSDate*curDate = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm"];
            NSString *curStr = [dateFormat stringFromDate:curDate];
            
            [dateFormat setDateFormat:@"hh:mm"];
            NSString* inputStr = [NSString stringWithFormat:@"%@ %@",datestr,[dateFormat stringFromDate:input]];
            
            return [curStr compare:inputStr];
        }
        default:{
            // 0
            //date
            NSDate*curDate = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyyMMdd"];
            NSString *curStr = [dateFormat stringFromDate:curDate];
            
            NSString* inputStr = [dateFormat stringFromDate:input];
            
            return [curStr compare:inputStr];
            
        }
            
    }
}
//+(UIImage*)customImageForMap:(NSString*)role PolyData:(TblPolygon*)polygon{
//    NSString* image = "0"
//    int spellsize = 8;
//    UIFont*font = [UIFont fontWithName:@"Helvetica" size:spellsize];
//    CGSize textSize = [number sizeWithAttributes:@{NSFontAttributeName:font}];
//    CGFloat bw = textSize.width;
//    CGFloat bh = textSize.height;
//    UIImage*bm = [UIImage imageNamed:@"map_pos.png"];
//    float radius = 10;
//    if (bw<bh) {
//        radius = bh/2;
//    }else{
//        radius = bw/2;
//    }
//    //radius+=5;
//
//    int sm,cw,tw,th;
//    sm = 1;
//    cw = radius;
//    tw = 20;
//    th = 30;
//    CGPoint A = CGPointMake(2, 2);
//    CGPoint B = CGPointMake(17, 17);
//
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tw,th), NO, 1.0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    // drawing with a white stroke color
//    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
//    // drawing with a white fill color
//    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
//    //    CGContextFillRect(context, CGRectMake(0, 0, tw*2, th*2));
//
//    //    CGRect dst = CGRectMake(tw,0,tw,th);
//    CGRect dst = CGRectMake(0,0,tw,th);
//    [bm drawInRect:dst];
//
//    if ([number intValue] >= 1) {
//        CGRect circle_rect = CGRectMake(A.x, A.y, B.x-A.x, B.y-A.y);
//        CGContextSetRGBFillColor(context, 0.29, 0.60, 0.85,1.0);
//        CGContextFillEllipseInRect(context, circle_rect);
//
//        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
//        NSDictionary* dict =  [NSDictionary dictionaryWithObjectsAndKeys:
//                               font, NSFontAttributeName,
//                               [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
//
//        CGRect text_rect = CGRectMake((circle_rect.size.width-bw)/2+circle_rect.origin.x,(circle_rect.size.height-bh)/2+circle_rect.origin.y,bw,bh);
//        [number drawInRect:text_rect withAttributes:dict];
//    }
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return resultImage;
//}
+(void)getVideoInfo:(TblPost*)post CallBack:(VideoInfoCallBack)callback{
    NSMutableDictionary*data = [[NSMutableDictionary alloc] init];
    if ([post.m_video_id length] == 0) {
        callback(post,data,false);
        return;
    }
    if([post.m_video_type intValue] == 0){
        // vimoe
        [[YTVimeoExtractor sharedExtractor]fetchVideoWithIdentifier:post.m_video_id withReferer:@"https://www.mobilitywod.com/" completionHandler:^(YTVimeoVideo * _Nullable video, NSError * _Nullable error) {
            
            if (video) {
                
                NSDictionary* dict = video.thumbnailURLs;
                
                
                NSString* str = dict[[NSNumber numberWithLong:0]];
                
                NSString *urlStr =[NSString stringWithFormat:@"%@", str];
//                post.m_video_thumb = urlStr;
                
                NSURL *highQualityURL = [video lowestQualityStreamURL];
                NSLog(@"vimeo video path %@...", highQualityURL);
                
                post.m_video_path = [highQualityURL absoluteString];
                
                data[@"thumb_path"] =urlStr;
                
                callback(post,data,true);
            }else{
                post.m_error_desc = error.localizedDescription;
                post.m_error_reason = error.localizedFailureReason;
                callback(post,data,false);
            }
            
        }];
        
    }else{
        // youtube
        NSString* url = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", post.m_video_id];
//        post.m_video_thumb = url;
        
        NSLog(@"youtube thumb %@",url);
        data[@"thumb_path"] =url;
        callback(post,data,true);
    }
    
}
+(BOOL)isIphone
{
    NSString* source = [[UIDevice currentDevice] model];
    return !([source rangeOfString:@"iPad" options:NSCaseInsensitiveSearch].length > 0);
    
}
@end
