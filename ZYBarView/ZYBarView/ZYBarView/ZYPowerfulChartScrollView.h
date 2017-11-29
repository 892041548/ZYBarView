//
//  ZYPowerfulChartScrollView.h

//

#import <UIKit/UIKit.h>

@protocol ZYPowerfulChartScrollViewDelegate <NSObject>

- (void)chartViewCurrentSelectedIndex:(NSInteger)index;

@end

@interface ZYPowerfulChartScrollView : UIScrollView

/**  */
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) id<ZYPowerfulChartScrollViewDelegate> chartDelegate;


@end
