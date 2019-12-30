//
//  CollectionViewHeaderView.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "CollectionViewHeaderView.h"

@implementation CollectionViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGBA(254, 254, 254, 1);
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 100, 17)];
        
        self.title.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        [self.title setTextColor:[UIColor blackColor]];
        
        self.title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.title];
    }
    return self;
}

@end
