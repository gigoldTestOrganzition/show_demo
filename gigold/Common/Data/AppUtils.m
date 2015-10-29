//
//  AppUtils.m
//  鲜生
//
//  Created by liu.wei on 8/20/13.
//  Copyright (c) 2013 王 苏诚. All rights reserved.
//

#import "AppUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"

@implementation AppUtils
AppUtils* mAppUtil = nil;
NSUserDefaults *defaults = nil;

+ (AppUtils*)shareAppUtils {
    if (mAppUtil == nil) {
        mAppUtil = [[AppUtils alloc] init];
        defaults = [NSUserDefaults standardUserDefaults];
    }
    return mAppUtil;


}

-(id)init {
    return [super init];
}



- (void)saveAccount:(NSString*)obj {
    if (defaults && obj)
    {
        [defaults setObject:obj forKey:@"username"];
        [defaults synchronize];
    }
}

- (NSString*)getAccount {
    if (defaults)
    {
        NSString *obj = [defaults objectForKey:@"username"];
        return obj ? obj : @"";
    }
    return nil;
}

- (void)savePassword:(NSString*)obj {
    if (defaults && obj)
    {
        [defaults setObject:obj forKey:@"password"];
        [defaults synchronize];
    }
}

- (NSString*)getPassword {
    if (defaults)
    {
        NSString *obj = [defaults objectForKey:@"password"];
        return obj ? obj : @"";
    }
    return nil;
}

- (void)saveUserId:(NSString*)obj {
    if (defaults && obj)
    {
        [defaults setObject:obj forKey:@"userid"];
        [defaults synchronize];
    }
}

- (NSString*)getUserId {
    if (defaults)
    {
        NSString *obj = [defaults objectForKey:@"userid"];
        return obj ? obj : @"";
    }
    return nil;
}

-(void)saveIsFirstRun:(BOOL)firstRun {
    if (defaults)
    {
        [defaults setObject:firstRun?@"YES":@"NO" forKey:@"IsFirstRun"];
        [defaults synchronize];
    }
}

-(BOOL)getIsFirstRun {
    if (defaults)
    {
        NSString *firstRun = [defaults stringForKey:@"IsFirstRun"];
        return (firstRun == nil) || (firstRun && [firstRun isEqual:@"YES"]);
    }
    return NO;
}


-(void)saveIsLogin:(BOOL)login{
    if (defaults)
    {
        [defaults setObject:login?@"YES":@"NO" forKey:@"IsLogin"];
        [defaults synchronize];
    }
}

-(BOOL)getIsLogin{
    if (defaults)
    {
        NSString *login = [defaults stringForKey:@"IsLogin"];
        return  (login && [login isEqual:@"YES"]);
    }
    return NO;
}

-(void)saveTokenId:(NSString*)tokenId{
    if (defaults)
    {
        [defaults setObject:tokenId?tokenId:@"" forKey:@"tokenId"];
        [defaults synchronize];
    }
}
-(NSString*)getTokenId{
    if (defaults)
    {
        return  [defaults stringForKey:@"tokenId"];
    }
    return nil;
}

//记录常用登录的账号
-(void)saveHistoricalAccount:(NSString *)obj andKey:(NSString*)key{
    if (defaults)
    {
        NSMutableDictionary* historicalAccount = [self getHistoricalAccount];
        if (!historicalAccount) {
            historicalAccount = [NSMutableDictionary dictionary];
        }
        
        [historicalAccount setValue:obj ? obj : @"" forKey:key];
        [defaults setValue:historicalAccount forKey:@"HistoricalAccount"];
        [defaults synchronize];
    }
}

-(NSMutableDictionary*)getHistoricalAccount{
    if (defaults)
    {
        NSMutableDictionary *obj = [NSMutableDictionary dictionaryWithDictionary:[defaults dictionaryForKey:@"HistoricalAccount"]];
        return obj ? obj : [NSMutableDictionary dictionary];
    }
    return nil;
}


- (NSString*)getVersion {
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    return versionNum;
}

