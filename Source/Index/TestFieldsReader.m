#import  <Foundation/Foundation.h>
#import  <UnitKit/UnitKit.h>
#import  "LCRAMDirectory.h"
#import  "LCDocument.h"
#import  "LCField.h"
#import  "TestDocHelper.h"
#import  "LCFieldInfos.h"
#import  "LCFieldsReader.h"
#import  "LCDocumentWriter.h"
#import  "LCWhitespaceAnalyzer.h"
#import  "LCSimilarity.h"

@interface TestFieldsReader: NSObject <UKTest> 
{
	LCRAMDirectory *dir;
	LCDocument *testDoc;
	LCFieldInfos *fieldInfos;
}

@end

@implementation TestFieldsReader

- (id) init
{
	self = [super init];
	dir = [[LCRAMDirectory alloc] init];
	testDoc = [[LCDocument alloc] init];
	fieldInfos = [[LCFieldInfos alloc] init];;
	[TestDocHelper setupDoc: testDoc];
	[fieldInfos addDocument: testDoc];
	LCDocumentWriter *writer = [[LCDocumentWriter alloc] initWithDirectory: dir
																  analyzer: [[LCWhitespaceAnalyzer alloc] init]
																similarity: [LCSimilarity defaultSimilarity]
															maxFieldLength: 50];
	UKNotNil(writer);
	[writer addDocument: @"test" document: testDoc];
	return self;
}

- (void) testFieldsReader
{
	UKNotNil(dir);
	UKNotNil(fieldInfos);
	LCFieldsReader *reader = [[LCFieldsReader alloc] initWithDirectory: dir segment: @"test" fieldInfos: fieldInfos];
	UKNotNil(reader);
	UKIntsEqual([reader size], 1);
	LCDocument *doc = [reader document: 0];
	UKNotNil(doc);
	UKNotNil([doc field: @"textField1"]);
	LCField *field = [doc field: @"textField2"];
	UKNotNil(field);
	UKTrue([field isTermVectorStored]);
	UKTrue([field isOffsetWithTermVectorStored]);
	UKTrue([field isPositionWithTermVectorStored]);
	UKFalse([field omitNorms]);

	field = [doc field: @"textField3"];
	UKNotNil(field);
	UKFalse([field isTermVectorStored]);
	UKFalse([field isOffsetWithTermVectorStored]);
	UKFalse([field isPositionWithTermVectorStored]);
	UKTrue([field omitNorms]);
	[reader close];
}

@end
