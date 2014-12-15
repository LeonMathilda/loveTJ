//
//  GMPhotoScrollView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/15.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMPhotoScrollView.h"
#import "GMPhotoView.h"
#import "GMPhoto.h"
@interface GMPhotoScrollView()<UIScrollViewDelegate>
{
    NSMutableArray *photos;
    NSMutableArray *viewList;
}
@end
@implementation GMPhotoScrollView
-(id)init
{
    self=[super init];
    if (self) {
        self.delegate=self;
        viewList=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)show:(NSMutableArray *)list
{
    photos=list;
    [self restView];
}
-(void)showViewIndex:(NSInteger)index
{
    CGRect bounds = self.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * self.padding);
    photoViewFrame.origin.x = (bounds.size.width * index) + self.padding;
    if ([self photosHasView:index]) {
        UIView *view=[self getPhotosView:index];
        if (![view isDescendantOfView:self]) {
            [self addSubview:view];
        }
        view.frame=photoViewFrame;
    }

}
-(BOOL)photosHasView:(NSInteger)index
{
    if (photos.count>index) {
        if ([self getPhotosView:index]) {
            return YES;
        }
    }
    return NO;
}
-(UIView *)getPhotosView:(NSInteger)index
{
    if (photos.count>index) {
     GMPhoto *photo=[photos objectAtIndex:index];
     return photo.view;
    }
    return nil;
}
-(BOOL)isShowingPhotoViewAtIndex:(NSInteger)index
{
    for (UIView *view in viewList) {
        if (view.tag-100==index) {
            return YES;
        }
    }
    return NO;
}
-(void)showView
{
    //暂时没有做view的重用 以后加
     self.contentSize=CGSizeMake(self.frame.size.width*photos.count, self.frame.size.height);
    float x=0;
    for (GMPhoto *photo in photos) {
        if ([self photosHasView:[photos indexOfObject:photo]]) {
            UIView *view=[self getPhotosView:[photos indexOfObject:photo]];
            if (![view isDescendantOfView:self]) {
                [self addSubview:view];
            }
            view.frame=CGRectMake(x, 0, self.frame.size.width-self.padding*2, self.frame.size.height);
            x+=self.frame.size.width;
        }else
        {
            GMPhotoView *view =[[GMPhotoView alloc]init];
            view.photo=photo;
            view.frame=CGRectMake(x, 0, self.frame.size.width-self.padding*2, self.frame.size.height);
            [self addSubview:view];
            x+=self.frame.size.width;
        }
    }
    
    /*
    CGRect visibleBounds = self.bounds;
    int firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+self.padding*2) / CGRectGetWidth(visibleBounds));
    int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-self.padding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= photos.count) firstIndex = photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= photos.count) lastIndex = photos.count - 1;
    
    
    NSInteger photoViewIndex;
    for (GMPhotoView *photoView in viewList) {
        photoViewIndex =photoView.tag-100;
        if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
            [photoView removeFromSuperview];
        }
    }
    for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
        if (![self isShowingPhotoViewAtIndex:index]) {
            [self showViewIndex:index];
        }
    }
//    for (int i=0 ;i<photos.count ;i++) {
//    }
//    NSLog(@"%d---%d",firstIndex,lastIndex);
     */
}
-(void)restView
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [viewList removeAllObjects];
    self.contentSize=CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self showView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegateView&&[self.delegateView respondsToSelector:@selector(GMPhotoScrollViewDelegateIndex:)]) {
        int i=self.contentOffset.x/self.frame.size.width;
        [self.delegateView GMPhotoScrollViewDelegateIndex:i];
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
