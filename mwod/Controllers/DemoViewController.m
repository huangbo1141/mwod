//
//  DemoViewController.m
//  mwod
//
//  Created by BoHuang on 10/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "DemoViewController.h"
#import "mwod-Swift.h"
#import "TblPost.h"
#import "VideoCollectionViewCell.h"
#import "CGlobal.h"
#import "YTVimeoExtractor.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "YoutubeVC.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "TestLoginViewController.h"

@interface DemoViewController ()
{
    AVPlayer* _playerURL;
}


@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initConf];
    [self initSample];
    [self initCons];
//    [self initObserer];
}
//-(void)initObserer{
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(rotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
//}
//-(void)rotated:(NSNotification*)noti{
//    [self setStackAxis];
//}
//-(void)dealloc{
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center removeObserver:self];
//}
-(void)initCons{
    self.cons_L1_TOP.constant = g_l1_top;
    self.cons_L2_TOP.constant = g_l2_top;
    
    NSString*fontname1 = self.lblTitle1.font.fontName;
    NSString*fontname2 = self.lblSubtitle1.font.fontName;
    UIFont*font1 = [UIFont fontWithName:fontname1 size:g_font_title];
    UIFont*font2 = [UIFont fontWithName:fontname2 size:g_font_subtitle];
    self.lblTitle1.font = font1;
    self.lblTitle2.font = font1;
    self.lblSubtitle1.font = font2;
    self.lblSubtitle2.font = font2;
    
    NSString*fontname = self.lblWelcome.font.fontName;
    self.lblWelcome.font = [UIFont fontWithName:fontname size:g_font_welcome];
    if ([CGlobal isIphone]) {
        
    }else{
        self.lblWelcome.text = @"Daily 8-12 minute follow along mobility and recovery\nvideos that can be done at the gym and at home.";
    }
    
}
-(void)setStackAxis{
    if (![CGlobal isIphone]) {
        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            self.stackHolder.axis = UILayoutConstraintAxisVertical;
            
            [self.collectionview1 reloadData];
            [self.collectionview2 reloadData];
            
            self.cons_L1_TOP.constant = g_l1_top;
            self.cons_L2_TOP.constant = g_l2_top;
            
            [self.lblTitle1 setNeedsUpdateConstraints];
            [self.lblTitle2 setNeedsUpdateConstraints];
            [self.lblSubtitle1 setNeedsUpdateConstraints];
            [self.lblSubtitle2 setNeedsUpdateConstraints];
            
            [self.lblTitle1 layoutIfNeeded];
            [self.lblTitle2 layoutIfNeeded];
            [self.lblSubtitle1 layoutIfNeeded];
            [self.lblSubtitle2 layoutIfNeeded];
        }else{
            self.stackHolder.axis = UILayoutConstraintAxisHorizontal;
            
            [self.collectionview1 reloadData];
            [self.collectionview2 reloadData];
            
            self.cons_L1_TOP.constant = g_l1_top_land;
            self.cons_L2_TOP.constant = g_l2_top_land;;
            
            [self.lblTitle1 setNeedsUpdateConstraints];
            [self.lblTitle2 setNeedsUpdateConstraints];
            [self.lblSubtitle1 setNeedsUpdateConstraints];
            [self.lblSubtitle2 setNeedsUpdateConstraints];
            
            [self.lblTitle1 layoutIfNeeded];
            [self.lblTitle2 layoutIfNeeded];
            [self.lblSubtitle1 layoutIfNeeded];
            [self.lblSubtitle2 layoutIfNeeded];
        }
    }
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    NSLog(@"viewWillTransitionToSize");
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [self setStackAxis];
    });
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = true;
    
    [self setStackAxis];
}
-(void)initConf{
    self.carouselLayout1.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    self.carouselLayout2.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    
    UINib*nib = [UINib nibWithNibName:@"VideoCollectionViewCell" bundle:nil];
    [self.collectionview1 registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"VideoCollectionViewCell" bundle:nil];
    [self.collectionview2 registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    self.collectionview1.delegate = self;
    self.collectionview1.dataSource = self;
    
    self.collectionview2.delegate = self;
    self.collectionview2.dataSource = self;
    
    self.carouselLayout1.itemSize = CGSizeMake(g_thumb_w, g_thumb_h);
    
    
    self.carouselLayout2.itemSize = CGSizeMake(g_thumb_w, g_thumb_h);
    if ([CGlobal isIphone]) {
        self.carouselLayout1.sideItemScale = 0.9;
        self.carouselLayout1.sideItemAlpha = 0.9;
        
        self.carouselLayout2.sideItemScale = 0.9;
        self.carouselLayout2.sideItemAlpha = 0.9;
    }else{
        self.carouselLayout1.sideItemScale = 0.7;
        self.carouselLayout1.sideItemAlpha = 0.9;
        
        self.carouselLayout2.sideItemScale = 0.7;
        self.carouselLayout2.sideItemAlpha = 0.9;
    }
    
    self.collectionview1.showsHorizontalScrollIndicator = false;
    self.collectionview2.showsHorizontalScrollIndicator = false;
    
    self.collectionview1.backgroundColor = [UIColor clearColor];
    self.collectionview2.backgroundColor = [UIColor clearColor];
}
-(void)initSample{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    TblPost* post = [[TblPost alloc] init];
    post.m_video_id = @"186351783";
    post.m_video_type = @"0";
    post.m_video_path = @"0";
    post.m_video_thumb = @"https://i.vimeocdn.com/video/596374602";
    
    [array addObject:post];
    
    post = [[TblPost alloc] init];
    post.m_video_id = @"109244758";
    post.m_video_type = @"0";
    post.m_video_path = @"0";
    post.m_video_thumb = @"https://i.vimeocdn.com/video/493162662";
    
    [array addObject:post];
    
    post = [[TblPost alloc] init];
    post.m_video_id = @"124466291";
    post.m_video_type = @"0";
    post.m_video_path = @"0";
    post.m_video_thumb = @"https://i.vimeocdn.com/video/514206897";
    
    [array addObject:post];
    
    self.data1 = array;
    self.data2 = array;
    
    [self.collectionview1 reloadData];
    [self.collectionview2 reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == self.collectionview1){
        return _data1.count;
    }else{
        return _data2.count;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if(collectionView == self.collectionview1){
        id obj = self.data1[indexPath.row];
        [cell setData:@{@"vc":self,@"aDelegate":self,@"indexPath":indexPath,@"collectionView":collectionView,@"model":obj}];
    }else{
        id obj = self.data2[indexPath.row];
        [cell setData:@{@"vc":self,@"aDelegate":self,@"indexPath":indexPath,@"collectionView":collectionView,@"model":obj}];
    }
    
    return cell;
}
-(void)didSubmit:(NSDictionary *)data View:(UIView *)view{
//    if(self.collectionview1 == view){
//        NSIndexPath* indexPath =  data[@"indexPath"];
//        NSDictionary*inputData =  data[@"inputData"];
//    }else if(self.collectionview2 == view){
//        NSIndexPath* indexPath =  data[@"indexPath"];
//        NSDictionary*inputData =  data[@"inputData"];
//    }
    
    TblPost* model = data[@"model"];
    
    if([model.m_video_type intValue] == 0){
        //vimeo
        [CGlobal getVideoInfo:model CallBack:^(TblPost *post, NSMutableDictionary*data,BOOL ret) {
            if(ret){
                NSURL* url = [NSURL URLWithString:post.m_video_path];
                AVPlayer* playerURL = [AVPlayer playerWithURL:url];                
                
                [playerURL addObserver:self forKeyPath:@"status" options:0 context:nil];
                
                AVPlayerViewController* moviePlayerViewController = [[AVPlayerViewController alloc] init];
                moviePlayerViewController.player = playerURL;
                [playerURL setAllowsAirPlayVideo:true];
                playerURL.allowsAirPlayVideo = true;
                playerURL.allowsExternalPlayback = true;
                playerURL.usesExternalPlaybackWhileExternalScreenIsActive = true;
                moviePlayerViewController.showsPlaybackControls = true;
                
                [self presentViewController:moviePlayerViewController animated:true completion:nil];
                
                _playerURL = playerURL;
            }else{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:post.m_error_desc message:post.m_error_reason preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                if (![CGlobal isIphone]) {
                    alert.popoverPresentationController.sourceView = self.view;
                }
                
                [self presentViewController:alert animated:true completion:nil];
            }
            
        }];
    }else{
        // youtube
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == _playerURL && [keyPath isEqualToString:@"status"]) {
        
        if (_playerURL.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
        } else if (_playerURL.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [_playerURL play];
            
        } else if (_playerURL.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
        [_playerURL removeObserver:self forKeyPath:@"status" context:nil];
    }
}
- (IBAction)tapSignup:(id)sender {
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TestLoginViewController*vc = [ms instantiateViewControllerWithIdentifier:@"TestLoginViewController"] ;
    vc.mode = @"signup";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:vc animated:true];
    });
}
- (IBAction)tapLogin:(id)sender {
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TestLoginViewController*vc = [ms instantiateViewControllerWithIdentifier:@"TestLoginViewController"] ;
    vc.mode = @"login";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:vc animated:true];
    });
}


@end
