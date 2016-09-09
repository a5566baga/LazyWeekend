//
//  TalkTableViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "TalkTableViewCell.h"

@interface TalkTableViewCell ()
@property(nonatomic, assign)UILabel * myLabel;
@property(nonatomic, strong)UIImageView * bgImage;
@property(nonatomic, strong)UIImageView * quoImage;
@property(nonatomic, strong)UILabel * timeLabl;
@end

@implementation TalkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initForCell];
    }
    return self;
}

-(void)initForCell{
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(float)cellHeight{
    return 20;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
