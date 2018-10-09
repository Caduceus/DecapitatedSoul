var Timer;
var TotalSeconds;

function CreateTimer(TimerID, Time) {
	Timer = document.getElementById(TimerID);
	TotalSeconds = Time;

	UpdateTimer()
	window.setTimeout("Tick()", 15);
}

function Tick() {
	TotalSeconds -= 0.01;
	UpdateTimer()
	window.setTimeout("Tick()", 15);
}

function UpdateTimer() {
		
if(TotalSeconds <= 0)
{
		window.TotalSeconds = 4;
}

if(TotalSeconds < 4 && TotalSeconds > 3)
{
    document.getElementById('Box1').style.display = "block";
    document.getElementById('Box4').style.display = "none";
}

if(TotalSeconds < 3 && TotalSeconds > 2)
{
    document.getElementById('Box2').style.display = "block";
    document.getElementById('Box1').style.display = "none";
}

if(TotalSeconds < 2 && TotalSeconds > 1)
{
    document.getElementById('Box3').style.display = "block";
    document.getElementById('Box2').style.display = "none";
}

if(TotalSeconds < 1 && TotalSeconds > 0)
{
    document.getElementById('Box4').style.display = "block";
    document.getElementById('Box3').style.display = "none";
}
		
		
Timer.innerHTML = TotalSeconds;
}
function rotator(number)
{
    if(number == 1)
    {
        document.getElementById('Box1').style.display = "block";
        document.getElementById('Box2').style.display = "none";
        document.getElementById('Box3').style.display = "none";
		document.getElementById('Box4').style.display = "none";
        window.TotalSeconds = 4;
    }
   	if(number == 2)
	{
		document.getElementById('Box1').style.display = "none";
		document.getElementById('Box2').style.display = "block";
		document.getElementById('Box3').style.display = "none";
		document.getElementById('Box4').style.display = "none";
		window.TotalSeconds = 3;
	}
	if(number == 3)
	{
		document.getElementById('Box1').style.display = "none";
		document.getElementById('Box2').style.display = "none";
		document.getElementById('Box3').style.display = "block";
		document.getElementById('Box4').style.display = "none";
		window.TotalSeconds = 2;
	}
	if(number == 4)
	{
		document.getElementById('Box1').style.display = "none";
		document.getElementById('Box2').style.display = "none";
 		document.getElementById('Box3').style.display = "none";
		document.getElementById('Box4').style.display = "block";
		window.TotalSeconds = 1;
	}
}

function show(id)
{
	document.getElementById(id+'img').src='layout/images/dot_dark.png';
	document.getElementById(id+'txt').setAttribute("class", "TextB");
}
   
function hide(id)
{
	document.getElementById(id+'img').src='layout/images/dot_light.png';
	document.getElementById(id+'txt').setAttribute("class", "Text");
}
   
function show2(id)
{
	document.getElementById(id+'img').src='layout/images/dot_dark.png';
	document.getElementById(id+'txtL').setAttribute("class", "TextLB");
	document.getElementById(id+'txtR').setAttribute("class", "TextRB");
}
   
function hide2(id)
{
	document.getElementById(id+'img').src='layout/images/dot_light.png';
	document.getElementById(id+'txtL').setAttribute("class", "TextL");
	document.getElementById(id+'txtR').setAttribute("class", "TextR");
}
		
function show3(id)
{
	document.getElementById(id+'txt').setAttribute("class", "TextB");
}
   
function hide3(id)
{
	document.getElementById(id+'txt').setAttribute("class", "Text");
}
		
function sshow()
{
	document.getElementById('Stat').style.display = "block";
}
   
function shide()
{
	document.getElementById('Stat').style.display = "none";
}