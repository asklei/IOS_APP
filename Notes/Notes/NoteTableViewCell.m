//
//  NoteTableViewCell.m
//  Notes
//
//  Created by Lei Xu on 7/24/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "NoteTableViewCell.h"

@implementation NoteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    return self;
}

@end
