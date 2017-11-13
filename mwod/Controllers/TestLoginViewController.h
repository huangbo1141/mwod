//
//  TestLoginViewController.h
//  mwod
//
//  Created by BoHuang on 11/2/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface TestLoginViewController : UIViewController<WKNavigationDelegate,WKScriptMessageHandler>
@property (weak, nonatomic) IBOutlet UIView *rootView;
@property (copy, nonatomic) NSString*mode;
@end
