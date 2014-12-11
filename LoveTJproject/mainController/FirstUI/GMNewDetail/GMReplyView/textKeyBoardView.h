//
//  textKeyBoardView.h
//  MaiKeDuo
//
//  Created by hepburn X on 13-1-4.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import <UIKit/UIKit.h>
#define textKeyBoardView_Default_Hight 46
@protocol textKeyBoardViewDelegate  <NSObject>
@optional
-(void)textKeyBoardViewSendMessageForDefault:(NSString *)str info:(id )info;
-(void)textKeyBoardViewKeyboardFrameChange:(float)height;
-(void)textkeyBoardViewKeyboardHiden;
-(void)textkeyBoardViewKeyboardClickRigthBtn;
-(void)textkeyBoardViewKeyboardClickLocation;
@end
@interface textKeyBoardView : UIView<UITextFieldDelegate>
{
        float yHeight;
       // SEL onSend;
        id infoValue;
    UIButton *btnFace;
    UIButton *btnSend;
    UIButton *btnLocation;
    UILabel *placeLabel;
    
}
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,assign)id<textKeyBoardViewDelegate> delegate;

+(textKeyBoardView *)shar:(id<textKeyBoardViewDelegate>)delegateValue y:(float)y;

-(id)initWithFrame:(CGRect)frame  withY:(float)y delegate:(id<textKeyBoardViewDelegate>)dele;
-(void)show :(id)info;
-(void)showValue:(id)info;
-(void)hiden;

-(void)removeNotification;
-(void)addNotification;

-(void)setTextViewRigthTitle:(NSString *)title;
-(void)setTextViewLocationTitle:(NSString *)title;
-(void)setTextViewPlaceTitle:(NSString *)title;
@end
