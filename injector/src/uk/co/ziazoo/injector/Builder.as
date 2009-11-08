package uk.co.ziazoo.injector
{
	import de.polygonal.ds.TreeNode;
	
	import uk.co.ziazoo.injector.construct.Constructor;
	import uk.co.ziazoo.injector.construct.IConstructor;
	import uk.co.ziazoo.injector.inspect.IInspector;
	import uk.co.ziazoo.injector.inspect.Inspector;
	import uk.co.ziazoo.injector.mapping.Mapper;

	public class Builder implements IBuilder
	{
		private var _inspector:IInspector;
		private var _constructor:IConstructor;
		private var _mapper:IMapper;
		
		public function Builder( config:IConfig  = null )
		{
			_inspector = new Inspector();
			_mapper = new Mapper();
			_inspector.mapper = _mapper;
			_constructor = new Constructor();
			
			if( config )
			{
				config.create( _mapper );
			}
		}
		
		/**
		*	@inheritDoc
		*/	
		public function addConfig( config:IConfig ):void
		{
			config.create( _mapper );
		}
		
		/**
		*	@inheritDoc
		*/	
		public function getObject( entryPoint:Class ):Object
		{
			var node:TreeNode = _inspector.getTree( _mapper.getMap( entryPoint ) );
			return _constructor.construct( node );
		}
	}
}
