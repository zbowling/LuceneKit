#import  "LCFieldsWriter.h"
#import  "LCIndexOutput.h"
#import  "NSData+Additions.h"


@implementation LCFieldsWriter

- (id) initWithDirectory: (id <LCDirectory>) d
				 segment: (NSString *) segment
			  fieldInfos: (LCFieldInfos *) fn
{
	self = [self init];
	fieldInfos = fn;
	NSString *f = [segment stringByAppendingPathExtension: @"fdt"];
	fieldsStream = [d createOutput: f];
	f = [segment stringByAppendingPathExtension: @"fdx"];
	indexStream = [d createOutput: f];
	return self;
}

- (void) dealloc
{
	fieldInfos=nil;;
	fieldsStream=nil;;
	indexStream=nil;;
}

- (void) close
{
	[fieldsStream close];
	[indexStream close];
}

- (void) addDocument: (LCDocument *) doc
{
	[indexStream writeLong: [fieldsStream offsetInFile]];
	
	int storedCount = 0;
	NSEnumerator *fields = [doc fieldEnumerator];
	LCField *field;
	while ((field = [fields nextObject])) 
    {
		if ([field isStored])
			storedCount++;
    }
	[fieldsStream writeVInt: storedCount];
	
	fields = [doc fieldEnumerator];
	while ((field = [fields nextObject])) 
    {
		if([field isStored]){
			[fieldsStream writeVInt: [fieldInfos fieldNumber: [field name]]];
			
			char bits = 0;
			if ([field isTokenized])
				bits |= LCFieldsWriter_FIELD_IS_TOKENIZED;
			if ([field isData])
				bits |= LCFieldsWriter_FIELD_IS_BINARY;
			if ([field isCompressed])
				bits |= LCFieldsWriter_FIELD_IS_COMPRESSED;
			
			[fieldsStream writeByte: bits];
			if ([field isCompressed]) {
				// compression is enabled for the current field
				NSData *data = nil;
				// check if it is a binary field
				if ([field isData]) {
                    data = [field data];
				}
				else {
					data = [[field string] dataUsingEncoding: NSUTF8StringEncoding];
				}
				data = [data compressedData];
				int len = [data length];
				[fieldsStream writeVInt: len];
				[fieldsStream writeBytes: data length: len];
				data=nil;;
			} else {
				// compression is disabled for the current field
				if ([field isData]) {
					NSData *data = [field data];
                    int len = [data length];
					[fieldsStream writeVInt: len];
					[fieldsStream writeBytes: data length: len];
				}
				else {
					[fieldsStream writeString: [field string]];
				}
			}
		}
	}
}

@end
