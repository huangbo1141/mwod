//
//  AppDelegate.m
//  mwod
//
//  Created by BoHuang on 10/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DemoViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "UIDeviceHardware.h"

@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    g_isii = false;
    [self initService];
    [self calcBoxSize];
    
    EnvVar* env = [CGlobal sharedId].env;
    
    if(env.lastLogin>0){
        [self goMain];
    }else{
        [self defaultHome];
    }
    
    return YES;
}
-(void) initService{
    // Register the supported interaction types.
    
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    
    
    // Register for remote notifications.
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
-(void)calcBoxSize{
    
    CGFloat sample_w = 300;
    CGFloat sample_h = 167;
    NSString* model = [UIDevice currentDevice].model;
    NSString*platform = [UIDeviceHardware platform];
    NSString*platformString = [UIDeviceHardware platformString];
    
    g_l1_top = 8;
    g_l2_top = 8;
    g_l1_top_logined = 16;
    g_l2_top_logined = 16;
    CGRect rt = [UIScreen mainScreen].bounds;
    if([CGlobal isIphone]){
//        iphone x              width 375.000000 height 812.000000
//        iphone 6              width 375.000000 height 667.000000
//        iphone 6 plus         width 414.000000 height 736.000000
//        iphone 7              width 375.000000 height 667.000000
//        iphone 7 plus         width 414.000000 height 736.000000

        CGFloat width_iphone6 = 375             ,height_iphone6 = 667;
        CGFloat width_iphone6_plus = 414        ,height_iphone6_plus = 736;
        CGFloat width_iphonex = 375             ,height_iphonex = 812;
        
        g_thumb_w =270;
        g_thumb_w_logined = 270;
        g_font_welcome = 18;
        
        g_font_title = 32 ;
        g_font_subtitle = 16 ;
        g_font_title_logined = 32;
        g_font_subtitle_logined = 16;
        // condition part for label top align
        if (rt.size.height<=667) {
            // attemp to detect model below iphone 6 , height bases , to align label
            g_l1_top_logined = 0;
            g_l2_top_logined = 0;
            
            g_l1_top = -4;
            g_l2_top = -4;
        }else{
            // this is where height is over 667  ,  iphone 6 model width  = 375 height 667
            // so this is where above iphone 6 (exclude iphone 6)
            g_l1_top_logined = 8;
            g_l2_top_logined = 8;
        }
        
        
        // condition part for determine video thumb width
        if ( rt.size.width>width_iphone6 && rt.size.height>height_iphone6 ) {
            // above iphone6 size ( > )
            // iphone 6 plus , 7 plus , 8 plus
            g_thumb_w = 270;
            g_thumb_w_logined = 300;
        }else{
            // iphone 6 , 5 , 5s , iphone x
            g_thumb_w = 270;
            g_thumb_w_logined = 270;
        }
        
        
        if (rt.size.width == width_iphonex && rt.size.height == height_iphonex) {
            // iphone x
            g_l1_top_logined = 16;
            g_l2_top_logined = 16;
        }
        
    }else{
        // ipad
        //  ipad air 2       width 768.000000 height 1024.000000
        //  ipad air        width 768.000000 height 1024.000000
        //  ipad pro 12.9 inch        width 1024.000000 height 1366.000000
        NSDictionary* dict = @{@"ipad_pro_12_9":@[@"1024",@"1366"],@"ipad_air2":@[@"768",@"1024"],@"ipad_air":@[@"768",@"1024"]};
        for (NSString* model in dict) {
            NSArray* pts = dict[model];
            CGFloat width = [pts[0] floatValue];
            CGFloat height = [pts[1] floatValue];
            if ((rt.size.width == width && rt.size.height == height)||(rt.size.width == height && rt.size.height == width) ) {
                self.model = model;
            }
        }
        
        g_font_welcome = 23;
        
        g_font_title = 48 ;
        g_font_subtitle = 24 ;
        g_font_title_logined = 44;
        g_font_subtitle_logined = 22;
        
        g_l1_top = 9;
        g_l2_top = 9;
        g_l1_top_logined = 16;
        g_l2_top_logined = 16;
        //g_thumb_w = rt.size.width*0.7;
        g_thumb_w = 500;
        g_thumb_w_logined = 500;
        if (rt.size.width/2>600) {
            g_thumb_w_land = 500;
            g_thumb_w_logined_land = 500;
            
            g_thumb_w = 500;
        }else{
            g_thumb_w_land = 450;
            g_thumb_w_logined_land = 450;
            
            g_thumb_w = 450;
        }
        g_l1_top_logined_land = g_l1_top_logined + 75;
        g_l2_top_logined_land = g_l2_top_logined+ 75;
        g_l1_top_land = g_l1_top + 20;
        g_l2_top_land = g_l2_top + 20;
        
        if (self.model!=nil) {
            if([self.model isEqualToString:@"ipad_pro_12_9"]){
                g_thumb_w       = 700;
                g_thumb_w_land  = 640;
                
                g_thumb_w_logined       = 720;
                g_thumb_w_logined_land  = 660;
                
                g_l1_top_logined_land = g_l1_top_logined + 70;
                g_l2_top_logined_land = g_l2_top_logined+ 70;
                g_l1_top_land = g_l1_top + 50;
                g_l2_top_land = g_l2_top + 50;
            }
        }
        if (g_isii) {
            g_thumb_w = 300;
            g_thumb_w_logined = 300;
        }
    }
    
    g_thumb_h = g_thumb_w/sample_w*sample_h;
    g_thumb_h_logined = g_thumb_w_logined/sample_w*sample_h;
    g_thumb_h_land = g_thumb_w_land/sample_w*sample_h;
    g_thumb_h_logined_land = g_thumb_w_logined_land/sample_w*sample_h;
    NSLog(@"%@ %@ %@",model,platform,platformString);
    NSLog(@"g_l1_top = %f g_l2_top = %f",g_l1_top,g_l2_top);
    NSLog(@"g_thumb_w = %d g_thumb_h = %d",g_thumb_w,g_thumb_h);
    NSLog(@"g_thumb_w_land = %d g_thumb_h_land = %d",g_thumb_w_land,g_thumb_h_land);
    NSLog(@"width %f height %f",rt.size.width,rt.size.height);
    
    if (self.model!=nil) {
        NSLog(@"model",self.model);
    }
}
-(void)goMain{
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController*vc = [ms instantiateViewControllerWithIdentifier:@"CMainNav"] ;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.window.rootViewController = vc;
    });
}
-(void)defaultHome{
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController*vc = [ms instantiateViewControllerWithIdentifier:@"CDefaultNav"] ;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.window.rootViewController = vc;
    });
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //    [GlobalVars sharedInstance].g_userInfo.token = [NSString stringWithFormat:@"%@", newToken];
    NSLog(@"My token is: %@", newToken);
    
    [CGlobal sharedId].uuid = newToken;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RECEIVEUUID object:nil];
    

    [self registerDeviceUUID];
    
    //    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:newToken delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //  [alert show];
    // Store the deviceToken in the current installation and save it to Parse.
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"didReceiveRemoteNotification");
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler{
    
    NSLog(@"forRemoteNotification");
}
-(void)registerDeviceUUID{
    if ([[CGlobal sharedId].uuid length]>10) {
        EnvVar* env = [CGlobal sharedId].env;
        NSMutableDictionary*dict = [[NSMutableDictionary alloc] init];
        dict[@"device_token"] = [CGlobal sharedId].uuid;
        dict[@"device_type"] = @"ios";
        if ([env.nickname length]>0) {
            dict[@"device_info"] = env.nickname;
        }
        if (env.lastLogin>0) {
            dict[@"user_id"] = [NSString stringWithFormat:@"%d",env.lastLogin];
            dict[@"channels_id"] = @"2";
        }
        NetworkParser* manager = [NetworkParser sharedManager];
        [manager ontemplateGeneralRequest:dict Path:@"/push/savetoken/" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (dict!=nil) {
                NSLog(@"%@",dict);
            }
        } method:@"POST"];
    }
}
-(void)unRegisterDeviceUUID{
    if ([[CGlobal sharedId].uuid length]>10) {
        EnvVar* env = [CGlobal sharedId].env;
        NSMutableDictionary*dict = [[NSMutableDictionary alloc] init];
        dict[@"device_token"] = [CGlobal sharedId].uuid;
        dict[@"device_type"] = @"ios";
        if ([env.nickname length]>0) {
            dict[@"device_info"] = env.nickname;
        }
        if (env.lastLogin>0) {
            dict[@"user_id"] = [NSString stringWithFormat:@"%d",env.lastLogin];
        }
        NetworkParser* manager = [NetworkParser sharedManager];
        [manager ontemplateGeneralRequest:dict Path:@"/push/deletetoken/" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (dict!=nil) {
                NSLog(@"%@",dict);
            }
        } method:@"POST"];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
