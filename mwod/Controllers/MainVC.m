//
//  ViewController.m
//  Testing
//
//  Created by Kapil Kumar on 10/24/17.
//  Copyright © 2017 Kapil Kumar. All rights reserved.
//

#import "MainVC.h"
#import "YTVimeoExtractor.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "YoutubeVC.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MainVC ()<UITextFieldDelegate>
{
    AVPlayer* _playerURL;
}

@property (weak, nonatomic) IBOutlet UITextField *youTubeURLField;
@property (weak, nonatomic) IBOutlet UITextField *vimeoURLField;

@property (weak, nonatomic) IBOutlet UIImageView *vimeoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *youtubeImageView;

@property (weak, nonatomic) IBOutlet UILabel *vimeoLabelView;
@property (weak, nonatomic) IBOutlet UILabel *youtubeLabelView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) NSMutableArray* idList;
@property (strong, nonatomic) NSMutableArray* idList_y;
@property (assign, nonatomic) int index;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_indicatorView stopAnimating];
    
    self.idList = [[NSMutableArray alloc] init];
    [self.idList addObject:@"186351783"];
    [self.idList addObject:@"109244758"];
    [self.idList addObject:@"124466291"];
    self.index = 0;
    self.vimeoURLField.text = self.idList[0];
    
    self.idList_y = [[NSMutableArray alloc] init];
    [self.idList_y addObject:@"8czz0nK4-lg"];
    [self.idList_y addObject:@"UZCMnABiKM8"];
    [self.idList_y addObject:@"DTGkiA0eQHk"];
    self.youTubeURLField.text = self.idList_y[0];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue sender:sender];
    
    if ([[segue destinationViewController] isKindOfClass:[YoutubeVC class]]) {
        
//        NSString* url = [NSString stringWithFormat:@"https://www.youtube.com/embed/%@?rel=0", self.youTubeURLField.text];
        YoutubeVC* tubeVC = (YoutubeVC*)[segue destinationViewController];
        tubeVC.webURL = self.youTubeURLField.text;
    }
    
}

#pragma mark
#pragma mark Private Methods

- (BOOL)isIphone
{
    NSString* source = [[UIDevice currentDevice] model];
    return !([source rangeOfString:@"iPad" options:NSCaseInsensitiveSearch].length > 0);
    
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"Duration: %02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}


- (NSString *)parseVideoDurationOfYoutubeAPI:(NSString*)videoDuration {
    
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    
    NSRange timeRange = [videoDuration rangeOfString:@"T"];
    
    videoDuration = [videoDuration substringFromIndex:timeRange.location];
    
    while (videoDuration.length > 1) {
    
        videoDuration = [videoDuration substringFromIndex:1];
        
        NSScanner* scanner = [NSScanner scannerWithString:videoDuration];
        
        NSString* part = @"";
        
        [scanner scanCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&part];
        NSRange partRange = [videoDuration rangeOfString:part];
        videoDuration = [videoDuration substringFromIndex:partRange.location + partRange.length];
        
        NSString* timeUnit = [videoDuration substringToIndex:1];
        
        if ([timeUnit isEqualToString:@"H"]) {
            hours = [part intValue];
        }
        else if ([timeUnit isEqualToString:@"M"]) {
            minutes = [part intValue];
        }
        else if ([timeUnit isEqualToString:@"S"]) {
            seconds = [part intValue];
        }
        else{
        }

    }

    return [NSString stringWithFormat:@"Duration: %02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

- (void)sendGetRequestB:(NSString *)url completion:(void(^)(id result))completionBlock {
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
        
        
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [_indicatorView stopAnimating];
            if (error == nil) {
                
                NSError* error2 = nil;
                id array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error2];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(array);
                });
            } else {
                
            }
        }] resume];
    });
}

- (void)updateYouTubeDuration {

    _youtubeLabelView.text = @"";
    NSString* apiURl = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?id=%@&part=contentDetails&key=AIzaSyDKgQVa28ZlcJVX265yyPMdnHcpFEjnorc", self.youTubeURLField.text];
    
    [self sendGetRequestB:apiURl completion:^(id result) {
        
        
        NSDictionary* dict = (NSDictionary*)result;
        if ([dict valueForKey:@"items"] != nil) {
            
            for (NSDictionary* lDict in [dict valueForKey:@"items"]) {
                
                if ([lDict valueForKey:@"contentDetails"] != nil) {
                    
                    
                    NSDictionary* content = [lDict valueForKey:@"contentDetails"];
                    
                    if ([content valueForKey:@"duration"] != nil) {
                        
                        NSString* duration = [content valueForKey:@"duration"];
                        
                        if (duration.length > 0) {

                            _youtubeLabelView.text = [self parseVideoDurationOfYoutubeAPI:duration];
                        }
                    }
                }
                
            }
            
        }
        
        
    }];
}

#pragma mark
#pragma mark UIButton Action
-(IBAction)removeKeyboardAction:(id)sender {

    [self.view endEditing:true];
}

