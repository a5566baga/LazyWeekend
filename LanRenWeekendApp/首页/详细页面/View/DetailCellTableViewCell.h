//
//  DetailCellTableViewCell.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/10.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCellTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^heightToCell)(double height);
-(void)setCellStyle:(NSDictionary *)dic;

@end
