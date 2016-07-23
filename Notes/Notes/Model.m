//
//  Model.m
//  Notes
//
//  Created by Lei Xu on 7/20/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "Model.h"
#import "Notes.h"
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

//-(void)saveNote:(Note *)note {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:note.title forKey:@"title"];
//    [defaults setObject:note.detail forKey:@"detail"];
//    [defaults synchronize];
//}
//-(Note *)loadNote {
//    //note should be saved here
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *title = [defaults stringForKey:@"title"];
//    NSString *detail = [defaults stringForKey:@"detail"];
//    Note *note;
//    if (title && detail) {
//        note = [[Note alloc] initWithTitle:title detail:detail];
//    } else {
//        note = [[Note alloc] initWithTitle:@"" detail:@""];
//    }
//    return note;
//}
@end
