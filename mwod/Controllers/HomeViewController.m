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

@interface HomeViewController ()
{
    AVPlayer* _playerURL;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initConf];
    [self initSample];
    [self initUser];
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
    
    self.carouselLayout1.itemSize = CGSizeMake(g_thumb_w, g_thumb_h);
    self.carouselLayout1.sideItemScale = 0.9;
    self.carouselLayout1.sideItemAlpha = 0.9;
    
    
    self.carouselLayout2.itemSize = CGSizeMake(g_thumb_w, g_thumb_h);
    self.carouselLayout2.sideItemScale = 0.9;
    self.carouselLayout2.sideItemAlpha = 0.9;
    
    self.collectionview1.showsHorizontalScrollIndicator = false;
    self.collectionview2.showsHorizontalScrollIndicator = false;
    
    self.collectionview1.backgroundColor = [UIColor clearColor];
    self.collectionview2.backgroundColor = [UIColor clearColor];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = true;
}
-(NSMutableDictionary*)checkValidate{
    EnvVar* env = [CGlobal sharedId].env;
    NSMutableDictionary*ret = [[NSMutableDictionary alloc] init];
    NSString* username = env.username;
    NSString* password = env.password;
    ret[@"username"] = username;
    ret[@"password"] = password;
    
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
- (IBAction)tapVisit:(id)sender {
    NSString*urlString = @"https://www.mobilitywod.com";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
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
