//
//  ViewController.m
//  ZYBarView
//
//  Created by dianchu on 2017/11/29.
//  Copyright © 2017年 ZZY. All rights reserved.
//

#import "ViewController.h"
#import "ZYPowerfulChartScrollView.h"
#import "Masonry.h"

@interface ViewController ()<ZYPowerfulChartScrollViewDelegate>

@property (nonatomic, strong) ZYPowerfulChartScrollView *chartScrollView;

@property (weak, nonatomic) IBOutlet UIView *chartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _chartScrollView = [[ZYPowerfulChartScrollView alloc] init];
    _chartScrollView.dataArray = @[@"100",@"200",@"999",@"123",@"888",@"100",@"200",@"999",@"123",@"888"];
    _chartScrollView.chartDelegate = self;
    [self.chartView addSubview:_chartScrollView];
    
    [_chartScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.chartView);
    }];
}

//当前选择的第几个柱形图
- (void)chartViewCurrentSelectedIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
