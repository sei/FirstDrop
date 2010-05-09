//
//  drag.m
//  Cocos2DProject
//
//  Created by 현철 박 on 10. 5. 12..
//  Copyright 2010 우리집. All rights reserved.
//

#import "drag.h"
#import "HelloWorldScene.h"


@implementation CDrag

+(void) spawn:(NSString*)filename;
{
	CDrag *spDrag = [CDrag spriteWithFile: filename];
		
	[spDrag setScale: 0.3f];
	[spDrag setOpacity:200];
	[spDrag setVisible:NO];
	
	[gLayer addDrag:spDrag];
}

-(void) TouchesBegan : (NSSet *)touches
{
	for( UITouch *touch in touches ) {
		
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];

		[self setPosition:location];		
		[self setVisible:YES];
	}
}

-(void) TouchesMove : (NSSet *)touches
{
	for( UITouch *touch in touches ) {
		
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		[self setPosition:location];
	}
}

-(void) TouchesEnd : (NSSet *)touches
{
	[self setVisible:NO];
}

@end
