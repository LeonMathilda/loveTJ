//
//  GMNewsReplyView.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMNewsReplyView : UIView
{
    UITableView *mTableView;
}
-(void)reloadData:(NSString *)newsID;
@end
