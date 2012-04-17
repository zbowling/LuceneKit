#import  "LCAnalyzer.h"

#import  <UnitKit/UnitKit.h>
#import  "LCStringReader.h"

@interface LCAnalyzer (UKTest_Additions)
- (void) compare: (NSString *) s and: (NSArray *) a
            with: (LCAnalyzer *) analyzer;
@end

