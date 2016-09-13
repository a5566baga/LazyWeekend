//
//  DetailCellTableViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/10.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "DetailCellTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <UCZProgressView.h>

@interface DetailCellTableViewCell ()

@property(nonatomic, strong)NSDictionary * dic;
@property(nonatomic, strong)UIImageView * picImage;
@property(nonatomic, strong)UILabel * txtLabel;

@property(nonatomic, strong)UCZProgressView * progressView;

@end

@implementation DetailCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)initForViewText{
    _txtLabel = [[UILabel alloc] init];
    _txtLabel.font = [UIFont fontWithName:@"Gotham-Light" size:18];
    _txtLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    _txtLabel.numberOfLines = 0;
    _txtLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_txtLabel];
}

-(void)initForViewImg{
    _picImage = [[UIImageView alloc] init];
    [self addSubview:_picImage];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([_dic[@"type"] isEqualToString:@"text"]) {
        CGSize mySize = CGSizeMake(self.width-20, CGFLOAT_MAX);
        CGSize size = [_dic[@"content"] boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        _txtLabel.frame = CGRectMake(10, 10, self.width-20, size.height);
    }else{
        NSArray * size = _dic[@"size"];
        float width = [size[0] floatValue];
        float height = [size[1] floatValue];
        _picImage.frame = CGRectMake(0, 10, self.width, self.width * (height/width));
    }
}

-(void)setCellStyle:(NSDictionary *)dic{
    _dic = dic;
    if ([_dic[@"type"] isEqualToString:@"text"]) {
        [self initForViewText];
        _txtLabel.text = _dic[@"content"];
    }else{
        [self initForViewImg];
        _progressView = [[UCZProgressView alloc] init];
        _progressView.center = CGPointMake(self.width/2, self.height/2);
        _progressView.size = CGSizeMake(60, 60);
        _progressView.indeterminate = YES;
        _progressView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_progressView];
        [_picImage sd_setImageWithURL:[NSURL URLWithString:_dic[@"content"]] placeholderImage:[UIImage imageNamed:@"angle-mask@3x"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _picImage.image = image;
            [_progressView removeFromSuperview];
        }];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
