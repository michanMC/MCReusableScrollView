//
//  MCView.h
//  MCPageScrollView
//
//  Created by MC on 16/4/8.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCView : UIView
@property(nonatomic,strong)NSDictionary *dataDic;
-(void)RefreshData;
@end
