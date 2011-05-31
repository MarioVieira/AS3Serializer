package org.as3.serializer.interfaces
{
	import flash.events.IEventDispatcher;
	/**
	 * 
	 * Contract to the SerializerCRUD
	 * @see org.as3.serializer.persister.control.SerializerCRUD
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public interface ICRUD extends IEventDispatcher
	{
		function update(object:Object, uniqueId:uint):void;
		function destroy(objectClass:Class, uniqueId:uint):void;
		function retrieve(objectClass:Class, uniqueId:uint):void;
	}
}