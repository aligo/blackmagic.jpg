
JPEG_MAGIC_NUMBER = 0xd8ffd9ff
JPEG_HEAD_NUMBER = 0xd8ff
JPEG_END_NUMBER  = 0xd9ff

class BigEndianBinaryStream

  constructor: (@stream) ->
    @resetByteIndex()

  resetByteIndex: ->
    @currentByteIndex = 0

  getByteAt: (index) ->
    @stream[index]

  getNextBytesAsNumber: (steps) ->
    result = @getByteRangeAsNumber @currentByteIndex, steps
    @currentByteIndex += steps
    result

  getByteRangeAsNumber: (index, steps) ->
    result = 0
    i = index + steps - 1;
    while i >= index
      result = (result << 8) + @stream[i]
      i--
    result

  haveNext: () ->
    ( @currentByteIndex < @stream.length )

xhr = new XMLHttpRequest()
xhr.open 'GET', '/c.jpg', true
xhr.responseType = 'arraybuffer'
xhr.onload = (e) ->
  if xhr.response
    ba = new Uint8Array xhr.response
    bebs = new BigEndianBinaryStream ba

    while bebs.haveNext()
      if bebs.getNextBytesAsNumber(2) == JPEG_END_NUMBER
        if bebs.getByteRangeAsNumber(bebs.currentByteIndex, 2) == JPEG_HEAD_NUMBER
          console.log bebs.currentByteIndex # another file start at


xhr.send null