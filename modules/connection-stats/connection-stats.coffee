define ['../interface/interface', '../pubsub/pubsub'], (Interface, PS)->


  #interface vs implementation
  #assume pubsub dependency only needs implement a publish method 
  publisher = new Interface('publisher', ['publish'])
  Interface.ensureImplements(PS, publisher)


  #derived from http://coding.smashingmagazine.com/2011/11/14/
  #analyzing-network-characteristics-using-javascript-and-the-dom-part-1/
  class ConnectionStats


    constructor: (@source)-> 
      @times = []
      @request()

    #---------------------------------------------------------------------

    request: ->
      @times.push(+new Date())
      if @times.length > 2 #request 1 = GET w/handshake; request 2 = GET w/established connection
        @report()
      else

        img = document.createElement('img')

        img.onload = =>
          @request.call(this)
        img.src = @source + '?' + Math.random() + '=' + new Date()


    report: ->

      times = @times
      rtt = times[2] - times[1] #post-handshake throughput
      tcp = times[1] - times[0] - rtt #difference b/w post and pre-handshake

      PS.publish('ConnectionStats.numbers', {rtt: rtt, tcp: tcp})


  return ConnectionStats
