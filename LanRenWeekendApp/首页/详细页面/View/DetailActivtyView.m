//
//  DetailActivtyView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/9.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "DetailActivtyView.h"

@interface DetailActivtyView ()

@property(nonatomic, strong)UITableView * tableView;

@end

@implementation DetailActivtyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForData];
        [self initForView];
    }
    return self;
}

-(void)initForData{
    
}

-(void)initForView{
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
