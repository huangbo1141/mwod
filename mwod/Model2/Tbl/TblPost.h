//
//  TblPost.h
//  mwod
//
//  Created by BoHuang on 10/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TblPost : NSObject

@property (nonatomic,copy) NSString* first_name;

@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* post_author;
@property (nonatomic,copy) NSString* post_date;
@property (nonatomic,copy) NSString* post_date_gmt;
@property (nonatomic,copy) NSString* post_content;
@property (nonatomic,copy) NSString* post_title;
@property (nonatomic,copy) NSString* post_excerpt;
@property (nonatomic,copy) NSString* post_status;
@property (nonatomic,copy) NSString* comment_status;
@property (nonatomic,copy) NSString* ping_status;
@property (nonatomic,copy) NSString* post_password;
@property (nonatomic,copy) NSString* post_name;
@property (nonatomic,copy) NSString* to_ping;
@property (nonatomic,copy) NSString* pinged;
@property (nonatomic,copy) NSString* post_modified;
@property (nonatomic,copy) NSString* post_modified_gmt;
@property (nonatomic,copy) NSString* post_content_filtered;
@property (nonatomic,copy) NSString* post_parent;
@property (nonatomic,copy) NSString* guid;
@property (nonatomic,copy) NSString* menu_order;
@property (nonatomic,copy) NSString* post_type;
@property (nonatomic,copy) NSString* post_mime_type;
@property (nonatomic,copy) NSString* comment_count;
@property (nonatomic,copy) NSString* filter;
@property (nonatomic,copy) NSString* a_post_image_id;
@property (nonatomic,strong) NSMutableArray* a_attachment;

// app side generated
@property (nonatomic,copy) NSString* m_video_id;      //
@property (nonatomic,copy) NSString* m_video_type;    //  0   vimeo   1 youtube
@property (nonatomic,copy) NSString* m_video_thumb;
@property (nonatomic,copy) NSString* m_video_path;
@property (nonatomic,copy) NSString* m_error_desc;
@property (nonatomic,copy) NSString* m_error_reason;
@property (nonatomic,strong) UIImage* m_img_origin;
@property (nonatomic,strong) UIImage* m_img_origin_reflect;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
