//
//  SignupViewController.h
//  mwod
//
//  Created by BoHuang on 10/31/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface SignupViewController : UIViewController<UIWebViewDelegate,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
