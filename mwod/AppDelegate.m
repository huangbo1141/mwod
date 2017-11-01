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

@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initService];
    EnvVar* env = [CGlobal sharedId].env;
    g_isii = true;
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
-(void)registerDeviceUUID{
//    if ([CGlobal sharedId].curUser != nil && [CGlobal sharedId].uuid!=nil) {
//
//    }
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
        [manager ontemplateGeneralRequest:dict Path:@"/push/savetoken/" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
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
