//
//  Notes.m
//  Notes
//
//  Created by Lei Xu on 7/21/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "Notes.h"
#import "Note.h"

@implementation Notes
-(id)initWithNotes:(NSArray *)notes {
    self = [super init];
    if (!self) {
        return nil; //something went wrong!
    }
    for(id note in notes) {
        if (![note isKindOfClass:[Note class]]) {
            return nil;
        }
    }
    self.notes = [notes mutableCopy];
    return self;
}

-(Note *)getNoteAtIndex:(NSInteger)index {
    return self.notes[index];
}

-(void)addNote:(Note *)note {
    [self.notes addObject:note];
}

-(NSInteger)count {
    return self.notes.count;
}

-(Note *)deleteNoteAtIndex:(NSInteger)index {
    Note *n = [self getNoteAtIndex:index];
    [self.notes removeObjectAtIndex:index];
    return n;
}

-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    Note *tmp = [self getNoteAtIndex:toIndex];
    self.notes[toIndex] = self.notes[fromIndex];
    self.notes[fromIndex] = tmp;
}

@end
