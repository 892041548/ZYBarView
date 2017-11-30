//
//  ZYPowerfulChartScrollView.m
//

#define VIEW_WIDTH  (SCREEN_WIDTH - 40)
#define VIEW_HEIGHT 180
#define BarSpace  0
#define BarWidth  14 * SCREEN_WIDTH / 320
#define CanTapView  YES


#import "ZYPowerfulChartScrollView.h"
#import "ZYBarChartView.h"
#import "UIView+ZYCategory.h"

@interface ZYPowerfulChartScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *barChartArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ZYPowerfulChartScrollView


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self slideChartView:scrollView view:nil];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self slideChartView:scrollView view:nil];
    
}

- (void)slideChartView:(UIScrollView *)scrollView view:(ZYBarChartView *)tapView
{
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[ZYBarChartView class]]) {
            ZYBarChartView *barView = (ZYBarChartView *)view;
            float range = fabs(scrollView.contentOffset.x + VIEW_WIDTH/2 - barView.zy_centerX);
            if (tapView) {
                if ([tapView isEqual:view]) {
                    range = -1;
                }
            }
            [rangeArray addObject:@(range)];
            barView.selected = NO;
        }
    }
    float min = [[rangeArray valueForKeyPath:@"@min.floatValue"] floatValue];
    NSInteger index = [rangeArray indexOfObject:@(min)];
    
    ZYBarChartView *selectView = _barChartArray[index];
    selectView.selected = YES;
    if ([self.chartDelegate respondsToSelector:@selector(chartViewCurrentSelectedIndex:)]) {
        [self.chartDelegate chartViewCurrentSelectedIndex:index]; // 通知执行代理方法
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    if ( currentIndex < self.barChartArray.count) {
        ZYBarChartView *view = self.barChartArray[currentIndex];
        [self slideChartView:self view:view];
    }
}

- (void)tapClick:(UIGestureRecognizer *)gesture
{
    ZYBarChartView *view = (ZYBarChartView *)gesture.view;
    [self slideChartView:self view:view];
}

- (void)setChartDataSource:(id<ZYPowerfulChartScrollViewDataSource>)chartDataSource
{
    _chartDataSource = chartDataSource;
    [self reloadData];
}

- (void)reloadData
{
    NSInteger count = [self.chartDataSource numberOfChartView];
    self.barChartArray = [NSMutableArray array];
    
    self.delegate = self;
    self.contentSize = CGSizeMake((BarSpace + 2 * BarWidth) * count + VIEW_WIDTH, VIEW_HEIGHT);
    self.bounces = NO;
    //设置scrollView的缓冲速度
    self.decelerationRate = 0.1;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.dataArray = [NSMutableArray array];
    @autoreleasepool {
        
        for (NSInteger i = 0; i < count; i ++) {
            [self.dataArray addObject:[self.chartDataSource chartViewData:i]];
        }
        float maxValue = [[_dataArray valueForKeyPath:@"@max.floatValue"] floatValue];
        
        for (NSInteger i = 0; i < count; i ++) {
            
            ZYBarChartView *view = [[ZYBarChartView alloc] init];
            view.frame = CGRectMake(VIEW_WIDTH/2 + i * (BarSpace + BarWidth * 2) - (BarWidth * 2)/2, 0, BarWidth * 2, VIEW_HEIGHT);
            [self addSubview:view];
            view.maxValue1 = maxValue;
            view.data = [[self.chartDataSource chartViewData:i] floatValue];
            view.XAxis = [self.chartDataSource chartViewXAxisTitle:i];
            
            view.userInteractionEnabled = CanTapView;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            
            [view addGestureRecognizer:tap];
            
            if (_currentIndex > 0 && _currentIndex < count) {
                if (i == _currentIndex) {
                    view.selected = YES;
                }
            }
            
            [self.barChartArray addObject:view];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
