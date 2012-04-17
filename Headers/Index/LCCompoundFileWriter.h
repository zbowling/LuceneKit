#ifndef __LUCENE_COMPOUND_FILE_WRITER__
#define __LUCENE_COMPOUND_FILE_WRITER__

#import  <Foundation/Foundation.h>
#import  "LCDirectory.h"

@interface LCCompoundFileWriter: NSObject
{
	id <LCDirectory> directory;
	NSString *fileName;
	NSMutableSet *ids;
	NSMutableArray *entries;
	BOOL merged;
}

- (id) initWithDirectory: (id <LCDirectory>) dir name: (NSString *) name;
- (id <LCDirectory>) directory;
- (NSString *) name;
- (void) addFile: (NSString *) file;
- (void) close;

@end

#endif /* __LUCENE_COMPOUND_FILE_WRITER__ */
