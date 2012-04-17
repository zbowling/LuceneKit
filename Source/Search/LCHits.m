#import  "LCHits.h"
#import  "LCSearcher.h"
#import  "LCFilter.h"
#import  "LCSort.h"
#import  "LCQuery.h"
#import  "LCTopDocs.h"
#import  "LCScoreDoc.h"
#import  "LCHitIterator.h"
#import  "LCDocument.h"


@interface LCHits (LCPrivate)
- (void) moreDocuments: (int) min;
- (LCHitDocument *) hitDocument: (int) n;
- (void) addToFront: (LCHitDocument *) hitDoc;
- (void) remove: (LCHitDocument *) hitDoc;
@end

@implementation LCHits
- (id) init
{
	self = [super init];
	filter = nil;
	sort = nil;
	hitDocs = [[NSMutableArray alloc] init];
	numDocs = 0;
	maxDocs = 200;
	return self;
}

- (void) dealloc
{
	hitDocs=nil;;
	weight=nil;;
	searcher=nil;;
	filter=nil;;
	sort=nil;;
        //Clean retain/release prev/next
        if (first)
          {
            LCHitDocument *hitDoc=first;
            while(hitDoc)
              {
                LCHitDocument *nextHitDoc=[hitDoc next];
                //No need to retain it because last one retain previouses
                [hitDoc setNext:nil];
                [nextHitDoc setPrev:nil];
                hitDoc=nextHitDoc;
              }
          }
	first=nil;;
	last=nil;;
}

- (id) initWithSearcher: (LCSearcher *) s
				  query: (LCQuery *) q
				 filter: (LCFilter *) f
{
	self = [self init];
	weight = [q weight: s];
	searcher = s;
	filter = f;
	[self moreDocuments: 50]; // retrieve 100 initially
	return self;
}

- (id) initWithSearcher: (LCSearcher *) s
				  query: (LCQuery *) q
				 filter: (LCFilter *) f
				   sort: (LCSort *) o
{
	self = [self init];
	weight = [q weight: s];
	searcher = s;
	filter = f;
	sort = o;
	[self moreDocuments: 50]; // retrieve 100 initially
	return self;
}

- (void) moreDocuments: (int)  min
{
	@autoreleasepool {
		if ([hitDocs count] > min) {
			min = [hitDocs count];
		}
		
		int n = min * 2; // double # retrieved
		LCTopDocs *topDocs;
		if (sort) {
			topDocs = (LCTopDocs *)[searcher search: weight filter: filter maximum: n sort: sort];
		}
		else {
			topDocs = [searcher search: weight filter: filter maximum: n];
		}
		
		length = [topDocs totalHits];
		NSArray * scoreDocs = [topDocs scoreDocuments];
		
		float scoreNorm = 1.0f;
		if (length > 0 && [topDocs maxScore] > 1.0f)
		{
			scoreNorm = 1.0f / [topDocs maxScore];
		}
		
		int end = ([scoreDocs count] < length) ? [scoreDocs count] : length;
		int i;
		for (i = [hitDocs count]; i < end; i++)
		{
			LCHitDocument *newDoc = [[LCHitDocument alloc] initWithScore: ([[scoreDocs objectAtIndex: i] score] * scoreNorm) 
															  identifier: [(LCScoreDoc *)[scoreDocs objectAtIndex: i] document]];
			[hitDocs addObject: newDoc];
		}
	}
}

- (NSUInteger) count 
{
	return length;
}

- (LCDocument *) document: (int) n
{
	LCHitDocument *hitDoc = [self hitDocument: n];
	
	// Update LRU cache of documents
	[self remove: hitDoc];               // remove from list, if there
	[self addToFront: hitDoc];           // add to front of list
	
	if (numDocs > maxDocs) {      // if cache is full
		LCHitDocument *oldLast = last;
		[self remove: last];             // flush last
		[oldLast setDocument: nil];       // let doc get gc'd
	}
	
	if ([hitDoc document] == nil) {
		[hitDoc setDocument: [searcher document: [hitDoc identifier]]];  // cache miss: read document
	}
	return [hitDoc document];
}

- (float) score: (int) n
{
	return [[self hitDocument: n] score];
}

- (int) identifier: (int) n
{
	return [[self hitDocument: n] identifier];
}

- (LCHitIterator *) iterator
{
	return [[LCHitIterator alloc] initWithHits: self];
}

- (LCHitDocument *) hitDocument: (int) n
{
	if (n >= length) {
		NSLog(@"Not a valid hit number: %d", n);
		return nil;
	}
	
	if (n >= [hitDocs count]) {
		[self moreDocuments: n];
	}
	
	return [hitDocs objectAtIndex: n];
}

- (void) addToFront: (LCHitDocument *) hitDoc
{
	if (first == nil) {
		last = hitDoc;
	} else {
		[first setPrev: hitDoc];
	}
	
	[hitDoc setNext: first];
	first = hitDoc;
	[hitDoc setPrev: nil];
	
	numDocs++;
}

- (void) remove: (LCHitDocument *) hitDoc
{
	if ([hitDoc document] == nil) { // it's not in the list
		return; // abort
	}
	
	if ([hitDoc next] == nil) {
		last = [hitDoc prev];
	} else {
		[[hitDoc next] setPrev: [hitDoc prev]];
	}
	
	if ([hitDoc prev] == nil) {
		first = [hitDoc next];
	} else {
		[[hitDoc prev] setNext: [hitDoc next]];
	}
	
	numDocs--;
}

@end

@implementation LCHitDocument
- (id) initWithScore: (float) s identifier: (int) i
{
	self = [self init];
	score = s;
	identifier = i;
	return self;
}

- (void) dealloc
{
    prev=nil;
    next=nil;
    doc=nil;
}

- (LCHitDocument *) prev { return prev; };
- (void) setPrev: (LCHitDocument *) d
{
	if (d == nil) {
		prev=nil;;
    }
	else
		prev = d;
}
- (LCHitDocument *) next { return next; };
- (void) setNext: (LCHitDocument *) d
{
	if (d == nil) {
        next=nil;
    }
	else
		next = d;
}
- (float) score { return score; };
- (int) identifier { return identifier; };
- (LCDocument *) document { return doc; };
- (void) setDocument: (LCDocument *) d
{
	if (d == nil) {
        doc=nil;;
    }
	else
		doc = d;
}

@end
