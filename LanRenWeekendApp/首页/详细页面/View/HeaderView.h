//
//  HeaderView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/10.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

/**
 *  添加header的内容
 */
-(void)setHeaderStyle:(NSArray *)imageArray title:(NSString *)title price_info:(NSString *)price_info type:(NSString *)type iconStr:(NSString *)iconStr timeStr:(NSString *)timeStr locationStr:(NSString *)locationStr;

@end
