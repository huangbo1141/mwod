//
//  TblUser.h
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TblUser : NSObject

@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* user_login;
@property (nonatomic,copy) NSString* user_pass;
@property (nonatomic,copy) NSString* user_nicename;
@property (nonatomic,copy) NSString* user_email;
@property (nonatomic,copy) NSString* user_url;
@property (nonatomic,copy) NSString* user_registered;
@property (nonatomic,copy) NSString* user_activation_key;
@property (nonatomic,copy) NSString* user_status;
@property (nonatomic,copy) NSString* display_name;
@property (nonatomic,copy) NSString* avatar;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
