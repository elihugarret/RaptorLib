
raptor140 #1

--It uses a default synth named velociRaptor(), you can change it by adding an argument called "ugen".

def:seq{ -- The def:seq{} function is like the Tdef in SC
  shift1 = 12, -- This argument shifts the scale by 12 every iteration
  shift2 = -3, -- Like the last one, but shifts the scale of the variation pattern
  patt = rseq("x $- % -ux - #R-p",64,2), -- The pattern! The "rseq()" function converts the string to table then each element of the table is "readed" and passed to a synth/sampler
  lenght = 9, -- The number of iterations
  every = 2, -- Every two iteration the pattern is changed
  vars = shuffle({5,20,6}), --A pattern variation, the "shuffle()" function is like the ".scramble" method in SC
  tempo = 190,
  volL = 1,
  volR = 1
}