-(IBAction)playYoutubeAction:(id)sender{
 
    [self.view endEditing:true];
    NSString* url = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", self.youTubeURLField.text];
    NSLog(@"youtube thumb %@",url);
    [_indicatorView startAnimating];
    [_youtubeImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        [_youtubeImageView setImage:image];
        [_indicatorView stopAnimating];
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
        [_indicatorView stopAnimating];
    }];
    
    [self updateYouTubeDuration];
    [self performSegueWithIdentifier:@"youtubesegue" sender:nil];
    
}

-(IBAction)thumbailYoutubeAction:(id)sender{
    
    [self.view endEditing:true];
    NSString* url = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", self.youTubeURLField.text];
    
    [_indicatorView startAnimating];
    [_youtubeImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        
        [_youtubeImageView setImage:image];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
        
    }];
    [self updateYouTubeDuration];
    
}

-(IBAction)playVimeoAction:(id)sender{
    
    [self.view endEditing:true];
    //NSString* url = [NSString stringWithFormat:@"https://player.vimeo/video/%@", self.vimeoURLField.text];
    [[YTVimeoExtractor sharedExtractor]fetchVideoWithIdentifier:self.vimeoURLField.text withReferer:@"https://www.mobilitywod.com/" completionHandler:^(YTVimeoVideo * _Nullable video, NSError * _Nullable error) {
        
        if (video) {
            
            //self.titleLabel.text = [NSString stringWithFormat:@"Video Title: %@",video.title];
            //Will get the lowest available quality.
            //NSURL *lowQualityURL = [video lowestQualityStreamURL];
            
            //Will get the highest available quality.
            
            NSDictionary* dict = video.thumbnailURLs;
//            NSLog(@"%@...", dict);
            
            NSString* str = dict[[NSNumber numberWithLong:0]];
            
            NSString *urlStr =[NSString stringWithFormat:@"%@", str];
            NSLog(@"vimeo thumb  %@...", urlStr);
            

            [_indicatorView startAnimating];
        
            [_vimeoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                
                [_vimeoImageView setImage:image];
                [_indicatorView stopAnimating];
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
                [_indicatorView stopAnimating];
            }];
            
            _vimeoLabelView.text = [self stringFromTimeInterval:video.duration];
            

//            NSLog(@"%@...", dict);
            NSURL *highQualityURL = [video lowestQualityStreamURL];
            NSLog(@"vimeo video path %@...", highQualityURL);
            
            AVPlayer* playerURL = [AVPlayer playerWithURL:highQualityURL];
            
             [playerURL addObserver:self forKeyPath:@"status" options:0 context:nil];
            
            AVPlayerViewController* moviePlayerViewController = [[AVPlayerViewController alloc] init];
            moviePlayerViewController.player = playerURL;
        
            [self presentViewController:moviePlayerViewController animated:true completion:nil];
            
            _playerURL = playerURL;
            
        }else{
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:error.localizedFailureReason preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            if (![self isIphone]) {
                alert.popoverPresentationController.sourceView = self.view;
            }
            
            [self presentViewController:alert animated:true completion:nil];

            
        }
        
    }];
    
}
- (IBAction)clickGetIds:(id)sender {
    self.index = self.index+1;
    self.index = self.index%[self.idList count];
    self.vimeoURLField.text = self.idList[self.index];
    
}
- (IBAction)clickYoutubeIds:(id)sender {
    self.index = self.index+1;
    self.index = self.index%[self.idList_y count];
    self.youTubeURLField.text = self.idList_y[self.index];
    
}

-(IBAction)thumbnailVimeoAction:(id)sender{
    
    [self.view endEditing:true];
    [[YTVimeoExtractor sharedExtractor]fetchVideoWithIdentifier:self.vimeoURLField.text withReferer:@"https://www.mobilitywod.com/" completionHandler:^(YTVimeoVideo * _Nullable video, NSError * _Nullable error) {
        
        if (video) {
            
            //self.titleLabel.text = [NSString stringWithFormat:@"Video Title: %@",video.title];
            //Will get the lowest available quality.
            //NSURL *lowQualityURL = [video lowestQualityStreamURL];
            
            //Will get the highest available quality.
            
            NSDictionary* dict = video.thumbnailURLs;
            NSLog(@"%@...", dict);
            
            NSString* str = dict[[NSNumber numberWithLong:0]];
            
            NSString *urlStr =[NSString stringWithFormat:@"%@", str];
            NSLog(@"%@...", urlStr);
            
            
            
            [_indicatorView startAnimating];
            
            [_vimeoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                
                [_vimeoImageView setImage:image];
                [_indicatorView stopAnimating];
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
                [_indicatorView stopAnimating];
            }];
            
            
            _vimeoLabelView.text = [self stringFromTimeInterval:video.duration];
            
        }else{
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:error.localizedFailureReason preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            if (![self isIphone]) {
                alert.popoverPresentationController.sourceView = self.view;
            }
            
            [self presentViewController:alert animated:true completion:nil];
            
            
        }
        
    }];
    
}


#pragma mark
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark UITextFieldDelegate
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


@end
