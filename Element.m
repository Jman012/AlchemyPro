//
//  Element.m
//
//  Created by Alexander Nabavi-Noori on 9/27/10.
//  Copyright 2010 Alexander Nabavi-Noori. All rights reserved.
//

#import "Element.h"


@implementation Element

@synthesize elementID, delegate, elementName;

- (void)setDelegate:(id <ElementDelegate>)dlg {
	delegate = dlg;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Send back a notification of a touch to the owner, including the photo ID and index
	CGPoint pt = [[touches anyObject] locationInView:self];
	[delegate elementWasTouchedWithName:elementName andID:elementID];
}

@end
