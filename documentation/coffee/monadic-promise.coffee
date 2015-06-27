promiseM =
    bind: (promise, continuation) ->
        promise.then continuation

downloadAndParseUrlPromise = monadic promiseM
  url <-- computeUrlAsPromise()
  result <-- downloadUrl url
  parse result
