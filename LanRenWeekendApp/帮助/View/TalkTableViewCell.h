//
//  TalkTableViewCell.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalkMessageModel.h"

@interface TalkTableViewCell : UITableViewCell

-(void)setCellValue:(TalkMessageModel *)model;

-(void)setCellString:(NSString *)talkStr;

@end
