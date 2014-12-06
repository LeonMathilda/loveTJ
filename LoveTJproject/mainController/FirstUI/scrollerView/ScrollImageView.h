//
//  ScrollImageView.h
//  JinBaiWan
//
//  Created by wei on 12-10-22.
//
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "MyPageControl.h"
@interface ScrollImageView : UIView<UIScrollViewDelegate>{
    UIScrollView *mScrollView;
    UIPageControl *mPageContrl;
    int miIndex;
    NSMutableArray *mPicArray;
    NSMutableArray *imageArray;
    MyPageControl *pageControl;
    int currentPage_;
    int totalPages_;
        UIButton *backBtn;
     NSTimer *timer;
}
@property(nonatomic,assign)id delegatePush;
- (void)SetImageList:(NSArray *)array;
@end
