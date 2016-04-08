//
//  ViewController.m
//  MCPageScrollView
//
//  Created by MC on 16/4/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ViewController.h"
#import "MCReusableScrollView.h"
#import "MCView.h"
#import "AFNetworking.h"

@interface ViewController ()<MCReusableScrollViewDelegate>
{
    NSMutableArray * _dataArray;
    MCReusableScrollView *ReusableScrollView;
    NSInteger _indexpage;
    BOOL _isRefresh;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"网易问吧";
    _indexpage = 0;
    _dataArray = [ NSMutableArray array];
    ReusableScrollView = [[MCReusableScrollView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width , Main_Screen_Height - 64)];
    ReusableScrollView.scrollViewDelegate = self;
    ReusableScrollView.pagingEnabled = YES;
    ReusableScrollView.showsVerticalScrollIndicator = NO;
    ReusableScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:ReusableScrollView];
    [self LoadData];//网络请求数据
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)LoadData{
    //@"http://c.m.163.com/newstopic/list/expert/0-10.html";
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/expert/%ld-10.html",_indexpage];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        NSArray * array = [dic objectForKey:@"data"][@"expertList"];
        for (NSDictionary * dic in array) {
            [_dataArray addObject:dic];
        }
        
        [ReusableScrollView reloadData];//ReusableScrollView刷新
        _isRefresh = NO;

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        _isRefresh = NO;

    }];
    
}
#pragma mark - ---------------------- MCReusableScrollViewDelegate
- (NSInteger)numberOfColumnsInTableView:(MCReusableScrollView *)tableView{
    return _dataArray.count;
}

- (CGFloat)tableView:(MCReusableScrollView *)tableView widthForColumnAtIndex:(NSInteger)index{
    return Main_Screen_Width;
}

- (UIView *)tableView:(MCReusableScrollView *)tableView viewForColumnAtIndex:(NSInteger)index{
    MCView *view = [tableView reusableView];
    if (!view) {
        view = [[MCView alloc]init];
    }
    NSDictionary * dic =_dataArray[index];
    view.dataDic =dic;
    [view RefreshData];//View的tableView刷新
    return view;
}
-(void)LoadNextData
{
    if (_isRefresh) {
        //如果当控制变量显示，正在刷新的话，那么直接返回
        //防止重复刷新，
        return;
    }
    _isRefresh = YES;
    _indexpage +=10;
    [self LoadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
