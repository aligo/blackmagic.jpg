
JPEG_MAGIC_NUMBER = 0xffd9ffd8
JPEG_HEAD_NUMBER = 0xffd8

xhr = new XMLHttpRequest()
xhr.open 'GET', '/c.jpg', true
xhr.responseType = 'arraybuffer'
xhr.onload = (e) ->
  if xhr.response
    ba = new Uint8Array xhr.response

    console.log ba.subarray(0, 4)

    console.log (ba.subarray(0, 4) == JPEG_HEAD_NUMBER) # expect to be true


xhr.send null