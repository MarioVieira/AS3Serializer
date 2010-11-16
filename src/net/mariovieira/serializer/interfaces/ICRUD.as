package net.mariovieira.serializer.interfaces
{
	import flash.events.IEventDispatcher;

	public interface ICRUD extends IEventDispatcher
	{
		function update(object:Object, uniqueId:uint):void;
		function destroy(objectClass:Class, uniqueId:uint):void;
		function retrieve(objectClass:Class, uniqueId:uint):void;
	}
}