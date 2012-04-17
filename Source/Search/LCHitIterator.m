#import  "LCHitIterator.h"
#import  "LCHits.h"
#import  "LCHit.h"


@implementation LCHitIterator

- (id) init
{
	self = [super init];
	hitNumber = 0;
	return self;
}

- (id) initWithHits: (LCHits *) h
{
	self = [self init];
	hits = h;
	return self;
}

- (void) dealloc
{
	hits=nil;;
}

- (BOOL) hasNext
{
	if (hitNumber < [hits count])
		return YES;
	return NO;
} 

- (LCHit *) next
{
	if (hitNumber == [hits count])
	{
		NSLog(@"Not such element exception");
		return nil;
	}
	
	LCHit *next = [[LCHit alloc] initWithHits: hits index: hitNumber];
	hitNumber++;
	
	return next;
}

- (int) count
{
	return [hits count];
}

@end
