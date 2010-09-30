//
//  Element.h
//
//  Created by Alexander Nabavi-Noori on 9/27/10.
//  Copyright 2010 Alexander Nabavi-Noori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Element;

@protocol ElementDelegate <NSObject>
@required
- (void)elementWasTouchedWithName:(NSString *)name andID:(int)ID;
@end

@interface Element : UIView {
	NSString	*elementName;
	int			elementID;
	id			<ElementDelegate> delegate;
    IBOutlet UIView *boardView;
    CGPoint         startPosition;
}

@property (nonatomic, retain) NSString	*elementName;
@property (nonatomic) int		elementID;
@property (nonatomic, retain) id <ElementDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIView *boardView;

- (void)setDelegate:(id <ElementDelegate>)dlg;


@end