- (NSDate*)getYestoday {
    return [NSDate dateWithTimeInterval:0-24*60*60 sinceDate:[NSDate date]];
}

- (NSDate*)getToday {
    
    //    NSDateFormatter *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    //    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    //    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    //    NSString *today = [NSString stringWithFormat:@"%4d-%02d-%02d 23:59:59", [dateComponent year], [dateComponent month], [dateComponent day]];
    //    return [dateformatter dateFromString:today];
    return [NSDate date];
}

- (NSDate*)getTomorrow {
    
    //    NSDateFormatter *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    //    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    //    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    //    NSString *today = [NSString stringWithFormat:@"%4d-%02d-%02d 23:59:59", [dateComponent year], [dateComponent month], [dateComponent day]];
    //    return [NSDate dateWithTimeInterval:24*60*60 sinceDate:[dateformatter dateFromString:today]];
    return [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
}

- (NSDate*)getFuture {
    
    //    NSDateFormatter *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    //    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    //    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    //    NSString *today = [NSString stringWithFormat:@"%4d-%02d-%02d 23:59:59", [dateComponent year], [dateComponent month], [dateComponent day]];
    //    return [NSDate dateWithTimeInterval:24*60*60*7 sinceDate:[dateformatter dateFromString:today]];
    return [NSDate dateWithTimeInterval:24*60*60*7 sinceDate:[NSDate date]];
}

- (NSComparisonResult)compareDate:(NSDate*)date withOther:(NSDate*)other {
    NSDate *one = [self getDateByRefer:date];
    NSDate *two = [self getDateByRefer:other];
    return [one compare:two];
}

- (NSDate*)getDateByRefer:(NSDate*)date {
    if (!date)
        return nil;
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    NSString *today = [NSString stringWithFormat:@"%4ld-%02ld-%02ld 23:59:59", (long)[dateComponent year], (long)[dateComponent month], (long)[dateComponent day]];
    return [dateformatter dateFromString:today];
}

- (NSString*)getDateString:(NSDate*)date withFormat:(NSString*)format {
    if (!date || !format)
        return nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}

- (NSDate*)getDateWithString:(NSString*)string withFormat:(NSString*)format{
    if (!string || !format){
        return nil;
    }
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:format];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    return inputDate;
}

//算个时间
- (NSString *)getCalcDaysFromBegin:(NSDate *)date
{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    NSString *dateStr = [[AppUtils shareAppUtils] getDateString:date withFormat:@"HH:mm"];
    if ([dateString isEqualToString:todayString])
    {
        return dateStr;
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return [NSString stringWithFormat:@"昨天 %@",dateStr];
    }else
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags0 = NSYearCalendarUnit;
        NSDateComponents *dateComponent0 = [calendar components:unitFlags0 fromDate:date];
        NSInteger year = [dateComponent0 year];
        NSUInteger unitFlags = NSMonthCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
        NSInteger month = [dateComponent month];
        NSUInteger unitFlags1 = NSCalendarUnitDay;
        NSDateComponents *dateComponent1 = [calendar components:unitFlags1 fromDate:date];
        NSInteger day = [dateComponent1 day];
        return  [NSString stringWithFormat:@"%ld年%ld月%ld日 %@",(long)year,(long)month,(long)day,dateStr];
    }
}


- (void)showAlert:(NSString*)text {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                     message:text
                                                    delegate:nil
                                           cancelButtonTitle:@"知道了"
                                           otherButtonTitles:nil];
    [alert show];
}

