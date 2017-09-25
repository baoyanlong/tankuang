//
//  ViewController.m
//  弹框demo
//
//  Created by 谢贤 on 2017/8/15.
//  Copyright © 2017年 包燕龙. All rights reserved.
//

#import "ViewController.h"
#import "YLTanKuangView.h"
#import "YLItemView.h"
#define YLScreenH [[UIScreen mainScreen] bounds].size.height
#define YLScreenW  [[UIScreen mainScreen] bounds].size.width
@interface ViewController ()
/// textField
@property (nonatomic,strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 添加文本框
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = CGRectMake(YLScreenW*0.7*0.5,YLScreenH * 0.3, YLScreenW * 0.3, 44);
    textField.placeholder = @"显示选择结果";
    textField.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:textField];
    self.textField = textField;
    
    
    // 添加弹框按钮
    UIButton *tankuangBtn = [[UIButton alloc]initWithFrame:CGRectMake(YLScreenW*0.7*0.5,YLScreenH * 0.5, YLScreenW * 0.3, 44)];
    tankuangBtn.backgroundColor = [UIColor redColor];
    [tankuangBtn setTitle:@"弹框" forState:UIControlStateNormal];
    [tankuangBtn addTarget:self action:@selector(tankuangClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tankuangBtn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tankuangClick
{
    YLTanKuangView *tanKuangView = [[YLTanKuangView alloc]initWithFrame:CGRectMake(0, YLScreenH, YLScreenW, YLScreenH*0.45)];
    [self.view.window addSubview:tanKuangView];
    
    // 设置数据
    NSArray *titleArray = [NSArray arrayWithObjects:@"选择标题",@"取消", nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"image1",@"image2",@"image3", nil];
    NSArray *modelArray = [NSArray arrayWithObjects:@"选择方式一",@"选择方式二",@"选择方式三", nil];
    [tanKuangView initWithModelArray:modelArray titleArray:titleArray andImageArray:imageArray];

    __weak YLTanKuangView *tanKuangView1 = tanKuangView;
    __weak typeof(self) weakSelf = self;
    tanKuangView.clickBlock = ^(UIView *itemView) {
        YLItemView *itemView1 = (YLItemView*)itemView;
        weakSelf.textField.text = itemView1.titleLabel.text;
        [tanKuangView1 destroyTanKuangView];
        
    };

    // 显示弹框
    [tanKuangView showTanKuangView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
