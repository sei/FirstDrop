//
//  gameui.m
//  Cocos2DProject
//
//  Created by 현철 박 on 10. 5. 14..
//  Copyright 2010 우리집. All rights reserved.
//

#import "gameui.h"


@implementation CGameUI

+(void) spawn:(NSString*)filename;
{
}

-(void) TouchesBegan : (NSSet *)touches
{
	for( UITouch *touch in touches ) {
		
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
	}
}

-(void) TouchesMove : (NSSet *)touches
{
	for( UITouch *touch in touches ) {
		
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
	}
}

-(void) TouchesEnd : (NSSet *)touches
{
	for( UITouch *touch in touches ) {
		
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
	}
	
}



@end
