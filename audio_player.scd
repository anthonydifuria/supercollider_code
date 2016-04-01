//Anthony Di Furia (2012)


//AUDIO PLAYER
s.boot;


(
// function load file
f ={
	b = Buffer.loadDialog(s, action: { arg buffer; //load file
	});
	x.set(\f, b);
};

//synth player
SynthDef(\player, {arg buf,trigger = 1,p,f,rate, loop = 0;
	Out.ar([0,1],
		PlayBuf.ar(2,f,rate,trigger,0,loop);
	)
}).add;

x = Synth(\player);x.run(false);
)




//GUI
(
var w,b,b_trig,b_open,trig,s_rate,n_rate,title,rate,b_rate,b_loop;

w = GUI.window.new("PLAYER", Rect(10,10,470,120)); w.front; w.view.background = Color.black;

//text
title = StaticText(w, Rect(180, 1, 200, 20)); title.string = "LITTLE PLAYER"; title.background = Color.black; title.stringColor = Color.blue;title.size;
rate = StaticText(w, Rect(420, 80, 200, 20)); rate.string = "RATE"; rate.background = Color.black; rate.stringColor = Color.blue;

// GUI  rate
b_rate = Button(w, Rect(190,30,100,40));
b_rate.states_([["RESET RATE", Color.blue, Color.black]]);
b_rate.action_({
	arg me;
	var val = me.value.postln, reset1,reset2;
	reset1 = val+0.55;
	reset2 = val+1;
	s_rate.value = reset1;
	n_rate.value = reset2;
	x.set(\rate, s_rate.value);
});
s_rate = Slider(w, Rect(10, 80,340,20));s_rate.background = Color.blue; s_rate.value = 0.55;
n_rate = NumberBox(w, Rect(360,80,50,20));n_rate.background = Color.blue;n_rate.value = 1;

//GUI button

b = Button(w, Rect(10,30 ,100 , 40));
b_trig = Button(w, Rect(120,30,60,40));
b_open = Button(w, Rect(400,30,60,40));
b_loop = Button(w, Rect(300,30,80,40));

// s rate action

s_rate.action_({
	arg me;
	var v = me.value.linlin(0,1,-4,5).postln;
	x.set(\rate, v);

	n_rate.value = v;
});

//   on/off
b.states_([["PLAY", Color.red, Color.black],["STOP", Color.red, Color.black]]);
b.action_({
	arg me, trigger ;
	var val = me.value.postln ;
	if(val == 1){x.run(true)}{x.run(false)};
});

// trig play
b_trig.states_([["REPLAY", Color.green, Color.black],["OFF",Color.green,Color.black]]);
b_trig.action_({
	arg me;
	var val = me.value.postln;
	if(val == 0){x.set(true)}{x.set(false)};
	x.set(\trigger, val)
});

// open panel
b_open.states_([["OPEN", Color.yellow, Color.black]]);
b_open.action_({
	arg me;
	var val = me.value.postln;
	if(val == 0){f.value(true)};
});

//loop
b_loop.states_([["LOOP ON", Color(0.5,0.5,0.2), Color.black],["LOOP OFF",Color(0.5,0.5,0.2),Color.black]]);
b_loop.action_({
	arg me;
	var val = me.value.postln;
	if(val == 0){x.set(true)}{x.set(false)};
	x.set(\loop, val);
});

)
