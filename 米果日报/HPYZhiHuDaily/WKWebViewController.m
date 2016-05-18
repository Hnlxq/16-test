//
//  ViewController.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/23.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()

@property(strong,nonatomic)StoryContentViewModel *viewmodel;
@property(weak,nonatomic)WKWebView *webView;

@end

@implementation WKWebViewController

- (instancetype)initWithViewModel:(StoryContentViewModel *)vm {
    self = [super init];
    if (self) {
        self.viewmodel = vm;
        [_viewmodel addObserver:self forKeyPath:@"storyModel" options:NSKeyValueObservingOptionNew context:nil];
        [_viewmodel getStoryContentWithStoryID:_viewmodel.loadedStoryID];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

- (void)dealloc{
    [_viewmodel removeObserver:self forKeyPath:@"storyModel"];
}

- (void)initSubViews {
    
    WKWebView *wk = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-43)];
    [self.view addSubview:wk];
    _webView = wk;
    
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    navBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0.f, kScreenHeight-43, kScreenWidth, 43)];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 43)];
    [backBtn setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:backBtn];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/5,0 ,kScreenWidth/5 , 43)];
    [nextBtn setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextStoryAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:nextBtn];
    
    UIButton *votedBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*2, 0 ,kScreenWidth/5 , 43)];
    [votedBtn setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateNormal];
    [toolBar addSubview:votedBtn];
    
    UIButton *sharedBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*3, 0 ,kScreenWidth/5 , 43)];
    [sharedBtn setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
    [toolBar addSubview:sharedBtn];
    
    UIButton *commentdBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*4, 0 ,kScreenWidth/5 , 43)];
    [commentdBtn setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
    [toolBar addSubview:commentdBtn];
    [self.view addSubview:toolBar];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStoryAction:(id)sender {
    [_viewmodel getNextStoryContent];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"storyModel"]) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_viewmodel.share_URL]]];
    }
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
