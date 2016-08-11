//
// Created by Dariusz Rybicki on 12/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "CollectionViewUpdaterExampleCell.h"

@implementation CollectionViewUpdaterExampleCell {
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadSubviews];
        [self setupLayout];
    }
    return self;
}

#pragma mark - Subviews

- (void)loadSubviews
{
    [self.contentView addSubview:self.label];
}

- (UILabel *)label
{
    if (!_label) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.font = [UIFont boldSystemFontOfSize:24];
        label.textColor = [UIColor whiteColor];
        _label = label;
    }
    return _label;
}

#pragma mark - Layout

- (void)setupLayout
{
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.label.superview addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.label
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.label.superview
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.f
                                      constant:0.f],
        [NSLayoutConstraint constraintWithItem:self.label
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.label.superview
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.f
                                      constant:0.f]
    ]];
}

@end
