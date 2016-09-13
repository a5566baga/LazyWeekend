//
//  UserSecondSettingCollectionViewCell.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSecondSettingCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)UIButton * imageView;
@property(nonatomic , strong)UIButton * titleButton;

-(void)setCellDetail:(NSString *)imageSelStr imageCancel:(NSString *)imageCancelStr titleName:(NSString *)titleName;

-(void)setCellSelectedStatus:(NSNumber *)status;

@end
