//
//  ZYPowerfulChartScrollView.m
//

#define VIEW_WIDTH  (SCREEN_WIDTH - 40)
#define VIEW_HEIGHT 180
#define BarSpace  25
#define BarWidth  14 * SCREEN_WIDTH / 320
#define CanTapView  YES



#import "ZYPowerfulChartScrollView.h"
#import "ZYBarChartView.h"
#import "UIView+ZYCategory.h"

@interface ZYPowerfulChartScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *barChartArray;

@end

@implementation ZYPowerfulChartScrollView

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    self.barChartArray = [NSMutableArray array];
    
    self.delegate = self;
    self.contentSize = CGSizeMake((BarSpace + 2 * BarWidth) * dataArray.count + VIEW_WIDTH, VIEW_HEIGHT);
    self.bounces = NO;
    //设置scrollView的缓冲速度
    self.decelerationRate = 0.1;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float maxValue = [[dataArray valueForKeyPath:@"@max.floatValue"] floatValue];

    for (NSInteger i = 0; i < dataArray.count; i ++) {
        
        ZYBarChartView *view = [[ZYBarChartView alloc] init];
        view.frame = CGRectMake(VIEW_WIDTH/2 + i * (BarSpace + BarWidth * 2) - (BarWidth * 2)/2, 0, BarWidth * 2, VIEW_HEIGHT);
        [self addSubview:view];
        view.maxValue1 = maxValue;
        view.XAxis = [NSString stringWithFormat:@"%ld",i + 1];
        view.data = [dataArray[i] floatValue];
        
        view.userInteractionEnabled = CanTapView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        
        [view addGestureRecognizer:tap];
        
        [self.barChartArray addObject:view];
    }
}

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

- (void)tapClick:(UIGestureRecognizer *)gesture
{
    // 监听手势
    ZYBarChartView *view = (ZYBarChartView *)gesture.view;
    [self slideChartView:self view:view];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
