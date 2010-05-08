//
//  Monster.m
//  Cocos2DProject
//
//  Created by Sei Hyung Lee on 10. 4. 23..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Monster.h"


@implementation CCMonster

+(void) spawn
{
	CCMonster *monster = [CCMonster spriteWithFile: @"CuteChicken.png"];
	
	monster->speed = CELL_SIZE / MONSTER_TICK_TIME;
	monster->cellIndex = 0;
	CGPoint position = [gTileMapLayer positionAt:[HelloWorld getCellCoordinateAtIndex:monster->cellIndex]];
	
	[monster setScale: 0.3f];
	[monster setPosition:position];
	[monster setAnchorPoint:ccp(0.f, 0.f)];
	
	[gLayer addMonster:monster];

	//NSLog(@"anchor point: %f, %f", monster.anchorPoint.x, monster.anchorPoint.y); 
	//
	//NSLog(@"pos %f, %f, rect pos %f, %f, rect size %f, %f", position.x, position.y,
	//	  monster.textureRect.origin.x, monster.textureRect.origin.y, 
	//	  monster.textureRect.size.width, monster.textureRect.size.height);

	//NSLog(@"layer width %f height %f", tileMapLayer.layerSize.width, tileMapLayer.layerSize.height);
	//for (int x = 0; x < tileMapLayer.layerSize.width; ++x)
	//{
	//	for (int y = 0; y < tileMapLayer.layerSize.height; ++y)
	//	{
	//		int myGid = [tileMapLayer tileGIDAt: ccp(x, y)];
	//		NSLog(@"GID: %d", myGid);
	//	}
	//}
	
	[monster moveToNextCell:MONSTER_TICK_TIME];
	
	[monster schedule:@selector(tick:) interval:MONSTER_TICK_TIME];
	//[monster schedule:@selector(update:)];
}

//-(void) despawn:(ccTime)dt
//{
//	[gLayer removeChild:self cleanup:YES];
//}

-(void) despawn
{
	[gLayer removeMonster:self];
}

-(void) moveToNextCell:(ccTime)dt
{
	CGPoint nextPos = [gTileMapLayer positionAt:[HelloWorld getCellCoordinateAtIndex:++cellIndex]];
	CCAction *spriteMoveToAction = [CCMoveTo actionWithDuration:dt position:nextPos];
	[self runAction:spriteMoveToAction];
}

-(void) tick:(ccTime)dt
{
	if (![HelloWorld isEndPointAtIndex:cellIndex])
	{
		[self moveToNextCell:dt];
	}
	else
	{
		[self despawn];
		//[self schedule:@selector(despawn:) interval:dt];
	}	
}	

-(int) getCellIndex
{
	return cellIndex;
}

-(float) getSpeed
{
	return speed;
}


@end
