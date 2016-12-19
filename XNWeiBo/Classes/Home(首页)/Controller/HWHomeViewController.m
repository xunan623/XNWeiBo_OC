//
//  HWHomeViewController.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWDropdownMenu.h"
#import "HWTitleMenuViewController.h"
#import "AFNetworking.h"
#import "HWAccountTool.h"
#import "HWTitleButton.h"
#import <UIImageView+WebCache.h>
#import "HWUser.h"
#import "HWStatus.h"
#import "MJExtension.h"
#import "HWLoadMoreFooter.h"
#import "HWStatusCell.h"
#import "HWStatusFrame.h"
#import <XNStatusBarHUD.h>

@interface HWHomeViewController () <HWDropdownMenuDelegate>
/**
 *  微博数组(里面放的都是HWStatusFrame模型,一个HWStatus代表一条微博)
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation HWHomeViewController



- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames = [[NSMutableArray alloc] init];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //距离上面的距离
//    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = rgb(242, 242, 242);
    // 设置导航栏内容
    [self setupNav];
    
    // 获得用户信息（昵称）
    [self setupUserInfo];
    
    // 加载最新的微博数据
//    [self loadNewStatus];
    
    // 集成下拉刷新控件
    [self setDownRefresh];
    
    // 集成上拉加载
    [self setUpRefresh];
    
    // 获取未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer (不管主线程是否在处理其他事情)
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
/**
 *  获取未读数
 */
- (void)setupUnreadCount
{
//    HWLog(@"获取未读数");
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求管理者
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^void(AFHTTPRequestOperation * operation, NSDictionary *responseOjbect) {
        // 设置提醒数字(微博的未读数)  @20 ----> @"20" description
        NSString *status = [responseOjbect[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        HWLog(@"请求失败%@",error);
    }];
}

/**
 *  集成上拉加载
 */
- (void)setUpRefresh
{
    HWLoadMoreFooter *footer = [HWLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  集成下拉刷新控件
 */
- (void)setDownRefresh
{
    // 1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    // 只用手动刷新才会刷新
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    // 2.开始刷新(仅仅刷新样式,并不会触发刷新方法)
    [control beginRefreshing];
    
    // 3.马上加载数据
    [self refreshStateChange:control];
}
/**
 *  UIRefreshControl进入刷新状态
 */
-(void)refreshStateChange:(UIRefreshControl *)control
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博(最新的微博,ID最大的微博)
    HWStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        // 若指定此参数,则返回ID比since_id大得微博(即比since_id时间晚的微博),默认为0
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        HWLog(@"%@",responseObject);
        
        // 取得微博字典数组
        NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];

        //将最新的微博数据,添加到 微博模型 数组
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        // 刷新表格
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        [self.tableView reloadData];
        //结束刷新
        [control endRefreshing];
        
        // 显示最新微博数量
        [self showNewStatusCount:newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败-%@", error);
        //结束刷新
        [control endRefreshing];
    }];

}
/**
 *  将HWStatus模型转为HWStatusFrame模型
 */
