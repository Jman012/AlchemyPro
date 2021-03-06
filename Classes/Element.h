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
@optional
- (void)elementWasTouchedWithName:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event;
- (void)elementWasMovedWithName:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event;
- (void)elementTouchEnded:(NSString *)name andID:(NSString *)ID touch:(NSSet *)touches andEvent:(UIEvent *)event;
@end

@interface Element : UIView {    
	NSString                    *elementName;
	NSString                    *elementID;
	id                          <ElementDelegate> delegate;
    CGPoint                     startPosition;

    UIImageView                 *selectedOverview;
}

@property (nonatomic, retain) NSString                      *elementName;
@property (nonatomic, retain) NSString                      *elementID;
@property (nonatomic, retain) id                            <ElementDelegate> delegate;
@property (nonatomic)         CGPoint                       startPosition;
@property (nonatomic, retain) UIImageView                   *selectedOverview;



- (void)setDelegate:(id <ElementDelegate>)dlg;
- (void)loadVisualViews;
- (BOOL)isValid;
- (id)initWithName:(NSString *)name andID:(NSString *)ID;
- (void)trash;
- (void)setSelected:(BOOL)isSelected;
- (BOOL)isSelected;

@end
