//
//  HomeViewController.h
//  mwod
//
//  Created by BoHuang on 10/31/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopupDialog.h"

@class UPCarouselFlowLayout;

@interface HomeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,ViewDialogDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview1;
@property (weak, nonatomic) IBOutlet UPCarouselFlowLayout *carouselLayout1;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview2;
@property (weak, nonatomic) IBOutlet UPCarouselFlowLayout *carouselLayout2;

@property (strong,nonatomic) NSMutableArray *data1;
@property (strong,nonatomic) NSMutableArray *data2;

@property (weak, nonatomic) IBOutlet UILabel *lblUser;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;

@end
