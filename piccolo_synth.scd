//Anthony Di Furia (2011)



//Server
s.boot;


//Synth
(
SynthDef(\sine, {arg freqfond = 100, amp = 1, pan = 0;
	Out.ar(0,
		Pan2.ar(
			SinOsc.ar(freqfond, mul:amp), pan))}).add;

x = Synth(\sine);
)

(
//GUI

//var
var lfreq, lamp, button, knob;

w = Window.new("PICCOLO SYNTH",Rect(20, 20, 300, 110)).front;
lfreq = Slider(w;, Rect(10, 50, 270, 15));
lamp = Slider(w;, Rect(10, 70, 270, 15));
button = Button(w, Rect(10, 10 ,60, 30));
knob = Knob(w, Rect(100, 10, 30, 30)); knob.value = 0.5;

p = knob;
b = button;


//ON-OFF
b.states_([
	["On", Color.red, Color.black],
	["Off", Color.black, Color.red];
]);

b.action_({
	arg me ;
	var val = me.value.postln ;
	if(val == 1){x.run(false)}{x.run}
});


//FREQ
lfreq.action_({ arg me;
	var v = me.value.linlin(0, 1, 50, 5000).postln;
	x.set(\freqfond, v);

});


//AMP
lamp.action_({ arg me;
	var v = me.value.linlin(0, 1, 0, 1).postln;
	x.set(\amp, v);
});


//PAN
p.action_({ arg me;
	var v = me.value.linlin(0, 1, -1, 1).postln;
	x.set(\pan, v);
});
)

