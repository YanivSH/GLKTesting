//
//  ViewController.m
//  GLKTesting
//
//  Created by Yaniv Marshaly on 7/4/13.
//  Copyright (c) 2013 Sketch Heroes LTD. All rights reserved.
//

#import "ViewController.h"
/////////////////////////////////////////////////////////////////
// This data type is used to store information for each vertex
typedef struct {
    GLKVector3  positionCoords;
}
SceneVertex;

@interface ViewController ()

@property (strong,nonatomic) GLKBaseEffect * effect;
@property (nonatomic, strong) NSData * pointsAsData;
@end

@implementation ViewController{
    NSMutableData * _mutablePoints;
    GLKMatrix4 _projectionMatrix;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPoints];
    
    [self setupGL];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidLayoutSubviews
{
    CGRect newBounds = self.view.bounds;
	newBounds.origin = CGPointMake(-self.view.bounds.size.width/2.0,
                                   -self.view.bounds.size.height/2.0);
	self.view.bounds = newBounds;
//	// Generate our projection matrix in response to changes to our view's coordinates
//	_projectionMatrix = GLKMatrix4MakeOrtho(
//											-self.view.bounds.size.width/2.0,
//											self.view.bounds.size.width/2.0,
//											self.view.bounds.size.height/2.0,
//											-self.view.bounds.size.height/2.0,
//											-1024, 1024);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupGL
{
    EAGLContext * context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    GLKView * view = (GLKView*)self.view;
    view.context = context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;

    [EAGLContext setCurrentContext:context];
    
    self.effect = [[GLKBaseEffect alloc]init];
    self.effect.useConstantColor = GL_TRUE;
    self.effect.constantColor = GLKVector4Make(0.1, 0.8, 0.9, 1.0);
    
    GLKTextureInfo * texureInfo = [GLKTextureLoader textureWithCGImage:[UIImage imageNamed:@"brush"].CGImage options:nil error:nil];
    self.effect.texture2d0.enabled = GL_TRUE;
    self.effect.texture2d0.target = texureInfo.target;
    self.effect.texture2d0.name = texureInfo.name;
    
    
}

-(void)update
{
    self.effect.transform.modelviewMatrix = GLKMatrix4Identity;
    // Generate our projection matrix in response to changes to our view's coordinates
	self.effect.transform.projectionMatrix = GLKMatrix4MakeOrtho(
                                                                     -self.view.bounds.size.width/2.0,
                                                                     self.view.bounds.size.width/2.0,
                                                                     self.view.bounds.size.height/2.0,
                                                                     -self.view.bounds.size.height/2.0,
                                                                     2.0, -2.0);

}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT );
    
	[self.effect prepareToDraw];
	
	//Pass the vertices
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0,(void *)self.points);
	
	// do actual drawing!
    glDrawArrays(GL_TRIANGLE_FAN, 0, self.pointCount);
	glDisableVertexAttribArray(GLKVertexAttribPosition);
}
- (CGPoint*)mutablePointData
{
	if(_mutablePoints == nil)
		_mutablePoints = [NSMutableData dataWithData:self.pointsAsData];
	return [_mutablePoints mutableBytes];
}
/*
 Add a new point to the current line
 */
- (void)addPoint:(CGPoint)p
{
	[self mutablePointData]; // Create our bytes
	[_mutablePoints appendBytes:&p length:sizeof(CGPoint)];
}

- (CGPoint*)points
{
	if (_mutablePoints )
		return (CGPoint*)_mutablePoints.bytes;
	else
		return (CGPoint*)self.pointsAsData.bytes;
}
- (int)pointCount
{
	if ( _mutablePoints )
		return _mutablePoints.length / sizeof(CGPoint);
	else
		return self.pointsAsData.length / sizeof(CGPoint);
}
-(void)setupPoints
{
//    [self addPoint:CGPointMake(166, 120)];
//    [self addPoint:CGPointMake(173, 120)];
//    [self addPoint:CGPointMake(166, 120)];
//    [self addPoint:CGPointMake(170.95, 124.95)];
//    [self addPoint:CGPointMake(166, 127)];
//    [self addPoint:CGPointMake(166, 120)];
//    [self addPoint:CGPointMake(161.05, 124.95)];
//    [self addPoint:CGPointMake(159, 120)];
//    [self addPoint:CGPointMake(166, 120)];
//    [self addPoint:CGPointMake(161.05, 115.05)];
//    [self addPoint:CGPointMake(166, 113)];
//    [self addPoint:CGPointMake(166, 120)];
//    [self addPoint:CGPointMake(170.95, 115.05)];
//    [self addPoint:CGPointMake(173, 120)];
//    [self addPoint:CGPointMake(166, 120)];
//    [self addPoint:CGPointMake(166, 120)];
//    [self addPoint:CGPointMake(166, 113)];
//    [self addPoint:CGPointMake(166, 127)];
//    [self addPoint:CGPointMake(165, 113)];
//    [self addPoint:CGPointMake(165, 127)];
//    [self addPoint:CGPointMake(169.95, 115.05)];
//    [self addPoint:CGPointMake(160.05, 124.95)];
//    [self addPoint:CGPointMake(168.95, 114.05)];
//    [self addPoint:CGPointMake(159.05, 123.95)];
//    [self addPoint:CGPointMake(166.214, 112.359)];
//    [self addPoint:CGPointMake(161.786, 125)];
//    [self addPoint:CGPointMake(163.214, 111.359)];
//    [self addPoint:CGPointMake(158.786, 124)];
//    [self addPoint:CGPointMake(165.2, 112.4)];
//    [self addPoint:CGPointMake(156.8, 123.6)];
//    [self addPoint:CGPointMake(161.2, 109.4)];
//    [self addPoint:CGPointMake(152.8, 120.6)];
//    [self addPoint:CGPointMake(160.883, 109.176)];
//    [self addPoint:CGPointMake(153.117, 120.824)];
//    [self addPoint:CGPointMake(157.883, 107.176)];
//    [self addPoint:CGPointMake(150.117, 118.824)];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    [self addPoint:[touch locationInView:self.view]];
}
 
@end
