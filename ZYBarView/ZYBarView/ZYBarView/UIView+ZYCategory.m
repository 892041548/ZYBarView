//
//  UIView+ZYExtension.m
//

#import "UIView+ZYCategory.h"

@implementation UIView (ZYCategory)

+ (instancetype)viewFromXib
{
#if TARGET_INTERFACE_BUILDER
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return [[bundle loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
#else
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
    
#endif
//    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)setZy_size:(CGSize)zy_size
{
    CGRect frame = self.frame;
    frame.size = zy_size;
    self.frame = frame;
}

- (CGSize)zy_size
{
    return self.frame.size;
}

- (void)setZy_width:(CGFloat)zy_width
{
    CGRect frame = self.frame;
    frame.size.width = zy_width;
    self.frame = frame;
}

- (void)setZy_height:(CGFloat)zy_height
{
    CGRect frame = self.frame;
    frame.size.height = zy_height;
    self.frame = frame;
}

- (void)setZy_x:(CGFloat)zy_x
{
    CGRect frame = self.frame;
    frame.origin.x = zy_x;
    self.frame = frame;
}

- (void)setZy_y:(CGFloat)zy_y
{
    CGRect frame = self.frame;
    frame.origin.y = zy_y;
    self.frame = frame;
}

- (void)setZy_centerX:(CGFloat)zy_centerX
{
    CGPoint center = self.center;
    center.x = zy_centerX;
    self.center = center;
}

- (void)setZy_centerY:(CGFloat)zy_centerY
{
    CGPoint center = self.center;
    center.y = zy_centerY;
    self.center = center;
}

- (CGFloat)zy_centerX
{
    return self.center.x;
}

- (CGFloat)zy_centerY
{
    return self.center.y;
}

- (CGFloat)zy_width
{
    return self.frame.size.width;
}

- (CGFloat)zy_height
{
    return self.frame.size.height;
}

- (CGFloat)zy_x
{
    return self.frame.origin.x;
}

- (CGFloat)zy_y
{
    return self.frame.origin.y;
}

@end
