package uk.co.ziazoo.injector
{
  public interface IScope
  {
    function wrap(provider:IProvider):IScope;

    function get requiresInjection():Boolean;

    function get instanceCreated():Boolean;

    function getObject():Object;

    function get finalArtifact():Object;
  }
}