//
//  Model.m
//  Notes
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "Model.h"
#import "Note.h"

@implementation Model
+ (Model *)sharedModel
{
    static Model* modelSingleton = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        modelSingleton = [[Model alloc] init];
    });
    return modelSingleton;
}

-(void)saveNote:(Note *)note {
    //note should be saved here
}
-(Note *)loadNote {
    //return a blank note for now
    Note *note = [[Note alloc] initWithTitle:@"" detail:@""];
    return note;
}
@end
