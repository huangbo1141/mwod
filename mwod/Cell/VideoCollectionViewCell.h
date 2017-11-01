//
//  VideoCollectionViewCell.h
//  mwod
//
//  Created by BoHuang on 10/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionViewCell.h"
@interface VideoCollectionViewCell : BaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageContent;
@property (weak, nonatomic) IBOutlet UIImageView *imagePlay;
@property (weak, nonatomic) IBOutlet UIView *viewPlay;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void)setData:(NSDictionary *)data;
@end
