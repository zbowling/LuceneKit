#import  <UnitKit/UnitKit.h>
#import  <Foundation/Foundation.h>
#import  "LCWhitespaceAnalyzer.h"
#import  "LCDocument.h"
#import  "LCIndexWriter.h"
#import  "LCTerm.h"
#import  "LCRAMDirectory.h"
#import  "LCTermQuery.h"
#import  "LCBooleanQuery.h"
#import  "LCHits.h"
#import  "LCIndexSearcher.h"

@interface TestBooleanScorer: NSObject <UKTest>
@end

static NSString *FIELD = @"category";

@implementation TestBooleanScorer

- (void) testMethod
{
	LCRAMDirectory *directory = [[LCRAMDirectory alloc] init];
	NSArray *values = [NSArray arrayWithObjects: @"1", @"2", @"3", @"4", nil];

    LCIndexWriter *writer = [[LCIndexWriter alloc] initWithDirectory: directory
															analyzer: [[LCWhitespaceAnalyzer alloc] init]
															  create: YES];
	int i;
	for (i = 0; i < [values count]; i++) {
		LCDocument *doc = [[LCDocument alloc] init];
		LCField *field = [[LCField alloc] initWithName: FIELD
												string: [values objectAtIndex: i]
												 store: LCStore_YES
												 index: LCIndex_Tokenized];
		[doc addField: field];
		[writer addDocument: doc];
	}
	[writer close];
	
	LCBooleanQuery *booleanQuery1 = [[LCBooleanQuery alloc] init];
	LCTerm *term = [[LCTerm alloc] initWithField: FIELD text: @"1"];
	LCTermQuery *q = [[LCTermQuery alloc] initWithTerm: term];
	[booleanQuery1 addQuery: q occur: LCOccur_SHOULD];
	term = [[LCTerm alloc] initWithField: FIELD text: @"2"];
	q = [[LCTermQuery alloc] initWithTerm: term];
	[booleanQuery1 addQuery: q occur: LCOccur_SHOULD];
	
	LCBooleanQuery *query = [[LCBooleanQuery alloc] init];
	[query addQuery: booleanQuery1 occur: LCOccur_MUST];
	term = [[LCTerm alloc] initWithField: FIELD text: @"9"];
	q = [[LCTermQuery alloc] initWithTerm: term];
	[query addQuery: q occur: LCOccur_MUST_NOT];
	
	LCIndexSearcher *indexSearcher = [[LCIndexSearcher alloc] initWithDirectory: directory];
	LCHits *hits = [indexSearcher search: query];
	UKIntsEqual(2, [hits count]);
}

@end
