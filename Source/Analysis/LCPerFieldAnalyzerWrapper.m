#import  "LCPerFieldAnalyzerWrapper.h"


/**
* This analyzer is used to facilitate scenarios where different
 * fields require different analysis techniques.  Use {@link #addAnalyzer}
 * to add a non-default analyzer on a field name basis.
 * See TestPerFieldAnalyzerWrapper.java for example usage.
 */

@implementation LCPerFieldAnalyzerWrapper

/**
* Constructs with default analyzer.
 *
 * @param defaultAnalyzer Any fields not specifically
 * defined to use a different analyzer will use the one provided here.
 */
- (id) initWithAnalyzer: (LCAnalyzer *) analyzer
{
	self = [self init];
	defaultAnalyzer = analyzer;
	analyzerMap = [[NSMutableDictionary alloc] init];
	return self;
}

- (void) dealloc
{
	defaultAnalyzer=nil;;
	analyzerMap=nil;;
}

/**
* Defines an analyzer to use for the specified field.
 *
 * @param fieldName field name requiring a non-default analyzer.
 * @param analyzer non-default analyzer to use for field
 */
- (void) setAnalyzer: (LCAnalyzer *) analyzer
            forField: (NSString *) name
{
	[analyzerMap setObject: analyzer forKey: name];
}

- (LCTokenStream *) tokenStreamWithField: (NSString *) name
								  reader: (id <LCReader>) reader
{
	LCAnalyzer *analyzer = nil;
	analyzer = [analyzerMap objectForKey: name];
	if (analyzer == nil) 
	{
		analyzer = defaultAnalyzer;
	}

	return [analyzer tokenStreamWithField: name
								   reader: reader];
}

- (NSString *) description
{
	return [NSString stringWithFormat: @"PerFieldAnalyzerWrapper(%@, default=%@)", analyzerMap, defaultAnalyzer];
}

@end
