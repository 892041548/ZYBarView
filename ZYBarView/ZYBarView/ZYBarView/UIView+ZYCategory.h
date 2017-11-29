//
//  UIView+ZYExtension.h
//

//

#import <UIKit/UIKit.h>

@interface UIView (ZYCategory)

/** 从xib中读取视图 */
+ (instancetype)viewFromXib;

/** 获取或者设置控件的size */
@property (nonatomic, assign) CGSize zy_size;
/** 获取或者设置控件的宽度 */
@property (nonatomic, assign) CGFloat zy_width;
/** 获取或者设置控件的高度 */
@property (nonatomic, assign) CGFloat zy_height;
/** 获取或者设置控件的x */
@property (nonatomic, assign) CGFloat zy_x;
/** 获取或者设置控件的y */
@property (nonatomic, assign) CGFloat zy_y;
/** 获取或者设置控件的中点x */
@property (nonatomic, assign) CGFloat zy_centerX;
/** 获取或者设置控件的中点y */
@property (nonatomic, assign) CGFloat zy_centerY;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

@end
