#import  "LCTextImporter.h"
#import  "LCDateTools.h"
#import  "LCMetadataAttribute.h"

@implementation LCTextImporter
- (BOOL) metadataForFile: (NSString *) path type: (NSString *) type 
			  attributes: (NSMutableDictionary *) attributes
{
	if ([[self types] containsObject: type] == NO) return NO;
	[attributes setObject: path forKey: LCPathAttribute];
    NSError *error;
	[attributes setObject: [NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error:&error]
				   forKey: LCTextContentAttribute];
	NSFileManager *manager = [NSFileManager defaultManager];
	NSDictionary *attribs = [manager attributesOfItemAtPath:[path stringByResolvingSymlinksInPath] error:&error];
	NSDate *modificationDate = [attribs objectForKey: NSFileModificationDate];
	if ([modificationDate isEqualToDate: [attributes objectForKey: LCContentModificationDateAttribute]] == NO)
	{
		[attributes setObject: [NSString stringWithCalendarDate: [modificationDate dateWithCalendarFormat: nil timeZone: nil] resolution: LCResolution_SECOND]
					   forKey: LCContentModificationDateAttribute];
		[attributes setObject: [NSString stringWithCalendarDate: [NSCalendarDate date] resolution: LCResolution_SECOND]
					   forKey: LCMetadataChangeDateAttribute];
		return YES;
	}
	else
		return NO;
}

- (NSArray *) types
{
	return [NSArray arrayWithObjects: @"txt", @"text", nil];
}

- (NSString *) identifier
{
	return LCPathAttribute;
}

@end
