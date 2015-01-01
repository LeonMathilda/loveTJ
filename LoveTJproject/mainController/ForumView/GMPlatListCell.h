//
//  GMPlatListCell.h
//  LoveTJproject
//
//  Created by yunqi on 15/1/1.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMPlatListSubList.h"
@interface GMPlatListCell : UITableViewCell
{
    UIView *line;
}
-(void)restCell:(GMPlatListSubList *)subModel;
+(float)cellHigth:(GMPlatListSubList *)subModel;
@end
