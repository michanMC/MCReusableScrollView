//
//  MCReusableScrollView.h
//  MCPageScrollView
//
//  Created by MC on 16/4/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#import <UIKit/UIKit.h>
@class MCReusableScrollView;

@protocol MCReusableScrollViewDelegate<NSObject>
/**
 加载下一页数据
 */
-(void)LoadNextData;

/**
 *  总列数
 */
- (NSInteger)numberOfColumnsInTableView:(MCReusableScrollView *)tableView;

/**
 *  每列显示的view
 */
- (UIView *)tableView:(MCReusableScrollView *)tableView viewForColumnAtIndex:(NSInteger)index;

/**
 *  每行view的宽度
 */
- (CGFloat)tableView:(MCReusableScrollView *)tableView widthForColumnAtIndex:(NSInteger)index;





@end

/**
 *  横向滚动列表
 */
@interface MCReusableScrollView :UIScrollView

@property (weak, nonatomic) id<MCReusableScrollViewDelegate> scrollViewDelegate;

/**
 *  重新加载
 */
- (void)reloadData;

/**
 *  获取可重用view
 */
- (id)reusableView;@end
