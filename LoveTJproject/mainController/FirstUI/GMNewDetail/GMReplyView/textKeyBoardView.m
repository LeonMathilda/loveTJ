//
//  textKeyBoardView.m
//  MaiKeDuo
//
//  Created by hepburn X on 13-1-4.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import "textKeyBoardView.h"
#define textKeyBoardView_leftPlace 5
#define textKeyBoardView_textView_higth 34

#define textKeyBoardView_KeboardShow_Hight (textKeyBoardView_Default_Hight+50+textKeyBoardView_textView_higth)
@interface textKeyBoardView()<UITextViewDelegate>
@end
@implementation textKeyBoardView
@synthesize textView;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(textKeyBoardView *)shar:(id<textKeyBoardViewDelegate>)delegateValue y:(float)y
{
    
    return [[textKeyBoardView alloc  ]initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, textKeyBoardView_KeboardShow_Hight) withY:y delegate:delegateValue] ;
}
-(void)restTextRigthtView:(BOOL)show
{
    if (!show) {
        btnFace.hidden=YES;
        btnSend.hidden=NO;
        btnLocation.hidden=NO;
        textView.frame=CGRectMake(textView.frame.origin.x, textView.frame.origin.y, self.frame.size.width-2*textView.frame.origin.x, textKeyBoardView_textView_higth*2);
        btnSend.frame=CGRectMake(btnSend.frame.origin.x, textView.frame.size.height+textView.frame.origin.y+10, btnSend.frame.size.width, btnSend.frame.size.height);
        btnLocation.frame=CGRectMake(btnLocation.frame.origin.x, btnSend.frame.origin.y, btnLocation.frame.size.width, btnLocation.frame.size.height);
        btnLocation.center=CGPointMake(btnLocation.center.x, btnSend.center.y);
    }else
    {
        btnSend.hidden=YES;
        btnFace.hidden=NO;
        btnLocation.hidden=YES;
        textView.frame=CGRectMake(textView.frame.origin.x, textView.frame.origin.y, btnFace.frame.origin.x-2*textView.frame.origin.x, textKeyBoardView_textView_higth);
    }
}
-(id)initWithFrame:(CGRect)frame withY:(float)y delegate:(id<textKeyBoardViewDelegate>)dele
{
        if (self=[super initWithFrame:frame]) {
            yHeight=y;
            self.textView=[[UITextView alloc] initWithFrame:CGRectMake(textKeyBoardView_leftPlace, (textKeyBoardView_Default_Hight-textKeyBoardView_textView_higth)/2, frame.size.width-textKeyBoardView_leftPlace*3, textKeyBoardView_textView_higth)] ;
//            textView.borderStyle=UITextBorderStyleNone;
            textView.backgroundColor=[UIColor clearColor];
            textView.layer.masksToBounds=YES;
            textView.layer.cornerRadius=6;
            textView.layer.borderColor=[UIColor grayColor].CGColor;
            textView.layer.borderWidth=0.5;
            textView.delegate=self;
            textView.font=[UIFont systemFontOfSize:15];
            textView.returnKeyType=UIReturnKeyDefault;
            [self addSubview:textView];
            self.delegate=dele;
            btnFace=[UIButton buttonWithType:UIButtonTypeCustom];
            [btnFace addTarget:self action:@selector(showEmojiView:) forControlEvents:UIControlEventTouchUpInside];
            btnFace.frame=CGRectMake(frame.size.width-65-textKeyBoardView_leftPlace, 0, 65, textView.frame.size.height);
            btnFace.layer.borderColor=[[UIColor lightGrayColor]CGColor];
            btnFace.layer.cornerRadius=4;
            btnFace.layer.borderWidth=0.6;
            [btnFace setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btnFace.titleLabel.font=[UIFont systemFontOfSize:14];
            btnFace.backgroundColor=[UIColor clearColor];
            btnFace.center=CGPointMake(btnFace.center.x, textView.center.y);
            [self addSubview:btnFace];
            btnFace.hidden=YES;
            btnSend=[UIButton buttonWithType:UIButtonTypeCustom];
            [btnSend setBackgroundImage:[CustomMethod createImageWithColor:[UIColor colorWithRed:30.0f/255.0f green:144.0f/255.0f blue:1 alpha:0.8] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
            btnSend.layer.masksToBounds=YES;
            btnSend.layer.cornerRadius=6;
            [btnSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnSend setTitle:@"发送" forState:UIControlStateNormal];
                btnSend.titleLabel.adjustsFontSizeToFitWidth=YES;
            [btnSend addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
            btnSend.frame=CGRectMake(frame.size.width-60-textKeyBoardView_leftPlace, 5, 60, 34);
            btnSend.hidden=YES;
            btnSend.enabled=NO;
            [self addSubview:btnSend];
            
            btnLocation=[UIButton buttonWithType:UIButtonTypeCustom];
            btnLocation.frame=CGRectMake(10, 0, 200, 30);
            btnLocation.backgroundColor=[UIColor clearColor];
            btnLocation.titleLabel.font=[UIFont systemFontOfSize:13];
            btnLocation.layer.cornerRadius=4;
            [btnLocation addTarget:self action:@selector(clickLoaction) forControlEvents:UIControlEventTouchUpInside];
            btnLocation.layer.borderColor=[[UIColor lightGrayColor]CGColor];
            btnLocation.layer.borderWidth=1;
            [btnLocation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnLocation setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            
            placeLabel=[[UILabel alloc]init];
            placeLabel.frame =CGRectMake(textView.frame.origin.x+4, textView.frame.origin.y+7, 200, 20);
            placeLabel.text = nil;
            placeLabel.textColor=[UIColor lightGrayColor];
            placeLabel.font=[UIFont systemFontOfSize:15];
            placeLabel.enabled = NO;
            placeLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:placeLabel];
            [self addSubview:btnLocation];
            btnLocation.hidden=YES;
            [self setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
            [self addNotification];
            [self restTextRigthtView:YES];
        }
        return self;
}
-(void)setTextViewRigthTitle:(NSString *)title
{
    [btnFace setTitle:title forState:UIControlStateNormal];
}
-(void)setTextViewLocationTitle:(NSString *)title
{
    float width=[GGUtil text:title sizeWithFont:btnLocation.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    if (width>200) {
        width=200;
    }
    btnLocation.frame=CGRectMake(btnLocation.frame.origin.x, btnLocation.frame.origin.y, width+10, btnLocation.frame.size.height);
    [btnLocation setTitle:title forState:UIControlStateNormal];
}
-(void)setTextViewPlaceTitle:(NSString *)title
{
    placeLabel.text=title;
}
-(void)addNotification
{
    [self removeNotification];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(viewChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyDidshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)showEmojiView:(UIButton *)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(textkeyBoardViewKeyboardClickRigthBtn)]) {
        [self.delegate textkeyBoardViewKeyboardClickRigthBtn];
    }
}
-(void)sendMessage
{
        if (delegate&&[delegate respondsToSelector:@selector(textKeyBoardViewSendMessageForDefault:info:)]) {
            [delegate textKeyBoardViewSendMessageForDefault:textView.text info:infoValue];
        }
}
-(void)clickLoaction
{
    if (delegate&&[self.delegate respondsToSelector:@selector(textkeyBoardViewKeyboardClickLocation)]) {
        [self.delegate textkeyBoardViewKeyboardClickLocation];
    }
}
-(void)sendFaceBoard
{
    [self sendMessage];
}
-(void)show:(id)info
{
    infoValue=info;
    [textView becomeFirstResponder];
}
-(void)showValue:(id)info
{
    infoValue=info;
}
-(void)hiden
{
    [textView resignFirstResponder];
    textView.text=nil;
    textView.inputView=nil;
    [textView reloadInputViews ];
    placeLabel.text=nil;

}
-(void)viewChange:(NSNotification *)notification
{
        
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [self restTextRigthtView:YES];
    if (self.superview!=nil) {
        if ([self.superview viewWithTag:1111]) {
            [[self.superview   viewWithTag:1111] removeFromSuperview];
        }
    }
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:animationDuration];
     self.frame=CGRectMake(self.frame.origin.x, yHeight, self.frame.size.width, self.frame.size.height);
   // scroller.frame=CGRectMake(scroller.frame.origin.x, 0, scroller.frame.size.width, scroller.frame.size.height);
    [UIView commitAnimations];
    if ([delegate respondsToSelector:@selector(textkeyBoardViewKeyboardHiden)]) {
        [delegate textkeyBoardViewKeyboardHiden];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMessage];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView;
{
    if (self.textView.text.length) {
        btnSend.enabled=YES;
        placeLabel.hidden=YES;
    }else
    {
        btnSend.enabled=NO;
        placeLabel.hidden=NO;
    }

}
-(void)dealloc
{
    delegate=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)regist
{
    [self hiden];
    if (delegate&&[delegate respondsToSelector:@selector(textKeyBoardViewSendMessageForDefault:info:)]) {
        [delegate textKeyBoardViewSendMessageForDefault:nil info:infoValue];
    }
}
-(void)willshow:(NSNotification *)notification
{
    [self restTextRigthtView:NO];
    [self textViewDidChange:self.textView];
        if (self.superview!=nil) {
        if (![self.superview viewWithTag:1111]) {
        UIControl *control=[[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [control addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
        [self.superview addSubview:control];
        control.tag=1111;
        }
                [self.superview bringSubviewToFront:self];
        }
    NSValue* aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
        CGRect keyboardRect = [aValue CGRectValue];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        if (IOS7_OR_LATER) {
            
         self.frame=CGRectMake(self.frame.origin.x,self.superview.frame.size.height- (keyboardRect.size.height-([UIScreen mainScreen].bounds.size.height-self.superview.frame.origin.y-self.superview.frame.size.height))-self.frame.size.height, self.frame.size.width, self.frame.size.height);
       }else{
           
         self.frame=CGRectMake(self.frame.origin.x, self.superview.frame.size.height-keyboardRect.size.height-self.frame.size.height+([self viewController].tabBarController.tabBar.hidden?0:49), self.frame.size.width, self.frame.size.height);
      }
        [UIView commitAnimations];
    if (delegate&&[delegate respondsToSelector:@selector(textKeyBoardViewKeyboardFrameChange:)]) {
        [delegate textKeyBoardViewKeyboardFrameChange:keyboardRect.size.height];
    }
} 

//键盘出现事件
-(void)keyDidshow:(NSNotification *)notification
{
    if (self) {
        [self performSelector:@selector(willshow:) withObject:notification afterDelay:0];
    }
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
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
