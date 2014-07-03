--raptorLib

--Written by Elihu Garret 2013-2014
--Sequencers, pseudo-samplers and a lot of stuff

require("microRaptor")
require("Tables")

math.randomseed(os.clock())

-- The tempo!!
function tempo(bpm)
  
  x=30/bpm
  
  return x
  
end
 --------------------------------
--Yeah you guess it! It is the pan!!
function pan(L,R)
   
   proAudio.volume(L,R)
   
 end
--------------------------------------------------------------
--Waiting is boring
function wait(sec)
 
 proAudio.sleep(sec)
 
  end

---------------------------------------------------------------------------------
--Do you remeber SuperCollider?
function clear(time)
wait(time)
proAudio.destroy()
os.exit()
end


-------------------------------------------------------------------------------

--This function converts strings to tables
-- It only works with raptor functions
function rseq(f,ratio,t)
t = t or 0
local arr = {f:byte(1,-1)}
local store = {}
for index, i in ipairs(arr) do
  
   if  i == 32 then table.insert(store,index,':')
  elseif  i == 35 then table.insert(store,index,'#')
  elseif  i == 36 then table.insert(store,index,'$')
  elseif  i == 37 then table.insert(store,index,'%')
  elseif  i == 38 then table.insert(store,index,'&')
  elseif  i == 42 then table.insert(store,index,'*')
  elseif  i == 43 then table.insert(store,index,'+')
  elseif  i == 45 then table.insert(store,index,'-')
  elseif  i == 59 then table.insert(store,index,';')
  elseif  i == 64 then table.insert(store,index,'@')
  elseif  i == 111 then table.insert(store,index,'o')
  elseif  i == 120 then table.insert(store,index,'x')
  elseif  i == 124 then table.insert(store,index,'|')
  elseif  i == 126 then table.insert(store,index,'~')
  
  else table.insert(store,index,(i/ratio)+t)

end
end
return store
end
----------------------------------------------------------------------------
--Only works for rdrum functions
function dseq(f)

local arr = {f:byte(1,-1)}
local store = {}
for index, i in ipairs(arr) do

   if  i == 35 then table.insert(store,index,'#')
  elseif  i == 36 then table.insert(store,index,'$')
  elseif  i == 37 then table.insert(store,index,'%')
  elseif  i == 38 then table.insert(store,index,'&')
  elseif  i == 42 then table.insert(store,index,'*')
  elseif  i == 43 then table.insert(store,index,'+')
  elseif  i == 45 then table.insert(store,index,'-')
  elseif  i == 59 then table.insert(store,index,';')
  elseif  i == 63 then table.insert(store,index,'?')
  elseif  i == 64 then table.insert(store,index,'@')
  elseif  i == 79 then table.insert(store,index,'O')
  elseif  i == 111 then table.insert(store,index,'o')
  elseif  i == 120 then table.insert(store,index,'x')
  elseif  i == 121 then table.insert(store,index,'y')
  elseif  i == 124 then table.insert(store,index,'|')
  elseif  i == 126 then table.insert(store,index,'~')
  
  
else table.insert(store,index,0)
end
end
return store
end
------------------------------------------------------------------------------------------

--Load yor samples!!!!!
local dir = "/your/path/to/Samples/"-- Your path!
local kic = proAudio.sampleFromFile(dir.."kick.ogg")
local sna = proAudio.sampleFromFile(dir.."snare.ogg")
local ope = proAudio.sampleFromFile(dir.."openhat.ogg")
local hat = proAudio.sampleFromFile(dir.."hat.ogg")
local rob = proAudio.sampleFromFile(dir.."robot.wav")
local vel = proAudio.sampleFromFile(dir.."velcro.wav")
local iro = proAudio.sampleFromFile(dir.."iron.wav")
local exh = proAudio.sampleFromFile(dir.."exhale.wav")
local air = proAudio.sampleFromFile(dir.."air.ogg")
local ice = proAudio.sampleFromFile(dir.."ice.ogg")
local kit = proAudio.sampleFromFile(dir.."kitkick.ogg")
local met = proAudio.sampleFromFile(dir.."metal.ogg")
local tin = proAudio.sampleFromFile(dir.."tin.ogg")
-----------------------------------------------------------------------
--Drum machine for raptor functions
function rpattern(patrones,i,tono,dino,dur,vol1,vol2,dis)
    
 for w, beat in ipairs(patrones[i]) do
 
       if beat == 'x' then  proAudio.soundPlay(kic,vol1,vol2,dis)
   elseif beat == 'o' then proAudio.soundPlay(sna,vol1,vol2,dis)  
   elseif beat == '*' then proAudio.soundPlay(hat,vol1,vol2,dis)
   elseif beat == '-' then proAudio.soundPlay(ope,vol1,vol2,dis)
   elseif beat == '&' then proAudio.soundPlay(rob,vol1,vol2,dis)
   elseif beat == '#' then proAudio.soundPlay(vel,vol1,vol2,dis)
   elseif beat == '+' then proAudio.soundPlay(iro,vol1,vol2,dis)
   elseif beat == '$' then proAudio.soundPlay(exh,vol1,vol2,dis)
   elseif beat == '@' then proAudio.soundPlay(air,vol1,vol2,dis)
   elseif beat == '%' then proAudio.soundPlay(ice,vol1,vol2,dis)
   elseif beat == '~' then proAudio.soundPlay(kit,vol1,vol2,dis)
   elseif beat == '|' then proAudio.soundPlay(met,vol1,vol2,dis)
   elseif beat == ';' then proAudio.soundPlay(tin,vol1,vol2,dis)
   elseif beat == ':' then play(1,velociRaptor(1,1,1,1),1,dur,0,0)
   else play(tono,dino,beat,dur,vol1/10,vol2/10)
 
  end 
 end
