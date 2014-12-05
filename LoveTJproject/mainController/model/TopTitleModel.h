//
//  TopTitleModel.h
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "TopTitleSubListModel.h"
@interface TopTitleModel : ITTBaseModelObject
@property(nonatomic,retain)NSMutableArray *list;//content is TopTitleSubListModel.h
@end
