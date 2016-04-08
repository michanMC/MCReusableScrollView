//
//  MCView.m
//  MCPageScrollView
//
//  Created by MC on 16/4/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCView.h"
#import "MCTableViewCell.h"

#import "UIImageView+WebCache.h"
@interface MCView ()
<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * _tableView;
    
}

@end



@implementation MCView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
 
    }
 
    
}
-(void)RefreshData{
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
           UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.textLabel.text = _dataDic[@"description"];
        cell.textLabel.numberOfLines = 0;
        return cell;
        
    }
    MCTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MCTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MCTableViewCell" owner:self options:nil]lastObject];
    }
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_dataDic[@"picurl"]?_dataDic[@"picurl"]:@""]];

    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
