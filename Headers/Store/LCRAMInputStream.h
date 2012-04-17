#ifndef __LUCENE_STORE_RAM_INPUT_STREAM__
#define __LUCENE_STORE_RAM_INPUT_STREAM__

#import  "LCIndexInput.h"
#import  "LCRAMFile.h"

@interface LCRAMInputStream: LCIndexInput
{
	LCRAMFile *file;
	unsigned long long pointer;
	
	NSRange bufferRange;
	unsigned char *buffer;
	unsigned int position;  // position within bufferRange
}

- (id) initWithFile: (LCRAMFile *) file;
@end

#endif /* __LUCENE_STORE_RAM_INPUT_STREAM__ */
