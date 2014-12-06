//
//  ScrollImageView.m
//  JinBaiWan
//
//  Created by wei on 12-10-22.
//
//

#import "ScrollImageView.h"
#import "MJPhoto.h"
#import "GMContentNewsScrollModel.h"
@implementation ScrollImageView
@synthesize delegatePush;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        miIndex = 0;
        mPicArray = [[NSMutableArray alloc]initWithCapacity:0];
        imageArray=[[NSMutableArray alloc] initWithCapacity:0];
        mScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        mScrollView.delegate = self;
        mScrollView.pagingEnabled = YES;
        mScrollView.showsVerticalScrollIndicator = NO;
        mScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:mScrollView];
        [mScrollView release];
        
//        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        backBtn.frame = self.bounds;
//        [backBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [mScrollView addSubview:backBtn];
        
    }
    return self;
}
-(void)dealloc
{
     
    if (timer) {
        [timer invalidate];
        [timer release];
        timer=nil;
    }
    [imageArray release];
    [mPicArray release];
        [super dealloc];
}
//-(void)setFrame:(CGRect)frame{
//    [super setFrame:frame];
//    mScrollView.contentSize = CGSizeMake([mPicArray count]*self.frame.size.width, self.frame.size.height);
//    int iWideth = self.frame.size.width;
//    int iHeight = self.frame.size.height;
//    for (int i=0; i<[mPicArray count]; i++) {
//        int iLeft = i *iWideth;
//        mImgView.Frame = CGRectMake(iLeft, 0, iWideth, iHeight);
//        mImgView.tag = i+100;
//    }
//    mScrollView.contentOffset = CGPointMake(mScrollView.frame.size.width *miIndex, 0);
//    iWideth = frame.size.width < frame.size.height ? frame.size.width:frame.size.height;
//}
- (void)SetImageList:(NSArray *)array
{
    [mPicArray removeAllObjects];
    [imageArray removeAllObjects];
    [mPicArray addObjectsFromArray:array];
   
    mScrollView.contentSize = CGSizeMake(mScrollView.frame.size.width *mPicArray.count, mScrollView.frame.size.height);
    int iWideth = self.frame.size.width;
    int iHeight = self.frame.size.height;
    for (int i=0; i<mPicArray.count; i++) {
     
        GMContentNewsScrollModel *dict = [mPicArray objectAtIndex:i];
        int iLeft = i * iWideth;
        UIImageView *mImgView = [[UIImageView alloc]initWithFrame:CGRectMake(iLeft, 0, iWideth, iHeight)];
        [mImgView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        mImgView.contentMode =  UIViewContentModeScaleAspectFill;
        mImgView.clipsToBounds=YES;
        [mImgView setImageURL:[NSURL URLWithString:dict.newsImagePath] placeholder:nil];
        [mScrollView addSubview:mImgView];
        [imageArray addObject:mImgView];
        [mImgView release];
        UILabel *title=[[UILabel alloc]init];
        title.frame=CGRectMake(iLeft, self.frame.size.height-25, self.frame.size.width, 20);
        title.backgroundColor=[UIColor clearColor];
        title.textAlignment=NSTextAlignmentCenter;
        title.textColor=[UIColor whiteColor];
        title.font=[UIFont systemFontOfSize:15];
        title.text=dict.newsTitle;
        [mScrollView addSubview:title];
        
    }
    if (!pageControl) {
        pageControl = [[MyPageControl alloc] initWithFrame:CGRectMake(mScrollView.frame.size.width-100, mScrollView.frame.size.height+mScrollView.frame.origin.y-30, 100, 30)];
        pageControl.userInteractionEnabled = NO;
        pageControl.backgroundColor = [UIColor clearColor];
        [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        [self insertSubview:pageControl atIndex:1];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:89.0f/255.0f green:105.0f/255.0f blue:108.0f/255.0f alpha:1];
        pageControl.pageIndicatorTintColor = [UIColor colorWithRed:177.0f/255.0f green:187.0f/255.0f blue:192.0f/255.0f alpha:1];
        [pageControl release];
    }
    [self bringSubviewToFront:pageControl];
    pageControl.numberOfPages = mPicArray.count;
    [pageControl setCurrentPage:0];
    currentPage_ =0;
    if (timer) {
        [timer invalidate];
        [timer release];
        timer=nil;
    }
    timer = [[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES]retain];
}
-(void)removeFromSuperview
{
    if (timer) {
        [timer invalidate];
        [timer release];
        timer=nil;
    }
    [super removeFromSuperview];
}
-(void)pageTurn:(id)sender
{
//    int index = ((UIPageControl *)sender).currentPage;
//    [mScrollView setContentOffset:CGPointMake(index *self.frame.size.width, 0) animated:YES];    
//    [pageControl setCurrentPage:index];
}

-(void)handleTimer:(NSInteger)sender
{
   // NSLog(@"timer");
    if (currentPage_%mPicArray.count==0) {
        currentPage_ = 0;
    }
        

    [mScrollView setContentOffset:CGPointMake(currentPage_ *self.frame.size.width, 0) animated:YES];

 
        backBtn.frame=CGRectMake(currentPage_*self.frame.size.width, 0, mScrollView.frame.size.width, mScrollView.frame.size.height);
        backBtn.tag=100+currentPage_;
        [self bringSubviewToFront:backBtn];
    [pageControl setCurrentPage:currentPage_];
    currentPage_++;

    
}
-(void)buttonPressed:(id)sender
{
    
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//	
//	//scrollview结束滚动时判断是否已经换页
//	if (mScrollView.contentOffset.x > 320.0)
//	{
//		//如果是最后一张图片，则将主imageview内容置为第一张图片
//		//如果不是最后一张图片，则将主imageview内容置为下一张图片
//		if (currentPage_ < (totalPages_ - 1))
//		{
//			currentPage_ ++;
////			imageView.image = ((UIImageView *)[array objectAtIndex:currentPage_]).image;
//		}
//		else
//		{
//			currentPage_ = 0;
////			imageView.image = ((UIImageView *)[array objectAtIndex:currentPage_]).image;
//		}
//		
//	}
//	else if (mScrollView.contentOffset.x < 320.0)
//	{
//		//如果是第一张图片，则将主imageview内容置为最后一张图片
//		//如果不是第一张图片，则将主imageview内容置为上一张图片
//		if (currentPage_ > 0)
//		{
//			currentPage_ --;
////			imageView.image = ((UIImageView *)[array objectAtIndex:currentPage_]).image;
//		}
//		else
//		{
//			currentPage_ = totalPages_ - 1;
////			imageView.image = ((UIImageView *)[array objectAtIndex:currentPage_]).image;
//		}
//	}
//	else
//	{
//		//没有换页，则主imageview仍然为之前的图片
////		imageView.image = ((UIImageView *)[array objectAtIndex:currentPage_]).image;
//		NSLog(@"current offset :%f", mScrollView.contentOffset.x);
//	}
//	//始终将scrollview置为第2页
//	[mScrollView setContentOffset:CGPointMake(320.0, 0.0)];
//	//移除scrollview上的图片
//	for (UIImageView *theView in [mScrollView subviews])
//	{
//		[theView removeFromSuperview];
//	}
//	pageControl.currentPage = currentPage_;
//}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
	float  x= mScrollView.contentOffset.x;
	int i=x/self.frame.size.width;
	mPageContrl.currentPage=i;
    [pageControl setCurrentPage:i];
    currentPage_=i;
    backBtn.frame=CGRectMake(i*self.frame.size.width, 0, mScrollView.frame.size.width, mScrollView.frame.size.height);
    backBtn.tag=100+currentPage_;
    [self bringSubviewToFront:backBtn];
    //NSLog(@"%d",currentPage_);
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
