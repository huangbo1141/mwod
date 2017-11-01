//
//  ImageResponse.h
//  simpleupload
//
//  Created by BoHuang on 7/26/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageResponse : NSObject
@property (copy, nonatomic) NSString* Photo ;
@property (copy, nonatomic) NSString* Status ;
@property (strong, nonatomic) NSMutableArray* ValidationErrors ;

@property (copy, nonatomic) NSString* action ;
@property (assign, nonatomic) BOOL isValidResponse;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
