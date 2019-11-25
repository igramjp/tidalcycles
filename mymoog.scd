Server.default = s = Server.internal.boot
SuperDirt.start

({
	var sound = MoogFF.ar(
		Pulse.ar(110, LFNoise1.ar(1.0, 0.1, 0.4)),
		1000, 3
	).dup;
	var env = EnvGen.kr(Env.perc(), doneAction: 2);
	sound * env
}.play)

(
SynthDef(
	"MyMoog", {
		arg out, freq = 110, pan = 0.5, pitch1 = 4.0;
		var detune, sig1, sig2, env, sound;
		detune = 1.0005;
		sig1 = MoogFF.ar(
			Pulse.ar(freq, LFNoise1.ar(1.0, 0.3, 0.4)),
			freq * pitch1, 3
		).dup;
		sig2 = MoogFF.ar(
			Pulse.ar(freq * detune, LFNoise1.ar(0.8, 0.2, 0.5)),
			freq * pitch1 * 1.5, 3
		).dup;
		sound = (sig1 + sig2) * 0.5;
		env = EnvGen.kr(Env.perc(0.005), doneAction: 2);
		OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, env));
}).add
)