-(void)showHUD:(NSString*)text andView:(UIView*)view
{
    if ([text isKindOfClass:[NSNull class]]) {
        text = @"";
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    [view addSubview:hud];
    hud.customView = [[UIView alloc] init] ;
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    [hud show:YES];
    [hud hide:YES afterDelay:0.3];
}


- (void)outerOpenAppWithIdentifier:(NSString *)appId {
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", appId];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)openAppWithIdentifier:(NSString *)appId andOwner:(UIViewController*)vc{
    
    //    if ([[[UIDevice currentDevice]systemVersion] floatValuze] < 6.0){
    [self outerOpenAppWithIdentifier:appId];
    return;
    //    }
    
//    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
//    storeProductVC.delegate = self;
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
//    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
//        if (result) {
//            [vc presentViewController:storeProductVC animated:YES completion:^{}];
//        }
//    }];
}

-(void)outerOpenAppGoCommentWithAppId:(NSString*)appId{
    NSString *evaluateString = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appId];
    BOOL bol =[[UIApplication sharedApplication] openURL:[NSURL URLWithString:evaluateString]];
    if (!bol){
        UIAlertView* alerVeiw = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"无法打开APPStore 评论界面" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alerVeiw show];
    }
}

-(void)openAppGoCommentWithAppId:(NSString*)appId andOwner:(UIViewController*)vc{
    if ([[[UIDevice currentDevice]systemVersion] floatValue] < 6.0){
        [self outerOpenAppGoCommentWithAppId:appId];
        return;
    }
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    //设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = self;
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:
     //appId唯一的
     @{SKStoreProductParameterITunesItemIdentifier :appId} completionBlock:^(BOOL result, NSError *error) {
         //block回调
         if(error){
             NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
             UIAlertView* alerVeiw = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"无法打开APPStore 评论界面" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
             [alerVeiw show];
         }else{
             //模态弹出appstore
             [vc presentViewController:storeProductViewContorller animated:YES completion:^{
             }
              ];
         }
     }];
}


- (BOOL)validateEmail:(NSString *)candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
//    NSString * MOBILE = @"^((\\+)?86)?1(3|4|5|7|8)\\d{9}$";
    //手机验证  只验证11位纯数字
    NSString * MOBILE = @"^\\d{11}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

- (BOOL)validatePhone:(NSString *)phoneNum
{
    NSString * phone = @"(^(\\d{7,8})$)|(^\\((\\d{3,4})\\)(\\d{7,8})$)|(^(\\d{3,4})-(\\d{7,8})$)|(^(\\d{3,4})(\\d{7,8})$)|(^(\\d{3,4})(\\d{7,8})-(\\d{1,4})$)|(^(\\d{3,4})-(\\d{7,8})-(\\d{1,4})$)|(^\\((\\d{3,4})\\)(\\d{7,8})-(\\d{1,4})$)|(^(\\d{7,8})-(\\d{1,4})$)|(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)";
    
    NSPredicate *regextestphone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    
    return [regextestphone evaluateWithObject:phoneNum];
}



- (BOOL)cameraEnbled{
    BOOL result = YES;
    if (IS_IOS_7){
        result = NO;
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        NSLog(@"status%ld",(long)status);
        if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined){
            result = YES;
        }
    }
    return result;
}
-(BOOL)AudioEnbled{
    BOOL result = YES;
    if (IS_IOS_7){
        result = NO;
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:
                                        AVMediaTypeAudio];
        NSLog(@"status%ld",(long)status);
        if (status == AVAuthorizationStatusAuthorized || status == AVAuthorizationStatusNotDetermined){
            result = YES;
        }
    }
    return result;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

- (NSString *)encryptMoblieNumber:(NSString*)str{
    if (str.length >= 11) {
        NSMutableString* newMoblie = [NSMutableString stringWithString:str];
        [newMoblie replaceCharactersInRange:NSMakeRange(3, 5) withString:@"***"];
        return newMoblie;
    }else{
        return str;
    }
}

- (BOOL)validateLoginPassword:(NSString*)password{
    NSString * regex = @"^[A-Za-z0-9]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

-(void)saveIsPayPwd:(BOOL)isPayPwd {
    if (defaults)
    {
        [defaults setBool:isPayPwd forKey:@"isPayPwd"];
        [defaults synchronize];
    }
}

-(BOOL)getIsPayPwd {
    if (defaults)
    {
        BOOL isPayPwd = [defaults boolForKey:@"isPayPwd"];
        return isPayPwd;
    }
    return NO;
}


@end
