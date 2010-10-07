// Element.m
#import "Element.h"
#import "Alchemy_ProViewController.h"

@implementation Element


@synthesize controller, elementName, elementID, delegate;
@synthesize startPosition;

- (void)setDelegate:(id <ElementDelegate>)dlg {
	delegate = dlg;
}

- (id)init {
    if((self = [super init])){
        self.userInteractionEnabled = TRUE;
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}

- (void)loadVisualViews {
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    [backgroundImage setImage:[UIImage imageNamed:@"ElementBackground2.png"]];
    [backgroundImage setOpaque:TRUE];
    [self addSubview:backgroundImage];
    [backgroundImage release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, 64, 21)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setAdjustsFontSizeToFitWidth:TRUE];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:elementName];
    [self addSubview:label];
    [label release];
    
    UIImageView *mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 5, 32, 32)];
    [mainImage setImage:[UIImage imageNamed:@"SampleElementIcon2.png"]];
    [mainImage setOpaque:TRUE];
    [self addSubview:mainImage];
    [mainImage release];
    
    NSLog(@"%@", controller.firstElementComboTaken);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint pt = [[touches anyObject] locationInView:self];
    startPosition = pt;
    [[self superview] bringSubviewToFront:self];
	[delegate elementWasTouchedWithName:elementName andID:elementID];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGRect frame = [self frame];
    frame.origin.x += pt.x - startPosition.x;
    frame.origin.y += pt.y - startPosition.y;
    if(frame.origin.x >= 0 &&
       frame.origin.y >= 0 &&
       frame.origin.x <= 352 &&
       frame.origin.y <= 252){
        self.frame = frame;
    }
    
//    NSLog(@"%i, %i", (int)self.frame.origin.x, (int)self.frame.origin.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    pt = pt; // Only for not getting a warning
}

- (void)dealloc {
    [super dealloc];
}

@end
