//
//  AppDelegate.h
//  mwod
//
//  Created by BoHuang on 10/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) NSString* model;

-(void)goMain;
-(void)defaultHome;
-(void)registerDeviceUUID;
-(void)unRegisterDeviceUUID;
@end