-(NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    // 将HWStatus数组 转为 HWStatusFrame数组
    NSMutableArray *frames = [NSMutableArray array];
    for (HWStatus *status in statuses) {
        HWStatusFrame *f = [[HWStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    HWStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
        
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}

/**
 *  显示最新微博数量
 *
 *  @param count 新微博数量
 */
- (void)showNewStatusCount:(NSInteger)count
{
    // 刷新成功清空图标
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // 1.创建label
    UILabel *reLabel = [[UILabel alloc] init];
    reLabel.width = [UIScreen mainScreen].bounds.size.width;
    reLabel.height = 35;
    reLabel.y = 64 - reLabel.height;
    reLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    reLabel.font = [UIFont systemFontOfSize:16.0f];
    reLabel.textColor = [UIColor whiteColor];
    reLabel.textAlignment = NSTextAlignmentCenter;
    if (count == 0) {
        reLabel.text = @"没有最新的微博数据";
    } else {
        reLabel.text = [NSString stringWithFormat:@"你刷新了%ld个微博",count];
    }
    
    // 3.添加label到导航栏的view中,并在导航栏后面
    [self.navigationController.view insertSubview:reLabel belowSubview:self.navigationController.navigationBar];
    
    // 4.动画  先利用1s的时间 让自己向下移动
    CGFloat duration = 1.0; // 动画时间
    [UIView animateWithDuration:duration animations:^{
//        reLabel.y += reLabel.height;
        
        // 回到以前的位置用这个transform
        reLabel.transform = CGAffineTransformMakeTranslation(0, reLabel.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0; //延迟一秒
        // UIViewAnimationOptionCurveLinear 匀速执行
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            reLabel.y -= reLabel.height;
            
            // 清空位移
            reLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [reLabel removeFromSuperview];
        }];
    }];
    // 如果某个动画执行完毕后,又要回到动画执行前的状态,建议用transform来做动画

}

/**
 *  加载最新的微博数据
 */
- (void)loadNewStatus
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 取得微博字典数组
        NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [self.statusFrames addObjectsFromArray:newStatuses];
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败-%@", error);
    }];


}

/**
 *  获得用户信息（昵称）
 */
- (void)setupUserInfo
{
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // MJ字典转模型
        HWUser *user = [HWUser objectWithKeyValues:responseObject];
        // 标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        // 设置名字
//        NSString *name = responseObject[@"name"];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        account.name = user.name;
        [HWAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败-%@", error);
    }];
}

/**
 *  设置导航栏内容
 */
- (void)setupNav
{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    HWTitleButton *titleButton = [[HWTitleButton alloc] init];
  
    // 设置图片和文字
    NSString *name = [HWAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

// 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
// 什么情况下建议使用imageEdgeInsets、titleEdgeInsets
// 如果按钮内部的图片、文字固定，用这2个属性来设置间距，会比较简单
// 标题宽度
//    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
////    // 乘上scale系数，保证retina屏幕上的图片宽度是正确的
//    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
//    CGFloat left = titleW + imageW;
//    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);

/**
 *  标题点击
 */
- (void)titleClick:(UIButton *)titleButton
{
    // 1.创建下拉菜单
    HWDropdownMenu *menu = [HWDropdownMenu menu];
    menu.delegate = self;
    
    // 2.设置内容
    HWTitleMenuViewController *vc = [[HWTitleMenuViewController alloc] init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;
    
    // 3.显示
    [menu showFrom:titleButton];
}

- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
}

#pragma mark - HWDropdownMenuDelegate
/**
 *  下拉菜单被销毁了
 */
- (void)dropdownMenuDidDismiss:(HWDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向下
    titleButton.selected = NO;
}

/**
 *  下拉菜单显示了
 */
- (void)dropdownMenuDidShow:(HWDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向上
    titleButton.selected = YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusCell *cell = [HWStatusCell cellWithTableView:tableView];
    // 点击cell的时候 不要变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
    
    /*
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // 取出这行对应的微博字典
//    NSDictionary *status = self.statues[indexPath.row];
    HWStatus *status = self.statues[indexPath.row];
    
    // 取出这条微博的作者(用户)
//    NSDictionary *user = status[@"user"];
//    cell.textLabel.text = user[@"name"];
    HWUser *user = status.user;
    cell.textLabel.text = user.name;
    
    // 设置文字
//    cell.detailTextLabel.text = status[@"text"];
    cell.detailTextLabel.text = status.text;

    // 设置头像
//    NSString *imageUrl = user[@"profile_image_url"];
    NSString *imageUrl = user.profile_image_url;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    return cell;
     */
}

/*
1.将字典转为模型
2.能够下拉刷新微博数据
3.能够上拉加载微博数据
 */

#pragma mark scrollView 上拉加载
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}





@end
