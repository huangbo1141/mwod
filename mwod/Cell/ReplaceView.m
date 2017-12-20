//
//  ReplaceView.m
//  mwod
//
//  Created by q on 11/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ReplaceView.h"
#import "CGlobal.h"

@implementation ReplaceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setData:(TblPost *)post{
    NSLog(@"%@",post.m_video_thumb);
    self.lblTitle.text = post.post_title;
    self.imageContent.image = post.m_img_origin;
    if ([post.post_title length] >  0) {
        self.viewTitle.hidden = false;
    }else{
        self.viewTitle.hidden = true;
    }
}
-(UIImage *)myScreenShot{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(self.frame.size);
    }
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //[self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    if (imageData) {
        return image;
    } else {
        NSLog(@"error while taking screenshot");
        return nil;
    }
}
@end
