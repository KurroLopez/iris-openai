Class St.OpenAi.B64.Util Extends %RegisteredObject
{

/// Be cautious if changing CHUNKSIZE. Incorrect values could cause the resulting encoded data to be invalid.
/// It should always be a multiple of 57 and needs to be less than ~2.4MB when MAXSTRING is 3641144
Parameter CHUNKSIZE = 2097144;

ClassMethod B64EncodeStream(pStream As %Stream.Object, pAddCRLF As %Boolean = 0) As %Stream.Object
{
    set tEncodedStream=##class(%Stream.GlobalCharacter).%New()
    
    do pStream.Rewind()
    
    while ('pStream.AtEnd) {
        set tReadLen=..#CHUNKSIZE
        set tChunk=pStream.Read(.tReadLen)
        
        do tEncodedStream.Write($System.Encryption.Base64Encode(tChunk,'pAddCRLF))
        if (pAddCRLF && 'pStream.AtEnd) {
            do tEncodedStream.Write($c(13,10))
        }
    }
    
    do tEncodedStream.Rewind()
    
    quit tEncodedStream
}

}
