define ->


  #Pro JavaScript Design Patterns
  #Dusitn Diaz and Ross Harmes
  class Interface


    #static class method
    #object - object to check
    #args 2 thru n - interfaces to check object against
    @ensureImplements = (object)->

      #test arguments length
      if arguments.length < 2
        throw new Error('Function Interface.ensureImplements called with ' + arguments.length + ' arguments, but expected at least 2')

      #test arguments[1] and above are Interface instances...
      #and that arguments[0] implements all supplied interface methods
      for argument, i in arguments
        if i > 0

          #test instance of Interface
          if argument.constructor isnt Interface
            throw new Error('Function Interface.ensureImplements expects arguments two and above to be instances of Interface')

          for method in argument.methods
            if not object[method] or typeof object[method] isnt 'function'
              throw new Error('Function Interface.ensureImplements: object does not implement the ' + argument.name + ' interface. ' + 
              'Method ' + method + ' was not found.')


    constructor: (@name, methods)->

      #test arguments length
      if arguments.length isnt 2
        throw new Error('Interface constructor called with ' + arguments.length + ' arguments, but expected exactly 2')

      @methods = []

      for method in methods
        if typeof method isnt 'string'
          throw new Error('Interface constructor expects method names to be passed as strings')
        @methods.push(method)


  return Interface
