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

- (Notes *)notes {
    if (!_notes) {
        _notes = [[Notes alloc] initWithNotes:[self loadNotes]];
    }
    return _notes;
}

-(NSString *)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return ([documentsDirectoryPath stringByAppendingPathComponent:@"noteData"]);
}

-(void)saveNotes {
    [NSKeyedArchiver archiveRootObject:self.notes.notes toFile:[self filePath]];
}

-(NSArray *)loadNotes {
    NSArray *notesArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    if (!notesArray) {
        notesArray = @[];
    }
    return(notesArray);
}

@end
