
JPEG_MAGIC_NUMBER = 0xffd9ffd8
JPEG_HEAD_NUMBER = 0xd8ff

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

xhr = new XMLHttpRequest()
xhr.open 'GET', '/c.jpg', true
xhr.responseType = 'arraybuffer'
xhr.onload = (e) ->
  if xhr.response
    ba = new Uint8Array xhr.response
    bebs = new BigEndianBinaryStream ba

    console.log (bebs.getByteRangeAsNumber(0, 2) == JPEG_HEAD_NUMBER) # expect to be true


xhr.send null