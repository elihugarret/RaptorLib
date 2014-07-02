--microRaptor lib
require("proAudioRt")
--zbstudio -cfg "singleinstance=false; debugger.port = 8173"
--motor de audio

if not proAudio.create() then os.exit(1) end


function play(tono,sample, pitch, duration, volumeL, volumeR)
	local scale = 2^(pitch/tono)
	local sound = proAudio.soundLoop(sample, volumeL, volumeR, 0, scale)
  proAudio.sleep(duration)
  proAudio.soundStop(sound)
end

function playChord(tono, sample, pitch, duration, volumeL, volumeR, note1, note2)
   
  local scale = 2^(pitch/tono)
  local sound = proAudio.soundLoop(sample,volumeL, volumeR, 0, scale)
  local sound1 = proAudio.soundLoop(sample,volumeL, volumeR, 0, scale+note1)
  local sound2 = proAudio.soundLoop(sample,volumeL, volumeR, 0, scale+note2)
  proAudio.sleep(duration)
  proAudio.soundStop(sound)
  proAudio.soundStop(sound1)
  proAudio.soundStop(sound2)
  end

-------------------------------------------------------------------------------------
 function stegoSaur(freq, duration, sampleRate,f,m,r)
	local data = {}
	for i = 1,duration*sampleRate do
		data[i] = math.random((i*math.cos(math.sin(f)))*(freq/math.random(m,r))/sampleRate,-19) 
	end
	return proAudio.sampleFromMemory(data, sampleRate)
end


function archaeOpterix(freq, duration, sampleRate,q,w)
	local data = {}
	for i = 1,duration*sampleRate do
		data[i] = math.tan( ((i*(math.pi*math.cosh(q)))*freq/sampleRate)*math.cos(w))
	end
	return proAudio.sampleFromMemory(data, sampleRate)
end


function velociRaptor(freq, duration, sampleRate,v)
	local data = {}
	for i = 1,duration*sampleRate do
		data[i] = math.cos( ((i*math.pi)*freq/sampleRate)*math.pi*v)
	end
	return proAudio.sampleFromMemory(data, sampleRate)
  
end

function pteroSaur (freq, duration , sampleRate)
  local data = {}
  for i = 1, duration*sampleRate do
    data[i] = math.atan2(-4,6)* (i*math.pi)*(freq/(sampleRate)*math.pi)
  end
  return proAudio.sampleFromMemory(data, sampleRate)
end

function mathRaptor (freq, duration, sampleRate,x,y,z)
  local data = {}
  for i = 1, duration*sampleRate do
    data[i] = math.tan(x*(math.cosh(math.pi,y)*(i*math.pi)*(freq/(sampleRate)*z)))
  end
  return proAudio.sampleFromMemory(data, sampleRate)
 end
