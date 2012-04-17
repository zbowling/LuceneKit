#import  "LCSegmentMergeInfo.h"


@implementation LCSegmentMergeInfo
- (id) initWithBase: (int) b termEnumerator: (LCTermEnumerator *) te
			 reader: (LCIndexReader *) r
{
	self = [super init];
	base = b;
	reader = r;
	termEnum = te;
	term = [te term];
	postings = nil;
	docMap = nil;
	return self;
}

- (void) dealloc
{
	reader=nil;;
	termEnum=nil;;
	term=nil;;
	postings=nil;;
	docMap=nil;;
}
	
- (NSArray *) docMap
{
    if (docMap == nil)
    {
    // build array which maps document numbers around deletions 
	if ([reader hasDeletions]) {
		int maxDoc = [reader maximalDocument];
		docMap = [[NSMutableArray alloc] init];
		int j = 0;
		int i;
		for (i = 0; i < maxDoc; i++) {
			if ([reader isDeleted: i])
				[docMap addObject: [NSNumber numberWithInt: -1]];
			else
				[docMap addObject: [NSNumber numberWithInt: j++]];
		}
    }
    }
	return docMap;
}

- (id <LCTermPositions>) postings
{
	if (postings == nil) {
		postings = [reader termPositions];
	}
	return postings;
}

- (BOOL) hasNextTerm
{
    if ([termEnum hasNextTerm]) {
		term = [termEnum term];
		return YES;
    } else {
		term=nil;;
		return NO;
    }
}

- (void) close
{
    [termEnum close];
    if (postings != nil) {
	    [postings close];
	}
}

- (LCTerm *) term { return term; }
- (LCTermEnumerator *) termEnumerator { return termEnum; }
- (int) base { return base; }
- (NSString *) description
{ 
	return [NSString stringWithFormat: @"LCSegmentMergeInfo %@, base %d", term, base];
}

- (NSComparisonResult) compare: (id) o
{
	LCSegmentMergeInfo *other = (LCSegmentMergeInfo *) o;
	NSComparisonResult comparison = [[self term] compare: [other term]];
	if (comparison == NSOrderedSame)
    {
		if ([self base] < [other base])
			return NSOrderedAscending;
		else if ([self base] > [other base])
			return NSOrderedDescending;
		else
			return NSOrderedSame;
    }
	else
		return comparison;
}

@end
