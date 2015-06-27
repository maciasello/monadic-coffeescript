test "monadic constructs bind on monad", ->
  binds = []
  monadM =
    bind: (mv, mf) ->
      binds.push mv
      mf()

  obj = monadic monadM
    a <-- 1
    b <-- 2
    c <-- 3
    4

  arrayEq binds, [1,2,3]

test "monadic constructs bind on pass lines", ->
  binds = []
  monadM =
    bind: (mv, mf) ->
      binds.push mv
      mf()

  obj = monadic monadM
    a <-- 1
    2
    b <-- 3
    4
    c <-- 5
    6

  arrayEq binds, [1,2,3,4,5]

test "monadic returns results up the bind chain", ->
  monadM =
    bind: (mv, mf) ->
      mf(mv)

  obj = monadic monadM
    a <-- 1
    b <-- 2
    c <-- 3
    [a, b, c]

  arrayEq obj, [1,2,3]

test "monadic supports unpacking complex values from monad", ->
  monadM =
    bind: (mv, mf) ->
      mf(mv)

  obj = monadic monadM
    [a,b] <-- [1,2]
    {c,d} <-- {c:3,d:4}
    {e,f:[g,{h,i}]} <-- {e:5, f:[6,{h:7, i:8}]}
    [a,b,c,d,e,g,h,i]

  arrayEq obj, [1,2,3,4,5,6,7,8]

test "monadic supports 'complex' expressions as monadic values", ->
  monadM =
    bind: (mv, mf) ->
      mf(mv)

  obj = monadic monadM
    [a,b] <-- if 1==2 then [1,2] else [5,6]
    {c,d} <-- {c:3,d:4}
    [a,b,c,d]

  arrayEq obj, [5,6,3,4]

test "monadic supports 'complex' expressions as monadic values 2", ->
  monadM =
    bind: (mv, mf) ->
      mf(mv)

  obj = monadic monadM
    [a,b] <-- if 1==2 then [1,2] else [5,6]
    {c,d} <-- do ->
      ina = [1..3]
      c: ina
      d: "d-value"
    [a,b,c,d]

  arrayEq obj, [5,6,[1,2,3],"d-value"]

test "monadic properly binds with bound-functions", ->
  monadM =
    bind: (mv, mf) ->
      mf(mv)

  obj =
    bound: -> monadic monadM
      a <== 1
      b <== 1
      c <== 1
      this

  eq obj, obj.bound()
