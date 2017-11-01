//
//  ColoredLabel.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ColoredLabel.h"
#import "CGlobal.h"

@implementation ColoredLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //[self customInit];
    }
    return self;
}
-(void)setBackMode:(NSInteger)backMode{
    switch (backMode) {
        case 4:{
            self.textColor = COLOR_PRIMARY;
            break;
        }
        case 3:{
            // sign up section title
            self.textColor = [CGlobal colorWithHexString:@"2f4f4f" Alpha:1.0f];
            break;
        }
        case 2:{
            // service label pack
            self.font = [UIFont systemFontOfSize:14];
        }
        case 1:{
            // forgot password
            self.textColor = [CGlobal colorWithHexString:@"2f4f4f" Alpha:1.0f];
            break;
        }
        default:
        {
            
            break;
        }
    }
    _backMode = backMode;
}
-(void)setCornerRadious:(CGFloat)cornerRadious{
    if (cornerRadious>0) {
        self.layer.cornerRadius = cornerRadious;
        self.layer.masksToBounds = true;
    }
    _cornerRadious = cornerRadious;
}
@end
