//
//  GMPlatCell.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/30.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMPlateModel.h"
@interface GMPlatCell : UITableViewCell
-(void)restView:(GMPlateSubModel*)subModel;
+(float)cellHigth:(GMPlateSubModel *)subModel;
@end
