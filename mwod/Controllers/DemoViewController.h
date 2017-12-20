//
//  DemoViewController.h
//  mwod
//
//  Created by BoHuang on 10/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopupDialog.h"
#import "ColoredView.h"

@class UPCarouselFlowLayout;
@interface DemoViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,ViewDialogDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview1;
@property (weak, nonatomic) IBOutlet UPCarouselFlowLayout *carouselLayout1;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview2;
@property (weak, nonatomic) IBOutlet UPCarouselFlowLayout *carouselLayout2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_L1_TOP;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_L2_TOP;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle1;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle1;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle2;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle2;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;
@property (weak, nonatomic) IBOutlet UIStackView *stackHolder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_Logo_TOP_IPAD_WRHR;

@property (weak, nonatomic) IBOutlet ColoredView *viewBottom;

@property (weak, nonatomic) IBOutlet ColoredView *viewContent;

@property (strong,nonatomic) NSMutableArray *data1;
@property (strong,nonatomic) NSMutableArray *data2;
@end
