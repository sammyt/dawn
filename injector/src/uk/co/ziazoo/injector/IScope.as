package uk.co.ziazoo.injector 
{
	public interface IScope
	{
		function wrapInScope( provider:IProvider ):IProvider;
	}
}