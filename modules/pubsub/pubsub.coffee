# Based on
# Library Agnostic Pubsub v1.0
# Darcy Clarke http://darcyclarke.me
# -
# Coffeescript, static singleton method, and AMD wrapper applied 5/2010
# Alex Aitken 


define ->


  class Pubsub


    @singleton: -> @instance ?= new this()

    #---------------------------------------------------------------------

    subscriptions: []

    #---------------------------------------------------------------------

    subscribe: (name, callback)->
      @subscriptions.push({name: name, callback: callback})
      return [name, callback]


    unsubscribe: (args)->

      subs = @subscriptions

      for sub, i in subs
        if sub.name is args[0] and sub.callback is args[1] #TODO comma or &&?
          subs.splice(i, 1)


    publish: (name, args)->

      temps = []
      subs = @subscriptions

      if subs.length > 0
        for sub in subs
          if sub.name = name
            temps.push({fn: sub.callback})
        for temp in temps
          temp.fn.apply(this, [args]) #this === Pubsub instance


  return Pubsub.singleton()
