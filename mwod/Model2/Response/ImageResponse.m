//
//  ImageResponse.m
//  simpleupload
//
//  Created by BoHuang on 7/26/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ImageResponse.h"
#import "BaseModel.h"

@implementation ImageResponse

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"ValidationErrors"];
        if (obj!=nil && obj!= [NSNull null]) {
            if ([obj isKindOfClass:[NSArray class]]) {
                NSArray* array = obj;
                self.ValidationErrors = [[NSMutableArray alloc] init];
                for (int i=0; i<array.count; i++) {
                    [self.ValidationErrors addObject:array[i]];
                }
            }
        }
        [self checkResponse];
        
    }
    return self;
}
-(void)checkResponse{
    self.isValidResponse = false;
    if ([self.Status length]>0 && [[self.Status lowercaseString] isEqualToString:@"passed"]) {
        self.isValidResponse = true;
    }
}
@end
