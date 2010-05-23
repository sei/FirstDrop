//
//  gameui.m
//  Cocos2DProject
//
//  Created by 현철 박 on 10. 5. 14..
//  Copyright 2010 우리집. All rights reserved.
//

#import "gameui.h"
#import "HelloWorldScene.h"

@implementation CGameUI

+(void) spawn:(NSString*)filename withPosition:(CGPoint)coordinate;
{
	
	CGameUI *gui = [CGameUI spriteWithFile: filename];

	gui->posX = (int)coordinate.x;
	gui->posY = (int)coordinate.y;
	gui->index = 1;
	
	CGPoint postion = ccp( gui->posX * CELL_SIZE, gui->posY * CELL_SIZE);

	[gui setScale: 0.3f];
	[gui setPosition:postion];
	[gui setAnchorPoint:ccp(0.f, 0.f)];
	
	[gLayer addTouchable:gui];	
}

-(void) TouchesBegan : (NSSet *)touches
{
	for( UITouch *touch in touches ) {
		
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		//if (location.x > posX * CELL_SIZE && location.x < (posX + 1) * CELL_SIZE
//			&& location.y > posY * CELL_SIZE && location.y < (posY + 1) * CELL_SIZE)
//		{
//			[gLayer setDragOn];
//		}
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
		
		if (location.x > posX * CELL_SIZE && location.x < (posX + 1) * CELL_SIZE
			&& location.y > posY * CELL_SIZE && location.y < (posY + 1) * CELL_SIZE)
		{
			if (index != [gLayer getSelectedUI])
			{
				[gLayer setSelectedUI:index];
				[gLayer setDragOn:YES];
				[self setOpacity:200];
			} else {
				[gLayer setSelectedUI:0];
				[gLayer setDragOn:NO];
				[self setOpacity:255];
			}

			
		}
	}
	
}



@end
