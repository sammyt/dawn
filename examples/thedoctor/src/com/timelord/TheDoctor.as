package com.timelord 
{
	public class TheDoctor
	{
		private var _tardis:Tardis;
		private var _assistant:IAssistant;
		private var _mission:IMission;
		
		public function TheDoctor(){
		}
		
		public function credits():String
		{
			var creds:String = "";
			creds += "The Doctor\n"
			creds += "Assistant = " + assistant.getName() + "\n";
			creds += "Mission = " + mission.getTitle()
			return creds;
		}
		
		public function get tardis():Tardis{
			return _tardis;
		}
		
		[Inject]
		public function set tardis(value:Tardis):void {
			_tardis = value;
		}
		
		public function get assistant():IAssistant{
			return _assistant;
		}
		
		[Inject]
		public function set assistant(value:IAssistant):void {
			_assistant = value;
		}
		
		public function get mission():IMission{
			return _mission;
		}
		
		[Inject]
		public function set mission(value:IMission):void {
			_mission = value;
		}
	}
}

