//
//  ZYBarChartView.h
//
/** 屏幕宽 */
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
/** 屏幕高 */
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import <UIKit/UIKit.h>

@interface ZYBarChartView : UIView

/** 数据 */
@property (nonatomic, assign) CGFloat data;

/** x轴标题 */
@property (nonatomic, copy) NSString *XAxis;

/** 所有月份的最大值 */
@property (nonatomic, assign) NSInteger maxValue1;


/**  */
@property (nonatomic, assign) BOOL selected;

@end
