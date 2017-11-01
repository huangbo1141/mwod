//
//  BaseCollectionViewCell.m
//  mwod
//
//  Created by BoHuang on 10/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell
-(void)setData:(NSDictionary*)data{
    self.vc = data[@"vc"];
    self.aDelegate = data[@"aDelegate"];
    self.indexPath = data[@"indexPath"];
    self.collectionView = data[@"collectionView"];
    self.model = data[@"model"];
    
    self.inputData = data;
    
}
- (IBAction)clickEntireCell:(id)sender {
    if (self.aDelegate!=nil) {
        NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
        data[@"indexPath"] = self.indexPath;
        data[@"inputData"] = self.inputData;
        data[@"model"] = self.model;
        
        [self.aDelegate didSubmit:data View:self.collectionView];
    }
}
@end
