//
//  TestLoginViewController.m
//  mwod
//
//  Created by BoHuang on 11/2/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TestLoginViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "AppDelegate.h"

@interface TestLoginViewController ()
@property (nonatomic,strong) NSMutableArray* list;
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) WKUserContentController*userContentVC;

@end

@implementation TestLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self doWebKit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = false;
}
- (IBAction)tapBack:(id)sender {
    
}
- (IBAction)tapReload:(id)sender {
    [self.webView reload];
}
-(void)doWebKit{
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    self.list = [[NSMutableArray alloc] init];
    [self.list addObject:@"documentReady"];
    [self.list addObject:@"observe"];
    
    WKUserContentController* userContentVC = [[WKUserContentController alloc] init];
    theConfiguration.userContentController = userContentVC;
    for (int i=0; i<self.list.count; i++) {
        NSString* name = self.list[i];
        [userContentVC addScriptMessageHandler:self name:name];
        
    }
    self.userContentVC = userContentVC;
    
    CGRect screen = self.view.frame;
    CGFloat top = 0;
    CGRect rect = CGRectMake(0, top, screen.size.width, screen.size.height-top);
    self.webView = [[WKWebView alloc] initWithFrame:rect configuration:theConfiguration];
    [self.rootView addSubview:self.webView];
    self.webView.navigationDelegate = self;
    theConfiguration.preferences.javaScriptEnabled = true;
    
    NSURL *URL = [NSURL URLWithString:g_baseUrl];
    if([self.mode isEqualToString:@"login"]){
        URL = [NSURL URLWithString:@"https://www.mobilitywod.com/wp-login.php"];
    }else if([self.mode isEqualToString:@"signup"]){
        NSString*urlString = @"https://www.mobilitywod.com/mwod-pro-b/";
        URL = [NSURL URLWithString:urlString];
    }
    
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:nsrequest];
    [CGlobal showIndicator:self];
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"name %@",message.name);
    // Log out the message received
    NSLog(@"body %@", message.body);
    
    if ([message.name isEqualToString:@"observe"]) {
        // Log out the message received
        NSLog(@"Received event %@", message.body);
        
        @try{
            NSData *data = [message.body dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([json objectForKey:@"ID"]!=nil &&[json objectForKey:@"action"]!=nil) {
                int action = [[json objectForKey:@"action"] intValue];
                if (action == 1) {
                    NSString*ID = [json objectForKey:@"ID"];
                    [self doLogin:ID];
                }
            }
        }
        @catch(NSError* error){
            
        }
    }
}
- (void)doLogin:(NSString*)ID {
    if (![self.mode isEqualToString:@"login"]) {
        return;
    }
    NSMutableDictionary*param = [[NSMutableDictionary alloc] init];
    param[@"ID"] = ID;
    if (param != nil) {
        [CGlobal showIndicator:self];
        NetworkParser* manager = [[NetworkParser alloc] init];
        param[@"mode"] = @"login";
        // NetworkParser
        // https://www.mobilitywod.com/wp-json/custom-plugin/login
        [manager ontemplateGeneralRequest:param Path:@"/wp-json/custom-plugin/login" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (dict != nil) {
                LoginResponse* response = [[LoginResponse alloc] initWithDictionary:dict];
                [CGlobal sharedId].curUser = response.user;
                EnvVar* env = [CGlobal sharedId].env;
                env.lastLogin = [response.user.ID intValue];
                env.nickname = response.user.display_name;
                env.avatar = response.user.avatar;
                AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                [appDelegate registerDeviceUUID];
                [appDelegate goMain];
                
            }else{
            }
            [CGlobal stopIndicator:self];
        } method:@"POST"];
    }
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"didFinishNavigation");
    [CGlobal stopIndicator:self];
}
@end
//        // Then pull something from the device using the message body
//        NSString *version = message.body;
//
//        // Execute some JavaScript using the result
//        NSString *exec_template = @"set_headline(\"received: %@\");";
//        NSString *exec = [NSString stringWithFormat:exec_template, version];
//        //exec = @"set_headline(\"received: \");";
//        [_webView evaluateJavaScript:exec completionHandler:^(id _Nullable p1, NSError * _Nullable error) {
//            if (error.description) {
//                NSLog(@"%@",error.description);
//            }
//        }];
