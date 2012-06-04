require ['connection-stats', '../pubsub/pubsub'], (ConnectionStats, ps)->

  #subscribe to publication of connection stats
  ps.subscribe 'ConnectionStats.numbers', (data)->
    writeStats(data)

  writeStats = (map)->

    dd = document.querySelectorAll('dd')

    dd[0].innerHTML = map.tcp
    dd[1].innerHTML = map.rtt


  new ConnectionStats('transparent.gif')
