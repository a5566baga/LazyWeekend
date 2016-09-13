//
//  BodyCollectionView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/6.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowDetailViewController.h"
@interface BodyCollectionView : UIView

@property(nonatomic, copy)void(^jumpToShowDetailVC)(ShowDetailViewController * showDetailVC, NSString * catery);

@end
