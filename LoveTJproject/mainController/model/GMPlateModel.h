//
//  GMPlateModel.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/30.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "GMPlateSubModel.h"
@interface GMPlateModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSMutableArray *list;//must be GMPlateSubModel
@property(nonatomic,assign)BOOL isOpen;
@end
