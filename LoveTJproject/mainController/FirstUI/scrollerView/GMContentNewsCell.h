//
//  GMContentNewsCell.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/6.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMContentNewsModel.h"
#define GMContentNewsCell_TitleFont [UIFont systemFontOfSize:18]
#define GMContentNewsCell_ContentFont [UIFont systemFontOfSize:13]



#define GMContentNewsCell_Default_Top 10
#define GMContentNewsCell_Default_left 9
#define GMContentNewsCell_Default_image 70

#define GMContentNewsCell_images_place 5
#define GMContentNewsCell_images_Top 30
#define GMContentNewsCell_images_Width ([UIScreen mainScreen].bounds.size.width-GMContentNewsCell_Default_left*2-GMContentNewsCell_images_place*2)/3

@interface GMContentNewsCell : UITableViewCell
{
    UIView *line;
}
-(void)restModel:(GMContentNewsModel *)model;
+(float)cellHight:(GMContentNewsModel *)model;
@end
