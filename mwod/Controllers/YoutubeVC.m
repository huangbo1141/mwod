//
//  YoutubeVC.m
//  ParasTV
//
//  Created by Kapil Kumar on 9/2/17.
//  Copyright © 2017 Kapil Kumar. All rights reserved.
//

#import "YoutubeVC.h"
#import <youtube-ios-player-helper/YTPlayerView.h>



@interface YoutubeVC ()<YTPlayerViewDelegate>

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation YoutubeVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self viewSettings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue sender:sender];
    
    
}



#pragma mark
#pragma mark Private Methods
- (void)viewSettings
{
    [_indicator startAnimating];
    [self.playerView setDelegate:self];
    [self.playerView loadWithVideoId:_webURL];
    self.playerView.webView.mediaPlaybackAllowsAirPlay = true;
    self.playerView.webView.allowsInlineMediaPlayback = true;
}

#pragma mark
#pragma mark UIBUTTON ACTION'S
#pragma mark
#pragma mark YTPlayerView delegates
- (void)playerViewDidBecomeReady:(nonnull YTPlayerView *)playerView {
    
    [_indicator stopAnimating];
    [self.playerView playVideo];
}

- (void)playerView:(nonnull YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
}

@end
