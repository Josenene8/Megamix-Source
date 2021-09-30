package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'fading':
				FlxG.sound.playMusic(Paths.music('city_ambience'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);	
			case 'cackle':
				FlxG.sound.playMusic(Paths.music('MyraDia1'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'bones':
				FlxG.sound.playMusic(Paths.music('MyraDia1'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'mystic':
				FlxG.sound.playMusic(Paths.music('MyraDia2'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'hocus-pocus':
				FlxG.sound.playMusic(Paths.music('MyraDia2'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);	
			case 'high school conflict':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);										
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'headache':
				hasDialog = true;

				box.frames = Paths.getSparrowAtlas('garcello/garBox');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'nerves':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('garWeak'));

				box.frames = Paths.getSparrowAtlas('garcello/garBox');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'release':
				hasDialog = true;

				box.frames = Paths.getSparrowAtlas('garcello/garBox');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'fading':
				hasDialog = true;
				
				box.frames = Paths.getSparrowAtlas('garcello/garBox');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);	
			case 'cackle':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel' , 'shared');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'bones':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel', 'shared');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'mystic':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel', 'shared');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'hocus-pocus':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel', 'shared');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'high school conflict':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-monika');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'bara no yume':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-monika');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'your demise':
			    hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-monika');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);								
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		if(PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns' )
			{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
			}
			else if (PlayState.SONG.song.toLowerCase()=='headache')
			{
			portraitLeft = new FlxSprite(130, 100);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/gardialogue');
			portraitLeft.animation.addByPrefix('enter', 'gar Default', 24, false);
			// portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
			portraitLeft.antialiasing = true;
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
			}
			else if (PlayState.SONG.song.toLowerCase()=='nerves')
			{
			portraitLeft = new FlxSprite(130, 100);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/gardialogue');
			portraitLeft.animation.addByPrefix('enter', 'gar Nervous', 24, false);
			// portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
			portraitLeft.antialiasing = true;
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
			}
			else if (PlayState.SONG.song.toLowerCase()=='release')
			{
			portraitLeft = new FlxSprite(130, 100);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/gardialogue');
			portraitLeft.animation.addByPrefix('enter', 'gar Ghost', 24, false);
			// portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
			portraitLeft.antialiasing = true;
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
			}
			else if (PlayState.SONG.song.toLowerCase()=='fading')
			{
			portraitLeft = new FlxSprite(130, 100);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/gardialogue');
			portraitLeft.animation.addByPrefix('enter', 'gar Dippy', 24, false);
			// portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
			portraitLeft.antialiasing = true;
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
			}
	
			if(PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' )
			{
			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
			}
			else if (PlayState.SONG.song.toLowerCase()=='headache' || PlayState.SONG.song.toLowerCase()=='nerves' || PlayState.SONG.song.toLowerCase()=='release' || PlayState.SONG.song.toLowerCase()=='fading')
			{
			portraitRight = new FlxSprite(770, 200);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bf_norm');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait Enter', 24, false);
			// portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.4));
			portraitRight.antialiasing = true;
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
			}
			if (PlayState.SONG.song.toLowerCase()=='high school conflict' || PlayState.SONG.song.toLowerCase()=='bara no yume' || PlayState.SONG.song.toLowerCase()=='your demise')
				{
					portraitRight = new FlxSprite(0, 40);
					portraitRight.frames = Paths.getSparrowAtlas('weeb/bf');
					portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
					portraitRight.updateHitbox();
					portraitRight.scrollFactor.set();
					add(portraitRight);
					portraitRight.visible = false;				
				}			
		if (PlayState.SONG.song.toLowerCase()=='high school conflict' || PlayState.SONG.song.toLowerCase()=='bara no yume' || PlayState.SONG.song.toLowerCase()=='your demise')
			{
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/monika');
		portraitLeft.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
			}			
	if (PlayState.SONG.song.toLowerCase()=='cackle')	
	{	
		portraitLeft = new FlxSprite(-50, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('myra/myra_dialogue_1');
		portraitLeft.animation.addByPrefix('enter', 'myradialoguea', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
if (PlayState.SONG.song.toLowerCase()=='bones')	
	{	
		portraitLeft = new FlxSprite(-50, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('myra/myra_dialogue_2');
		portraitLeft.animation.addByPrefix('enter', 'myradialogueb', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
if (PlayState.SONG.song.toLowerCase()=='mystic')	
	{	
		portraitLeft = new FlxSprite(-50, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('myra/myra_dialogue_3');
		portraitLeft.animation.addByPrefix('enter', 'myradialoguec', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
if (PlayState.SONG.song.toLowerCase()=='hocus-pocus')	
	{	
		portraitLeft = new FlxSprite(-50, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('myra/myra_dialogue_4');
		portraitLeft.animation.addByPrefix('enter', 'myradialogued', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.2));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;
	}
	if (PlayState.SONG.song.toLowerCase()=='cackle' || PlayState.SONG.song.toLowerCase()=='bones' || PlayState.SONG.song.toLowerCase()=='mystic' || PlayState.SONG.song.toLowerCase()=='hocus-pocus')	
		{
			portraitRight = new FlxSprite(420, 50);
			portraitRight.frames = Paths.getSparrowAtlas('myra/bf_dialogue');
			portraitRight.animation.addByPrefix('enter', 'bfdialogue', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.2));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}	
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		else if (PlayState.SONG.song.toLowerCase()=='headache' || PlayState.SONG.song.toLowerCase()=='nerves')
		{
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		else if (PlayState.SONG.song.toLowerCase()=='release')
		{
			swagDialogue.color = 0xFF0DF07E;
			dropText.color = FlxColor.BLACK;
		}
		else if (PlayState.SONG.song.toLowerCase()=='fading')
		{
			swagDialogue.color = 0xFF0DF07E;
			dropText.color = FlxColor.BLACK;
		}
		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}
		#if mobile
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			justTouched = false;
			
			if (touch.justReleased){
				justTouched = true;
			}
		}
		#end

		if (FlxG.keys.justPressed.ANY #if mobile || justTouched #end && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'monika':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.frames = Paths.getSparrowAtlas('weeb/monika');
					portraitLeft.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitLeft.animation.play('enter');
				}
			case 'monikahappy':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.frames = Paths.getSparrowAtlas('weeb/monikahappy');
					portraitLeft.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitLeft.animation.play('enter');
				}
			case 'monikagasp':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.frames = Paths.getSparrowAtlas('weeb/monikagasp');
					portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitRight.animation.play('enter');
				}
				case 'monikagaspleft':
					portraitRight.visible = false;
					portraitLeft.visible = false;
					if (!portraitRight.visible)
					{
						portraitRight.visible = true;
						portraitRight.frames = Paths.getSparrowAtlas('weeb/monikagaspleft');
						portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
						portraitRight.animation.play('enter');
					}
				case 'monikahmm':
					portraitRight.visible = false;
					portraitLeft.visible = false;
					if (!portraitRight.visible)
						{
							portraitRight.visible = true;
							portraitRight.frames = Paths.getSparrowAtlas('weeb/monikahmm');
							portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
							portraitRight.animation.play('enter');
						}
				case 'monikauhoh':
					portraitRight.visible = false;
					portraitLeft.visible = false;
					if (!portraitRight.visible)
						{
							portraitRight.visible = true;
							portraitRight.frames = Paths.getSparrowAtlas('weeb/monikauhohright');
							portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
							portraitRight.animation.play('enter');
						}
			case 'monikauhohleft':
					portraitRight.visible = false;
					portraitLeft.visible = false;
					if (!portraitRight.visible)
						{
							portraitRight.visible = true;
							portraitRight.frames = Paths.getSparrowAtlas('weeb/monikauhohleft');
							portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
							portraitRight.animation.play('enter');
						}
			case 'monikasad':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.frames = Paths.getSparrowAtlas('weeb/monikasad');
					portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitRight.animation.play('enter');
				}
			case 'bfwhat':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.frames = Paths.getSparrowAtlas('weeb/bfwhat');
					portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitRight.animation.play('enter');
				}
			case 'bfangry':
					portraitRight.visible = false;
					portraitLeft.visible = false;
					if (!portraitRight.visible)
					{
						portraitRight.visible = true;
						portraitRight.frames = Paths.getSparrowAtlas('weeb/bfangry');
						portraitRight.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
						portraitRight.animation.play('enter');
					}
			case 'senpai':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpai');
					portraitLeft.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitLeft.animation.play('enter');
				}
			case 'senpaihappy':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaihappy');
					portraitLeft.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitLeft.animation.play('enter');
				}
			case 'senpaihmm':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaihmm');
					portraitLeft.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitLeft.animation.play('enter');
				}
			case 'whodis':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.frames = Paths.getSparrowAtlas('weeb/whodis');
					portraitLeft.animation.addByPrefix('enter', 'Portrait Enter instance', 24, false);
					portraitLeft.animation.play('enter');
				}								
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
