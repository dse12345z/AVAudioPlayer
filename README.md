DSKPlayer
=============
DSKPlayer is a simple player combine Block.

Usage
=============

[DSKPlayer playMP3:@"Westlife - My Love" pathType:PathTypeFromDefault completion: ^{  
　　　// play finish do something ...  
}];

PathType
=============
typedef enum {

    PathTypeFromDefault,
    PathTypeFromDocument,
    PathTypeFromResource
    
} PathType;

PathTypeFromDefault: First from document, if no files, the second from the resource.

PathTypeFromDocument: Only from the document.

PathTypeFromResource: Only from the resource.

Other
=============

[DSKPlayer setCurrentTime:10.0f];

[DSKPlayer currentTime];

[DSKPlayer duration];

[DSKPlayer play];

[DSKPlayer isPlaying];

[DSKPlayer pause];
