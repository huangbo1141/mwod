//
//  TblPost.m
//  mwod
//
//  Created by BoHuang on 10/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TblPost.h"
#import "BaseModel.h"
#import "CGlobal.h"
@implementation TblPost

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"a_attachment"];
        if (obj!=nil && obj!= [NSNull null] && [obj isKindOfClass:[NSMutableArray class]]) {
            self.a_attachment = [[NSMutableArray alloc] init];
            NSArray* array = obj;
            for (int i=0; i<array.count; i++) {
                id irow = array[i];
                if([irow isKindOfClass:[NSString class]]){
                    [self.a_attachment addObject:irow];
                }
            }
            if(self.a_attachment.count>0){
                self.m_video_thumb = self.a_attachment[0];
            }
        }
        
        if (self.m_video_type!=nil && [self.m_video_type isKindOfClass:[NSString class]] && [self.m_video_type intValue] == 1) {
            // youtube
            self.m_video_thumb = nil;
        }
    }
    return self;
}
@end