end

----------------------------------------------------------------------------

raptor = {}

-----------------------------------------------------------------
-- Linear sequencing
function raptor:seq(patrones,tono,dino,dur,vol1,vol2)
  
 rpattern(patrones,1,tono,dino,dur,vol1,vol2)
 end


---------------------------------------
-- Random
function raptor:rrnd(patrones,tono,dino,dur,vol1,vol2)
 
 local r = math.random(rawlen(patrones))
 
 rpattern(patrones,r,tono,dino,dur,vol1,vol2)

end
-----------------------------------------------------------------
-- You can choose your own patterns
function raptor:swt(patrones,i,tono,dino,dur,vol1,vol2)
 
 rpattern(patrones,i,tono,dino,dur,vol1,vol2) 
 
 end
-------------------------------------------------------------------------
-- It wasnt me
function raptor:xrnd(patrones,tono,dino,dur,vol1,vol2)
 
local d = math.random(math.random(rawlen(patrones)),math.random(rawlen(patrones)))

 rpattern(patrones,d,tono,dino,dur,vol1,vol2)

end
-------------------------------------------------------------------------------
function raptor:splay(tipo,s,volL,volR,dis,pitch)
dis = dis or 0
pitch = pitch or 1

local x

if tipo == 'w' then x = ".wav"
elseif tipo == 'o' then x = ".ogg"
end

local sample = proAudio.sampleFromFile(dir..s..x)

proAudio.soundPlay(sample,volL,volR,dis,pitch)

end
----------------------------------------------------------------------------------------
function raptor:sloop(tip,z,dur,volL,volR,dis,pitch)
 dis = dis or 0
 pitch = pitch or 1
 
 local y
 
if tip == 'w' then x = ".wav"
elseif tip == 'o' then x = ".ogg" end

local sample = proAudio.sampleFromFile(dir..z..x)
local sound = proAudio.soundLoop(sample, volL, volR, dis, pitch)
 proAudio.sleep(dur)
 proAudio.soundStop(sound)
   
  end
-----------------------------------------------------------------------------------------
function pattern(patron,dur,index,vol1,vol2,dis,pit)

vol1 = vol1 or 1
vol2 = vol2 or 1
dis = dis or 0
pit = pit or 1

  local a = 0.025
  
for _, beat in ipairs(patron[index]) do
 
if beat == 'x' then  proAudio.soundPlay(kic)
   elseif beat == 'o' then proAudio.soundPlay(sna,vol1,vol2,dis,pit)  
   elseif beat == '*' then proAudio.soundPlay(hat,vol1,vol2,dis,pit)
   elseif beat == '-' then proAudio.soundPlay(ope,vol1,vol2,dis,pit)
   elseif beat == '&' then proAudio.soundPlay(rob,vol1,vol2,dis,pit)
   elseif beat == '#' then proAudio.soundPlay(vel,vol1,vol2,dis,pit)
   elseif beat == '+' then proAudio.soundPlay(iro,vol1,vol2,dis,pit)
   elseif beat == '$' then proAudio.soundPlay(exh,vol1,vol2,dis,pit)
   elseif beat == '@' then proAudio.soundPlay(air,vol1,vol2,dis,pit)
   elseif beat == '%' then proAudio.soundPlay(ice,vol1,vol2,dis,pit)
   elseif beat == '~' then proAudio.soundPlay(kit,vol1,vol2,dis,pit)
   elseif beat == '|' then proAudio.soundPlay(met,vol1,vol2,dis,pit)
   elseif beat == ';' then proAudio.soundPlay(tin,vol1,vol2,dis,pit)
   elseif beat == 'y' then rdrum:seq({{'&',0,'&',0,'&',0,'&',0}},a)
   elseif beat == '?' then rdrum:seq({{'+',0,'+',0,'+',0,'+',0}},a)
   elseif beat == 'O' then rdrum:seq({{'o',0,'o',0,'o',0,'o',0}},a)
   else play(1,velociRaptor(1,1,1,1),beat,dur,0,0)
 
  end
 end
  
  end
