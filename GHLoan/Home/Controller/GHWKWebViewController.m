//
//  GHWKWebViewController.m
//  GHLoan
//
//  Created by Lin on 2017/9/20.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "GHWKWebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface GHWKWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;
@end

@implementation GHWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc] init];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    self.context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    
}

#pragma mark    -
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.context[@""] = ^() {
        NSArray *args = [JSContext currentArguments];
        
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
