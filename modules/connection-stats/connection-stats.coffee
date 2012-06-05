#proof of concept, client-side network performance measurement
#abandoned after handshake time measurement 120605
#Exploring boomerang...

define ['../interface/interface', '../pubsub/pubsub'], (Interface, PS)->


  #interface vs implementation
  #assume pubsub dependency only needs implement a publish method 
  publisher = new Interface('publisher', ['publish'])
  Interface.ensureImplements(PS, publisher)


  #derived from http://coding.smashingmagazine.com/2011/11/14/
  #analyzing-network-characteristics-using-javascript-and-the-dom-part-1/
  class ConnectionStats


    #source - 1X1 pixel gif c. 35 bytes, needs come back in a single TCP packet (which also includes HTTP headers)
    constructor: (@source)-> 

      @times = []

      @_request()

    #---------------------------------------------------------------------


    _request: ->

      #push new time and fork accordingly
      #times[0] = time of 1st request
      #tiimes[1] = time of response after tcp handshake
      #times[2] = time of response with established connection
      @times.push(+new Date())
      if @times.length > 2
        @_report()
      else

        img = document.createElement('img')

        img.onload = =>
          @_request.call(this)
        img.src = @source + '?' + Math.random() + '=' + new Date()


    _report: ->

      times = @times
      rtt = times[2] - times[1] #post-handshake latency
      tcp = times[1] - times[0] - rtt #handshake time (negligible or negative with http pipelining, potentially other browser optimizations...)

      PS.publish('ConnectionStats.numbers', {rtt: rtt, tcp: tcp})


  return ConnectionStats
