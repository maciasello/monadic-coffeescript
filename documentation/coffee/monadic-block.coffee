monadic monadM
  p1 <-- mv1
  p2 <-- mv2
  mv3

# is translated to

monadM.bind mv1, (p1) ->
  monadM.bind mv2, (p2) ->
    mv3
