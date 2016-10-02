//
//  TalkTableViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "TalkTableViewCell.h"

@interface TalkTableViewCell ()
@property(nonatomic, strong)UILabel * myLabel;
@property(nonatomic, strong)UIImageView * bgImage;
@property(nonatomic, strong)UIImageView * quoImage;
@property(nonatomic, strong)UILabel * timeLabl;

@property(nonatomic, strong)TalkMessageModel * model;
@property(nonatomic, assign)float cellHeight;
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
    _bgImage = [[UIImageView alloc] init];
    _bgImage.image = [[UIImage imageNamed:@"rc_left_chat_wind.9"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    [self addSubview:_bgImage];
    
    _quoImage = [[UIImageView alloc] init];
    _quoImage.image = [UIImage imageNamed:@"black_yh"];
    [self.bgImage addSubview:_quoImage];
    
    _myLabel = [[UILabel alloc] init];
    _myLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    _myLabel.textAlignment = NSTextAlignmentLeft;
    _myLabel.numberOfLines = 0;
    [self.bgImage addSubview:_myLabel];
    
    _timeLabl = [[UILabel alloc] init];
    _timeLabl.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    _timeLabl.font = [UIFont systemFontOfSize:14];
    _timeLabl.textAlignment = NSTextAlignmentCenter;
    [self.bgImage addSubview:_timeLabl];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _bgImage.frame = CGRectMake(10, 10, (self.width-20)/2, self.cellHeight+40);
    
    _quoImage.frame = CGRectMake(15, 5, 10, 10);
    
    _myLabel.frame = CGRectMake(CGRectGetMaxX(_quoImage.frame)+5, 10, _bgImage.width-30, self.cellHeight);
    
    _timeLabl.frame = CGRectMake(10, CGRectGetMaxY(_myLabel.frame)+10, _bgImage.width-30, 15);
}

-(void)setCellValue:(TalkMessageModel *)model{
    CGSize size = CGSizeMake((self.width-20)/2, MAXFLOAT);
    CGFloat height = [model.requirement_text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    self.cellHeight = height;
    
    _myLabel.text = model.requirement_text;
    
    _timeLabl.text = model.create_time;
}

-(void)setCellString:(NSString *)talkStr{
    CGSize size = CGSizeMake((self.width-20)/2, MAXFLOAT);
    CGFloat height = [talkStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    self.cellHeight = height;

    _myLabel.text = talkStr;
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
