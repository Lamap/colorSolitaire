package com.szinpassz 
{
	import com.szinpassz.commands.CheckGameEndCommand;
	import com.szinpassz.commands.DealFromDeckToBufferCommand;
	import com.szinpassz.commands.NewGameCommand;
	import com.szinpassz.commands.PlaceCardOnCollectorCommand;
	import com.szinpassz.commands.ReplaceCardInBuffer;
	import com.szinpassz.commands.StartUpCommand;
	import com.szinpassz.models.ColorModel;
	import com.szinpassz.models.ConfigModel;
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import com.szinpassz.views.Card;
	import com.szinpassz.views.CardMediator;
	import com.szinpassz.views.Deck;
	import com.szinpassz.views.DeckMediator;
	import com.szinpassz.views.GameEndPopup;
	import com.szinpassz.views.GameEndPopupMediator;
	import com.szinpassz.views.GameRules;
	import com.szinpassz.views.GameRulesMediator;
	import com.szinpassz.views.Menu;
	import com.szinpassz.views.MenuMediator;
	import com.szinpassz.views.PreScene;
	import com.szinpassz.views.PreSceneMediator;
	import com.szinpassz.views.Table;
	import com.szinpassz.views.TableMediator;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class MainContext extends Context 
	{
		
		public function MainContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true) 
		{
			super(contextView, autoStartup);
			trace("MainContextSetup");
			
			//reg models
			injector.mapSingleton(ConfigModel);
			injector.mapSingleton(ColorModel);
			injector.mapSingleton(GameModel);
			
			//reg Commands
			commandMap.mapEvent(GameEvent.GAME_STARTUP, StartUpCommand, GameEvent, true);
			commandMap.mapEvent(GameEvent.START_DEAL_FROM_DECK, DealFromDeckToBufferCommand, GameEvent, false);
			commandMap.mapEvent(GameEvent.CARDS_REPLACED_IN_BUFFER, ReplaceCardInBuffer, GameEvent, false);
			commandMap.mapEvent(GameEvent.CARDS_PLACED_ON_COLLECTOR, PlaceCardOnCollectorCommand, GameEvent, false);
			commandMap.mapEvent(GameEvent.TABLE_CHANGE_FINISHED, CheckGameEndCommand, GameEvent, false);
			commandMap.mapEvent(GameEvent.START_NEW_GAME,NewGameCommand, GameEvent, false);
			
			//reg mediators
			mediatorMap.mapView(PreScene, PreSceneMediator);
			mediatorMap.mapView(Table, TableMediator);
			mediatorMap.mapView(Deck, DeckMediator);
			mediatorMap.mapView(Card, CardMediator);
			mediatorMap.mapView(GameEndPopup, GameEndPopupMediator);
			mediatorMap.mapView(Menu, MenuMediator);
			mediatorMap.mapView(GameRules,GameRulesMediator);
			
			
			//reg services
			
			//add PreScene
			contextView.addChild(new PreScene());
			
			super.startup();
			
			
		}
		
	}

}