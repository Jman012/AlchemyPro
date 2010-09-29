//
//  Element.h
//
//  Created by Alexander Nabavi-Noori on 9/27/10.
//  Copyright 2010 Alexander Nabavi-Noori. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Element;

@protocol ElementDelegate <NSObject>
@required
- (void)elementWasTouchedWithName:(NSString *)name andID:(int)ID;
@end

@interface Element : UILabel {
	NSString	*elementName;
	int			elementID;
	id			<ElementDelegate> delegate;
}

@property (nonatomic, retain) NSString	*elementName;
@property (nonatomic) int		elementID;
@property (nonatomic, retain) id <ElementDelegate> delegate;

- (void)setDelegate:(id <ElementDelegate>)dlg;


@end
