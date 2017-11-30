//
//  ViewController.m
//  ZYBarView
//
//  Created by dianchu on 2017/11/29.
//  Copyright © 2017年 ZZY. All rights reserved.
//

#define RandomArray @[@(arc4random() % 1000),@(arc4random() % 1000),@(arc4random() % 1000),@(arc4random() % 1000),@(arc4random() % 1000),@(arc4random() % 1000),@(arc4random() % 1000),@(arc4random() % 1000),@(arc4random() % 1000),@(arc4random() % 1000)]

#import "ViewController.h"
#import "ZYPowerfulChartScrollView.h"
#import "Masonry.h"

@interface ViewController ()<ZYPowerfulChartScrollViewDelegate,ZYPowerfulChartScrollViewDataSource>

@property (nonatomic, strong) ZYPowerfulChartScrollView *chartScrollView;

@property (strong, nonatomic) IBOutlet UIView *chartView;

/**  */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArray = [NSMutableArray arrayWithArray:RandomArray];
    
    _chartScrollView = [[ZYPowerfulChartScrollView alloc] init];
    _chartScrollView.chartDelegate = self;
    _chartScrollView.chartDataSource = self;
    _chartScrollView.currentIndex = 9;
    [self.chartView addSubview:_chartScrollView];
    
    [_chartScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.chartView);
    }];
}

#pragma ZYChartViewDataSource
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

- (IBAction)reloadClick:(id)sender {
    self.dataArray = [RandomArray mutableCopy];
    
    [_chartScrollView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
