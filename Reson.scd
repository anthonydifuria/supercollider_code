//server on
s.boot;




// reson
(

SynthDef.new(\reson,{

	arg
	outbus,
	ampin1 = 0,
	pan1 = 0,
	mix = 0.1,
	room = 0.1,
	damp = 0.5,
	freqres1a = 0, freqres2a = 0, freqres3a = 0, freqres4a = 0, freqres5a = 0,
	parz1a = 0, parz2a = 0, parz3a = 0, parz4a = 0, parz5a = 0,
	freqscale1 = 1, freqoffset1 = 0, decayscale1 = 1;

	var x1,signal;

	x1 = (Pan2.ar(
		DynKlank.ar(
			`[[freqres1a, freqres2a, freqres3a, freqres4a, freqres5a],
				[parz1a,parz2a,parz3a,parz4a,parz5a],
				[1,1,1,1,1]],
			(SoundIn.ar(0, ampin1/10)),
			freqscale1,
			freqoffset1,
			decayscale1
		),
		pan1,
		1)
	);



	signal = x1;

	ReplaceOut.ar(outbus,FreeVerb2.ar(signal[0],signal[1],mix,room,damp));

}).add;


//run
x = Synth(\reson); x.run(false);

)





//Reson
(


//var
var w,b,tin,tpan,t,s1,k1,smix,sroom,sdamp,treverb,tmix,troom,tdamp,
resonbox1a,resonbox2a,resonbox3a,resonbox4a,resonbox5a,
tres1,
sres1a,sres2a,sres3a,sres4a,sres5a,
fscale1,foffset1,dscale1,
tfscale1,tfoffset1,tdscale1;

w = GUI.window.new("RESONATION", Rect(10,10,400,700)); w.front;
b = Button(w, Rect(100,10 ,100 , 40));

//in
tin = GUI.staticText.new(w, Rect(10, 10, 90, 30)).string_("INPUT").align_( \center );
tpan = GUI.staticText.new(w, Rect(10, 370, 30, 30)).string_("PAN").align_( \center );

s1 = GUI.slider.new(w, Rect(40, 60, 30, 300)); s1.value = 0;
k1 = GUI.knob.new(w, Rect(40, 370, 30, 30)); k1.value = 0.5;

s1.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\ampin1, v); });
k1.action_({ arg me; var v = me.value.linlin(0, 1, -1, 1).postln; x.set(\pan1, v); });

//on-off
b.states_([["OFF", Color.red, Color.black],["ON", Color.black, Color.red]]);
b.action_({
	arg me ;
	var val = me.value.postln ;
	if(val == 1){x.run(true)}{x.run(false)}
});

//gui reverb
treverb = GUI.staticText.new(w, Rect(240, 10, 100, 30)).string_("REVERB").align_( \center );

tmix = GUI.staticText.new(w, Rect(220, 35, 40, 30)).string_("MIX").align_( \center );
troom = GUI.staticText.new(w, Rect(260, 35, 45, 30)).string_("ROOM").align_( \center );
tdamp = GUI.staticText.new(w, Rect(308, 35, 40, 30)).string_("DAMP").align_( \center );

smix = GUI.slider.new(w, Rect(225, 60, 30, 300)); smix.value = 0;
sroom = GUI.slider.new(w, Rect(268, 60, 30, 300)); sroom.value = 0;
sdamp = GUI.slider.new(w, Rect(311, 60, 30, 300)); sdamp.value = 0;

smix.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\mix, v); });
sroom.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\room, v); });
sdamp.action_({ arg me; var v = me.value.linlin(0, 1, 0, 1).postln; x.set(\damp, v); });


//gui reson
tres1 = GUI.staticText.new(w, Rect(150, 405, 75, 30)).string_("RESON 1").align_( \center );

resonbox1a = GUI.numberBox.new( w, Rect( 40, 430, 50, 20 )).string_("Reson").align_( \center );
resonbox1a.value = 0;
resonbox2a = GUI.numberBox.new( w, Rect( 100, 430, 50, 20 )).string_("Reson").align_( \center );
resonbox2a.value = 0;
resonbox3a = GUI.numberBox.new( w, Rect( 160, 430, 50, 20 )).string_("Reson").align_( \center );
resonbox3a.value = 0;
resonbox4a = GUI.numberBox.new( w, Rect( 220, 430, 50, 20 )).string_("Reson").align_( \center );
resonbox4a.value = 0;
resonbox5a = GUI.numberBox.new( w, Rect( 280, 430, 50, 20 )).string_("Reson").align_( \center );
resonbox5a.value = 0;

sres1a = GUI.slider.new(w, Rect(40, 450, 50, 170)); sres1a.value = 0;
sres2a = GUI.slider.new(w, Rect(100, 450, 50, 170)); sres2a.value = 0;
sres3a = GUI.slider.new(w, Rect(160, 450, 50, 170)); sres3a.value = 0;
sres4a = GUI.slider.new(w, Rect(220, 450, 50, 170)); sres4a.value = 0;
sres5a = GUI.slider.new(w, Rect(280, 450, 50, 170)); sres5a.value = 0;

resonbox1a.action_({arg v; x.set(\freqres1a, v.value); });
resonbox2a.action_({arg v; x.set(\freqres2a, v.value); });
resonbox3a.action_({arg v; x.set(\freqres3a, v.value); });
resonbox4a.action_({arg v; x.set(\freqres4a, v.value); });
resonbox5a.action_({arg v; x.set(\freqres5a, v.value); });

sres1a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 0.1).postln; x.set(\parz1a, v); });
sres2a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 0.1).postln; x.set(\parz2a, v); });
sres3a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 0.1).postln; x.set(\parz3a, v); });
sres4a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 0.1).postln; x.set(\parz4a, v); });
sres5a.action_({ arg me; var v = me.value.linlin(0, 1, 0, 0.1).postln; x.set(\parz5a, v); });

)





