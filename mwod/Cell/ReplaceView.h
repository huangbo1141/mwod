//
//  ReplaceView.h
//  mwod
//
//  Created by q on 11/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TblPost.h"
@interface ReplaceView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageContent;
@property (weak, nonatomic) IBOutlet UIImageView *imagePlay;
@property (weak, nonatomic) IBOutlet UIView *viewPlay;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *viewTitle;

-(void)setData:(TblPost *)post;
-(UIImage *)myScreenShot;
@end
