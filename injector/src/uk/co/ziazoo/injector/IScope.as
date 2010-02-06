package uk.co.ziazoo.injector 
{
	public interface IScope extends IProvider
	{
		function scopeMapping( mapping:IMapping ):void;
	}
}

