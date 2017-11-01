//
//  LoginResponse.h
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TblUser.h"

@interface LoginResponse : NSObject

@property (strong, nonatomic) TblUser* user;


@property (strong, nonatomic) NSMutableArray* daily ;
@property (strong, nonatomic) NSMutableArray* episodes ;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
