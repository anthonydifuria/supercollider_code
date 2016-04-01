//Anthony Di Furia (2010)


s.boot ; // first boot the server


(
// audio
SynthDef.new("sine1",
{
		arg

		kfreq = 50,
		amp1 = 0,
		amp2 = 0,
		amp3 = 0,
		amp4 = 0,
		amp5 = 0,
		amp6 = 0,
		amp7 = 0,
		amp8 = 0,
		amp9 = 0,
		amp10 = 0 ;

		var o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,out;


		//ARMONIC
		o1 = SinOsc.ar(kfreq*1,0, amp1);
		o2 = SinOsc.ar(kfreq*2,0, amp2);
		o3 = SinOsc.ar(kfreq*3,0, amp3);
		o4 = SinOsc.ar(kfreq*4,0, amp4);
		o5 = SinOsc.ar(kfreq*5,0, amp5);
		o6 = SinOsc.ar(kfreq*6,0, amp6);
		o7 =  SinOsc.ar(kfreq*7,0, amp7);
		o8 =  SinOsc.ar(kfreq*8,0, amp8);
		o9 =  SinOsc.ar(kfreq*9,0, amp9);
		o10 =  SinOsc.ar(kfreq*10,0, amp10);

		out =  (o1+o2+o3+o4+o5+o6+o7+o8+o9+o10);

		Out.ar([0,1],out);

};

).send(s);

)




(

// vars
var aSynth, window,t, text, kslider1, kslider2, kslider3, kslider4, kslider5, kslider6, kslider7, kslider8, kslider9, kslider10, kffondbox, kffond, button, w, fft ; aSynth = Synth.new("sine1"); // the synth

aSynth.run(false);

// GUI
window = GUI.window.new("SIMPLE ADDITIVE SYNTHESIS", Rect(1000,1000,500,500)); window.front;

//TITLE
t = "SIMPLE ADDITIVE SYNTHESIS";
text = GUI.staticText.new(window, Rect(50, 50, 380, 30)).string_(t).align_( \center );

//Slider

kslider1 = GUI.slider.new(window, Rect(30, 100, 20, 300));
kslider1.value = 0;
kslider2 = GUI.slider.new(window, Rect(60, 100, 20, 300));
kslider2.value = 0;
kslider3 = GUI.slider.new(window, Rect(90, 100, 20, 300));
kslider3.value = 0;
kslider4 = GUI.slider.new(window, Rect(120, 100, 20, 300));
kslider4.value = 0;
kslider5 = GUI.slider.new(window, Rect(150, 100, 20, 300));
kslider5.value = 0;
kslider6 = GUI.slider.new(window, Rect(180, 100, 20, 300));
kslider6.value = 0;
kslider7 = GUI.slider.new(window, Rect(210, 100, 20, 300));
kslider7.value = 0;
kslider8 = GUI.slider.new(window, Rect(240, 100, 20, 300));
kslider8.value = 0;
kslider9 = GUI.slider.new(window, Rect(270, 100, 20, 300));
kslider9.value = 0;
kslider10 = GUI.slider.new(window, Rect(300, 100, 20, 300));
kslider10.value = 0;



kffond = GUI.slider.new(window, Rect(20, 430, 300, 30));
kffond.value = 0;


kffondbox = GUI.numberBox.new( window, Rect( 350, 430, 100, 30 ));
kffondbox.value = 0;


button = GUI.button.new(window, Rect(10, 10, 30, 30)) ;
button.states = [ // array of states
	[ "ON", Color.black ], ["OFF", Color.red]] ;
button.action = ({ arg button;
	var val = button.value.postln;
	if (val == 0, { aSynth.run(false) }, { aSynth.run }) });



// GUI: controlling audio

kslider1.action_({
	arg v;
	aSynth.set("amp1", v.value);
});
kslider2.action_({
	arg v;
	aSynth.set("amp2", v.value);
});
kslider3.action_({
	arg v;
	aSynth.set("amp3", v.value);
});
kslider4.action_({
	arg v;
	aSynth.set("amp4", v.value);
});
kslider5.action_({
	arg v;
	aSynth.set("amp5", v.value);
});
kslider6.action_({
	arg v;
	aSynth.set("amp6", v.value);
});
kslider7.action_({
	arg v;
	aSynth.set("amp7", v.value);
});
kslider8.action_({
	arg v;
	aSynth.set("amp8", v.value);
});
kslider9.action_({
	arg v;
	aSynth.set("amp9", v.value);
});
kslider10.action_({
	arg v;
	aSynth.set("amp10", v.value);
});


kffond.action_({
	arg v;
	var freq;
	freq = v.value.linlin( 0, 1, 50, 2000);
	kffondbox.value = (freq);
	aSynth.set("kfreq", freq);
});

kffondbox.action_({
	arg v;
	aSynth.set("kfreq", v.value);
});



)
