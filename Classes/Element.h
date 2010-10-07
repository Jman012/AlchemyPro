//
//  Element.h
//
//  Created by Alexander Nabavi-Noori on 9/27/10.
//  Copyright 2010 Alexander Nabavi-Noori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "Alchemy_ProViewController.h"

@class Element;
@class Alchemy_ProViewController;

@protocol ElementDelegate <NSObject>
@required
- (void)elementWasTouchedWithName:(NSString *)name andID:(int)ID;
@end

@interface Element : UIView {
    Alchemy_ProViewController *controller;
    
	NSString                *elementName;
	int                     elementID;
	id                      <ElementDelegate> delegate;
    CGPoint                 startPosition;

    
}

@property (nonatomic, retain) Alchemy_ProViewController *controller;
@property (nonatomic, retain)   NSString            *elementName;
@property (nonatomic)           int                 elementID;
@property (nonatomic, retain)   id                  <ElementDelegate> delegate;
@property (nonatomic) CGPoint startPosition;



- (void)setDelegate:(id <ElementDelegate>)dlg;
- (void)loadVisualViews;

@end
