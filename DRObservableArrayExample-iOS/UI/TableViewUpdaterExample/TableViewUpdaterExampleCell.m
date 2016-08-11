//
// Created by Dariusz Rybicki on 12/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "TableViewUpdaterExampleCell.h"

@implementation TableViewUpdaterExampleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
