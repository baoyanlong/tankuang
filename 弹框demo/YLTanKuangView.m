//
//  YLTanKuangView.m
//  弹框demo
//
//  Created by 谢贤 on 2017/8/15.
//  Copyright © 2017年 包燕龙. All rights reserved.
//

#import "YLTanKuangView.h"
#import "YLItemView.h"
#define YLColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define YLScreenH [[UIScreen mainScreen] bounds].size.height
#define YLScreenW  [[UIScreen mainScreen] bounds].size.width
#define YLColor(r, g, b) YLColorA((r), (g), (b), 255)
#define YLRandomColor YLColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface YLTanKuangView()
/// 遮盖
@property (nonatomic,strong) UIView *coverView;
/// 列表数据
@property (nonatomic,strong) NSArray *modelArray;
/// 首尾标题数据
@property (nonatomic,strong) NSArray *titleArray;
/// 图片数据
@property (nonatomic,strong) NSArray *imageArray;
@end
@implementation YLTanKuangView


// 初始化数据
- (void)initWithModelArray:(NSArray *)modelArray titleArray:(NSArray *)titleArray andImageArray:(NSArray *)imageArray
{
    self.modelArray = modelArray;
    self.titleArray = titleArray;
    self.imageArray = imageArray;
    
    // 创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 44, YLScreenW, self.frame.size.height - 44 - 44);
    scrollView.contentSize = CGSizeMake(YLScreenW, 44*modelArray.count+100);
    scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self addSubview:scrollView];
    
    for (int i = 0; i < modelArray.count + 2; i++) {
        
        YLItemView *itemView = [[YLItemView alloc]init];
        itemView.backgroundColor = [UIColor whiteColor];
        itemView.tag = i + 100;
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView:)];
        [itemView addGestureRecognizer:tap];
        
        // 标题
        if (i == 0) {
            
            itemView.frame = CGRectMake(0, i * 44, YLScreenW, 44);
            itemView.backgroundColor = [UIColor whiteColor];
            [self addSubview:itemView];
            itemView.titleLabel.textAlignment = NSTextAlignmentCenter;
            itemView.titleLabel.text = self.titleArray[0];
            
            continue;
        }
        // 取消
        if (i == modelArray.count+1) {
            itemView.frame = CGRectMake(0, self.frame.size.height-44, YLScreenW, 44);
            [self addSubview:itemView];
            itemView.imageView.hidden = YES;
            itemView.titleLabel.textAlignment = NSTextAlignmentCenter;
            itemView.titleLabel.text = self.titleArray[1];
            continue;
        }
        if (i != 0 & i != modelArray.count+1) {
            itemView.frame = CGRectMake(0, (i - 1) * 44, YLScreenW, 44);
            [scrollView addSubview:itemView];
            itemView.imageView.image = [UIImage imageNamed:self.imageArray[i - 1]];
            itemView.titleLabel.text = self.modelArray[i - 1];
        }
        
    }


}

/// 显示弹框
- (void)showTanKuangView
{
    // 弹出view前加遮盖
    UIView *coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = YLColorA(120, 120, 122, 0.8);
    [self.superview addSubview:coverView];
    self.coverView = coverView;
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewClick)];
    [coverView addGestureRecognizer:tap];
    
    
    
    // 动画弹出选择支付view
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.superview bringSubviewToFront:weakSelf];
        weakSelf.frame = CGRectMake(0, YLScreenH -0.45*YLScreenH, YLScreenW, 0.45*YLScreenH);
    }];
}

/// 销毁弹框
- (void)destroyTanKuangView
{
    // 动画退出选择支付view
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(0, YLScreenH , YLScreenW, 0.45*YLScreenH);
        
    }];
    // 移除弹框
    [self removeFromSuperview];
    // 移除遮盖
    [self.coverView removeFromSuperview];
}

/// 遮盖点击事件
- (void)coverViewClick
{
    [self destroyTanKuangView];
}

// 点击事件
- (void)clickView:(UITapGestureRecognizer *)tap
{
    NSLog(@"clickView:(UITapGestureRecognizer *)tap");
    if (tap.view.tag == 100 ) {// 点击头部标题
        
    }else if (tap.view.tag == 100 + self.modelArray.count + 1 ) {// 点击尾部取消
         [self destroyTanKuangView];
    }else{
        self.clickBlock(tap.view);
    }

}
@end
