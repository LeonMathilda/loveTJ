//
//  PGToast.m
//  iToastDemo
//
//  Created by gong Pill on 12-5-21.
//  Copyright (c) 2012年 ceo softcenters. All rights reserved.
//

#import "PGToast.h"
#import <QuartzCore/QuartzCore.h>

#define bottomPadding 50
#define startDisappearSecond 1.5
#define disappeartDurationSecond 0.5

const CGFloat pgToastTextPadding     = 5;
const CGFloat pgToastLabelWidth      = 180;
const CGFloat pgToastLabelHeight     = 60;

@interface PGToast()

@property (nonatomic, copy) NSString *pgLabelText;
@property (nonatomic, retain) UILabel *pgLabel;

- (id)initWithText:(NSString *)text;    
//- (void)deviceOrientationChange;

@end

@implementation PGToast

@synthesize pgLabel;
@synthesize pgLabelText;

- (id)initWithText:(NSString *)text {

    if (self = [super init]) {
        self.pgLabelText = text;        
    }    
    return self;
}

- (void)dealloc {
    [pgLabel release];
    [pgLabelText release];
    [super dealloc];
}

+ (PGToast *)makeToast:(NSString *)text {
    PGToast *pgToast = [[PGToast alloc] initWithText:text];
    [pgToast show];
    return [pgToast autorelease];
}


- (void)show {
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize textSize = [pgLabelText sizeWithFont:font constrainedToSize:CGSizeMake(pgToastLabelWidth, pgToastLabelHeight)];
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    pgLabel = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-textSize.width + 2 * pgToastTextPadding)/2, 250, textSize.width + 2 * pgToastTextPadding, textSize.height + 2 * pgToastTextPadding)];
         }
        else
        {                            
                pgLabel = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-textSize.width + 2 * pgToastTextPadding)/2, [UIScreen mainScreen].bounds.size.height-300, textSize.width + 2 * pgToastTextPadding, textSize.height + 2 * pgToastTextPadding)];
        }
        
     pgLabel.backgroundColor = [UIColor blackColor];
    pgLabel.textColor = [UIColor whiteColor];
    pgLabel.layer.masksToBounds=YES;
    pgLabel.layer.cornerRadius = 7;
    pgLabel.layer.borderWidth = 1;
    pgLabel.numberOfLines = 2;
    pgLabel.font = font;
    pgLabel.textAlignment = NSTextAlignmentCenter;
    pgLabel.text = self.pgLabelText;
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        
        [window addSubview:self.pgLabel];
        
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:startDisappearSecond];

}

-(void)startAnimation
{
       
        
        CABasicAnimation *theAnimation;    
        
        theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];    
        
        theAnimation.duration=disappeartDurationSecond; 
        
        // theAnimation.beginTime = 0;    
        
        theAnimation.repeatCount=1;
        
        theAnimation.autoreverses=NO;    
        
        theAnimation.fromValue=[NSNumber numberWithFloat:1.0];    
        
        theAnimation.toValue=[NSNumber numberWithFloat:0];
        theAnimation.delegate=self;
        
        [self.pgLabel.layer addAnimation:theAnimation forKey:nil];
}

-(void)animationDidStart:(CAAnimation *)anim
{
    self.pgLabel.alpha=0;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{     
        [self.pgLabel removeFromSuperview];
}


@end
