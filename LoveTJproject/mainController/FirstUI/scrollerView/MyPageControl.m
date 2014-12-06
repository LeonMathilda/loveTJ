//
//  MyPageControl.m
//  JinBaiWan
//
//  Created by wei on 12-10-22.
//
//

#import "MyPageControl.h"

@implementation MyPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
        activeImage = [UIImage imageNamed:@"click_down.png"]  ;
        inactiveImage = [UIImage imageNamed:@"click_n.png"];
    }
    return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        activeImage = [UIImage imageNamed:@"click_down.png"] ;
        inactiveImage = [UIImage imageNamed:@"click_n.png"];
    }
    
    return self;
}
- (void)drawRect:(CGRect)iRect
{
//    int i;
//    CGRect rect;
//    UIImage *image;
//    
//    iRect = self.bounds;
//    
//    if (self.opaque) {
//        [self.backgroundColor set];
//        UIRectFill(iRect);
//    }
//    
//    CGFloat _kSpacing = 0;
//    
//    if (self.hidesForSinglePage && self.numberOfPages == 1) {
//        return;
//    }
//    
//    rect.size.height = activeImage.size.height;
//    rect.size.width = self.numberOfPages * activeImage.size.width + (self.numberOfPages - 1) * _kSpacing;
//    rect.origin.x = floorf((iRect.size.width - rect.size.width) / 2.0);
//    rect.origin.y = floorf((iRect.size.height - rect.size.height) / 2.0);
//    rect.size.width = activeImage.size.width;
//    
//    for (i = 0; i < self.numberOfPages; ++i) {
//        image = (i == self.currentPage) ? activeImage : inactiveImage;
//        [image drawInRect:rect];
//        rect.origin.x += activeImage.size.width + _kSpacing;
//    }
}
-(void) updateDots
{
    //[self setNeedsDisplay];
//    for (int i = 0; i < [self.subviews count]; i++) {
//        
//        UIImageView* dot = [self.subviews objectAtIndex:i];
//        
//        if (i == self.currentPage) {
//            
//            if ( [dot isKindOfClass:UIImageView.class] ) {
//                
//                ((UIImageView *) dot).image = activeImage;
//            }
//            else {
//                
//                dot.backgroundColor = [UIColor colorWithPatternImage:activeImage];
//            }
//        }
//        else {
//            
//            if ( [dot isKindOfClass:UIImageView.class] ) {
//                
//                ((UIImageView *) dot).image = inactiveImage;
//            }
//            else {
//                
//                dot.backgroundColor = [UIColor colorWithPatternImage:inactiveImage];
//            }
//        }
//    }
}
-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
//    for (NSUInteger i = 0; i < [self.subviews count]; i++) {
//        UIImageView* subview = [self.subviews objectAtIndex:i];
//        CGSize size;
//        size.height = 20;
//        size.width = 20;
//        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
//                                     size.width,size.height)];
//        if (i == page)
//            [subview setImage:[UIImage imageNamed:@"click_down.png"]];
//        else
//            [subview setImage:[UIImage imageNamed:@"click_n.png"]];
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
