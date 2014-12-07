//
//  GMAddDifferentTitleController.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/7.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMAddDifferentTitleController.h"
#import "TouchView.h"
#import "TopTitleSubListModel.h"
@interface GMAddDifferentTitleController ()
{
    NSMutableArray * _viewArr1;
    NSMutableArray * _viewArr2;
    UILabel * _titleLabel;
    UILabel * _titleLabel2;
    NSMutableArray *serverList;
}
@end

@implementation GMAddDifferentTitleController
-(void)dealloc
{
    [_viewArr1 removeAllObjects];
    _viewArr1 =nil;
    [_viewArr2 removeAllObjects];
    _viewArr2=nil;
    serverList=nil;
    _modelList=nil;
    _titleLabel=nil;
    _titleLabel2=nil;
}
-(void)loadAllData
{
    serverList=[[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0;i<10;i++) {
        TopTitleSubListModel *model=[[TopTitleSubListModel alloc]init];
        model.titID=@"2";
        model.title=[NSString stringWithFormat:@"测试%d",i];
        [serverList addObject:model];
    }
}
-(NSString *)getNotMoveString
{
    if (_modelList.count) {
        TopTitleSubListModel *mode=[_modelList objectAtIndex:0];
        return mode.title;
    }
    return @"";
}
- (void)viewDidLoad {
    [self loadAllData];
    self.view.backgroundColor=[UIColor whiteColor];
    [self showBackButton];
    [super viewDidLoad];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 40)];
    _titleLabel.text = @"我的订阅";
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor colorWithRed:187/255.0 green:1/255.0 blue:1/255.0 alpha:1.0]];
    [self.view addSubview:_titleLabel];
    
    
    
    _titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(110, KTableStartPointY + KButtonHeight * ([self array2StartY] - 1) + 22, 100, 20)];
    _titleLabel2.text = @"更多频道";
    [_titleLabel2 setFont:[UIFont systemFontOfSize:10]];
    [_titleLabel2 setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel2 setTextColor:[UIColor grayColor]];
    [self.view addSubview:_titleLabel2];
    _viewArr1 = [[NSMutableArray alloc] init];
    _viewArr2 = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < _modelList.count; i++) {
        TopTitleSubListModel *model=[_modelList objectAtIndex:i];
        TouchView * touchView = [[TouchView alloc] initWithFrame:CGRectMake(KTableStartPointX + KButtonWidth * (i%5), KTableStartPointY + KButtonHeight * (i/5), KButtonWidth, KButtonHeight)];
        [touchView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        
        [_viewArr1 addObject:touchView];
        touchView->_array = _viewArr1;
        if (i == 0) {
            [touchView.label setTextColor:[UIColor colorWithRed:187/255.0 green:1/255.0 blue:1/255.0 alpha:1.0]];
        }
        else{
            
            [touchView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
        }
        touchView.label.text = model.title;
        touchView.cantMoveStr=[self getNotMoveString];
        [touchView.label setTextAlignment:NSTextAlignmentCenter];
        [touchView setMoreChannelsLabel:_titleLabel2];
        touchView->_viewArr11 = _viewArr1;
        touchView->_viewArr22 = _viewArr2;
        touchView.model=model;
        [self.view addSubview:touchView];
    }
    
//    
    for (int i = 0; i < serverList.count; i++) {
         TopTitleSubListModel *model=[serverList objectAtIndex:i];
        TouchView * touchView = [[TouchView alloc] initWithFrame:CGRectMake(KTableStartPointX + KButtonWidth * (i%5), KTableStartPointY + [self array2StartY] * KButtonHeight + KButtonHeight * (i/5), KButtonWidth, KButtonHeight)];
        
        [touchView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
        
        [_viewArr2 addObject:touchView];
        touchView->_array = _viewArr2;
        
        
        touchView.label.text = model.title;
        [touchView.label setTextColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1.0]];
         touchView.cantMoveStr=[self getNotMoveString];
        [touchView.label setTextAlignment:NSTextAlignmentCenter];
        [touchView setMoreChannelsLabel:_titleLabel2];
        touchView->_viewArr11 = _viewArr1;
        touchView->_viewArr22 = _viewArr2;
        touchView.model=model;
        [self.view addSubview:touchView];
    }
    

    // Do any additional setup after loading the view.
}
- (unsigned long )array2StartY{
    unsigned long y = 0;
    
    y = self.modelList.count/5 + 2;
    if (_modelList.count%5 == 0) {
        y -= 1;
    }
    return y;
}
-(BOOL)isChange:(NSMutableArray *)list
{
    if (list.count!=_modelList.count) {
        return YES;
    }
    for (int i=0; i<_modelList.count; i++) {
        TopTitleSubListModel *model1=[_modelList objectAtIndex:i];
        TopTitleSubListModel *model2=[list objectAtIndex:i];
        if (![model1.title isEqualToString:model2.title]) {
            return YES;
        }
    }
    return NO;
}
-(void)BaseClickBackButton:(id)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMAddDifferentTitleControllerDelegateBack:)]) {
        NSMutableArray *list=[[NSMutableArray alloc]initWithCapacity:0];
        
        for (TouchView *view in _viewArr1) {
            if (view.model) {
                [list addObject:view.model];
            }
        }
        if ([self isChange:list]) {
            [self.delegate GMAddDifferentTitleControllerDelegateBack:list];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
