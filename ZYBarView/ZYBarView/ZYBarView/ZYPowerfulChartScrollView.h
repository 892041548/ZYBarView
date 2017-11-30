//
//  ZYPowerfulChartScrollView.h

//

#import <UIKit/UIKit.h>

@protocol ZYPowerfulChartScrollViewDelegate <NSObject>

@optional
- (void)chartViewCurrentSelectedIndex:(NSInteger)index;

@end


@protocol ZYPowerfulChartScrollViewDataSource <NSObject>

@required

- (NSInteger)numberOfChartView;

/**
 data

 @param XAxis index
 @return <#return value description#>
 */
- (NSString *)chartViewData:(NSInteger)XAxis;
/**
 XAxis title

 @param XAxis index
 @return title
 */
- (NSString *)chartViewXAxisTitle:(NSInteger)XAxis;


@end


@interface ZYPowerfulChartScrollView : UIScrollView

/**  */
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) id<ZYPowerfulChartScrollViewDelegate> chartDelegate;
@property (nonatomic, weak) id<ZYPowerfulChartScrollViewDataSource> chartDataSource;

- (void)reloadData;

@end
