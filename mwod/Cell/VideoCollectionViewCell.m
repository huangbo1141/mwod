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

@implementation VideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
//    self.imageContent.contentMode = UIViewContentModeScaleAspectFit;
    
}
-(void)setData:(NSDictionary *)data{
    [super setData:data];
    self.viewPlay.hidden = true;
    self.activityIndicator.hidden = true;
    if ([self.model isKindOfClass:[TblPost class]]) {
        self.activityIndicator.hidden = false;
        [self.activityIndicator startAnimating];
        TblPost *post = self.model;
        NSLog(@"%@",post.m_video_thumb);
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
    [_imageContent sd_setImageWithURL:[NSURL URLWithString:post.m_video_thumb]
                     placeholderImage:nil
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                self.viewPlay.hidden = false;
                                [self.activityIndicator stopAnimating];
                                self.activityIndicator.hidden = true;
                                NSLog(@"logged");
                            }];
}
@end