---------------------------------------------------------------------------------------
rdrum = {}

function rdrum:seq(patron,dur,vol1,vol2,dis,pit)

pattern(patron,dur,1,vol1,vol2,dis,pit)

 end
------------------------------------------------------------------------
function rdrum:rrnd(patrones,dur,vol1,vol2,dis,pit)
  
local d = math.random(rawlen(patrones))

pattern(patrones,dur,d,vol1,vol2,dis,pit)

end
-----------------------------------------------------------------------------
function rdrum:swt(patrones,i,dur,vol1,vol2,dis,pit)
  
  pattern(patrones,dur,i,vol1,vol2,dis,pit)

  
end 
--------------------------------------------------------------------------------
function rdrum:xrnd(patrones,dur,vol1,vol2,dis,pit)
  
local d = math.random(math.random(rawlen(patrones)),math.random(rawlen(patrones)))

pattern(patrones,dur,d,vol1,vol2,dis,pit)

end

----------------------------------------------------------------------------------------
def = {}

function def:seq(arg)
--[[lenght, every, variationPattern,shift1,dinoVar,tempo,volL,volR,loop--]]

arg.scale2 = arg.scale2 or 12
arg.scale1 = arg.scale1 or 12
arg.shift1 = arg.shift1 or 0
arg.shift2 = arg.shift2 or 0
arg.ugen = arg.ugen or velociRaptor(40,0.5,400,1,2)
arg.ugenVar = arg.ugenVar or velociRaptor(40,0.5,400,1,2)
arg.tempo = arg.tempo or 120
arg.volR = arg.volR or 0.2
arg.volL = arg.volL or 0.2
 
for q = 0, arg.lenght do
 
  for i = 0, arg.every do

    if i == arg.every then raptor:seq({arg.vars},arg.scale2+q*(arg.shift1),
                                    arg.ugenVar,tempo(arg.tempo),arg.volR,arg.volL) 
     elseif i < arg.every then raptor:seq({arg.patt},arg.scale1+q*(arg.shift2),
                                arg.ugen,tempo(arg.tempo),arg.volR,arg.volL)

      end
    end
  end
end
-----------------------------------------------------------
function def:swt(s)
  
  s.scale = s.scale or 12
  s.indexVar = s.indexVar or 1
  s.index = s.index or 1
  s.ugen = s.ugen or velociRaptor(40,0.5,400,1,2)
  s.ugenVar = s.ugenVar or velociRaptor(40,0.5,400,1,2)
  s.tempo = s.tempor or 120
  s.volR = s.volR or 0.2
  s.volL = s.volL or 0.2
  s.shift1 = s.shift1 or 0
  s.shift2 = s.shift2 or 0
  
  for w = 0, s.lenght do
    
       for e = 0, s.every do 
         
 if e == s.every then raptor:swt(s.vars,s.indexVar,s.scale+(w*s.shift1),s.ugenVar,tempo(s.tempo),s.volR,s.volL)
 elseif e < s.every then raptor:swt(s.patts,s.index,s.scale+(w*s.shift2),s.ugen,tempo(s.tempo),s.volR,s.volL)
   end
       end
     end
  end
------------------------------------------------------
function def:rrnd(r)

r.scale = r.scale or 12
r.ugenVar = r.ugenVar or velociRaptor(40,0.5,400,1,2)
r.tempo = r.tempo or 120
r.volR = r.volR or 0.2
r.volL = r.volL or 0.2
r.ugen = r.ugen or velociRaptor(40,0.5,400,1,2)
r.shift1 = r.shift1 or 0
r.shift2 = r.shift2 or 0

for t = 0, r.lenght do 
 
 for y = 0, r.every do
 if y == r.every then raptor:rrnd(r.vars,r.scale+(t*r.shift1),r.ugenVar,tempo(r.tempo),r.volR,r.volL)
 elseif y < r.every then raptor:rrnd(r.patts,r.scale+(t*r.shift2),r.ugen,tempo(r.tempo),r.volR,r.volL) end  
   end
 end
end
--------------------------------------------------------------------
function def:splay(u)
  
  u.volL = u.volL or 0.2
  u.volR = u.volR or 0.2
  u.wait1 = u.wait1 or 0.5
  u.wait2 = u.wait2 or 0.5
  u.shift1 = u.shift1 or 0
  u.shift2 = u.shift2 or 0
  u.pitch1 = u.pitch or 0.5
  u.pitch2 = u.pitch2 or 0.5
  
  for o = 0, u.lenght do
    
    for p = 0, u.every do
      
      if p == u.every then raptor:splay(u.typV,u.vname,u.volL,u.volR,u.dis1,u.pitch1+(o*u.shift1/10))
        wait(u.wait1)
      elseif p < u.every then raptor:splay(u.typ,u.sname,u.volL,u.volR,u.dis2,u.pitch2+(o*u.shift2/10))
       wait(u.wait2)
      end
      
       end
     
    end
  
  end
