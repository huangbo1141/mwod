//
//  VideoCollectionViewCell.m
//  mwod
//
//  Created by BoHuang on 10/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "VideoCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TblPost.h"
#import "CGlobal.h"
#import <UIImage+FX.h>

@implementation VideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
//    self.imageContent.contentMode = UIViewContentModeScaleAspectFit;
    [self addShadow:self.rootView Color:@"000000"];
}
-(void)setData:(NSDictionary *)data{
    [super setData:data];
    self.viewPlay.hidden = true;
    _viewTitle.hidden = true;
    self.activityIndicator.hidden = true;
    if ([self.model isKindOfClass:[TblPost class]]) {
        self.activityIndicator.hidden = false;
        [self.activityIndicator startAnimating];
        TblPost *post = self.model;
        NSLog(@"%@",post.m_video_thumb);
        self.lblTitle.text = post.post_title;
        
        if ([post.m_video_thumb length]>0) {
            [self setImageData:post];
        }else{
            [CGlobal getVideoInfo:post CallBack:^(TblPost *post,NSMutableDictionary*data, BOOL ret) {
                if (ret) {
                    post.m_video_thumb = data[@"thumb_path"];
                    [self setImageData:post];
                }
                
            }];
        }
        
    }
    
}
-(void)setImageData:(TblPost*)post{
    UIImage*place=[[UIImage alloc] init];
    [_imageContent sd_setImageWithURL:[NSURL URLWithString:post.m_video_thumb]
                     placeholderImage:place
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                self.viewPlay.hidden = false;
                                [self.activityIndicator stopAnimating];
                                self.activityIndicator.hidden = true;
                                if ([post.post_title length]>0) {
                                    _viewTitle.hidden = false;
                                }else{
                                    _viewTitle.hidden = true;
                                }
                                NSLog(@"logged");
                            }];
//    if (post.m_img_origin_reflect!=nil) {
//        self.viewPlay.hidden = false;
//        [self.activityIndicator stopAnimating];
//        self.activityIndicator.hidden = true;
//        //_imageContent.image = post.m_img_origin_reflect;
//        _imageContent.image = post.m_img_origin;
//    }else{
//        [_imageContent sd_setImageWithURL:[NSURL URLWithString:post.m_video_thumb]
//                         placeholderImage:nil
//                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                    self.viewPlay.hidden = false;
//                                    [self.activityIndicator stopAnimating];
//                                    self.activityIndicator.hidden = true;
//                                    NSLog(@"logged");
//                                    post.m_img_origin = image;
//                                    post.m_img_origin_reflect = [image reflectedImageWithScale:0.5];
////                                    _imageContent.image = post.m_img_origin_reflect;
//                                    _imageContent.image = post.m_img_origin;
//
//                                }];
//    }
    
}
-(void)addShadow:(UIView *)view Color:(NSString * ) color
{
//    view.layer.shadowColor = [[self colorWithHexString:color] CGColor];
//    view.layer.shadowOffset = CGSizeMake(2, 2);
//    view.layer.shadowOpacity = 0.16f;
//    view.layer.shadowRadius = 1.0;
    
    view.layer.shadowColor = [[self colorWithHexString:color] CGColor];
    view.layer.shadowOffset = CGSizeMake(2, 2);
    view.layer.shadowOpacity = 0.2f;
    view.layer.shadowRadius = 1.5;
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
