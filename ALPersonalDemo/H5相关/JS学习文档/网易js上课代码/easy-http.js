function http(options) {

  return new Promise(function(resolve, reject) {

    var xhr = new XMLHttpRequest()
    xhr.open(options.method, options.url)

    function ResponseError(status, message) {
      this.status = status
      this.message = message
    }

    function paserJson(dataString) {
      return JSON.parse(dataString)
    }

    function parseString(json) {
      return JSON.stringify(json)
    }

    function addHeaders(headers) {
      if (headers) {
        Object.keys(headers).forEach(function(key) {
          xhr.setRequestHeader(key, headers[key])
        })
      }
    }

    xhr.onload = function onload() {
      if (this.status >= 200 && this.status < 300) {
        return resolve(paserJson(xhr.response))
      }
      return reject(new ResponseError(this.status, xhr.statusText))
    }

    xhr.onerror = function onerror() {
      return reject(new ResponseError(this.status, xhr.statusText))
    }

    addHeaders(options.headers)
    xhr.send(parseString(options.data))
  })
}
/*
usage examples
 http({
      method: 'GET',
      url: 'https://dragons-api.herokuapp.com/api/dragons'
    })
    .then(function(response) {
      console.log('response', response)
    })
    .catch(function(err) {
      console.log('err', err)
    })
 http({
      method: 'POST',
      url: 'https://app.com/api/user',
      data: {
        name: 'Olar',
        email: 'email@gmail.com'
      }
    })
    .then(function(response) {
      console.log('response', response)
    })
    .catch(function(err) {
      console.log('err', err)
    })
 http({
      method: 'PUT',
      url: 'https://app.com/api/user',
      data: {
        name: 'Olar',
        email: 'email@hotmail.com'
      }
    })
    .then(function(response) {
      console.log('response', response)
    })
    .catch(function(err) {
      console.log('err', err)
    })
 http({
      method: 'DELETE',
      url: 'https://app.com/api/user',
      data: {
        id: '09e81b2d-3e9e-4427-b579-c6b27f13a5f0'
      }
    })
    .then(function(response) {
      console.log('response', response)
    })
    .catch(function(err) {
      console.log('err', err)
    })
Add headers
 http({
      method: 'POST',
      url: 'https://app.com/api/user',
      data: {
        name: 'Olar',
        email: 'email@gmail.com'
      },
      headers: {
       'Content-Type': 'application/json;charset=UTF-8'
      }
    })
    .then(function(response) {
      console.log('response', response)
    })
    .catch(function(err) {
      console.log('err', err)
    })

*/






