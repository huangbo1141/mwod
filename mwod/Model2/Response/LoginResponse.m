//
//  LoginResponse.m
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "LoginResponse.h"
#import "BaseModel.h"
#import "TblPost.h"
@implementation LoginResponse

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"user"];
        if (obj!=nil && obj!= [NSNull null]) {
            self.user = [[TblUser alloc] initWithDictionary:obj];
        }
        
        obj = dict[@"daily"];
        if (obj!=nil && obj!= [NSNull null] && [obj isKindOfClass:[NSArray class]]) {
            NSArray* array = obj;
            self.daily = [[NSMutableArray alloc] init];
            for (int i=0; i<array.count; i++) {
                id idict = array[i];
                TblPost* ipost = [[TblPost alloc] initWithDictionary:idict];
                [self.daily addObject:ipost];
            }
        }
        
        obj = dict[@"episodes"];
        if (obj!=nil && obj!= [NSNull null] && [obj isKindOfClass:[NSArray class]]) {
            NSArray* array = obj;
            self.episodes = [[NSMutableArray alloc] init];
            for (int i=0; i<array.count; i++) {
                id idict = array[i];
                TblPost* ipost = [[TblPost alloc] initWithDictionary:idict];
                [self.episodes addObject:ipost];
            }
        }
    }
    return self;
}

@end
