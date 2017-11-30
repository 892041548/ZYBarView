//
//  ZYBarChartView.m
//



#define BarWidth  (14 * SCREEN_WIDTH / 320)
#define MAX_HEIGHT  160
#define BarAndXAxisSpace  10

#define isEmptyString(str) ([str isKindOfClass:[NSNull class]] || !str || [str isEqualToString:@""] || [str isEqualToString:@"<null>"])

#import "ZYBarChartView.h"
#import "ZYPowerfulChartScrollView.h"
#import "UIView+ZYCategory.h"

@interface ZYBarChartView ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *firstBarLabel;


@end

@implementation ZYBarChartView

- (void)setData:(CGFloat)data
{
    _data = data;
    float zhuZhuangHigh = 1;
    if (self.maxValue1 != 0) {
        zhuZhuangHigh  = (data/self.maxValue1)*MAX_HEIGHT == 0?1:(data/self.maxValue1)*MAX_HEIGHT;
    }
    
    self.firstBarLabel.zy_height = zhuZhuangHigh;
    self.firstBarLabel.zy_y = MAX_HEIGHT - zhuZhuangHigh;
}

- (void)setXAxis:(NSString *)XAxis
{
    _XAxis = XAxis;
    self.dateLabel.text = XAxis;
    if (isEmptyString(XAxis)) {
        self.firstBarLabel.zy_height = self.firstBarLabel.zy_height + CGRectGetHeight(self.dateLabel.frame) + BarAndXAxisSpace;
    }
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    ZYPowerfulChartScrollView *superView = (ZYPowerfulChartScrollView *)self.superview;

    if (selected) {
        self.firstBarLabel.backgroundColor = [UIColor redColor];
        float x = self.frame.origin.x - (SCREEN_WIDTH - 40)/2 + self.frame.size.width/2;
        [superView setContentOffset:CGPointMake(x, 0) animated:YES];
    } else {
        self.firstBarLabel.backgroundColor = [UIColor greenColor];
    }
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - BarAndXAxisSpace, self.frame.size.width, BarAndXAxisSpace)];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = [UIColor whiteColor];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (UILabel *)firstBarLabel
{
    if (!_firstBarLabel) {
        _firstBarLabel = [[UILabel alloc] init];
        _firstBarLabel.zy_x = self.bounds.size.width/2 - BarWidth/2;
        _firstBarLabel.zy_width = BarWidth;
        
        _firstBarLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:_firstBarLabel];
    }
    return _firstBarLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
