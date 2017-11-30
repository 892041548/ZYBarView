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

@interface ViewController ()<ZYPowerfulChartScrollViewDelegate,ZYPowerfulChartScrollViewDataSource>

@property (nonatomic, strong) ZYPowerfulChartScrollView *chartScrollView;

@property (weak, nonatomic) IBOutlet UIView *chartView;

/**  */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArray = [NSMutableArray arrayWithArray:@[@"100",@"200",@"999",@"123",@"888",@"100",@"200",@"999",@"123",@"888"]];
    _chartScrollView = [[ZYPowerfulChartScrollView alloc] init];
    _chartScrollView.chartDelegate = self;
    _chartScrollView.chartDataSource = self;
    _chartScrollView.currentIndex = 9;
    [self.chartView addSubview:_chartScrollView];
    
    [_chartScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.chartView);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataArray = [@[@"10",@"20",@"30",@"30",@"50",@"10",@"10",@"10",@"10",@"10"] mutableCopy];
        [_chartScrollView reloadData];
    });
}

- (NSInteger)numberOfChartView
{
    return 10;
}

- (NSString *)chartViewData:(NSInteger)XAxis
{
    return self.dataArray[XAxis];
}

- (NSString *)chartViewXAxisTitle:(NSInteger)XAxis
{
    return @[@"x0",@"x1",@"x2",@"x3",@"x4",@"x5",@"x6",@"x7",@"x8",@"x9"][XAxis];
}

#pragma ZYChartViewDelegate

- (void)chartViewCurrentSelectedIndex:(NSInteger)index
{
    NSLog(@"currentSelected%ld",(long)index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
