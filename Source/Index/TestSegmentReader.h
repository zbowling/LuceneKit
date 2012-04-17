#import  <Foundation/Foundation.h>
#import  <UnitKit/UnitKit.h>

@class LCRAMDirectory;
@class LCDocument;
@class LCSegmentReader;
@class LCIndexReader;

@interface TestSegmentReader: NSObject <UKTest>
{
	LCRAMDirectory *dir;
	LCDocument *testDoc;
	LCSegmentReader *reader;
}

+ (void) checkNorms: (LCIndexReader *) reader;
@end

