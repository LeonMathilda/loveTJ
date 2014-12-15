//
//  GMPhotoView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/11.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMPhotoView.h"
#import "GMPhotoButtomView.h"
@interface GMPhotoView()<UIScrollViewDelegate>
{
    UIImageView *_imageView;
    GMPhotoButtomView *buttomView;
}
@end

@implementation GMPhotoView
-(id)init
{
    self=[super init];
    if (self) {
        [self initData];
    }
    return self;
}
-(void)initData
{
    self.clipsToBounds = YES;
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor=[UIColor clearColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    buttomView=[[GMPhotoButtomView alloc]init];
    
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delaysTouchesBegan = YES;
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];

}
-(void)handleSingleTap:(UITapGestureRecognizer *)ges
{
    
}
-(void)handleDoubleTap:(UITapGestureRecognizer *)ges
{
    
}
-(void)restScale
{
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = _imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    // 设置伸缩比例
    CGFloat minScale = boundsWidth / imageWidth;
    if (minScale > 1) {
        minScale = 1.0;
    }
    CGFloat maxScale = 2.0;
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        maxScale = maxScale / [[UIScreen mainScreen] scale];
    }
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
    } else {
        imageFrame.origin.y = 0;
    }
    _imageView.frame = imageFrame;
}
-(void)setPhoto:(GMPhoto *)photo
{
    _photo=photo;
    [buttomView contentStr:_photo.title];
    __weak GMPhotoView *sself=self;
    __weak  UIImageView *siamge=_imageView;
    __weak GMPhoto *sphoto=photo;
    [[[SDWebImageManager sharedManager]imageDownloader]downloadImageWithURL:[NSURL URLWithString:photo.url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (finished&&image&&sself&&siamge&&sphoto) {
            [[SDWebImageManager sharedManager].imageCache storeImage:image recalculateFromImage:YES imageData:data forKey:sphoto.url toDisk:YES];
            siamge.image=image;
            [sself restScale];
        }
    }];
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if (![buttomView isDescendantOfView:newSuperview]) {
        [newSuperview addSubview:buttomView];
    }
    [super willMoveToSuperview:newSuperview];
}
-(void)didMoveToSuperview
{
    [self.superview bringSubviewToFront:buttomView];
    [super didMoveToSuperview];
}
-(void)setFrame:(CGRect)frame
{
    _imageView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    if (![buttomView isDescendantOfView:self.superview]) {
        [self.superview addSubview:buttomView];
    }
    buttomView.frame=CGRectMake(frame.origin.x, frame.size.height-100, frame.size.width, 100);
    [super setFrame:frame];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}
- (void)dealloc
{
    [_imageView setImageWithURL:[NSURL URLWithString:@"file:///abc"]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
