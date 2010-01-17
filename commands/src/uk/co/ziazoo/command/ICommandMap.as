package uk.co.ziazoo.command
{
	/**
	 * defines API for adding command classes to Dawn
	 */ 
	public interface ICommandMap
	{
		/**
		 * Adds a command class (a class that has a method decorated with
		 * the Execute metadata) to Dawn
		 * 
		 * @param command:Class the class/type of the command
		 */ 
		function addCommand( command:Class ):void;
	}
}