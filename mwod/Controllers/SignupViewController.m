//
//  SignupViewController.m
//  mwod
//
//  Created by BoHuang on 10/31/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "SignupViewController.h"
#import "CGlobal.h"

@interface SignupViewController ()
@property (nonatomic,strong) NSDate*date;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _date = [NSDate date];
    
    NSString*urlString = @"https://www.mobilitywod.com/mwod-pro-b/";
    NSURL *url = [NSURL URLWithString:urlString];
    switch (1) {
        case 1:
        {
            [self doWebkit:url];
            break;
        }
        default:
            break;
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = false;
}
-(void)doWebView:(NSURL*)url{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    [_webView setDelegate:self];
    
    [CGlobal showIndicator:self];
}
-(void)doWebkit:(NSURL*)nsurl{
    self.webView.hidden = true;
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    CGRect screen = self.view.frame;
    CGFloat top = 44;
    CGRect rect = CGRectMake(0, top, screen.size.width, screen.size.height-top);
    WKWebView *webView = [[WKWebView alloc] initWithFrame:rect configuration:theConfiguration];
    webView.navigationDelegate = self;
    
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    [self.view addSubview:webView];
    
    [CGlobal showIndicator:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSDate* end = [NSDate date];
    NSTimeInterval seconds = [end timeIntervalSinceDate:_date];
    
    NSLog(@"seconds %f",seconds);
    //    [CGlobal stopIndicator:self];
    [CGlobal stopIndicator:self];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSDate* end = [NSDate date];
    NSTimeInterval seconds = [end timeIntervalSinceDate:_date];
    
    NSLog(@"seconds %f",seconds);
    //    [CGlobal stopIndicator:self];
    [CGlobal stopIndicator:self];
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
