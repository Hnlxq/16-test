//
//  DailyThemesViewController.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/23.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "DailyThemesViewController.h"
#import "DailyThemesViewModel.h"
#import "HomeViewCell.h"
#import "StoryContentViewModel.h"
#import "WKWebViewController.h"

@interface DailyThemesViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak,nonatomic)UITableView *mainTableView;
@property (weak,nonatomic)UIScrollView *mainScrollView;
@property (weak,nonatomic)UIImageView *imaView;
@property (weak,nonatomic)UIVisualEffectView *cover;

@property (strong,nonatomic)DailyThemesViewModel* viewmodel;

@end

@implementation DailyThemesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
    _viewmodel = [[DailyThemesViewModel alloc] init];
    [_viewmodel addObserver:self forKeyPath:@"stories" options:NSKeyValueObservingOptionNew context:nil];
    [_viewmodel addObserver:self forKeyPath:@"imageURLStr" options:NSKeyValueObservingOptionNew context:nil];
    [_viewmodel addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [_viewmodel addObserver:self forKeyPath:@"editors" options:NSKeyValueObservingOptionNew context:nil];
    [_viewmodel getDailyThemesDataWithThemeID:self.themeID];
}

- (void)dealloc {
    [self.viewmodel removeObserver:self forKeyPath:@"stories"];
    [self.viewmodel removeObserver:self forKeyPath:@"imageURLStr"];
    [self.viewmodel removeObserver:self forKeyPath:@"name"];
    [self.viewmodel removeObserver:self forKeyPath:@"editors"];
}
- (void)initSubViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:sv];
    _mainScrollView = sv;
    
    UIImageView* iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, -24, kScreenWidth, 112)];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    [_mainScrollView addSubview:iv];
    _imaView = iv;
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    tv.dataSource = self;
    tv.delegate = self;
    tv.rowHeight = 88.f;
    tv.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tv];
    _mainTableView = tv;
    
    [_mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([HomeViewCell class])];
   
//    UIBlurEffect *blurEffect =  [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    effectView.frame = CGRectMake(0, 0, kScreenWidth, 64);
//    [self.view addSubview:effectView];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"News_Arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Dark_Management_Add"] style:UIBarButtonItemStylePlain target:self action:@selector(attention:)];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)attention:(id)sender {

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"stories"]) {
        [_mainTableView reloadData];
    }
    if ([keyPath isEqualToString:@"imageURLStr"]) {
        [_imaView sd_setImageWithURL:[NSURL URLWithString:_viewmodel.imageURLStr]];
    }
    if ([keyPath isEqualToString:@"name"]) {
        self.title = _viewmodel.name;
    }
    if ([keyPath isEqualToString:@"editors"]) {
        if (_viewmodel.editors.count>0) {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
            headerView.backgroundColor = [UIColor whiteColor];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 40, 30)];
            lab.text = @"主编";
            [headerView addSubview:lab];
            for (int i = 0; i<_viewmodel.editors.count; i++) {
                NSDictionary *dic = _viewmodel.editors[i];
                UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(65+40*i, 7, 30, 30)];
                [imaView sd_setImageWithURL: dic[@"avatar"]];
                imaView.layer.cornerRadius = 15;
                imaView.layer.masksToBounds = YES;
                [headerView addSubview:imaView];
            }
            _mainTableView.tableHeaderView = headerView;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y;
    if (-offSetY<=48&&-offSetY>0) {
        _mainScrollView.contentOffset = CGPointMake(0, offSetY/2);
    }else if (-offSetY>48){
        scrollView.contentOffset = CGPointMake(0, -48);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewmodel.stories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeViewCell class])];
    cell.storyModel = _viewmodel.stories[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryModel *model = self.viewmodel.stories[indexPath.row];
    StoryContentViewModel* vm = [[StoryContentViewModel alloc] init];
    vm.loadedStoryID = model.storyID;
    vm.storiesID = [self.viewmodel.stories valueForKey:@"storyID"];
    vm.storyType = model.type;
    self.navigationItem.backBarButtonItem = nil;
    [self.navigationController pushViewController:[[WKWebViewController alloc] initWithViewModel:vm] animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
