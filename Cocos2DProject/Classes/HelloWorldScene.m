//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "Monster.h"
#import "Tower.h"

HelloWorld *gLayer; 
CCTMXLayer *gTileMapLayer;
int mapTowers[CELL_COUNT_X][CELL_COUNT_Y];

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		self.isTouchEnabled = YES;
		
		// create and initialize a Label
		//CCLabel* label = [CCLabel labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		//CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		//label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		//[self addChild: label];
		
		gLayer = self;
		m_drag = nil;
		m_selectedUI = 0;
		
		tileMap = [CCTMXTiledMap tiledMapWithTMXFile: @"FirstTileMap.tmx"];
		[self addChild:tileMap];
		
		gTileMapLayer = [tileMap layerNamed: @"Layer 0"];
	
		monsters = [[NSMutableArray alloc] init];
		touchables = [[NSMutableArray alloc] init];

		[CDrag spawn:@"MushroomRed.png"];
		
		CGPoint uiPos = ccp( 2, 0);//2 * CELL_SIZE, 0 );
//		uiPos = [CGPoint()];
		[CGameUI spawn:@"MushroomRed.png" withPosition:uiPos];
		
		[self buildCoordinatePath];

		// monster tick
		[self schedule:@selector(tick:) interval:1.f];

		memset(mapTowers, 0, sizeof(mapTowers));
	}
	return self;
}

-(void) setSelectedUI:(int)index
{
	m_selectedUI = index;
}

-(int) getSelectedUI
{
	return m_selectedUI;
}
// mouse event

- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		
//		if (
//		[self spawnTower:pos];
		if (nil != m_drag)
		{
			[m_drag TouchesEnd:touches];
		}
		
		for (CTouchable* touch in touchables) {
			[touch TouchesEnd:touches];
		}
		
	
	}
	return kEventHandled;
}

- (BOOL)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		if (nil != m_drag)
		{
			[m_drag TouchesMove:touches];
		}
		
		for (CTouchable* touch in touchables) {
			[touch TouchesMove:touches];
		}
		
		
		
	}
	return kEventHandled;
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
		if (nil != m_drag)
		{
			[m_drag TouchesBegan:touches];
		}
		
		for (CTouchable* touch in touchables) {
			[touch TouchesBegan:touches];
		}
		
	

	}
	return kEventHandled;
}

-(void) addMonster:(CCMonster*)monster
{
	[self addChild:monster];
	[monsters addObject:monster];
}

-(void) removeMonster:(CCMonster*)monster
{
	[monsters removeObject:monster];
	[self removeChild:monster cleanup:YES];
}

-(NSMutableArray*) getMonsters
{
	return monsters;
}

-(void) spawnTower : (CGPoint) location
{
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	CGPoint pos = ccp((int)(location.x / CELL_SIZE),
					  (int)((size.height - location.y) / CELL_SIZE));
	
	[CCTower spawn:pos];//
	
}

-(void) setDrag:(CDrag*)drag
{
	[self addChild:drag];
	m_drag = drag;
}

-(void) setDragOn:(bool)flag
{
	if (nil != m_drag)
	{
		[m_drag setCheckable:flag];
	}
}

-(void) addTouchable:(CTouchable*)touchable
{
	[self addChild:touchable];
	[touchables addObject:touchable];
}

-(void) removeTouchable:(CTouchable*)touchable
{
	[touchables removeObject:touchable];
	[self removeChild:touchable cleanup:YES];
}

-(NSMutableArray*) getTouchable
{
	return touchables;
}


-(NSMutableArray*) getCoordinatePath
{		
	return coordinatePath;
}

-(void) buildCoordinatePath
{
	CGPoint coordinate = START_POINT_COORDINATE;
	CGPoint prevCoordinate = START_POINT_COORDINATE;
	
	//coordinatePath = [NSMutableArray array];
	coordinatePath = [[NSMutableArray alloc] init];
	[coordinatePath addObject:[NSValue valueWithCGPoint:coordinate]];
	
	while (![HelloWorld isEndPoint:coordinate])
	{
		CGPoint nextCellCoordinate = [HelloWorld findNextCell:coordinate prevCoordinate:prevCoordinate];
		[coordinatePath addObject:[NSValue valueWithCGPoint:nextCellCoordinate]];
		
		prevCoordinate = coordinate;
		coordinate = nextCellCoordinate;
	}	
}

+(CGPoint) findNextCell:(CGPoint)coordinate prevCoordinate:(CGPoint)prevCoordinate
{
	//CGPoint position = [tileMapLayer positionAt:ccp(coordinate.x, coordinate.y)];
	
	CGPoint coordinateUp = ccp(coordinate.x, coordinate.y - 1);
	CGPoint coordinateDown = ccp(coordinate.x, coordinate.y + 1);
	CGPoint coordinateRight = ccp(coordinate.x + 1, coordinate.y);
	CGPoint coordinateLeft = ccp(coordinate.x - 1, coordinate.y);
	

	if ([self isInsideBoundary:coordinateUp] 
		&& !CGPointEqualToPoint(coordinateUp, prevCoordinate) 
		&& [self isPath:coordinateUp])
	{
		return coordinateUp;
	}
	else if ([self isInsideBoundary:coordinateDown] 
			 && !CGPointEqualToPoint(coordinateDown, prevCoordinate) 
			 && [self isPath:coordinateDown])
	{
		return coordinateDown;
	}
	else if ([self isInsideBoundary:coordinateRight] 
			 && !CGPointEqualToPoint(coordinateRight, prevCoordinate) 
			 && [self isPath:coordinateRight])
	{
		return coordinateRight;
	}
	else if ([self isInsideBoundary:coordinateLeft] 
			 && !CGPointEqualToPoint(coordinateLeft, prevCoordinate) 
			 && [self isPath:coordinateLeft])
	{
		return coordinateLeft;
	}
	
	return START_POINT_COORDINATE;
}

+(bool) isPath:(CGPoint)tileCoordinate
{
	int tileGid = [gTileMapLayer tileGIDAt:tileCoordinate];
	return tileGid == TILE_PATH_GID || tileGid == TILE_END_POINT_GID;
}

+(bool) isEndPoint:(CGPoint)tileCoordinate
{
	int tileGid = [gTileMapLayer tileGIDAt:tileCoordinate];
	return tileGid == TILE_END_POINT_GID;
}

+(bool) isInsideBoundary:(CGPoint)tileCoordinate
{
	return tileCoordinate.x >= -1 && tileCoordinate.y >= -1 
	&& tileCoordinate.x < gTileMapLayer.layerSize.width && tileCoordinate.y < gTileMapLayer.layerSize.height;
}

+(CGPoint) getCellCoordinateAtIndex:(int)cellIndex
{
	NSValue *cellValue = [[gLayer getCoordinatePath] objectAtIndex:cellIndex];
	return [cellValue CGPointValue];
}

+(int) getTileGidAtIndex:(int)cellIndex
{
	CGPoint coordinate = [self getCellCoordinateAtIndex:cellIndex];
	return [gTileMapLayer tileGIDAt:coordinate];
}

+(bool) isEndPointAtIndex:(int)cellIndex
{
	return [self getTileGidAtIndex:cellIndex] == TILE_END_POINT_GID;
}




// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void) tick:(ccTime)dt
{
	[CCMonster spawn];
}

@end
