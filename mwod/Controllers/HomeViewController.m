//
//  HomeViewController.m
//  mwod
//
//  Created by BoHuang on 10/31/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "HomeViewController.h"
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
#import "NetworkParser.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TestLoginViewController.h"
#import "ViewPhotoFull.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface HomeViewController ()
{
    AVPlayer* _playerURL;
}

@property (nonatomic,strong) MyPopupDialog* dialog;
@property (nonatomic,strong) NSIndexPath* path1;
@property (nonatomic,strong) NSIndexPath* path2;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initConf];
    [self initSample];
    [self initUser];
    [self initCons];
}
-(void)initCons{
    self.cons_L1_TOP.constant = g_l1_top_logined;
    self.cons_L2_TOP.constant = g_l2_top_logined;
    
    NSString*fontname1 = self.lblTitle1.font.fontName;
    NSString*fontname2 = self.lblSubtitle1.font.fontName;
    UIFont*font1 = [UIFont fontWithName:fontname1 size:g_font_title_logined];
    UIFont*font2 = [UIFont fontWithName:fontname2 size:g_font_subtitle_logined];
    self.lblTitle1.font = font1;
    self.lblTitle2.font = font1;
    self.lblSubtitle1.font = font2;
    self.lblSubtitle2.font = font2;
    
    if (![CGlobal isIphone]) {
//        NSString*fontname = _lblUser.font.fontName;
//        UIFont*font = [UIFont fontWithName:fontname size:19];
//        _lblUser.font = font1;
        
        _profileImageContainer.cornerRadious = 29;
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
        // keep
        self.btnAirplayLabel.hidden = true;
        self.imgAirplay.hidden = true;
        self.btnAirplayAction.hidden = true;
    }else{
        //
        
    }
    
}
-(void)initUser{
    EnvVar* env = [CGlobal sharedId].env;
    self.lblUser.text = [NSString stringWithFormat:@"Welcome back %@",env.nickname];
    UIImage* image = [UIImage imageNamed:@"ico_user.png"];
    if ([env.avatar length]>0) {
        [_imgUser sd_setImageWithURL:[NSURL URLWithString:env.avatar]
                    placeholderImage:image
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                               
                           }];
    }
    
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
    
    self.carouselLayout1.itemSize = CGSizeMake(g_thumb_w_logined, g_thumb_h_logined);
    self.carouselLayout2.itemSize = CGSizeMake(g_thumb_w_logined, g_thumb_h_logined);
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
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.collectionview1 == scrollView) {
        for (UICollectionViewCell *cell in [self.collectionview1 visibleCells]) {
            NSIndexPath *indexPath = [self.collectionview1 indexPathForCell:cell];
            NSLog(@"%@",indexPath);
            self.path1 = indexPath;
        }
    }else if (self.collectionview2 == scrollView) {
        for (UICollectionViewCell *cell in [self.collectionview2 visibleCells]) {
            NSIndexPath *indexPath = [self.collectionview2 indexPathForCell:cell];
            NSLog(@"%@",indexPath);
            self.path2 = indexPath;
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
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [self setStackAxis];
    });
}
-(void)setStackAxis{
    AppDelegate* delegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
    if (![CGlobal isIphone]) {
        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            self.stackHolder.axis = UILayoutConstraintAxisVertical;
            
            self.carouselLayout1.itemSize = CGSizeMake(g_thumb_w_logined, g_thumb_h_logined);
            self.carouselLayout2.itemSize = CGSizeMake(g_thumb_w_logined, g_thumb_h_logined);
            
            [self.collectionview1 reloadData];
            [self.collectionview2 reloadData];
            
            self.cons_L1_TOP.constant = g_l1_top_logined;
            self.cons_L2_TOP.constant = g_l2_top_logined;
            
            NSArray* array = @[self.lblTitle1,self.lblTitle2,self.lblSubtitle1,self.lblSubtitle2];
            for (UIView* view in array) {
                [view setNeedsUpdateConstraints];
                [view layoutIfNeeded];
            }
            
            if ([delegate.model isEqualToString:@"ipad_pro_12_9"]) {
                self.cons_Logo_TOP_IPAD_WRHR.constant = 20;
                NSArray* array = @[self.imgLogo];
                for (UIView* view in array) {
                    [view setNeedsUpdateConstraints];
                    [view layoutIfNeeded];
                }
            }
        }else{
            self.stackHolder.axis = UILayoutConstraintAxisHorizontal;
            
            
            self.carouselLayout1.itemSize = CGSizeMake(g_thumb_w_logined_land, g_thumb_h_logined_land);
            self.carouselLayout2.itemSize = CGSizeMake(g_thumb_w_logined_land, g_thumb_h_logined_land);
            
            [self.collectionview1 reloadData];
            [self.collectionview2 reloadData];
            
            self.cons_L1_TOP.constant = g_l1_top_logined_land;
            self.cons_L2_TOP.constant = g_l2_top_logined_land;
            
            NSArray* array = @[self.lblTitle1,self.lblTitle2,self.lblSubtitle1,self.lblSubtitle2];
            for (UIView* view in array) {
                [view setNeedsUpdateConstraints];
                [view layoutIfNeeded];
            }
            
            if ([delegate.model isEqualToString:@"ipad_pro_12_9"]) {
                self.cons_Logo_TOP_IPAD_WRHR.constant = 80;
                NSArray* array = @[self.imgLogo];
                for (UIView* view in array) {
                    [view setNeedsUpdateConstraints];
                    [view layoutIfNeeded];
                }
            }
        }
    }
}
-(NSMutableDictionary*)checkValidate{
    EnvVar* env = [CGlobal sharedId].env;
    NSMutableDictionary*ret = [[NSMutableDictionary alloc] init];
    
    ret[@"ID"] = [NSString stringWithFormat:@"%d",env.lastLogin];
    
    return ret;
}
-(void)initSample{
    NSMutableDictionary*param = [self checkValidate];
    if (param != nil) {
        [CGlobal showIndicator:self];
        NetworkParser* manager = [[NetworkParser alloc] init];
        param[@"mode"] = @"1";
        param[@"thumb_width"] = [NSString stringWithFormat:@"%d",g_thumb_w];
        param[@"thumb_height"] = [NSString stringWithFormat:@"%d",g_thumb_h];
        
        // NetworkParser
        // https://www.mobilitywod.com/wp-json/custom-plugin/login
        [manager ontemplateGeneralRequest:param Path:@"/wp-json/custom-plugin/login" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (dict != nil) {
                LoginResponse* response = [[LoginResponse alloc] initWithDictionary:dict];
                self.data1 = response.daily;
                self.data2 = response.episodes;
                
                [self.collectionview1 reloadData];
                [self.collectionview2 reloadData];
            }else{
                
            }
            
            [CGlobal stopIndicator:self];
        } method:@"POST"];
    }
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
    
    TblPost* model = data[@"model"];
    
    if([model.m_video_type intValue] == 0){
        //vimeo
        [CGlobal getVideoInfo:model CallBack:^(TblPost *post,NSMutableDictionary*data, BOOL ret) {
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
        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        YoutubeVC*tubeVC = [ms instantiateViewControllerWithIdentifier:@"YoutubeVC"] ;
        tubeVC.webURL = model.m_video_id;
        [self showViewController:tubeVC sender:self];
        
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
- (IBAction)tapAirplay:(id)sender {
    
    UIViewController* vc = self;
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"ViewPhotoFull" owner:vc options:nil];
    ViewPhotoFull* view = array[0];
    [view firstProcess:@{@"vc":vc,@"aDelegate":self}];
    
    self.dialog = [[MyPopupDialog alloc] init];
    [self.dialog setup:view backgroundDismiss:true backgroundColor:[UIColor grayColor]];
    [self.dialog showPopup:vc.view];
    
    
}

- (IBAction)tapVisit:(id)sender {
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TestLoginViewController*vc = [ms instantiateViewControllerWithIdentifier:@"TestLoginViewController"] ;
    vc.mode = @"visit";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:vc animated:true];
    });
}
- (IBAction)tapLogout:(id)sender {
//    EnvVar* env = [CGlobal sharedId].env;
//    [env logOut];
//    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [delegate defaultHome];
//    [CGlobal stopIndicator:self];
    
    
    [CGlobal showIndicator:self];
    WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
    [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                     completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                         for (WKWebsiteDataRecord *record  in records)
                         {
                             if ( [record.displayName containsString:@"mobilitywod"])
                             {
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                            NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                        }];
                             }
                         }
                         
                         AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                         [delegate unRegisterDeviceUUID];
                         
                         EnvVar* env = [CGlobal sharedId].env;
                         [env logOut];
                         [delegate defaultHome];
                         [CGlobal stopIndicator:self];
                     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
