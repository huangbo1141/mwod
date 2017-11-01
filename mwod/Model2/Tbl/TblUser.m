//
//  TblUser.m
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "TblUser.h"
#import "BaseModel.h"
#import "CGlobal.h"

@implementation TblUser

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
                
    }
    return self;
}

@end
