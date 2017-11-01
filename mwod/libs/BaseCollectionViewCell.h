//
//  BaseCollectionViewCell.h
//  mwod
//
//  Created by BoHuang on 10/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopupDialog.h"

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UICollectionView* collectionView;
@property (nonatomic,strong) NSIndexPath* indexPath;
@property (nonatomic,strong) id model;

@property (nonatomic,strong) UIViewController* vc;
@property (nonatomic,strong) NSDictionary* inputData;
@property (nonatomic,strong) id<ViewDialogDelegate> aDelegate;

-(void)setData:(NSDictionary*)data;

@end
