//
//  YLTanKuangView.h
//  弹框demo
//
//  Created by 谢贤 on 2017/8/15.
//  Copyright © 2017年 包燕龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(UIView *);
@interface YLTanKuangView : UIView


/// 初始化数据
- (void)initWithModelArray:(NSArray *)modelArray titleArray:(NSArray *)titleArray andImageArray:(NSArray *)imageArray;

/// 显示弹框
- (void)showTanKuangView;

/// 销毁弹框
- (void)destroyTanKuangView;

/// 点击block
@property (copy,nonatomic) ClickBlock clickBlock;

@end
