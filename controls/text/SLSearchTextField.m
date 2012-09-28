//
//  SLSearchTextField.m
//
//  Created by Aaron Brethorst on 9/23/12.
//
//

#import "SLSearchTextField.h"

@interface SLSearchTextField ()
- (void)_configureView;
@end

@implementation SLSearchTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _configureView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self)
    {
        [self _configureView];
    }

    return self;
}

- (void)_configureView
{
    self.placeholder = NSLocalizedString(@"Search", @"");
    self.borderStyle = UITextBorderStyleNone;
    self.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.background = [[UIImage imageNamed:@"search_bar_border"] stretchableImageWithLeftCapWidth:17 topCapHeight:15];
    self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

#pragma mark - Drawing and Positioning

- (CGRect)borderRectForBounds:(CGRect)bounds
{
    NSLog(@"IN:  %s: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(bounds));
    CGRect outRect = [super borderRectForBounds:bounds];
    NSLog(@"OUT: %s: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(outRect));

    return outRect;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    NSLog(@"IN:  %s: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(bounds));
    CGRect outRect = [super textRectForBounds:bounds];
    return CGRectOffset(outRect, 2, 4);
    NSLog(@"OUT: %s: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(outRect));

    return outRect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    NSLog(@"IN:  %s: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(bounds));
    CGRect outRect = [super placeholderRectForBounds:bounds];
    NSLog(@"OUT: %s: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(outRect));

    return outRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectOffset([super editingRectForBounds:bounds], 2, 4);
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect outRect = [super clearButtonRectForBounds:bounds];
    return outRect;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectOffset([super leftViewRectForBounds:bounds], 8, 0);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return [super rightViewRectForBounds:bounds];
}

- (void)drawTextInRect:(CGRect)rect
{
//    [[UIColor redColor] set];
//    UIRectFill(rect);

    [super drawTextInRect:rect];
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
//    [[UIColor redColor] set];
//    UIRectFill(rect);

    [super drawPlaceholderInRect:rect];
}

@end
