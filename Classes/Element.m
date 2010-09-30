//
//  Element.m
//
//  Created by Alexander Nabavi-Noori on 9/27/10.
//  Copyright 2010 Alexander Nabavi-Noori. All rights reserved.
//

#import "Element.h"

@implementation Element

@synthesize elementID, delegate, elementName, boardView;


- (void)setDelegate:(id <ElementDelegate>)dlg {
	delegate = dlg;
}

- (id)init {
    if((self = [super init])){
        self.userInteractionEnabled = TRUE;
        [self setBackgroundColor:[UIColor lightGrayColor]];
        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
        [backgroundImage setImage:[UIImage imageNamed:@"ElementBackground2"]];
        [backgroundImage setOpaque:TRUE];
        [self addSubview:backgroundImage];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Send back a notification of a touch to the owner, including the photo ID and index
	CGPoint pt = [[touches anyObject] locationInView:self];
    startPosition = pt;
    NSLog(@"Element Touched! %f: %f", pt.x, pt.y);
    [[self superview] bringSubviewToFront:self];
	[delegate elementWasTouchedWithName:elementName andID:elementID];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGRect frame = [self frame];
    frame.origin.x += pt.x - startPosition.x;
    frame.origin.y += pt.y - startPosition.y;
    //Fix minor bugs, Elements gettign stuck on sides, may need alteration to original code ^
    if(frame.origin.x >= 0 &&
       frame.origin.y >= 0 &&
       frame.origin.x <= 352 &&
       frame.origin.y <= 252){
        self.frame = frame;
    }
}

@end
